# PharmaReachDB

## Overview
PharmaReachDB is a structured relational database designed to support the operations of the PharmaReach system. The database is tailored for managing healthcare-related entities, including customers, pharmacies, medicines, orders, and healthcare supplies. It provides robust support for tracking commercial, charitable, and prepaid transactions in a secure and scalable manner.

## Features
- **Comprehensive Schema**: Organized entities for managing customers, orders, medicines, healthcare supplies, and more.
- **Support for Charitable Operations**: Tracks charitable organizations, recipients, and donations.
- **Order Management**: Handles commercial, prepaid, and charitable orders with detailed tracking of order details and statuses.
- **Pharmacy Integration**: Links pharmacies with prescriptions and medicines.
- **Audit and Tracking**: Supports tracking surplus medicines, rare medicines, and receiving tickets for customers and recipients.

## Database Structure
The database is built using SQL Server and adheres to best practices in database normalization and entity relationships. Below is an outline of the key entities:

### Key Entities
- **Customers**: Stores customer information, including personal details and login credentials.
- **Pharmacies**: Manages pharmacy details, including contact information and licenses.
- **Medicines**: Tracks commercial, charitable, prepaid, and rare medicines with their attributes.
- **Orders**: Handles order lists and details for customers, prepaid transactions, and charitable distributions.
- **Healthcare Supplies**: Manages both commercial and charitable healthcare supplies.
- **Receiving Tickets**: Tracks the receiving of orders by customers and recipients.

### Relationships
The database schema leverages primary and foreign key relationships to maintain data integrity and enforce business rules. 

## ERD (Entity-Relationship Diagram)
The Entity-Relationship Diagram (ERD) visually represents the database structure and relationships. Below is an overview of the ERD:

![ERD Diagram](./DB/Assets/imgs/PharmaReach-ERD.jpg)