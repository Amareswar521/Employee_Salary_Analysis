

CREATE DATABASE Employee_Salary_Analysis;
USE Employee_Salary_Analysis;
-- 1. Create tables
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees_data (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    age INT,
    gender VARCHAR(10),
    dept_id INT,
    city VARCHAR(50),
    joining_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    emp_id INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (emp_id) REFERENCES Employees_data(emp_id)
);

-- 2. Insert sample data
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

INSERT INTO Employees_data
(emp_id, emp_name, age, gender, dept_id, city, joining_date) VALUES
(101, 'Ravi', 25, 'Male', 1, 'Hyderabad', '2023-01-15'),
(102, 'Priya', 27, 'Female', 2, 'Chennai', '2022-05-10'),
(103, 'Siva', 24, 'Male', 1, 'Bangalore', '2024-02-20'),
(104, 'Divya', 29, 'Female', 3, 'Hyderabad', '2021-08-12'),
(105, 'Kiran', 26, 'Male', 4, 'Pune', '2023-06-18'),
(106, 'Meena', 28, 'Female', 2, 'Chennai', '2022-11-05'),
(107, 'Arjun', 30, 'Male', 5, 'Mumbai', '2020-04-22'),
(108, 'Anil', 23, 'Male', 1, 'Hyderabad', '2024-07-01'),
(109, 'Sneha', 26, 'Female', 3, 'Bangalore', '2023-09-14'),
(110, 'Rahul', 31, 'Male', 5, 'Pune', '2019-12-10');

INSERT INTO Salaries (salary_id, emp_id, salary, bonus) VALUES
(1, 101, 45000, 5000),
(2, 102, 35000, 3000),
(3, 103, 55000, 6000),
(4, 104, 60000, 8000),
(5, 105, 40000, 4000),
(6, 106, 38000, 3500),
(7, 107, 70000, 10000),
(8, 108, 30000, 2000),
(9, 109, 52000, 5000),
(10, 110, 75000, 12000);

-- 3. Basic analysis queries

-- Q1. Display all employees.
SELECT * FROM Employees_data;

-- Q2. Find employees earning more than 40000.
SELECT e.emp_name, s.salary
FROM Employees_data AS e
JOIN Salaries AS s ON e.emp_id = s.emp_id
WHERE s.salary > 40000;

-- Q3. Find the highest salary.
SELECT MAX(salary) AS highest_salary
FROM Salaries;

-- Q4. Find the lowest salary.
SELECT MIN(salary) AS lowest_salary
FROM Salaries;

-- Q5. Calculate the average salary.
SELECT ROUND(AVG(salary), 2) AS average_salary
FROM Salaries;

-- Q6. Calculate the total salary paid (excluding bonuses).
SELECT SUM(salary) AS total_salary
FROM Salaries;

-- Q7. Count the number of employees.
SELECT COUNT(*) AS total_employees
FROM Employees_data;

-- Q8. Show employee names and their department names.
SELECT e.emp_name, d.dept_name
FROM Employees_data AS e
JOIN Departments AS d ON e.dept_id = d.dept_id;

-- Q9. Calculate average salary by department.
SELECT d.dept_name, ROUND(AVG(s.salary), 2) AS average_salary
FROM Employees_data AS e
JOIN Departments AS d ON e.dept_id = d.dept_id
JOIN Salaries AS s ON e.emp_id = s.emp_id
GROUP BY d.dept_name;

-- Q10. Find the second-highest distinct salary.
SELECT MAX(salary) AS second_highest_salary
FROM Salaries
WHERE salary < (SELECT MAX(salary) FROM Salaries);

-- Q11. Display the top three highest-paid employees.
SELECT e.emp_name, s.salary
FROM Employees_data AS e
JOIN Salaries AS s ON e.emp_id = s.emp_id
ORDER BY s.salary DESC
LIMIT 3;

-- Q12. Classify employees by salary.
SELECT e.emp_name, s.salary,
       CASE
           WHEN s.salary >= 60000 THEN 'High Salary'
           WHEN s.salary >= 40000 THEN 'Medium Salary'
           ELSE 'Low Salary'
       END AS salary_category
FROM Employees_data AS e
JOIN Salaries AS s ON e.emp_id = s.emp_id
ORDER BY s.salary DESC;
