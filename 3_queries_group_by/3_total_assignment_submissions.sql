-- Get the total number of assignment submissions for each cohort.

-- Select the cohort name and total submissions.
-- Order the results from greatest to least submissions.

SELECT cohorts.name AS cohort_name, COUNT(assignment_submissions.*) as submission_count
FROM assignment_submissions
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
GROUP BY cohort_name
ORDER BY submission_count DESC;