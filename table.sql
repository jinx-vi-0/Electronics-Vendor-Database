-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(255),
    Category VARCHAR(50),
    ManufacturerID INT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    Megapixels INT, -- Example attribute for cameras
    StorageCapacity INT, -- Example attribute for phones
    PackageID INT, -- For products sold as part of a package
    CONSTRAINT fk_manufacturer FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
);

-- Create the Manufacturers table
CREATE TABLE Manufacturers (
    ManufacturerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    ContactPerson VARCHAR(50),
    PhoneNumber VARCHAR(15)
);

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    BillingAddress VARCHAR(255),
    ShippingAddress VARCHAR(255),
    DateOfBirth DATE,
    CardInformation VARCHAR(255), -- For storing credit card details
    ContractAccountNumber VARCHAR(20),
    CONSTRAINT uc_customer UNIQUE (Email, PhoneNumber),
    CONSTRAINT ck_cardinfo CHECK (CardInformation IS NULL OR LENGTH(CardInformation) = 16)
);

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ShipperID INT,
    OrderStatus VARCHAR(20), -- Order status: processing, shipped, delivered, etc.
    DeliveryDate DATE,
    PromisedDeliveryTime TIMESTAMP, -- Promised delivery time
    TrackingNumber VARCHAR(50), -- Tracking number for shipped packages
    CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT fk_shipper FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID)
);

-- Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    DiscountApplied DECIMAL(5, 2),
    TaxAmount DECIMAL(8, 2),
    TotalAmount DECIMAL(12, 2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the Shippers table
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    ContactPerson VARCHAR(50),
    PhoneNumber VARCHAR(15)
);

-- Create the Inventory table
CREATE TABLE Inventory (
    ProductID INT,
    StoreID INT,
    Quantity INT,
    ReorderStatus VARCHAR(20), -- Reorder status
    ReorderDate DATE,
    ReorderQuantity INT,
    PRIMARY KEY (ProductID, StoreID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

-- Create the Stores table
CREATE TABLE Stores (
    StoreID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    State VARCHAR(50),
    ManagerName VARCHAR(50),
    ManagerContact VARCHAR(15),
    StoreSize INT -- Size of the store in square feet
);

-- Create the OnlineCustomers table
CREATE TABLE OnlineCustomers (
    CustomerID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    LastLoginDate TIMESTAMP,
    ShoppingCartID INT, -- Assuming a shopping cart mechanism
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
