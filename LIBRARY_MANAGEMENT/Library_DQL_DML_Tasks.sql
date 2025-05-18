
-- 1. Display all book records.
SELECT * FROM Book;

-- 2. Show each book’s title, genre, and availability.
SELECT b.Title, bg.Genre, b.IsAvailable
FROM Book b
JOIN BookGenre bg ON b.BookID = bg.BookID;

-- 3. Display all members' names, email, and membership start date.
SELECT FullName, Email, MembershipStartDate FROM Member;

-- 4. Display each book’s title and price with alias “BookPrice”.
SELECT Title, Price AS BookPrice FROM Book;

-- 5. List books priced above 250 LE.
SELECT * FROM Book WHERE Price > 250;

-- 6. List members who joined before 2023.
SELECT * FROM Member WHERE MembershipStartDate < '2023-01-01';

-- 7. Display names and roles of staff working in 'Zamalek Branch'.
SELECT s.FullName, s.Position
FROM Staff s
JOIN Library l ON s.LibraryID = l.LibraryID
WHERE l.Name = 'Zamalek Branch';

-- 8. Display branch name managed by staff ID = 3008.
SELECT l.Name
FROM Library l
JOIN Staff s ON l.LibraryID = s.LibraryID
WHERE s.StaffID = 3008;

-- 9. List titles and authors of books available in branch ID = 2.
SELECT Title, ISBN
FROM Book
WHERE LibraryID = 2 AND IsAvailable = 1;

-- 10. Insert yourself as a member with ID = 405 and register to borrow book ID = 1011.
INSERT INTO Member (MemberID, FullName, Email, Phone, MembershipStartDate)
VALUES (405, 'Your Name', 'your@email.com', '90000000', GETDATE());

INSERT INTO Loan (MemberID, BookID, LoanDate, DueDate, Status)
VALUES (405, 1011, GETDATE(), DATEADD(DAY, 14, GETDATE()), 'Issued');

INSERT INTO Member (FullName, Email, Phone, MembershipStartDate)
VALUES ('No Contact Member', 'unknown@example.com', '00000000', GETDATE());


-- 12. Update the return date of your loan to today.
UPDATE Loan
SET ReturnDate = GETDATE(), Status = 'Returned'
WHERE MemberID = 405 AND BookID = 1011;
