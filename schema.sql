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
    DateOfBirth DATE
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
    LegalLicense NVARCHAR(255)
);

CREATE TABLE CharitableOrganizationsRecipients (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NationalID NVARCHAR(14) NOT NULL UNIQUE,
    SocialStatusDescription NVARCHAR(255),
    SerialNumber NVARCHAR(255),
    CustomerID INT NOT NULL,
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
    LegalLicense NVARCHAR(255)
);

-- ===========================
-- Section: Medicines
-- ===========================
CREATE TABLE CommercialMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL
);

CREATE TABLE PrePaidMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL,
    MaximumAmountPerCustomer INT
);

CREATE TABLE CharitableMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL
);

CREATE TABLE RareMedicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Status NVARCHAR(255),
    Amount INT NOT NULL,
    MaximumAmountPerCustomer INT,
    Type NVARCHAR(255),
    MedicineID INT NOT NULL,
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
    Amount INT NOT NULL
);

CREATE TABLE PrePaidHealthcareSupplies (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL,
    MaximumAmountPerCustomer INT
);

CREATE TABLE CharitableHealthcareSupplies (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Type NVARCHAR(255),
    Description NVARCHAR(MAX),
    Amount INT NOT NULL
);

-- ===========================
-- Section: Orders
-- ===========================
CREATE TABLE CustomerOrderLists (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    DateTime DATETIME NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

CREATE TABLE CustomerOrderDetailsLists (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerOrderListID INT NOT NULL,
    ProductID INT NOT NULL,
    Amount INT NOT NULL,
    FOREIGN KEY (CustomerOrderListID) REFERENCES CustomerOrderLists(ID)
);

CREATE TABLE PrePaidOrderLists (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    IsCharitableOrganizationRecipient BIT,
    CustomerNationalID NVARCHAR(14),
    PrescriptionIfNeeded NVARCHAR(255),
    DateTime DATETIME NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

CREATE TABLE PrePaidOrderDetailsLists (
    ID INT PRIMARY KEY IDENTITY(1,1),
    PrePaidOrderListID INT NOT NULL,
    ProductID INT NOT NULL,
    Amount INT NOT NULL,
    FOREIGN KEY (PrePaidOrderListID) REFERENCES PrePaidOrderLists(ID)
);

CREATE TABLE CharitableOrderLists (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    DateTime DATETIME NOT NULL,
    PrescriptionIfNeeded NVARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

CREATE TABLE CharitableOrderDetailsLists (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CharitableOrderListID INT NOT NULL,
    ProductID INT NOT NULL,
    Amount INT NOT NULL,
    FOREIGN KEY (CharitableOrderListID) REFERENCES CharitableOrderLists(ID)
);

-- ===========================
-- Section: Receiving Tickets
-- ===========================
CREATE TABLE CustomerReceivingTickets (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    CustomerOrderListID INT NOT NULL,
    PharmacyID INT NOT NULL,
    DateOfReceivingOrder DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID),
    FOREIGN KEY (CustomerOrderListID) REFERENCES CustomerOrderLists(ID),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacies(ID)
);

CREATE TABLE RecipientReceivingTickets (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    CustomerOrderListID INT NOT NULL,
    PharmacyID INT NOT NULL,
    DateOfReceivingOrder DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID),
    FOREIGN KEY (CustomerOrderListID) REFERENCES CustomerOrderLists(ID),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacies(ID)
);

-- ===========================
-- Section: Prescriptions
-- ===========================
CREATE TABLE PrescriptionsLists (
    ID INT PRIMARY KEY IDENTITY(1,1),
    PharmacyCharitableOrganizationID INT NOT NULL,
    FOREIGN KEY (PharmacyCharitableOrganizationID) REFERENCES CharitableOrganizations(ID)
);

CREATE TABLE Prescriptions (
    ID INT PRIMARY KEY IDENTITY(1,1),
    PrescriptionListID INT NOT NULL,
    CustomerID INT NOT NULL,
    PhotoURL NVARCHAR(MAX),
    CreatedAt DATETIME NOT NULL,
    FOREIGN KEY (PrescriptionListID) REFERENCES PrescriptionsLists(ID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

GO

