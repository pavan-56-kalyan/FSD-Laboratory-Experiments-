CREATE DATABASE student_db;

USE student_db;

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    dob DATE,
    department VARCHAR(100),
    phone VARCHAR(15)
);