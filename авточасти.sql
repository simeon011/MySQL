CREATE DATABASE Avtochasti;
USE Avtochasti;
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Product VARCHAR(100) NOT NULL,
    Marka VARCHAR(100) NOT NULL,
    Model VARCHAR(100) NOT NULL,
    Description TEXT,
    CatalogNumber VARCHAR(100) UNIQUE,
    Price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE Customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(255) NOT NULL
);
CREATE TABLE Purchases (
    PurchaseID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,  
    CustomerID INT, 
    EmployeeID INT, 
    PurchaseDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Price DECIMAL(10, 2) NOT NULL,
    Discount DECIMAL(5, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(id),
    FOREIGN KEY (CustomerID) REFERENCES Customers(id),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(id) 
);
CREATE TABLE Employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(100) NOT NULL
);
INSERT INTO Products (Product, Marka, Model, Description, CatalogNumber, Price)
VALUES 
('Двигател', 'BMW', 'E46', 'Двигател за BMW 3 серия, модел E46', 'DN1234', 1500.00),
('Спирачни дискове', 'Volkswagen', 'Golf 7', 'Спирачни дискове за VW Golf 7', 'SD4567', 250.00),
('Филтър за масло', 'Mercedes-Benz', 'C-Class', 'Оригинален филтър за масло за Mercedes C-Class', 'FM7890', 20.00),
('Спойлер', 'Audi', 'A4', 'Преден спойлер за Audi A4', 'SP0123', 180.00);
INSERT INTO Customers (Name, Email, Phone, Address)
VALUES 
('Иван Иванов', 'ivan@example.com', '0888123456', 'ул. Цветна 5, София'),
('Петър Петров', 'peter@example.com', '0899123456', 'ул. Лилия 10, Пловдив'),
('Мария Георгиева', 'maria@example.com', '0877123456', 'бул. Роза 15, Варна'),
('Георги Димитров', 'georgi@example.com', '0887123456', 'ул. Орех 20, Бургас');
INSERT INTO Employees (Name, Position)
VALUES 
('Иван Иванов', 'Мениджър'),
('Петър Петров', 'Продавач'),
('Мария Георгиева', 'Продавач'),
('Георги Димитров', 'Администратор');
INSERT INTO Purchases (ProductID, CustomerID, EmployeeID, Price, Discount)
VALUES 
(1, 2, 1, 1500.00, 0.00),
(3, 3, 2, 20.00, 0.00),    
(4, 4, 3, 180.00, 10.00);

SELECT * FROM Products WHERE Price > 250;

SELECT CustomerID, COUNT(*) AS TotalPurchased FROM Purchases GROUP BY CustomerID;

SELECT Purchases.ProductID, Purchases.Price, Customers.Name AS CustomerName FROM Purchases  INNER JOIN Customers  ON Purchases.CustomerID = Customers.id;

SELECT Products.*, Purchases.* FROM Products LEFT OUTER JOIN Purchases ON Products.id = Purchases.ProductID;

SELECT * FROM Products WHERE Price > (SELECT AVG(Price) FROM Products);

SELECT Customers.Name AS CustomerName, COUNT(Purchases.ProductID) AS TotalPurchases FROM Customers  LEFT JOIN Purchases  ON Customers.id = Purchases.CustomerID GROUP BY Customers.id, Customers.Name;

DELIMITER |
CREATE TRIGGER purchases_insert_trigger
AFTER INSERT ON Purchases
FOR EACH ROW
BEGIN
    INSERT INTO Purchase_Log (PurchaseID, PurchaseTime)
    VALUES (NEW.PurchaseID, NOW());
END;
|
DELIMITER ;

DELIMITER |
CREATE PROCEDURE GetAllCustomers()
BEGIN
    SELECT * FROM Customers;
END;
|
DELIMITER ;
 
 



 
