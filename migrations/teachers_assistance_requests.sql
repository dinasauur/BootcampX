DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS assistance_requests;

CREATE TABLE teachers (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  name VARCHAR(255) NOT NULL,
  start_date DATE,
  end_date DATE,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE assistance_requests (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  assignment_id INTEGER REFERENCES assignments(id) ON DELETE CASCADE, -- FOREIGN KEY
  student_id INTEGER REFERENCES students(id) ON DELETE CASCADE, -- FOREIGN KEY
  teacher_id INTEGER REFERENCES teachers(id) ON DELETE CASCADE, -- FOREIGN KEY
  created_at TIMESTAMP,
  started_at TIMESTAMP,
  completed_at TIMESTAMP,
  student_feedback TEXT,
  teacher_feedback TEXT
);

-- From psql, type \i migrations/teachers_assistance_requests.sql
-- Now enter \dt into your psqlsession to make sure the two tables have been created.