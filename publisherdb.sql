DROP TABLE IF EXISTS Authorship;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Book;
DROP TABLE IF Exists Publisher; 

CREATE TABLE Publisher (
    publisher_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (publisher_id)
);

CREATE TABLE Book (
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,   
    publisher_id INT NOT NULL,
    PRIMARY KEY (book_id),
    FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id)
);

CREATE TABLE Author (
    author_id INT NOT NULL,
    last_name CHAR(255) NOT NULL,
    first_name CHAR(255) NOT NULL,
    PRIMARY KEY (author_id)
);

CREATE TABLE Authorship (
    author_id INT NOT NULL,
    book_id INT NOT NULL,

    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

SHOW ENGINE INNODB STATUS;