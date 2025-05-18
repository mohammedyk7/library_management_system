
-- Create Library table
CREATE TABLE Library (
    LibraryID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL UNIQUE,
    EstablishedYear INT CHECK (EstablishedYear > 1800)
);

-- Create Book table
CREATE TABLE Book (
    BookID INT IDENTITY PRIMARY KEY,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    Title VARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price > 0),
    IsAvailable BIT DEFAULT 1,
    ShelfLocation VARCHAR(50),
    LibraryID INT NOT NULL,
    FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID)
        ON DELETE CASCADE ON UPDATE CASCADE
		-- If a library is deleted all books linked to that library will be deleted automatically.
);

-- Create BookGenre table
CREATE TABLE BookGenre (
    BookID INT,
    Genre VARCHAR(50) CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
    PRIMARY KEY (BookID, Genre),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
        ON DELETE CASCADE ON UPDATE CASCADE
		--
);

-- Create Member table
CREATE TABLE Member (
    MemberID INT IDENTITY PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20) NOT NULL,
    MembershipStartDate DATE NOT NULL
);

-- Create Staff table
CREATE TABLE Staff (
    StaffID INT IDENTITY PRIMARY KEY,
    LibraryID INT NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Loan table
CREATE TABLE Loan (
    LoanID INT IDENTITY PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Status VARCHAR(20) DEFAULT 'Issued' CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Payment table (weak entity)
CREATE TABLE Payment (
    PaymentID INT IDENTITY PRIMARY KEY,
    LoanID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Method VARCHAR(30) NOT NULL,
    Amount DECIMAL(10,2) CHECK (Amount > 0),
    FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Review table
CREATE TABLE Review (
    ReviewID INT IDENTITY PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT DEFAULT 'No comments',
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
--  If the parent row is deleted, all child rows that reference it will be automatically deleted too.


-- Insert Libraries
INSERT INTO Library (Name, Address, ContactNumber, EstablishedYear) VALUES
('Central Library', 'Downtown', '91234567', 1995),
('North Branch', 'Northside', '92345678', 2001),
('West Wing Library', 'Westend', '93456789', 1987);


-- Insert Libraries
INSERT INTO Library (Name, Location, ContactNumber, EstablishedYear) VALUES
('Central Library', 'Downtown', '91234567', 1995),
('North Branch', 'Northside', '92345678', 2001),
('West Wing Library', 'Westend', '93456789', 1987);

INSERT INTO Book (ISBN, Title, Price, IsAvailable, ShelfLocation, LibraryID) VALUES
('978-1-23456-789-0', 'The Great Gatsby', 12.99, 1, 'A1', 1),
('978-1-23456-789-1', 'Introduction to Algorithms', 59.99, 1, 'B2', 1),
('978-1-23456-789-2', 'Harry Potter and the Sorcerer''s Stone', 20.50, 1, 'C3', 2),
('978-1-23456-789-3', 'Sapiens', 25.00, 1, 'D4', 2),
('978-1-23456-789-4', '1984', 15.75, 1, 'E5', 3),
('978-1-23456-789-5', 'Educated', 18.00, 1, 'F6', 3),
('978-1-23456-789-6', 'Green Eggs and Ham', 10.00, 1, 'G7', 1),
('978-1-23456-789-7', 'The Catcher in the Rye', 14.00, 1, 'H8', 2),
('978-1-23456-789-8', 'Python Crash Course', 29.99, 1, 'I9', 2),
('978-1-23456-789-9', 'Charlotte''s Web', 9.50, 1, 'J10', 1);

INSERT INTO BookGenre (BookID, Genre) VALUES
(1, 'Fiction'),
(2, 'Reference'),
(3, 'Children'),
(4, 'Non-fiction'),
(5, 'Fiction'),
(6, 'Non-fiction'),
(7, 'Children'),
(8, 'Fiction'),
(9, 'Reference'),
(10, 'Children');

-- Insert Members
INSERT INTO Member (FullName, Email, Phone, MembershipStartDate) VALUES
('Alice Smith', 'alice@example.com', '91112222', '2022-01-01'),
('Bob Johnson', 'bob@example.com', '92223333', '2021-11-15'),
('Charlie Lee', 'charlie@example.com', '93334444', '2020-06-10'),
('Diana King', 'diana@example.com', '94445555', '2019-09-25'),
('Evan Wright', 'evan@example.com', '95556666', '2023-02-05'),
('Fiona Davis', 'fiona@example.com', '96667777', '2023-03-20');

-- Insert Staff
INSERT INTO Staff (FullName, Position, ContactNumber, LibraryID) VALUES
('Grace Miller', 'Librarian', '90123456', 1),
('Hank Thomas', 'Assistant', '90234567', 2),
('Isla Moore', 'Technician', '90345678', 3),
('Jack White', 'Archivist', '90456789', 1);

-- Insert Loans
INSERT INTO Loan (MemberID, BookID, LoanDate, DueDate, ReturnDate, Status) VALUES
(1, 1, '2023-01-01', '2023-01-15', '2023-01-10', 'Returned'),
(2, 2, '2023-02-01', '2023-02-14', NULL, 'Issued'),
(3, 3, '2023-02-10', '2023-02-20', '2023-02-28', 'Overdue'),
(4, 4, '2023-03-05', '2023-03-19', NULL, 'Issued'),
(5, 5, '2023-03-10', '2023-03-24', '2023-03-22', 'Returned'),
(6, 6, '2023-04-01', '2023-04-15', NULL, 'Issued'),
(1, 7, '2023-04-10', '2023-04-24', NULL, 'Issued'),
(2, 8, '2023-05-01', '2023-05-15', NULL, 'Issued'),
(3, 9, '2023-05-05', '2023-05-20', NULL, 'Issued'),
(4, 10, '2023-05-10', '2023-05-25', NULL, 'Issued');

-- Insert Payments
INSERT INTO Payment (LoanID, PaymentDate, Amount, Method) VALUES
(1, '2023-01-11', 3.50, 'Cash'),
(3, '2023-03-01', 5.00, 'Credit'),
(3, '2023-03-02', 2.00, 'Cash'),
(5, '2023-03-23', 1.50, 'Cash');

-- Insert Reviews
INSERT INTO Review (MemberID, BookID, Rating, Comment, ReviewDate) VALUES
(1, 1, 5, 'Loved it!', '2023-01-11'),
(2, 2, 4, 'Very informative.', '2023-02-02'),
(3, 3, 3, 'Kids loved it.', '2023-02-21'),
(4, 4, 5, 'Amazing read.', '2023-03-10'),
(5, 5, 2, 'Too slow.', '2023-03-25'),
(6, 6, 4, 'Well written.', '2023-04-15');

-- Simulated application behavior
-- 1. Mark loan as returned
UPDATE Loan SET ReturnDate = '2023-05-10', Status = 'Returned' WHERE LoanID = 2;

-- 2. Mark loan as overdue
UPDATE Loan SET Status = 'Overdue' WHERE LoanID = 4;

-- 3. Delete a review
DELETE FROM Review WHERE ReviewID = 5;

-- 4. Delete a payment
DELETE FROM Payment WHERE PaymentID = 3;