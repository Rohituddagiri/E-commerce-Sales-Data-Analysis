With PaymentDetails AS (
  SELECT                              ----------  Selecting Type payment method and its count grouped by country
    to_char(o.OrderDate, 'YYYY') OrderYear,
    pm.PaymentMethod As PaymentMethod,
    ca.Country As Country,
    count(1) PayCount
  FROM
    Orders o
    INNER JOIN Payments pm ON o.PaymentID = pm.PaymentID
    INNER JOIN CustomerAddresses ca ON ca.CustomerID = pm.CustomerID
  GROUP BY
    to_char(o.OrderDate, 'YYYY'),
    pm.PaymentMethod,
    ca.Country
),
PaymentRank AS (
  SELECT
    OrderYear,
    PaymentMethod,
    Country,
    RANK() OVER (
      PARTITION BY OrderYear,
      PaymentMethod,
      Country
      ORDER BY
        PayCount
    ) PayRank   ---------- Ranking Payment method
  FROM
    PaymentDetails
) 
SELECT   ----------- Selecting Top payment method in each country
  OrderYear,
  Country,
  PaymentMethod
FROM
  PaymentRank
WHERE
  PayRank = 1
ORDER BY
  OrderYear,
  Country;
         
