-- ProductSale gives the sales data of each product
-- | PRODUCTNAME | TOTALSALE |
-- The Final query results the details of each product sales in a category
-- | PRODUCT NAME | CATEGOREY NAME | TOTAL SALES | SALES RANK |
WITH ProductSale AS(
SELECT 
    Products.ProductName AS PName,
    SUM(OrderDetails.TotalPrice) AS TotalSale
FROM OrderDetails
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
GROUP BY Products.ProductName
ORDER BY TotalSale DESC) 
SELECT 
    PName,  -- select the product name
    ProductCategories.CategoryName, -- select the product category
    TotalSale, -- the total sales of each product
    RANK() OVER(PARTITION BY ProductCategories.CategoryName ORDER BY TotalSale DESC) AS SalesRank  -- Rank of total sales for each product in a category 
FROM ProductSale
INNER JOIN Products ON ProductSale.PName = Products.ProductName
INNER JOIN ProductCategories ON Products.CategoryID = ProductCategories.CategoryID;