-- ============================================================
-- LAB EXERCISE: PL/SQL 
-- ============================================================

-- Que 1:Write a PL/SQL block to print the total number of employees from the employees table. 
SET SERVEROUTPUT ON;
DECLARE
    total_employees NUMBER;
BEGIN
    SELECT COUNT(*) INTO total_employees FROM employees;
    DBMS_OUTPUT.PUT_LINE('Total employees: ' || total_employees);
END;


-- Que 2: Create a PL/SQL block that calculates the total sales from an orders table. 
DECLARE
    total_sales NUMBER;
BEGIN
    SELECT SUM(amount) INTO total_sales FROM orders;
    DBMS_OUTPUT.PUT_LINE('Total sales: ' || total_sales);
END;


-- Que 3: Write a PL/SQL block using an IF-THEN condition to check the department of an employee.
DECLARE
    dept_name VARCHAR2(50);
BEGIN
    SELECT dept_name INTO dept_name 
    FROM departments 
    WHERE dept_id = (SELECT dept_id FROM employees WHERE emp_id = 101);
    
    IF dept_name = 'Engineering' THEN
        DBMS_OUTPUT.PUT_LINE('Engineering Department');
    END IF;
END;


-- Que 4: Use a FOR LOOP to iterate through employee records and display their names. 
BEGIN
    FOR emp_rec IN (SELECT emp_name FROM employees) 
    LOOP
        DBMS_OUTPUT.PUT_LINE(emp_rec.emp_name);
    END LOOP;
END;


-- Que 5:Write a PL/SQL block using an explicit cursor to retrieve and display employee details.
DECLARE
    CURSOR emp_cur IS SELECT emp_name, salary FROM employees;
    emp_name employees.emp_name%TYPE;
    emp_salary employees.salary%TYPE;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO emp_name, emp_salary;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(emp_name || ': $' || emp_salary);
    END LOOP;
    CLOSE emp_cur;
END;


-- QUE 6:Create a cursor to retrieve all courses and display them one by one.
DECLARE
    CURSOR course_cur IS SELECT course_name, course_duration FROM courses;
    c_name courses.course_name%TYPE;
    c_dur courses.course_duration%TYPE;
BEGIN
    OPEN course_cur;
    LOOP
        FETCH course_cur INTO c_name, c_dur;
        EXIT WHEN course_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(c_name || ' - ' || c_dur || ' months');
    END LOOP;
    CLOSE course_cur;
END;
