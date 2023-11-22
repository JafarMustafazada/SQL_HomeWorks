
GO
--CREATE DATABASE AzMB101_Jafar_Alinono
USE AzMB101_Jafar_Alinono

DROP TABLE Comments
DROP TABLE Books_Language
DROP TABLE [Language]
DROP TABLE Books_Genres
DROP TABLE Genres
DROP TABLE Authors_Books
DROP TABLE Books
DROP TABLE [Bindings]
DROP TABLE Authors
DROP TABLE Publishing_House
DROP TABLE Categories

CREATE TABLE Categories(
	ID INT IDENTITY PRIMARY KEY,
	Title VARCHAR(31) NOT NULL,
	Parent_ID INT FOREIGN KEY REFERENCES Categories(ID),
	Is_Deleted BIT DEFAULT 0
)

CREATE TABLE Publishing_House(
	ID INT IDENTITY PRIMARY KEY,
	Title VARCHAR(31) NOT NULL,
	Is_Deleted BIT DEFAULT 0
)

CREATE TABLE Authors(
	ID INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(31),
	Surname NVARCHAR(31),
	Is_Deleted BIT DEFAULT 0
)

CREATE TABLE [Bindings](
	ID INT IDENTITY PRIMARY KEY,
	Title NVARCHAR(31) NOT NULL,
	Is_Deleted BIT DEFAULT 0
)

CREATE TABLE Books(
	ID INT IDENTITY PRIMARY KEY,
	Title NVARCHAR(31) NOT NULL,
	[Description] NVARCHAR(131),
	Actual_Price MONEY,
	Discount_Price MONEY DEFAULT NULL,
	Pages INT,
	Stock_Count INT,
	Article_Code INT,
	Publishing_House_ID INT FOREIGN KEY REFERENCES Publishing_House(ID),
	Binding_ID INT FOREIGN KEY REFERENCES [Bindings](ID),
	Is_Deleted BIT DEFAULT 0
)

CREATE TABLE Authors_Books(
	ID INT IDENTITY PRIMARY KEY,
	Books_ID INT FOREIGN KEY REFERENCES Books(ID),
	Author_ID INT FOREIGN KEY REFERENCES Authors(ID),
	Is_Deleted BIT DEFAULT 0
)

CREATE TABLE Genres(
	ID INT IDENTITY PRIMARY KEY,
	Title NVARCHAR(31) NOT NULL,
	Is_Deleted BIT DEFAULT 0
)

CREATE TABLE Books_Genres(
	ID INT IDENTITY PRIMARY KEY,
	Books_ID INT FOREIGN KEY REFERENCES Books(ID),
	Genre_ID INT FOREIGN KEY REFERENCES Genres(ID),
	Is_Deleted BIT DEFAULT 0
)


CREATE TABLE [Language](
	ID INT IDENTITY PRIMARY KEY,
	Title NVARCHAR(31) NOT NULL,
	Is_Deleted BIT DEFAULT 0
)

CREATE TABLE Books_Language(
	ID INT IDENTITY PRIMARY KEY,
	Books_ID INT FOREIGN KEY REFERENCES Books(ID),
	Language_ID INT FOREIGN KEY REFERENCES [Language](ID),
	Is_Deleted BIT DEFAULT 0
)


CREATE TABLE Comments(
	ID INT IDENTITY PRIMARY KEY,
	Book_ID INT FOREIGN KEY REFERENCES Books(ID),
	[Description] NVARCHAR(131),
	Rating TINYINT CHECK(Rating BETWEEN 0 AND 5),
	[Name] VARCHAR(31),
	Email VARCHAR(31),
	ImageURL NVARCHAR(MAX),
	Is_Deleted BIT DEFAULT 0
)


GO
CREATE TRIGGER After_Delete_Categories
ON Categories
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Categories
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Publishing_House
ON Publishing_House
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Publishing_House
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Authors
ON Authors
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Authors
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Bindings
ON [Bindings]
INSTEAD OF DELETE AS 
BEGIN
	UPDATE [Bindings]
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Books
ON Books
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Books
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Authors_Books
ON Authors_Books
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Authors_Books
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Genres
ON Genres
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Genres
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Books_Genres
ON Books_Genres
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Books_Genres
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Language
ON [Language]
INSTEAD OF DELETE AS 
BEGIN
	UPDATE [Language]
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Books_Language
ON Books_Language
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Books_Language
	SET Is_Deleted = 1
END

GO
CREATE TRIGGER After_Delete_Comments
ON Comments
INSTEAD OF DELETE AS 
BEGIN
	UPDATE Comments
	SET Is_Deleted = 1
END



GO
DROP PROCEDURE Insert_Into_Categories
DROP PROCEDURE Insert_Into_Authors
DROP PROCEDURE Insert_Into_Bindings
DROP PROCEDURE Insert_Into_Books
DROP PROCEDURE Insert_Into_Authors_Books
DROP PROCEDURE Insert_Into_Genres
DROP PROCEDURE Insert_Into_Books_Genres
DROP PROCEDURE Insert_Into_Language
DROP PROCEDURE Insert_Into_Books_Language
DROP PROCEDURE Insert_Into_Comments

GO
CREATE PROCEDURE Insert_Into_Categories
(@Title varchar(31),@Parent_ID INT = NULL)
AS
BEGIN
INSERT INTO Categories VALUES (@Title, @Parent_ID, DEFAULT)
END

GO
CREATE PROCEDURE Insert_Into_Authors
(
    @Name NVARCHAR(31),
    @Surname NVARCHAR(31)
)
AS
BEGIN
    INSERT INTO Authors
    VALUES (@Name, @Surname, 1) 
END

GO
CREATE PROCEDURE Insert_Into_Bindings
(
    @Title NVARCHAR(31)
)
AS
BEGIN
    INSERT INTO [Bindings]
    VALUES (@Title, 1)
END


GO
CREATE PROCEDURE Insert_Into_Books
(
    @Title NVARCHAR(31),
    @Description NVARCHAR(131),
    @Actual_Price MONEY,
    @Discount_Price MONEY = NULL,
    @Pages INT,
    @Stock_Count INT,
    @Article_Code INT,
    @Publishing_House_ID INT,
    @Binding_ID INT
)
AS
BEGIN
    INSERT INTO Books 
    VALUES (@Title, @Description, @Actual_Price, @Discount_Price, @Pages, @Stock_Count, @Article_Code, @Publishing_House_ID, @Binding_ID, 1)
END


GO
CREATE PROCEDURE Insert_Into_Authors_Books
(
    @Books_ID INT,
    @Author_ID INT
)
AS
BEGIN
    INSERT INTO Authors_Books
    VALUES (@Books_ID, @Author_ID, 1)
END


GO
CREATE PROCEDURE Insert_Into_Genres
(
    @Title NVARCHAR(31)
)
AS
BEGIN
    INSERT INTO Genres 
    VALUES (@Title, 1) 
END


GO
CREATE PROCEDURE Insert_Into_Books_Genres
(
    @Books_ID INT,
    @Genre_ID INT
)
AS
BEGIN
    INSERT INTO Books_Genres
    VALUES (@Books_ID, @Genre_ID, 1)
END


GO
CREATE PROCEDURE Insert_Into_Language
(
    @Title NVARCHAR(31)
)
AS
BEGIN
    INSERT INTO [Language]
    VALUES (@Title, 1)
END


GO
CREATE PROCEDURE Insert_Into_Books_Language
(
    @BookS_ID INT,
    @Language_ID INT
)
AS
BEGIN
    INSERT INTO Books_Language
    VALUES (@Books_ID, @Language_ID, 1)
END


GO
CREATE PROCEDURE Insert_Into_Comments
(
    @Book_ID INT,
    @Description NVARCHAR(131),
    @Rating TINYINT,
    @Name VARCHAR(31),
    @Email VARCHAR(31),
    @ImageURL NVARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO Comments
    VALUES (@Book_ID, @Description, @Rating, @Name, @Email, @ImageURL, 1) 
END



GO
DROP PROCEDURE Update_Into_Categories
DROP PROCEDURE Update_Into_Authors
DROP PROCEDURE Update_Into_Bindings
DROP PROCEDURE Update_Into_Books
DROP PROCEDURE Update_Into_Authors_Books
DROP PROCEDURE Update_Into_Genres
DROP PROCEDURE Update_Into_Books_Genres
DROP PROCEDURE Update_Into_Language
DROP PROCEDURE Update_Into_Books_Language
DROP PROCEDURE Update_Into_Comments

GO
CREATE PROCEDURE Update_Into_Categories
(@ID INT, @Title varchar(31),@Parent_ID INT = NULL)
AS
BEGIN
Update Categories 
SET Title = @Title, Parent_ID = @Parent_ID
WHERE @ID = Categories.ID
END

GO
CREATE PROCEDURE Update_Into_Authors
(
	@ID INT,
    @Name NVARCHAR(31),
    @Surname NVARCHAR(31)
)
AS
BEGIN
    Update Authors
	SET Name = @Name, Surname = @Surname
	WHERE @ID = Authors.ID
END

GO
CREATE PROCEDURE Update_Into_Bindings
(
	@ID INT,
    @Title NVARCHAR(31)
)
AS
BEGIN
    Update [Bindings]
     SET Title = @Title
	 WHERE @ID = Bindings.ID
END


GO
CREATE PROCEDURE Update_Into_Books
(
	@ID INT,
    @Title NVARCHAR(31),
    @Description NVARCHAR(131),
    @Actual_Price MONEY,
    @Discount_Price MONEY = NULL,
    @Pages INT,
    @Stock_Count INT,
    @Article_Code INT,
    @Publishing_House_ID INT,
    @Binding_ID INT
)
AS
BEGIN
    Update Books 
    SET Title = @Title, [Description] = @Description, Actual_Price = @Actual_Price, Discount_Price = @Discount_Price,
	Pages = @Pages, Stock_Count = @Stock_Count, Article_Code = @Article_Code, Publishing_House_ID = @Publishing_House_ID, Binding_ID = @Binding_ID
	WHERE @ID = Books.ID
END


GO
CREATE PROCEDURE Update_Into_Authors_Books
(
	@ID INT,
    @Books_ID INT,
    @Author_ID INT
)
AS
BEGIN
    Update Authors_Books
    SET Books_ID = @Books_ID, Author_ID = @Author_ID
	WHERE @ID = Authors_Books.ID
END


GO
CREATE PROCEDURE Update_Into_Genres
(
	@ID INT,
    @Title NVARCHAR(31)
)
AS
BEGIN
    Update Genres 
    SET Title = @Title
	WHERE @ID = Genres.ID
END


GO
CREATE PROCEDURE Update_Into_Books_Genres
(
	@ID INT,
    @Books_ID INT,
    @Genre_ID INT
)
AS
BEGIN
    Update Books_Genres
    SET Books_ID = @Books_ID, Genre_ID = @Genre_ID
	WHERE @ID = Books_Genres.ID
END


GO
CREATE PROCEDURE Update_Into_Language
(
	@ID INT,
    @Title NVARCHAR(31)
)
AS
BEGIN
    Update [Language]
    SET Title = @Title
	WHERE @ID = [Language].ID
END


GO
CREATE PROCEDURE Update_Into_Books_Language
(
	@ID INT,
    @BookS_ID INT,
    @Language_ID INT
)
AS
BEGIN
    Update Books_Language
    SET Books_ID = @BookS_ID, Language_ID = @Language_ID
	WHERE @ID = Books_Language.ID

END


GO
CREATE PROCEDURE Update_Into_Comments
(
	@ID INT,
    @Book_ID INT,
    @Description NVARCHAR(131),
    @Rating TINYINT,
    @Name VARCHAR(31),
    @Email VARCHAR(31),
    @ImageURL NVARCHAR(MAX)
)
AS
BEGIN
    Update Comments
    SET Book_ID = @Book_ID, [Description] = @Description, Rating = @Rating, 
	[Name] = @Name, Email = @Email, ImageURL = @ImageURL
	WHERE @ID = Comments.ID
END
