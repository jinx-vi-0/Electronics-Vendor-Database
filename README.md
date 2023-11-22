# Electronics Vendor Database

This project is an Electronics Vendor Database designed to manage products, manufacturers, customers, orders, and inventory for an electronics store.

## Table of Contents

1. [Introduction](#introduction)
2. [Database Schema](#database-schema)
3. [Table Descriptions](#table-descriptions)
4. [Queries](#queries)
5. [Usage](#usage)

## Introduction

The Electronics Vendor Database is a relational database management system that facilitates the management of electronic products, manufacturers, customer information, orders, and inventory for an electronics vendor.

## Database Schema

The database schema includes the following tables:
- Products
- Manufacturers
- Customers
- Orders
- OrderDetails
- Shippers
- Inventory
- Stores
- OnlineCustomers

## Table Descriptions

- **Products**: Stores information about electronic products including cameras, phones, TVs, laptops, and desktops.
- **Manufacturers**: Contains details about manufacturers producing electronic products.
- **Customers**: Manages customer information including billing and shipping addresses.
- **Orders**: Stores information about customer orders, shipping details, and order status.
- **OrderDetails**: Contains details about individual products within an order, including quantity, price, and discounts.
- **Shippers**: Manages information about shipping companies responsible for order deliveries.
- **Inventory**: Tracks the quantity and status of products in various stores.
- **Stores**: Contains information about physical stores, including location and manager details.
- **OnlineCustomers**: Stores information about customers using the online platform.

## Queries

Example queries for common tasks or analytics within the system:
- Find the contact information for a customer whose package was reported destroyed.
- Identify the customer who spent the most in the past year.
- Find the top 2 products by dollar-amount sold in the past year.
- Find the top 2 products by unit sales in the past year.
- Identify products that are out-of-stock at every store in California.
- Find packages that were not delivered within the promised time.
- Generate bills for each customer for the past month.

## Usage

1. **Database Setup**:
   - Create the database.
   - Execute the SQL script to create tables.
   - Insert initial data into tables.

2. **Running Queries**:
   - Execute SQL queries to retrieve information from the database.
   - Examples are provided in the "Queries" section.

3. **Customization**:
   - Adjust the database schema or queries based on specific project requirements.

