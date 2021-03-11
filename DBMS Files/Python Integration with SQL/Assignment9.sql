-- 
-- records courses
-- 
CREATE TABLE courses (
	courseid		INTEGER,
	coursename		VARCHAR(40) NOT NULL,
	credits			REAL NOT NULL,
	PRIMARY KEY (courseid)
);

-- 
-- records students
--
CREATE TABLE students (
	studentid		INTEGER,
	lastname		VARCHAR(80) NOT NULL,
	firstname		VARCHAR(80) NOT NULL,
	dob				DATE,
	PRIMARY KEY		(studentid)
);

--
-- Records all grades for all students
--
CREATE TABLE grades (
	studentid		INTEGER,
	courseid		INTEGER,
	term			VARCHAR(10),
	grade 			VARCHAR(2) NOT NULL,
	PRIMARY KEY (studentid, courseid, term),
	FOREIGN KEY (studentid) REFERENCES students(studentid),
	FOREIGN KEY (courseid) REFERENCES courses(courseid),
	CHECK (grade IN ('F', 'I', 'D', 'C-', 'C', 'C+', 'B-', 'B', 'B+',
		'A-', 'A', 'A+'))
);

--
-- Data load
--
INSERT INTO students (studentid, lastname, firstname, dob)
VALUES
(1000000001, 'Smith', 'John', '1975/1/1');

INSERT INTO students (studentid, lastname, firstname, dob)
VALUES
(1000000002, 'Doe', 'Jane', '1985/12/15');

INSERT INTO students (studentid, lastname, firstname, dob)
VALUES
(1000000003, 'Greene', 'David', '1995/6/15');

INSERT INTO students (studentid, lastname, firstname, dob)
VALUES
(1000000004, 'Cooper', 'Susan', '1998/8/12');

INSERT INTO courses (courseid, coursename, credits)
VALUES
(12543, 'CSC 263', 3);

INSERT INTO grades (studentid, courseid, term, grade)
VALUES
(1000000001, 12543, 'Fall 2020', 'A-');

