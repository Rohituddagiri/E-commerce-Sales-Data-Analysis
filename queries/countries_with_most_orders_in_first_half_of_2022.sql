SELECT
  A.Country,
  COUNT(B.OrderID) AS OrderCount ------------ Selecting Total orders from each country
FROM
  CustomerAddresses A
  JOIN Orders B ON A.CustomerID = B.CustomerID
  AND b.OrderDate BETWEEN '01-jan-22'
  AND '30-jun-22'
Group by
  A.Country
ORDER BY
  OrderCount DESC
