-- Step 1: Create the Database
CREATE DATABASE BookStore;

-- Step 2: Use the Database
USE BookStore;

-- Step 3: Create the Tables

-- Table: Authors
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Country VARCHAR(50)
);

-- Table: Publishers
CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY identity,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50)
);
-- Table: Books
CREATE TABLE Books (
    BookID INT PRIMARY KEY identity,
    Title VARCHAR(150) NOT NULL,
    AuthorID INT,
    PublishedYear date,
    Genre VARCHAR(50),
    PublisherID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);



-- Table: Sales
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY identity,
    BookID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Step 4: Insert Records into the Tables

-- Insert Records into Authors Table
INSERT INTO Authors ( AuthorID,Name, Country)
VALUES
    (1,'J.K. Rowling', 'United Kingdom'),
    (2,'George Orwell', 'United Kingdom'),
    (3,'J.R.R. Tolkien', 'United Kingdom'),
    (4,'Mark Twain', 'United States'),
    (5,'Agatha Christie', 'United Kingdom'),
    (6,'Stephen King', 'United States'),
    (7,'Jane Austen', 'United Kingdom'),
    (8,'Ernest Hemingway', 'United States'),
    (9,'F. Scott Fitzgerald', 'United States'),
    (10,'Isaac Asimov', 'United States');

-- Insert Records into Publishers Table
INSERT INTO Publishers (Name, Country)
VALUES
    ('Bloomsbury', 'United Kingdom'),
    ('HarperCollins', 'United States'),
    ('Penguin Random House', 'United States'),
    ('Macmillan Publishers', 'United Kingdom'),
    ('Houghton Mifflin Harcourt', 'United States');

-- Insert Records into Books Table
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre, PublisherID)
VALUES
    ('Harry Potter and the Sorcerer''s Stone', 1, '1-1-1997', 'Fantasy', 1),
    ('1984', 2, '4-7-1949', 'Dystopian', 2),
    ('Animal Farm', 2, '2-2-1945', 'Political Satire', 2),
    ('The Hobbit', 3, '1-2-1937', 'Fantasy', 3),
    ('The Adventures of Tom Sawyer', 4, '2-4-1876', 'Fiction', 4),
    ('Murder on the Orient Express', 5, '4-6-1934', 'Mystery', 3),
    ('The Shining', 6, '8-8-1977', 'Horror', 5),
    ('Pride and Prejudice', 7, '5-6-1813', 'Romance', 2),
    ('The Old Man and the Sea', 8, '3-4-1952', 'Fiction', 3),
    ('The Great Gatsby', 9, '3-6-1925', 'Fiction', 4),
    ('Foundation', 10, '5-5-1951', 'Science Fiction', 5);


-- Insert Records into Sales Table
INSERT INTO Sales (BookID, SaleDate, Quantity, TotalAmount)
VALUES
    (1, '2023-01-15', 120, 2400.00),
    (2, '2023-02-18', 200, 3000.00),
    (3, '2023-03-22', 150, 2250.00),
    (4, '2023-04-10', 80, 1600.00),
    (5, '2023-05-05', 90, 1350.00),
    (6, '2023-06-14', 130, 2600.00),
    (7, '2023-07-19', 110, 2200.00),
    (8, '2023-08-25', 70, 1400.00),
    (9, '2023-09-30', 95, 1900.00),
    (10, '2023-10-11', 50, 1000.00),
    (11, '2023-11-23', 60, 1200.00);

-- Additional Insert Records into Sales Table
INSERT INTO Sales (BookID, SaleDate, Quantity, TotalAmount)
VALUES
    (1, '2023-07-25', 130, 2600.00),
    (2, '2023-08-30', 160, 2400.00),
    (3, '2023-09-12', 170, 2550.00),
    (4, '2023-10-21', 140, 2800.00),
    (5, '2023-11-15', 100, 1500.00),
    (6, '2023-12-18', 150, 3000.00),
    (7, '2024-01-25', 180, 3600.00),
    (8, '2024-02-22', 110, 2200.00),
    (9, '2024-03-14', 120, 2400.00),
    (10, '2024-04-20', 60, 1200.00),
    (11, '2024-05-05', 90, 1800.00);

	select*from Authors

	select*from Books where PublishedYear>='1-1-1994'

	select count (*) as TotalBooks from Books

	select* from Publishers where Country='United Kingdom'

	select Authors.Name='George Orwell',Books.Title
	from Authors
 Books on Authors.Name=Books.Title where Name='George Orwell'


 select Title from Books join Authors 
 on Books.AuthorID=Authors.AuthorID
 where Authors.Name='George Orwell'

 select Quantity from Sales join Books on
 Sales.BookID=Books.BookID 
 where Books.Title='1984'

 select sum(Quantity) as TotalQuantity 
 from Sales join Books on Sales.BookID=Books.BookID
 where Books.Title='1984'

 select* from Books join Authors on Books.PublisherID=Publishers.PublisherID
 select* from Publishers join Publishers on Publishers.Name=Authors.Name

 select Books.Title, Authors.Name as Author , Publishers.Name as Puplisher
 from Books join Authors
 on Books.AuthorID=Authors.AuthorID 
 join Publishers
 on Books.PublisherID=Publishers.PublisherID

select sum (TotalAmount ) from Sales join Books on Books.BookID=Sales.BookID


select Books.Title ,SUM(sales.TotalAmount) As Total
from Sales join Books 
on Sales.BookID=Books.BookID
group by Books.Title

select Authors.Name ,count(Books.BookID) as book_count
from Authors join Books 
on Authors.AuthorID=Books.AuthorID
group by Authors.AuthorID,Authors.Name
order by book_count desc 

select Books.Title,sum(Sales.Quantity)
from Sales join Books on 
Sales.BookID=Books.BookID
group by Books.Title 
having sum(s.Quantity)>200

select b.title, sum(s.quantity) total_qty
from books b
join sales s
on b.BookID=s.BookID
group by b.Title
having sum(s.quantity)>200
order by total_qty desc

select Title from Books
where BookID not in (select Distinct BookID from Sales)

Select Concat( CAST(PublishedYear as varchar),title)from books;

select cast(PublishedYear as varchar) as 'Year', 
CONCAT(Title, '-', CAST(PublishedYear as varchar))
from Books

SELECT Title, CONCAT(Title,'(',CAST(PublishedYear AS varchar(10)),')') AS Title_with_year
FROM books;

select BookID , 
CONCAT(Title, '(' ,CAST(PublishedYear as varchar(4)),')') AS TitleWithYear
from Books

select AuthorID , Name , Coalesce(Country ,'Unknown') as Country
from Authors

select Title as Book_title , Name As Authur_Name ,PublishedYear
from Books B
 join Authors A
	on B.AuthorID =A.AuthorID
	

	Select Title,Genre
	From Books
	union all
	Select Name,Country
	From Authors



	Select Title,Genre
	From Books
	union all
	Select Name,Country
	From Authors

	select*
	from Books
	Select*
	from Sales

	select Title , Name 
	from Books B
	join Authors S
	on B.AuthorID = S.AuthorID

	select BookID, Quantity ,TotalAmount,
	case
		when TotalAmount >=1800 then 'High' else 'Low'
	End As Identification
	from Sales