# Author: Omer Basar
# Filename: Assignment9.py
# Version: 10/21/20
# Assignment: 9

from datetime import date
from sqlalchemy import create_engine, Table, Column, Integer, String, MetaData, Date, Float, join
from sqlalchemy.sql import select
from sqlalchemy.sql import insert

engine=create_engine('postgresql+psycopg2:///omerbasar')
conn=engine.connect()
metadata=MetaData()

students = Table('students', metadata,
	Column('studentid', Integer, primary_key=True),
	Column('lastname', String),
	Column('firstname', String),
	Column('dob', Date)
)

courses = Table('courses', metadata,
	Column('courseid', Integer, primary_key=True),
	Column('coursename', String),
	Column('credits', Integer)
)

grades = Table('grades', metadata,
	Column('courseid', Integer, primary_key=True),
	Column('studentid', Integer, primary_key=True),
	Column('term', String, primary_key=True),
	Column('grade', String)
)

def student_ability():
	# Get the student ID to be used
	student_id_integer = input("Please enter your student ID")

	# Set up selection query
	j = join(students, grades, students.c.studentid == grades.c.studentid)
	s = select([students.c.lastname,students.c.firstname,grades.c.grade]).\
		where(students.c.studentid == student_id_integer).select_from(j)

	# Execute the query
	result=conn.execute(s)
	for row in result:
		print(row)

def professor_ability():
	# Get the course ID to be used
	course_id_integer = input("Please enter the course's ID")
	# Get the course's term to be used
	term_str = input("Please enter the course's term")
	# Get the student ID to be used
	student_id_integer = input("Please enter the student's ID")
	# Get the student ID to be used
	grade_str = input("Please enter the student's grade letter")

	# Set up insertion query
	i = grades.insert().\
	values(courseid = course_id_integer, studentid = student_id_integer,
		term = term_str, grade = grade_str)

	# Execute the query
	conn.execute(i)
	print("Record was successfully added to the database")
