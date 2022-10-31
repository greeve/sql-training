CREATE TABLE Book (
    bookID INT NOT NULL AUTO_INCREMENT,
    ISBN BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    Author CHAR(255),
    publish_year INT, 
    category VARCHAR(255),      
    PRIMARY KEY (bookID)
);

CREATE TABLE Patron (
    patronID INT NOT NULL,
    lastname CHAR(255) NOT NULL,
    firstname CHAR(255) NOT NULL,
    address_ VARCHAR(255),    
    phone_number BIGINT,   
    limit_ INT,

    PRIMARY KEY (patronID, lastname, firstname)
);

CREATE TABLE CurrentLoan (
    patronID INT NOT NULL,
    bookID INT NOT NULL,
    loan_date DATE,
    due_date DATE,

    PRIMARY KEY (patronID, bookID),
    FOREIGN KEY (bookID) REFERENCES Book(bookID)
);

CREATE TABLE History (
    patronID INT NOT NULL,
    bookID INT NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE,

    PRIMARY KEY (patronID, bookID, loan_date),
    FOREIGN KEY (bookID) REFERENCES Book(bookID),
    FOREIGN KEY (patronID) REFERENCES Patron(patronID)
);

INSERT INTO Patron VALUES (1001, 'Smith', 'John', 'Captial road', 9195863230, 10);
INSERT INTO Patron VALUES (2123, 'Sacks', 'Mark', '7th Black Street', 9195627774, 10);
INSERT INTO Patron VALUES (3456, 'Johnson', 'Susan', '405 South', 9198564325, 10);
INSERT INTO Patron VALUES (4223, 'States', 'Nick', '12th East Street', 9198889999, 10);
INSERT INTO Patron VALUES (5987, 'Stew', 'Martha', '85 North', 9193642256, 10);

INSERT INTO Book VALUES (0001, 444222666325, 'Mars', 'Mark Sas', 2001, 'fiction');
INSERT INTO Book VALUES (0002, 784566512135, 'The Cow', 'Stephy Williams', 1996, 'children');
INSERT INTO Book VALUES (0003, 488984115444, 'XML for beginners', 'Jake Snow', 2005, 'non-fiction'); 
INSERT INTO Book VALUES (0004, 544465545655, 'Into Thin Air', 'Jon Krakauer', 1990, 'non-fiction'); 
INSERT INTO Book VALUES (0005, 878745656513, 'And Tango Makes Three', 'Peter Parnell', 1956, 'children');
INSERT INTO Book VALUES (0006, 564564123213, 'Swimmy', 'Leo Lionni', 2010, 'children');
INSERT INTO Book VALUES (0007, 132125645678, 'XML and XQuery Tutorial', 'Lee Cakes', 2014, 'non-fiction');
INSERT INTO Book VALUES (0008, 132154548746, 'Happy Places', 'Steve Zus', 1998, 'refrence');
INSERT INTO Book VALUES (0009, 788897998754, 'The Mascot', 'Kevin Bacon', 1987, 'fiction');
INSERT INTO Book VALUES (0010, 878561132116, 'XQuery for beginners', 'Virginia Woolf', 2018, 'non-fiction');

INSERT INTO CurrentLoan VALUES (5987, 0004, '2017-09-13', '2017-11-14');
INSERT INTO CurrentLoan VALUES (2123, 0003, '2017-01-13', '2017-11-15');
INSERT INTO CurrentLoan VALUES (4223, 0009, '2017-02-14', '2017-03-12');
INSERT INTO CurrentLoan VALUES (1001, 0005, '2017-10-12', '2017-11-09');
INSERT INTO CurrentLoan VALUES (2123, 0002, '2017-04-13', '2017-05-12');

INSERT INTO History VALUES (4223, 0007, '2017-01-14', '2017-10-04');
INSERT INTO History VALUES (3456, 0001, '2017-01-12', '2017-11-04');
INSERT INTO History VALUES (1001, 0003, '2017-04-14', '2017-10-08');
INSERT INTO History VALUES (5987, 0009, '2017-05-14', '2017-12-04');

-- find the book ID, title, and due date of all the books currently being checked out by John Smith.
SELECT b.bookID, b.title, cl.due_date 
FROM Book AS b
INNER JOIN CurrentLoan AS cl ON b.bookID=cl.bookID 
INNER JOIN Patron AS p ON p.patronID=cl.patronID
WHERE p.patronID=2123;

SELECT p.patronID, p.firstname, p.lastname, b.bookID, b.title, cl.due_date 
FROM Book AS b
INNER JOIN CurrentLoan AS cl ON b.bookID=cl.bookID 
INNER JOIN Patron AS p ON p.patronID=cl.patronID
ORDER BY cl.due_date;

SELECT p.patronID, p.firstname, p.lastname, b.bookID, b.title, cl.due_date 
FROM Book AS b
INNER JOIN CurrentLoan AS cl ON b.bookID=cl.bookID 
INNER JOIN Patron AS p ON p.patronID=cl.patronID
ORDER BY cl.due_date;

SELECT COUNT(cl.patronID) AS checkout_count, p.firstname, p.lastname
FROM CurrentLoan AS cl
JOIN Patron as p ON p.patronID=cl.patronID
GROUP BY cl.patronID;

SELECT COUNT(cl.patronID) AS checkout_count, cl.patronID
FROM CurrentLoan AS cl
GROUP BY cl.patronID;