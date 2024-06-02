WITH ProductSale AS(
  SELECT
    Products.ProductName AS ProductName, -----  Selecting product names from product table
    SUM(OrderDetails.TotalPrice) AS TotalSale -----  Calculating total Sale amount for products
  FROM
    OrderDetails
    INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
    INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
  GROUP BY
    Products.ProductName
  ORDER BY
    TotalSale DESC
) 
SELECT
  ProductName,
  Productcategories.CategoryName,
  TotalSale,
  RANK() OVER(
    PARTITION BY Productcategories.CategoryName
    ORDER BY
      TOTALSALE DESC
  ) SalesRank      ---- Rank of total sales for each product in their respective category
FROM
  ProductSale
  INNER JOIN Products ON ProductSale.ProductName = Products.ProductName
  INNER JOIN ProductCategories ON Products.CategoryID =
Productcategories.CategoryID;
