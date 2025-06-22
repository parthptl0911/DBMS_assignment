-- Que 1:  Perform a transaction where you create a savepoint, insert records, then rollback to the savepoint. 
START TRANSACTION;
SAVEPOINT sp1;
INSERT INTO courses (course_name, course_duration) VALUES ('History', 9);
ROLLBACK TO sp1;  -- Undoes History insertion

-- Que 2: Commit part of a transaction after using a savepoint and then rollback the remaining changes. 
START TRANSACTION;
SAVEPOINT sp2;
INSERT INTO courses (course_name, course_duration) VALUES ('Geography', 6);
COMMIT;  -- Commits Geography
ROLLBACK TO sp2;  -- Rolls back only uncommitted changes
