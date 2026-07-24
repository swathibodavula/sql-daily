CREATE OR REPLACE TABLE Departments (
    department_id INTEGER,
    dept_name     VARCHAR
);
CREATE OR REPLACE TABLE Employees (
    employee_id   INTEGER,
    emp_name      VARCHAR,
    department_id INTEGER,
    salary        DECIMAL(10,2)
);
INSERT INTO Departments VALUES
(1, 'Engineering'),
(2, 'Sales'),
(3, 'Research');
INSERT INTO Employees VALUES
(1, 'Ana',  1, 9000.00),
(2, 'Ben',  1, 9000.00),
(3, 'Cara', 1, 8000.00),
(4, 'Dan',  1, 7000.00),
(5, 'Eve',  2, 5000.00),
(6, 'Fay',  2, 6000.00),
(7, 'Gus',  2, 6000.00),
(8, 'Hal',  2, 6000.00),
(9, 'Ivy',  2, 4000.00);