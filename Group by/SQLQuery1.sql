--CREATE DATABASE AzMB101_Jafar_GroupBy

USE AzMB101_Jafar_GroupBy

DROP TABLE Sells
DROP TABLE Products
DROP TABLE Fillials
DROP TABLE Workers
DROP TABLE Positions


CREATE TABLE Positions(
	ID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(63) NOT NULL
)

CREATE TABLE Workers(
	ID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(31) NOT NULL,
	Surname VARCHAR(31) NOT NULL,
	Salary MONEY CHECK(Salary > 0),
	Position_ID INT FOREIGN KEY REFERENCES Positions(ID) NOT NULL
)

CREATE TABLE Fillials(
	ID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(63) NOT NULL
)

CREATE TABLE Products(
	ID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(63) NOT NULL,
	Import_Cost MONEY CHECK(Import_Cost > 0) NOT NULL,
	Export_Profit MONEY CHECK(Export_Profit > 0) NOT NULL
)

CREATE TABLE Sells(
	ID INT IDENTITY PRIMARY KEY,
	Worker_ID INT FOREIGN KEY REFERENCES Workers(ID),
	Product_ID INT FOREIGN KEY REFERENCES Products(ID),
	Fillial_ID INT FOREIGN KEY REFERENCES Fillials(ID),
	Sell_Time DATETIME DEFAULT CURRENT_TIMESTAMP
)


INSERT INTO Positions VALUES
('Zorluq'),('Back-End dev helper'),('Back-End Seniour')

INSERT INTO Workers VALUES
('Jafar','Zorzade',999999999,1),('Ülvi','NotZorzade',111111111,2),('Qemer','YeneZorzade',333333333,3)

INSERT INTO Fillials VALUES
('Enderg Fun Games'),('Bizim Market'),('Code Academy')

INSERT INTO Products VALUES
('Lots of Fun x1',10000000,400000000),('Scroll bar service x1',1000,40000),('Chiko semechka x1',10000,400000)

INSERT INTO Sells VALUES
(1,1,1,DEFAULT),(1,2,1,DEFAULT),(2,2,3,DEFAULT),(2,3,2,DEFAULT),(3,2,3,DEFAULT)


SELECT (w.[Name] + ' ' + w.Surname) as Fullname, p.[Name] as 'Product Name', f.[Name] as 'Fillial Name',
p.Import_Cost as 'Cost of importing', p.Export_Profit as 'Profit from exporting'
FROM Sells as s
JOIN Workers as w ON w.ID = s.Worker_ID
JOIN Products as p ON p.ID = s.Product_ID
JOIN Fillials as f ON f.ID = s.Fillial_ID

SELECT SUM(p.Export_Profit) as 'Total gain' FROM Sells as s
JOIN Products as p ON p.ID = s.Product_ID

SELECT p.[Name] as Product, SUM(p.Export_Profit - p.Import_Cost) as 'Profit in this month' FROM Sells as s
JOIN Products as p ON p.ID = s.Product_ID
WHERE DATEDIFF(MONTH,s.Sell_Time,CURRENT_TIMESTAMP) < 1
GROUP BY p.[Name]
