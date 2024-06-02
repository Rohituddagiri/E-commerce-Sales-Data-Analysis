With OrderDetail AS (
  SELECT                 ----------- Select order details
    o.OrderID,
    od.ProductID,
    initcap(pr.ProductName) As ProductName,
    orr.ReturnID
FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN OrderItemReturns orr ON o.OrderID = orr.OrderID
    AND od.ProductID = orr.ProductID
    JOIN Products pr ON od.ProductID = pr.ProductID
WHERE
    o.OrderDate > = Add_Months(
      trunc(Sysdate, 'mm'),
      -12 ----------- Fetching returned products details for last 1 year
) ),
ReturnCounts AS (
  SELECT
    ProductName,
    count(ReturnID) ReturnCount ----------- Taking count of returned product
  FROM
    OrderDetail
  GROUP BY
    ProductName
),
ProductRank as (
  SELECT
    ProductName,
    RANK() OVER(
      ORDER BY
        ReturnCount DESC
    ) ProdRank -----------  Ranking products in descending  
order based on their returned count
  FROM
    ReturnCounts
) 
  
SELECT
  ProductName  ------------- Selecting Top 5 returned Products
FROM
  ProductRank
WHERE
ProdRank < = 5
