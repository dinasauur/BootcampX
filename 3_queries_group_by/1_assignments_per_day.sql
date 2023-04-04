-- Get the total number of assignments for each day of bootcamp.
-- Select the day and the total assignments.
-- Order the results by day.
-- This query only requires the assignments table.
-- only return rows where total assignments is greater than or equal to 10.

SELECT day, COUNT(*) as total_assignments
FROM assignments
GROUP BY day
HAVING COUNT(*) >= 10
ORDER BY day;