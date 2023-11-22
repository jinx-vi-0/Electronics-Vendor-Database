
-- Find contact information for the customer
SELECT c.FirstName, c.LastName, c.Email, c.PhoneNumber
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Shippers s ON o.ShipperID = s.ShipperID
WHERE o.TrackingNumber = '123456';

-- Find contents of the shipment and create a new shipment of replacement items
INSERT INTO Orders (CustomerID, OrderDate, ShipperID, OrderStatus, PromisedDeliveryTime, TrackingNumber)
VALUES (customer_id, CURRENT_DATE, new_shipper_id, 'Processing', CURRENT_TIMESTAMP + INTERVAL '5 days', 'NEW_TRACKING_NUMBER');

-- Insert the replacement items into OrderDetails table
-- Adjust ProductID, Quantity, Price, and other details based on the actual replacement items
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price, DiscountApplied, TaxAmount, TotalAmount)
VALUES(new_order_id, replacement_product_id_1, quantity_1, price_1, discount_1, tax_1, total_amount_1),
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price, DiscountApplied, TaxAmount, TotalAmount)
VALUES(new_order_id, replacement_product_id_2, quantity_2, price_2, discount_2, tax_2, total_amount_2);


-----------------------------------------------

-- Find the customer who has bought the most (by price) in the past year: --

SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(od.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.OrderDate >= SYSDATE - INTERVAL '1' YEAR
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC
FETCH FIRST 1 ROWS ONLY;



-------------------------------------------

-- Find the top 2 products by dollar-amount sold in the past year: --

SELECT
    p.ProductID,
    p.Name,
    SUM(od.TotalAmount) AS TotalSales
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= SYSDATE - INTERVAL '1' YEAR
GROUP BY p.ProductID, p.Name
ORDER BY TotalSales DESC
FETCH FIRST 2 ROWS ONLY;


-------------------------------------------

-- Find the top 2 products by unit sales in the past year: --

SELECT
    p.ProductID,
    p.Name,
    SUM(od.Quantity) AS TotalUnitsSold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= SYSDATE - INTERVAL '1' YEAR
GROUP BY p.ProductID, p.Name
ORDER BY TotalUnitsSold DESC
FETCH FIRST 2 ROWS ONLY;


------------------------------------------------

-- Find those products that are out-of-stock at every store in California: --

SELECT p.ProductID, p.Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Stores s
    LEFT JOIN Inventory i ON s.StoreID = i.StoreID AND p.ProductID = i.ProductID
    WHERE s.State = 'CA' AND (i.Quantity IS NULL OR i.Quantity = 0)
);

--------------------------------------

-- Find those packages that were not delivered within the promised time: --

SELECT o.OrderID, o.TrackingNumber, o.PromisedDeliveryTime, o.DeliveryDate
FROM Orders o
WHERE o.OrderStatus = 'Delivered' AND o.DeliveryDate > o.PromisedDeliveryTime;

------------------------------------------

-- Generate the bill for each customer for the past month: --

SELECT
    Subquery.CustomerID,
    Subquery.FirstName,
    Subquery.LastName,
    SUM(Subquery.TotalAmount) AS TotalAmount,
    MIN(Subquery.StartDate) AS StartDate,
    MAX(Subquery.EndDate) AS EndDate
FROM (
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        o.OrderDate,
        SUM(od.TotalAmount) AS TotalAmount,
        MIN(o.OrderDate) AS StartDate,
        MAX(o.OrderDate) AS EndDate
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE o.OrderDate >= SYSDATE - INTERVAL '1' MONTH
    GROUP BY c.CustomerID, c.FirstName, c.LastName, o.OrderDate
) Subquery
GROUP BY Subquery.CustomerID, Subquery.FirstName, Subquery.LastName
ORDER BY Subquery.CustomerID;

