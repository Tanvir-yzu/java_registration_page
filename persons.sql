USE registration_db;

CREATE TABLE IF NOT EXISTS persons (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    pwd VARCHAR(100) NOT NULL,
    gender VARCHAR(20) NOT NULL
);

INSERT INTO persons (id, name, pwd, gender) VALUES
    (1, 'Alice', 'alice123', 'Female'),
    (2, 'Bob', 'bob123', 'Male'),
    (3, 'Chandra', 'chan123', 'Other')
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    pwd = VALUES(pwd),
    gender = VALUES(gender);
