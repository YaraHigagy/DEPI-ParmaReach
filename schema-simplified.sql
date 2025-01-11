/*
>> DATABASE NAME: PharmaReachDB
*/

-- Step 1: Create the Database
CREATE DATABASE PharmaReachDB;
GO

-- Step 2: Use the Database
USE PharmaReachDB;
GO

-- Step 3: Create Tables

-- Section: Users (Combining Customers, Charitable Organizations, and Pharmacies)
CREATE TABLE Users (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    Role NVARCHAR(50) NOT NULL, -- 'Customer', 'Organization', 'Pharmacy'
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Section: Medicines (Combining All Medicine Types)
CREATE TABLE Medicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255), -- 'Commercial', 'Charitable', 'Rare', etc.
    Description NVARCHAR(MAX),
    Amount INT NOT NULL,
    Price DECIMAL(10,2), -- For commercial/prepaid medicines
    ExpirationDate DATE,
    MaximumAmountPerCustomer INT
);

-- Section: Orders (Simplified for All Users)
CREATE TABLE Orders (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    TotalPrice DECIMAL(10,2),
    DateTime DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

CREATE TABLE OrderDetails (
    ID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    MedicineID INT NOT NULL,
    Amount INT NOT NULL,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(ID),
    FOREIGN KEY (MedicineID) REFERENCES Medicines(ID)
);

-- Section: Surplus Medicines for Donation
CREATE TABLE SurplusMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    ExpirationDate DATE,
    Amount INT NOT NULL,
    DonorUserID INT NOT NULL,
    IsApproved BIT DEFAULT 0,
    FOREIGN KEY (DonorUserID) REFERENCES Users(ID)
);

-- Section: Prescriptions
CREATE TABLE Prescriptions (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    PhotoURL NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

GO
