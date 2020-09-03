use master
Create database Library
go

-- Create main table Library_inventory
use library
CREATE TABLE Library_inventory  
(
Item_id int(20) PRIMARY KEY,  
Borrowed_id int(15), 
Avaialable_status bit,  
Price decimal(7,2),  
description varchar(255),  
Book_id int ,  
Material_id int ,  
Location int,
Borrowed_count int,
Borrowed_date Date 
)  

-- Create table Borrows 
CREATE TABLE Borrows 
(
ID int(10) PRIMARY KEY
Item_id int(20) ,  
Memeber_id int(10),  
Issue_date date,
Return_date date,
Librarian_id int(10),
Pass_due_amount decimal(6,2) 
)
  
-- Create table Member_info
CREATE TABLE Member_info
(
Memeber_ID int(10) PRIMARY KEY,
Item_id int(20) ,  
Borrowed_id int(15), 
Memeber_id int(10),  
Issue_date date,
Return_date date,
Librarian_id int(10) 
)  

-- Create table Libranian_info
CREATE TABLE Libranian_info
(
Librarian_ID int(10) PRIMARY KEY,
Email varchar(255),
Name Vrchar(255),
Code int(10)
) 
 
--Creating table “Location”
CREATE TABLE Location  
(
Location_id int(10) PRIMARY KEY,  
shelf_id int(10),  
Row_id int(10),  
Section_id int(10)  
)  

-- Create table book
CREATE TABLE book
(
Book_id int(10) PRIMARY KEY,  
ISBN varchar(255), 
publisher_id int(10) ,  
Author_id int(10) ,  
Year int,
Title varchar(255)
)  

-- Create table publisher
CREATE TABLE publisher
(
publisher_id int(10) PRIMARY KEY,  
Address varchar(255), 
Phone varchar(255),  
Url int,  
published_name varchar(255)
)  

-- Create table Author
CREATE TABLE Author
(
Author_id int(10) PRIMARY KEY,  
Address varchar(255), 
Phone varchar(255),  
Url varchar(255),  
Author_name varchar(255)
)  

-- Create table Author
CREATE TABLE Other_loan_material
(
Material_id int(10) PRIMARY KEY,  
ISSN varchar(255), 
Title varchar(255),  
year int,  
Authorname varchar(255)
)  


--Building Relationship between library_inventory & borrows:
ALTER TABLE borrows
ADD CONSTRAINT item_id_Id_FK FOREIGN KEY(item_Id) REFERENCES library_inventory(item_Id);  

--Building Relationship between library_inventory & location:
ALTER TABLE library_inventory
ADD CONSTRAINT location_id_Id_FK FOREIGN KEY(location_Id) REFERENCES library_inventory(location_Id);

-Building Relationship between library_inventory & book:
ALTER TABLE library_inventory
ADD CONSTRAINT book__Id_FK FOREIGN KEY(Book_Id) REFERENCES Book(Book_Id);

-Building Relationship between library_inventory & other_loan_material:
ALTER TABLE library_inventory
ADD CONSTRAINT Material__Id_FK FOREIGN KEY(Material_Id) REFERENCES other_loan_material(Material_Id);

-Building Relationship between Borrows & Memeber_info:
ALTER TABLE Borrows
ADD CONSTRAINT Member__Id_FK FOREIGN KEY(Member_Id) REFERENCES Memeber_info(Member_Id);

-Building Relationship between Borrows & libraian_info:
ALTER TABLE Borrows
ADD CONSTRAINT libraian__Id_FK FOREIGN KEY(libraian_Id) REFERENCES libraian_info(libraian_Id);

-Building Relationship between book & publisher:
ALTER TABLE Book
ADD CONSTRAINT publisher__Id_FK FOREIGN KEY(publisher_Id) REFERENCES publisher(publisher_Id);

-Building Relationship between book & Author:
ALTER TABLE Book
ADD CONSTRAINT Author__Id_FK FOREIGN KEY(Author_Id) REFERENCES Author(Author_Id);


-- DML insert data into table

Insert into library_inventory VALUES(1,1004,'N','120.45,'go with wind',1000, 18,25)  
Insert into library_inventory VALUES(2,100,'Y','63.85,'CD',2000,35,80)
Insert into BORROWER VALUES(1,1004,'1380','8-Aug-2019','22-Aug-2019,330,6.24) Insert into Memeber_info VALUES(1380,'Joe kenselle','879253487','12 main st los sangel CA 10000','123456','joeken@gmail.com','y') 
Insert into Book VALUES('USCOPY192877766',100023,376241,2019,'go with wind',1000) 

--Stored procedure returning 5 most borrowed authors for the given year

Use Library

Create store procedure top5author as
declare @year int
select a.author_name, a.author_id from Author A join Book b 
on a.author_id=b.author_id
join Library_inventory c
on b.item_id=c.item_id and c.item_id in 
( select top 5 item_id order by Borrowed_count desc from Library_inventory where year(borrowed_date)=@year)
return


----Function returning # of borrowed materials by the specified members during the specified month

CREATE FUNCTION dbo.materials_borrowed(@memberID int,@month int)  
RETURNS int   
AS   
BEGIN  
    DECLARE @number int;  
    SELECT @number = p.Description  
    FROM Library_inventory p   
    WHERE p.Borrowed_id = @memberID
        and month(p.Borrowed_date)= @month 
     IF (@number IS NULL)   
        SET @number = 0;  
    RETURN @number;  
END; 









  

