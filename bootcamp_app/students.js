const { Pool } = require('pg');
const args = process.argv.slice(2);

//// STEP TWO - the part that comes from somewhere else
const cohortName = args[0];
const limit = args[1] || 5;
// Store all potentially malicious values in an array.
const values = [`%${cohortName}%`, limit];

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

/* OLD QUERY WRITTEN WHERE THERE IS RISK OF SQL INJECTION

pool.query(`
SELECT students.id as student_id, students.name as name, cohorts.name as cohort
FROM cohorts
JOIN students ON cohorts.id = cohort_id
WHERE cohorts.name LIKE '${args[0]}%'
LIMIT ${args[1] || 5};
`)
.then(response => {
  response.rows.forEach(user => {
    console.log(`${user.name} has an id of ${user.student_id} and was in the ${user.cohort} cohort`);
  })
})
.catch(err => {
  console.error('query error', err.stack)
});

*/

/*** NOTES
 * pool.query is a function that accepts an SQL query as a JavaScript string.
 * Using the ` (backtick), we can write a multi line string like this to make our SQL look nicer.
 * The function then returns a promise that contains our result when the query is successful.
 * When we make the query from our JavaScript application, the results come back as JavaScript objects.
 * That means that once the .then(res => {}) gets executed, we're not dealing with SQL or the database any more, we're just dealing with JavaScript objects.
 */

/*** PARAMETERIZED QUERY
 * Because we have paramerterized query, it risks SQL injection which is a malicious attack
 * They can update our data or even delete it entirely e.g node app.js FEB "2; DROP TABLE students"
 * SO, In our applications, we will separate out our SQL into two different parts.
 * STEP 1: The part that we write as the developer, the part that we have complete control over.
 * STEP 2: The part that comes from somewhere else and might be malicious.
 * * Each $s in our query is a placeholder that represents where a value should go but can't because it's coming from somewhere else, so it might be malicious.
 * * The $1 and $2 placeholders will eventually get replaced with the actual data from the values array.
 * * The numbering starts at 1 instead of 0, so the first value in the query $1 corresponds to the first value in the array values[0].
 */

//// STEP 1 - the part we write
const queryString = `
SELECT students.id as student_id, students.name as name, cohorts.name as cohort
FROM cohorts
JOIN students ON cohorts.id = cohort_id
WHERE cohorts.name LIKE $1
LIMIT $2;
`;

pool.query(queryString, values)
  .then(response => {
    response.rows.forEach(row => {
      console.log(`${row.name} has an id of ${row.student_id} and was in the ${row.cohort} cohort`);
    });
  })
  .catch(err => {
    console.error('query error', err.stack);
  });
