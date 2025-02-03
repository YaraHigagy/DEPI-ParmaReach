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
-- Section: ProductTypes
-- ===========================
CREATE TABLE ProductTypes (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(1000),
);

-- ===========================
-- Categories for Medicines
-- ===========================
CREATE TABLE MedicineCategories (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(1000)
);

-- ===========================
-- Categories for Healthcare Supplies
-- ===========================
CREATE TABLE HealthcareSupplyCategories (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(1000)
);

-- ===========================
-- Section: Medicines
-- ===========================
CREATE TABLE Medicines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    CategoryID INT NOT NULL,
    Amount INT NOT NULL CHECK (Amount >= 0),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES MedicineCategories(ID)
);

-- ===========================
-- Section: Healthcare Supplies
-- ===========================
CREATE TABLE HealthcareSupplies (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    CategoryID INT NOT NULL,
    Amount INT NOT NULL CHECK (Amount >= 0),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES HealthcareSupplyCategories(ID)
);

-- ===========================
-- Section: Charitable Medicines
-- ===========================
CREATE TABLE CharitableMedicines (
    ID INT PRIMARY KEY REFERENCES Medicines(ID),
    DonorCustomerID INT,
    CharityOrganizationID INT
);

-- ===========================
-- Section: Prepaid Medicines
-- ===========================
CREATE TABLE PrePaidMedicines (
    ID INT PRIMARY KEY REFERENCES Medicines(ID),
    MinimumAmountPerCustomer INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- ===========================
-- Section: Rare Medicines
-- ===========================
CREATE TABLE RareMedicines (
    ID INT PRIMARY KEY REFERENCES Medicines(ID),
    Status NVARCHAR(50),
    MinimumAmountPerCustomer INT NOT NULL
);

-- ===========================
-- Section: Surplus Medicines
-- ===========================
CREATE TABLE SurplusMedicines (
    ID INT PRIMARY KEY REFERENCES Medicines(ID),
    ExpirationDate DATE NOT NULL,
    Photo NVARCHAR(MAX),
    DonorCustomerID INT NOT NULL
);

-- ===========================
-- Section: Charitable Healthcare Supplies
-- ===========================
CREATE TABLE CharitableHealthcareSupplies (
    ID INT PRIMARY KEY REFERENCES HealthcareSupplies(ID),
    DonorCustomerID INT,
    CharityOrganizationID INT
);

-- ===========================
-- Section: Prepaid Healthcare Supplies
-- ===========================
CREATE TABLE PrePaidHealthcareSupplies (
    ID INT PRIMARY KEY REFERENCES HealthcareSupplies(ID),
    MinimumAmountPerCustomer INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- ===========================
-- Section: Orders
-- ===========================
CREATE TABLE Orders (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderType NVARCHAR(50) CHECK (OrderType IN ('Commercial', 'Charitable', 'Prepaid')),
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
-- Section: Order Details
-- ===========================
CREATE TABLE OrderDetails (
    OrderID INT REFERENCES Orders(ID),
    ProductID INT NOT NULL,
    ProductType NVARCHAR(50) CHECK (ProductType IN ('Medicine', 'HealthcareSupply')),
    ProductCategoryID INT,  -- Foreign key to either MedicineCategories or HealthcareSupplyCategories
    Amount INT NOT NULL CHECK (Amount > 0),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (ProductCategoryID) REFERENCES MedicineCategories(ID),  -- If ProductType is Medicine
    FOREIGN KEY (ProductCategoryID) REFERENCES HealthcareSupplyCategories(ID)  -- If ProductType is HealthcareSupply
);

-- ===========================
-- Section: Tickets
-- ===========================
CREATE TABLE Tickets (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderID INT REFERENCES Orders(ID),
    IssuedBy NVARCHAR(50) CHECK (IssuedBy IN ('Pharmacy', 'CharityOrganization')),
    IssuedAt DATETIME DEFAULT GETDATE(),a
    CreatedBy NVARCHAR(255),
    UpdatedAt DATETIME,
    UpdatedBy NVARCHAR(255),
    IsDeleted BIT DEFAULT 0,
    DeletedBy NVARCHAR(255),
    DeletedDate DATETIME,
    DeletedReason NVARCHAR(255)
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);
