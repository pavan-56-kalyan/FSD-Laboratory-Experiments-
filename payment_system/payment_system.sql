DROP TABLE IF EXISTS accounts;
USE payment_system;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(100),
    balance DECIMAL(10,2)
);

INSERT INTO accounts (account_name, balance) VALUES
('User_A', 5000),
('Merchant_X', 10000);
SELECT * FROM accounts;
START TRANSACTION;

-- Deduct money from user
UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

-- Add money to merchant
UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT;

START TRANSACTION;

-- Deduct from user
UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 1;

-- Simulate error (wrong merchant id)
UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 99;

ROLLBACK;

SELECT * FROM accounts;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    amount DECIMAL(10,2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

START TRANSACTION;

UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

INSERT INTO transactions (sender_id, receiver_id, amount)
VALUES (1,2,500);

COMMIT;

SELECT * FROM transactions;