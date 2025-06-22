-- ============================================================
-- Que 1: Create a new database named school_db and a table called students with the 
-- following columns: student_id, student_name, age, class, and address. 
-- ============================================================
CREATE DATABASE school_db;
USE school_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100),
    age INT,
    class VARCHAR(20),
    address VARCHAR(255)
);

-- ============================================================
-- Que 2: Insert five records into the students table and retrieve all records using the SELECT statement. 
-- ============================================================
INSERT INTO students (student_name, age, class, address) 
VALUES 
('Rahul Sharma', 12, '7A', '123 Delhi Road'),
('Priya Patel', 11, '6B', '456 Mumbai Lane'),
('Amit Kumar', 13, '8C', '789 Bangalore Street'),
('Sneha Singh', 10, '5A', '321 Chennai Avenue'),
('Vikram Joshi', 14, '9D', '654 Kolkata Path');

SELECT * FROM students;

-- ============================================================
-- Que 3: Write SQL queries to retrieve specific columns (student_name and age) from the students table. 
-- ============================================================
SELECT student_name, age FROM students;

-- ============================================================
-- Que 4:  Write SQL queries to retrieve all students whose age is greater than 10.
-- ============================================================
SELECT * FROM students WHERE age > 10;

-- ============================================================
-- Que 5:  Create a table teachers with the following columns: teacher_id (Primary Key), 
--         teacher_name (NOT NULL), subject (NOT NULL), and email (UNIQUE). 
-- ============================================================
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_name VARCHAR(100) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- ============================================================
-- Que 6: Implement a FOREIGN KEY constraint to relate the teacher_id from the 
--        teachers table with the students table.
-- ============================================================
ALTER TABLE students
ADD COLUMN teacher_id INT,
ADD FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id);

-- ============================================================
-- Que 7:  Create a table courses with columns: course_id, course_name, and 
--         course_credits. Set the course_id as the primary key. 
-- ============================================================
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    course_credits INT
);

-- ============================================================
-- Que 8:  Use the CREATE command to create a database university_db. 
-- ============================================================
CREATE DATABASE university_db;

-- ============================================================
-- Que 9:  Modify the courses table by adding a column course_duration using the ALTER command.
-- ============================================================
ALTER TABLE courses
ADD course_duration INT;

-- ============================================================
-- Que 10:  Drop the course_credits column from the courses table. 
-- ============================================================
ALTER TABLE courses
DROP COLUMN course_credits;

-- ============================================================
-- Que 11:  Drop the teachers table from the school_db database. 
-- ============================================================
DROP TABLE teachers;

-- ============================================================
-- Que 12:  Drop the students table from the school_db database and verify that the table has been removed. 
-- ============================================================
DROP TABLE students;

-- ============================================================
-- Que 13: Insert three records into the courses table using the INSERT command.
-- ============================================================
INSERT INTO courses (course_name, course_duration) VALUES ('Mathematics', 12),('Computer Science', 24),('Physics', 18);

-- ============================================================
-- Que 14: Update the course duration of a specific course using the UPDATE command. 
-- ============================================================
UPDATE courses SET course_duration = 36 WHERE course_name = 'Computer Science';

-- ============================================================
-- Que 15:  Delete a course with a specific course_id from the courses table using the DELETE command. 
-- ============================================================
DELETE FROM courses WHERE course_id = 2;

-- ============================================================
-- Que 16: Retrieve all courses from the courses table using the SELECT statement. 
-- ============================================================
SELECT * FROM courses;

-- ============================================================
-- Que 17: Sort the courses based on course_duration in descending order using ORDER BY. 
-- ============================================================
SELECT * FROM courses ORDER BY course_duration DESC;

-- ============================================================
-- Que 18:Create two new users user1 and user2 and grant user1 permission to SELECT from the courses table. 
-- ============================================================
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'pass1';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'pass2';
GRANT SELECT ON university_db.courses TO 'user1'@'localhost';

REVOKE INSERT ON university_db.courses FROM 'user1'@'localhost';
GRANT INSERT ON university_db.courses TO 'user2'@'localhost';

-- ============================================================
-- Que 19:  Insert additional rows, then use ROLLBACK to undo the last insert operation.
-- ============================================================
START TRANSACTION;
INSERT INTO courses (course_name, course_duration) VALUES ('Chemistry', 15);
COMMIT;

START TRANSACTION;
INSERT INTO courses (course_name, course_duration) VALUES ('Biology', 10);
ROLLBACK;

START TRANSACTION;
SAVEPOINT sp1;
UPDATE courses SET course_duration = 20 WHERE course_name = 'Physics';
ROLLBACK TO sp1;

-- ============================================================
-- Que 20: Create a SAVEPOINT before updating the courses table, and use it to roll back specific changes.
-- ============================================================

START TRANSACTION;
SAVEPOINT sp1;
UPDATE courses SET course_duration = 20 WHERE course_name = 'Physics';
ROLLBACK TO sp1;  

-- ============================================================
-- Que 21: Create two tables: departments and employees. Perform an INNER JOIN to 
--               display employees along with their respective departments. 
-- ============================================================
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- ============================================================
-- Que 22:  Use a LEFT JOIN to show all departments, even those without employees
-- ============================================================
-- Inner Join
SELECT e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- Left Join
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- ============================================================
-- Que 23: Lab 1: Group employees by department and count the number of employees in each 
--                      department using GROUP BY. 
--         Lab 2: Use the AVG aggregate function to find the average salary of employees in each 
--                     department.
-- ============================================================
-- Group by department
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Average salary
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- ============================================================
-- Que 24:  
-- Lab 1: Write a stored procedure to retrieve all employees from the employees table based 
--         on department. 
-- Lab 2: Write a stored procedure that accepts course_id as input and returns the course details.  
-- ============================================================
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN dept_id INT)
BEGIN
    SELECT * FROM employees WHERE dept_id = dept_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetCourseDetails(IN c_id INT)
BEGIN
    SELECT * FROM courses WHERE course_id = c_id;
END //
DELIMITER ;

-- ============================================================
--Que 25:
--  Lab 1: Create a view to show all employees along with their department names. 
--  Lab 2: Modify the view to exclude employees whose salaries are below $50,000.
-- ============================================================
CREATE VIEW employee_dept_view AS
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

CREATE OR REPLACE VIEW employee_dept_view AS
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary >= 50000;

-- ============================================================
-- Que 26:
--  Lab 1: Create a trigger to automatically log changes to the employees table when a new 
--          employee is added. 
--  Lab 2: Create a trigger to update the last_modified timestamp whenever an employee 
--          record is updated. 
-- ============================================================
CREATE TABLE employee_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(50),
    emp_id INT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_logs (action, emp_id)
    VALUES ('INSERT', NEW.emp_id);
END //
DELIMITER ;

ALTER TABLE employees ADD COLUMN last_modified TIMESTAMP;

DELIMITER //
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.last_modified = CURRENT_TIMESTAMP;
END //
DELIMITER ;



-- ============================================================
-- LAB EXERCISE: Advanced transactions
-- ============================================================
START TRANSACTION;
SAVEPOINT sp1;
INSERT INTO courses (course_name, course_duration) VALUES ('History', 9);
ROLLBACK TO sp1;

START TRANSACTION;
SAVEPOINT sp2;
INSERT INTO courses (course_name, course_duration) VALUES ('Geography', 6);
COMMIT;
