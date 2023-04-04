-- Get all of the students without a gmail.com account and a phone number.
-- Get their name, email, id, and cohort_id.

SELECT name, id, email, cohort_id
FROM students
WHERE email NOT LIKE '%gmail%'
AND phone IS NULL;