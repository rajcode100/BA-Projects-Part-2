-- Library System Management SQL Project


-- Create Table "Branch"
DROP TABLE IF EXISTS branch;
CREATE TABLE branch(
	branch_id VARCHAR(20) PRIMARY KEY,
	manager_id VARCHAR(20),
	branch_address VARCHAR(30),
	contact_no VARCHAR(20)
);


-- Create table "Employee"
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_id VARCHAR(10) PRIMARY KEY,
	emp_name VARCHAR(30),
	position VARCHAR(30),
	salary DECIMAL(10,2),
	branch_id VARCHAR(10)
);          


-- Create table "Members"
DROP TABLE IF EXISTS members;
CREATE TABLE members
(
    member_id VARCHAR(10) PRIMARY KEY,
    member_name VARCHAR(30),
    member_address VARCHAR(30),
    reg_date DATE
);


-- Create table "Books"
DROP TABLE IF EXISTS books;
CREATE TABLE books(
	isbn VARCHAR(50) PRIMARY KEY,
	book_title VARCHAR(80),
	category VARCHAR(30),
	rental_price DECIMAL(10,2),
	status VARCHAR(10),
	author VARCHAR(30),
	publisher VARCHAR(30)
);


-- Create table "IssueStatus"
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
            issued_id VARCHAR(10) PRIMARY KEY,
            issued_member_id VARCHAR(30),
            issued_book_name VARCHAR(80),
            issued_date DATE,
            issued_book_isbn VARCHAR(50),
            issued_emp_id VARCHAR(10),
            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
            FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn) 
);

-- Create table "ReturnStatus"
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status(
	return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(30),
    return_book_name VARCHAR(80),
    return_date DATE,
    return_book_isbn VARCHAR(50)
);


ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);


SELECT * FROM Books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;


-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')

SELECT * FROM books;


-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';

SELECT * FROM members;


-- Task 3: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';


-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
  issued_emp_id, 
  emp_name,
  COUNT(*) AS books_issued
FROM issued_status
JOIN employees 
  ON employees.emp_id = issued_status.issued_emp_id
GROUP BY issued_emp_id, emp_name
HAVING COUNT(*) > 1;


-- Task 6. Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Classic'


-- Task 7: Find Total Rental Income by Category:

SELECT
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1


-- Task 8. List Members Who Registered in the Last 180 Days:

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'


-- Task 9. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:

CREATE TABLE books_price_greater_than_seven
AS    
SELECT * FROM Books
WHERE rental_price > 7


SELECT * FROM 
books_price_greater_than_seven







