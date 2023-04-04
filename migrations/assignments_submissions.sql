DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS assignment_submissions;

CREATE TABLE assignments (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  name VARCHAR(255),
  content TEXT,
  day INTEGER,
  chapter INTEGER,
  duration INTEGER
);

CREATE TABLE assignment_submissions (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  assignment_id INTEGER REFERENCES assignments(id) ON DELETE CASCADE, --FOREIGN KEY
  student_id INTEGER REFERENCES students(id) ON DELETE CASCADE, -- FOREIGN KEY
  duration INTEGER,
  submission_date DATE
);

-- From psql, type \i migrations/assignments_submissions.sql
-- Now enter \dt into your psqlsession to make sure the two tables have been created.