CREATE DATABASE ems_db;
USE ems_db;

-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,  -- Increased length for hashed passwords
    role ENUM('admin', 'employee') NOT NULL,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Attendance and leaves table
CREATE TABLE attendance_leaves (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Leave_Pending', 'Leave_Approved', 'Leave_Rejected') NOT NULL,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Messages table
CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    subject VARCHAR(255),
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Default Admin
INSERT INTO users (username, password, role, name, email, department)
VALUES ('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrkvAQnQJ5v3Xb5J3z7N7J6J7J6J7J6', 'admin', 'Administrator', 'admin@ems.com', 'Management');

-- Sample Employee
INSERT INTO users (username, password, role, name, email, department)
VALUES ('john_doe', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrkvAQnQJ5v3Xb5J3z7N7J6J7J6J7J6', 'employee', 'John Doe', 'john@ems.com', 'IT');