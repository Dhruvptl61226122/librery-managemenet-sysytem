use Enterprise;
CREATE TABLE Departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);
INSERT INTO Departments (department_id, department_name, location) VALUES
(1, 'Sales', 'New York'),
(2, 'HR', 'London'),
(3, 'Engineering', 'San Francisco'),
(4, 'Marketing', 'Chicago'),
(5, 'IT', 'Austin');

CREATE TABLE Employees (
    employee_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    department_id INTEGER,
    salary INTEGER,
    constraint fk_Department FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
INSERT INTO Employees (employee_id, name, department_id, salary) VALUES
(101, 'Alice Johnson', 1, 80000),
(102, 'Bob Smith', 2, 65000),
(103, 'Charlie Brown', 3, 95000),
(104, 'David Wilson', 4, 70000),
(105, 'Emily Davis', 3, 73000),
(106, 'Frank Lee', 2, 85000),
(107, 'Grace White', 5, 62000),
(108, 'Hannah Green', 4, 75000);

CREATE TABLE Projects (
    project_id INTEGER PRIMARY KEY,
    project_name VARCHAR(50),
    department_id INTEGER,
    budget INTEGER,
    constraint fk_Department FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
INSERT INTO Projects (project_id, project_name, department_id, budget) VALUES
(201, 'Project Alpha', 1, 45000),
(202, 'Project Beta', 2, 30000),
(203, 'Project Gamma', 3, 80000),
(204, 'Project Delta', 4, 60000),
(205, 'Project Epsilon', 3, 120000),
(206, 'Project Zeta', 1, 70000),
(207, 'Project Eta', 4, 50000),
(208, 'Project Theta', 5, 95000);

SELECT * FROM Employees WHERE department_ID = 3 and Salary > 70000;
SELECT * FROM Projects WHERE department_ID IN (1, 4) AND Budget < 50000;
SELECT * FROM Employees WHERE Department_ID != 2;
SELECT * FROM Employees WHERE Salary BETWEEN 50000 AND 80000;
SELECT * FROM Projects WHERE Budget >= 75000;
SELECT * FROM Employees WHERE Salary != 90000;
SELECT * FROM Employees WHERE Name LIKE 'A%' AND Salary > 60000;
SELECT * FROM Departments WHERE Department_ID < 3;
SELECT * FROM Employees WHERE Department_ID IN (2, 3) AND Salary > 75000;
SELECT * FROM Projects WHERE Budget BETWEEN 50000 AND 100000 AND Department_ID != 4;
SELECT * FROM Employees WHERE Department_ID = 1 AND Name NOT LIKE '%John%';
SELECT * FROM Projects WHERE Department_ID IN (1, 3, 4) AND Budget > 70000;
SELECT SUM(Salary) AS TotalSalary FROM Employees WHERE Department_ID IN (2, 3);
SELECT AVG(Salary) AS AverageSalary FROM Employees WHERE Department_ID != 4;
SELECT COUNT(*) AS ProjectCount FROM Projects WHERE Budget < 30000 OR Budget > 90000;


Create database LibraryManagement;
use LibraryManagement;
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    Genre VARCHAR(100),
    YearPublished YEAR,
    CopiesAvailable INT
);
INSERT INTO Books (BookID, Title, Author, Genre, YearPublished, CopiesAvailable)
VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 4),
(2, '1984', 'George Orwell', 'Dystopian', 1949, 2),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925, 5);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DateOfBirth DATE,
    MembershipDate DATE
);
INSERT INTO Members (MemberID, FirstName, LastName, DateOfBirth, MembershipDate)
VALUES
(1, 'Alice', 'Smith', '1990-05-15', '2021-06-01'),
(2, 'Bob', 'Johnson', '1985-11-23', '2022-01-15'),
(3, 'Charlie', 'Brown', '2000-07-30', '2023-03-12');

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Transactions (TransactionID, MemberID, BookID, IssueDate, ReturnDate)
VALUES
(1, 1, 1, '2025-04-01', NULL),
(2, 2, 2, '2025-03-20', '2025-03-30');

SELECT * FROM Books WHERE Author = 'George Orwell';
SELECT * FROM Books WHERE Genre = 'Fiction';
SELECT * FROM Members WHERE YEAR(MembershipDate) = 2022;
SELECT Transactions.TransactionID, Books.Title, Members.FirstName, Members.LastName, Transactions.IssueDate, Transactions.ReturnDate
FROM Transactions
JOIN Books ON Transactions.BookID = Books.BookID
JOIN Members ON Transactions.MemberID = Members.MemberID
WHERE Transactions.ReturnDate IS NULL;
SELECT SUM(CopiesAvailable) AS TotalBooks FROM Books;
SELECT Members.FirstName, Members.LastName, COUNT(Transactions.TransactionID) AS BooksIssued
FROM Transactions
JOIN Members ON Transactions.MemberID = Members.MemberID
GROUP BY Transactions.MemberID
ORDER BY BooksIssued DESC
LIMIT 1;
SELECT Transactions.TransactionID, Books.Title, Members.FirstName, Members.LastName, Transactions.IssueDate
FROM Transactions
JOIN Books ON Transactions.BookID = Books.BookID
JOIN Members ON Transactions.MemberID = Members.MemberID
WHERE Transactions.ReturnDate IS NULL AND Transactions.IssueDate < CURDATE() - INTERVAL 30 DAY;







