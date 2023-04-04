DROP TABLE IF EXISTS cohorts;
DROP TABLE IF EXISTS students;

CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  name VARCHAR(255) NOT NULL,
  start_date DATE,
  end_date DATE
);

CREATE TABLE students (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(32),
  github VARCHAR(255),
  start_date DATE,
  end_date DATE,
  cohort_id INTEGER REFERENCES cohorts(id) ON DELETE CASCADE -- FOREIGN KEY
);



--  \c bootcampx every time you enter a new psql session to make sure that you're using the correct database.
--  To add tables to the database:
--  From your psql session, type \i migrations/students_cohorts.sql
--  Now enter \dt into your psql session to make sure the two tables have been created.
