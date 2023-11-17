--CREATE DATABASE AzMB101_Jafar_SQLJoins_Task1
USE AzMB101_Jafar_SQLJoins_Task1

--DROP TABLE Users
--DROP TABLE Roles

CREATE TABLE Roles(
	ID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(20) NOT NULL UNIQUE
)

CREATE TABLE Users(
	ID INT IDENTITY PRIMARY KEY,
	Username VARCHAR(20) NOT NULL UNIQUE,
	[Password] VARCHAR(20) NOT NULL,
	Role_ID INT FOREIGN KEY REFERENCES Roles(ID)
)

INSERT INTO Roles VALUES
('Zor olmaq'),
('Be Ulvi'),
('Yene zor olmamaq')

INSERT INTO Users VALUES
('Jafar','ZorParol123', 1),
('Zorzade','ZorParol327', NULL)

SELECT u.Username as [User], r.Name as [Role]
FROM Users as u
LEFT JOIN Roles as r ON r.ID = u.Role_ID


-- TASK 2
--DROP TABLE Categories

CREATE TABLE Categories(
	ID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(20) NOT NULL,
	Parent_ID INT FOREIGN KEY REFERENCES Categories(ID)
)

INSERT INTO Categories VALUES
('Sweets',NULL),
('Cakes',1),
('Cheesecakes',2),
('Biscuits',2),
('Sand Cakes',2),
('Waffle cakes',2),
('Flour',NULL),
('Tandir',7),
('Vegetables',NULL)

Select c1.[Name] as Parent, c2.[Name] as Child
FROM Categories as c1
RIGHT JOIN Categories as c2 ON c2.Parent_ID = c1.ID
