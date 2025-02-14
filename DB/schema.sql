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
-- Section: Users (Abstract Table - Do not create directly)
-- ===========================
/*
This table serves as a base for Customers, Pharmacies, and CharitableOrganizations.
It contains common fields and audit columns.  You won't create this table directly;
instead, you'll inherit from it in the other tables.
*/

-- ===========================
-- Section: Customers
-- ===========================
CREATE TABLE Customers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    DateOfBirth DATE,
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedById INT NULL, -- Reference to Customers (Admin or the Customer itself)
    UpdatedAt DATETIME,
    UpdatedById INT NULL, -- Reference to Customers
    IsDeleted BIT DEFAULT 0,
    DeletedById INT NULL, -- Reference to Customers
    DeletedAt DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CreatedById) REFERENCES Customers(Id),
    FOREIGN KEY (UpdatedById) REFERENCES Customers(Id),
    FOREIGN KEY (DeletedById) REFERENCES Customers(Id)
);

-- ===========================
-- Section: Charitable Organizations
-- ===========================
CREATE TABLE CharitableOrganizations (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    LegalLicense NVARCHAR(255),
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedById INT NULL,  -- Reference to CharitableOrganizations (Admin or the Organization itself)
    UpdatedAt DATETIME,
    UpdatedById INT NULL,  -- Reference to CharitableOrganizations
    IsDeleted BIT DEFAULT 0,
    DeletedById INT NULL,  -- Reference to CharitableOrganizations
    DeletedAt DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CreatedById) REFERENCES CharitableOrganizations(Id),
    FOREIGN KEY (UpdatedById) REFERENCES CharitableOrganizations(Id),
    FOREIGN KEY (DeletedById) REFERENCES CharitableOrganizations(Id)
);

-- Charitable Organizations Recipients Table
CREATE TABLE CharitableOrganizationsRecipients (
    Id INT PRIMARY KEY IDENTITY(1,1),
    NationalId NVARCHAR(14) NOT NULL UNIQUE,
    SocialStatusDescription NVARCHAR(255),
    SerialNumber NVARCHAR(255),
    CustomerId INT NOT NULL,
    IsApproved BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),

    -- Audit Fields
    CreatedById INT NULL,
    UpdatedAt DATETIME,
    UpdatedById INT NULL,
    IsDeleted BIT DEFAULT 0,
    DeletedById INT NULL,
    DeletedAt DATETIME,
    DeletedReason NVARCHAR(255),

    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
       FOREIGN KEY (CreatedById) REFERENCES CharitableOrganizations(Id),
    FOREIGN KEY (UpdatedById) REFERENCES CharitableOrganizations(Id),
    FOREIGN KEY (DeletedById) REFERENCES CharitableOrganizations(Id)
);

-- ===========================
-- Section: Pharmacies
-- ===========================
CREATE TABLE Pharmacies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    LegalLicense NVARCHAR(255),
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedById INT NULL,  -- Reference to Pharmacies (Admin or the Pharmacy itself)
    UpdatedAt DATETIME,
    UpdatedById INT NULL,  -- Reference to Pharmacies
    IsDeleted BIT DEFAULT 0,
    DeletedById INT NULL,  -- Reference to Pharmacies
    DeletedAt DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CreatedById) REFERENCES Pharmacies(Id),
    FOREIGN KEY (UpdatedById) REFERENCES Pharmacies(Id),
    FOREIGN KEY (DeletedById) REFERENCES Pharmacies(Id)
);

-- ===========================
-- Section: ProductTypes
-- ===========================
CREATE TABLE ProductTypes (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(1000),
);

-- ===========================
-- Categories for Medicines
-- ===========================
CREATE TABLE MedicineCategories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(1000)
);

-- ===========================
-- Categories for Healthcare Supplies
-- ===========================
CREATE TABLE HealthcareSupplyCategories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(1000)
);

-- ===========================
-- Section: Medicines
-- ===========================
CREATE TABLE Medicines (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    CategoryId INT NOT NULL,
    Amount INT NOT NULL CHECK (Amount >= 0),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedById INT NULL,
    UpdatedAt DATETIME,
    UpdatedById INT NULL,
    IsDeleted BIT DEFAULT 0,
    DeletedById INT NULL,
    DeletedAt DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CategoryId) REFERENCES MedicineCategories(Id),
    FOREIGN KEY (CreatedById) REFERENCES Pharmacies(Id),  -- Updated Foreign key
    FOREIGN KEY (UpdatedById) REFERENCES Pharmacies(Id),  -- Updated Foreign key
    FOREIGN KEY (DeletedById) REFERENCES Pharmacies(Id)   -- Updated Foreign key
);

-- ===========================
-- Section: Healthcare Supplies
-- ===========================
CREATE TABLE HealthcareSupplies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    CategoryId INT NOT NULL,
    Amount INT NOT NULL CHECK (Amount >= 0),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedById INT NULL, -- Reference to Pharmacies (or Admin)
    UpdatedAt DATETIME,
    UpdatedById INT NULL, -- Reference to Pharmacies (or Admin)
    IsDeleted BIT DEFAULT 0,
    DeletedById INT NULL, -- Reference to Pharmacies (or Admin)
    DeletedAt DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CategoryId) REFERENCES HealthcareSupplyCategories(Id),
    FOREIGN KEY (CreatedById) REFERENCES Pharmacies(Id),  -- Updated Foreign key
    FOREIGN KEY (UpdatedById) REFERENCES Pharmacies(Id),  -- Updated Foreign key
    FOREIGN KEY (DeletedById) REFERENCES Pharmacies(Id)   -- Updated Foreign key
);

-- ===========================
-- Section: Charitable Medicines
-- ===========================
CREATE TABLE CharitableMedicines (
    Id INT PRIMARY KEY REFERENCES Medicines(Id),
    DonorCustomerId INT,
    CharityOrganizationId INT
);

-- ===========================
-- Section: Prepaid Medicines
-- ===========================
CREATE TABLE PrePaidMedicines (
    Id INT PRIMARY KEY REFERENCES Medicines(Id),
    MinimumAmountPerCustomer INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- ===========================
-- Section: Rare Medicines
-- ===========================
CREATE TABLE RareMedicines (
    Id INT PRIMARY KEY REFERENCES Medicines(Id),
    Status NVARCHAR(50),
    MinimumAmountPerCustomer INT NOT NULL
);

-- ===========================
-- Section: Surplus Medicines
-- ===========================
CREATE TABLE SurplusMedicines (
    Id INT PRIMARY KEY REFERENCES Medicines(Id),
    ExpirationDate DATE NOT NULL,
    Photo NVARCHAR(MAX),
    DonorCustomerId INT NOT NULL
);

-- ===========================
-- Section: Charitable Healthcare Supplies
-- ===========================
CREATE TABLE CharitableHealthcareSupplies (
    Id INT PRIMARY KEY REFERENCES HealthcareSupplies(Id),
    DonorCustomerId INT,
    CharityOrganizationId INT
);

-- ===========================
-- Section: Prepaid Healthcare Supplies
-- ===========================
CREATE TABLE PrePaidHealthcareSupplies (
    Id INT PRIMARY KEY REFERENCES HealthcareSupplies(Id),
    MinimumAmountPerCustomer INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- ===========================
-- Section: Pharmacy-Medicine Relationship
-- ===========================
CREATE TABLE PharmacyMedicine (
    PharmacyId INT NOT NULL,
    MedicineId INT NOT NULL,
    PRIMARY KEY (PharmacyId, MedicineId),
    FOREIGN KEY (PharmacyId) REFERENCES Pharmacies(Id),
    FOREIGN KEY (MedicineId) REFERENCES Medicines(Id)
);

-- ===========================
-- Section: Pharmacy-Healthcare Supply Relationship
-- ===========================
CREATE TABLE PharmacyHealthcareSupply (
    PharmacyId INT NOT NULL,
    HealthcareSupplyId INT NOT NULL,
    PRIMARY KEY (PharmacyId, HealthcareSupplyId),
    FOREIGN KEY (PharmacyId) REFERENCES Pharmacies(Id),
    FOREIGN KEY (HealthcareSupplyId) REFERENCES HealthcareSupplies(Id)
);

-- ===========================
-- Section: Charitable Organization-Medicine Relationship
-- ===========================
CREATE TABLE CharityOrganizationMedicine (
    CharityOrganizationId INT NOT NULL,
    MedicineId INT NOT NULL,
    PRIMARY KEY (CharityOrganizationId, MedicineId),
    FOREIGN KEY (CharityOrganizationId) REFERENCES CharitableOrganizations(Id),
    FOREIGN KEY (MedicineId) REFERENCES Medicines(Id)
);

-- ===========================
-- Section: Orders
-- ===========================
CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL,
    OrderType NVARCHAR(50) CHECK (OrderType IN ('Commercial', 'Charitable', 'Prepaid')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedById INT NULL,  -- Reference to Customers
    UpdatedAt DATETIME,
    UpdatedById INT NULL,  -- Reference to Customers
    IsDeleted BIT DEFAULT 0,
    DeletedById INT NULL,  -- Reference to Customers
    DeletedAt DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (CreatedById) REFERENCES Customers(Id),  -- Updated Foreign key
    FOREIGN KEY (UpdatedById) REFERENCES Customers(Id),  -- Updated Foreign key
    FOREIGN KEY (DeletedById) REFERENCES Customers(Id)   -- Updated Foreign key
);

-- ===========================
-- Section: Order Details
-- ===========================
CREATE TABLE OrderDetails (
    OrderId INT REFERENCES Orders(Id),
    ProductId INT NOT NULL,
    ProductType NVARCHAR(50) CHECK (ProductType IN ('Medicine', 'HealthcareSupply')),
    ProductCategoryId INT,  -- Foreign key to either MedicineCategories or HealthcareSupplyCategories
    Amount INT NOT NULL CHECK (Amount > 0),
    PRIMARY KEY (OrderId, ProductId),
    FOREIGN KEY (ProductCategoryId) REFERENCES MedicineCategories(Id),  -- If ProductType is Medicine
    FOREIGN KEY (ProductCategoryId) REFERENCES HealthcareSupplyCategories(Id)  -- If ProductType is HealthcareSupply
);

-- ===========================
-- Section: Tickets
-- ===========================
CREATE TABLE Tickets (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL,
    OrderId INT REFERENCES Orders(Id),
    IssuedBy NVARCHAR(50), -- CHECK (IssuedBy IN ('Pharmacy', 'CharityOrganization')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedById INT NULL,
    UpdatedAt DATETIME,
    UpdatedById INT NULL,
    IsDeleted BIT DEFAULT 0,
    DeletedById INT NULL,
    DeletedAt DATETIME,
    DeletedReason NVARCHAR(255),
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (CreatedById) REFERENCES Customers(Id),  -- Updated Foreign key
    FOREIGN KEY (UpdatedById) REFERENCES Customers(Id),  -- Updated Foreign key
    FOREIGN KEY (DeletedById) REFERENCES Customers(Id)   -- Updated Foreign key
);
