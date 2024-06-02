SELECT
  B.Country,
  COUNT(A.SupplierID) SupCount,
  DENSE_RANK () OVER ( ORDER BY COUNT(A.SupplierID) DESC) AS SupplierRank ------ Ranking suppliers based on their rating
FROM
  Suppliers A
  JOIN SupplierAddresses B ON A.SupplierID = B.SupplierID
WHERE
  A.Rating >(SELECT AVG(Rating) FROM Suppliers)------- Selecting suppliers having rating greater than average rating
GROUP BY
  B.Country
ORDER BY
  SupCount DESC
