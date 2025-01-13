/*
>> DATABASE NAME: PharmaReachDB
*/

-- ===========================
-- Step 1: Create the Database
-- ===========================
CREATE DATABASE PharmaReachDB;
GO

-- ===========================
-- Step 2: Use the Database
-- ===========================
USE PharmaReachDB;
GO

-- ===========================
-- Step 3: Create Tables
-- ===========================

-- ===========================
-- Section: Customers
-- ===========================
CREATE TABLE Customers (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Address NVARCHAR(255),
    Password NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15),
    DateOfBirth DATE,
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255)
);

-- ===========================
-- Section: Charitable Organizations
-- ===========================
CREATE TABLE CharitableOrganizations (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    Password NVARCHAR(255) NOT NULL,
    LegalLicense NVARCHAR(255),
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255)
);

CREATE TABLE CharitableOrganizationsRecipients (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NationalID NVARCHAR(14) NOT NULL UNIQUE,
    SocialStatusDescription NVARCHAR(255),
    SerialNumber NVARCHAR(255),
    CustomerID INT NOT NULL,
    IsApproved BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

-- ===========================
-- Section: Pharmacies
-- ===========================
CREATE TABLE Pharmacies (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    Password NVARCHAR(255) NOT NULL,
    LegalLicense NVARCHAR(255),
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255)
);

-- ===========================
-- Section: Medicines
-- ===========================
CREATE TABLE CommercialMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL DEFAULT 0.0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255)
);

CREATE TABLE PrePaidMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL,
    MaximumAmountPerCustomer INT,
    Price DECIMAL(10, 2) NOT NULL DEFAULT 0.0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255)
);

CREATE TABLE CharitableMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL,
    ExpirationDate DATE,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255)
);

CREATE TABLE RareMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Status NVARCHAR(255),
    Amount INT NOT NULL,
    MaximumAmountPerCustomer INT,
    Type NVARCHAR(255),
    MedicineID INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (MedicineID) REFERENCES CommercialMedicines(ID)
);

CREATE TABLE SurplusMedicinesForExamination (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    ExpirationDate DATE,
    Amount INT NOT NULL,
    DonorCustomerID INT,
    IsApproved BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (DonorCustomerID) REFERENCES Customers(ID)
);

-- ===========================
-- Section: Healthcare Supplies
-- ===========================
CREATE TABLE CommercialHealthcareSupplies (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL DEFAULT 0.0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255)
);

-- ===========================
-- Section: Orders
-- ===========================
CREATE TABLE CustomerOrderLists (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    DateTime DATETIME NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL DEFAULT 0.0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);
