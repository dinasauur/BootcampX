const { Pool } = require('pg');
const args = process.argv.slice(2);

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

// pool.query is a function that accepts an SQL query as a JavaScript string. 
// Using the ` (backtick), we can write a multi line string like this to make our SQL look nicer. 
// The function then returns a promise that contains our result when the query is successful.

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

// When we make the query from our JavaScript application, the results come back as JavaScript objects. 
// That means that once the .then(res => {}) gets executed, we're not dealing with SQL or the database any more, we're just dealing with JavaScript objects.
