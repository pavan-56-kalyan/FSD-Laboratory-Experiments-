CREATE DATABASE company_db;
USE company_db;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(100),
    joining_date DATE
);

INSERT INTO employees (name, department, joining_date) VALUES
('Arjun', 'IT', '2023-01-10'),
('Meena', 'HR', '2022-06-15'),
('Rahul', 'Finance', '2024-02-12'),
('Sneha', 'IT', '2023-08-05'),
('Kiran', 'HR', '2021-09-22');