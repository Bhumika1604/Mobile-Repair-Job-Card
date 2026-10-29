CREATE DATABASE repairdb;
USE repairdb;

CREATE TABLE repair_job (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer VARCHAR(40),
    model VARCHAR(30),
    problem VARCHAR(60),
    status VARCHAR(15) DEFAULT 'Received'
);

DESCRIBE repair_job;

SELECT * FROM repair_job;