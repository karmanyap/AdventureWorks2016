--Intermediate Questions:

--Write a SQL query to retrieve the top 10 customers with the highest total sales amount.

--How can you find the total number of products in each category in the AdventureWorks2016 database?

--Explain the difference between clustered and non-clustered indexes in MSSQL. When would you use each type?

--Write a query to calculate the average product price for each subcategory in AdventureWorks2016.

--Explain the purpose of stored procedures in MSSQL. How can they be beneficial in terms of performance and security?

--Advanced Questions:

--Write a SQL query to find the salesperson who made the highest number of sales in each region.

--Explain the concept of query optimization in MSSQL. How can you optimize a slow-performing query in AdventureWorks2016?

--Write a query to retrieve the top 5 customers who have made the highest purchases within the last 6 months.

--Explain the ACID properties in the context of database transactions. How does MSSQL ensure transactional integrity?

--Write a recursive SQL query to retrieve the hierarchical structure of employees in the AdventureWorks2016 database.



--Intermediate Questions:

--Write a SQL query to retrieve the top 10 products with the highest average rating.

SELECT TOP 2 ProductID, AVG(Rating) AS AvgRating
FROM Production.ProductReview
GROUP BY ProductID
ORDER BY AvgRating DESC;

--How would you find the total revenue generated from sales in the AdventureWorks2016 database for a specific year?

SELECT YEAR(OrderDate) AS OrderYear, SUM(TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2022
GROUP BY YEAR(OrderDate);


--Write a query to calculate the total number of orders placed by each customer.

SELECT CustomerID, Count(*) AS TotalOrders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY TotalOrders DESC;

-- Rank of TotalOrders

SELECT CustomerID, Count(*) AS TotalOrders,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS Rank
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;

--DENSE_RANK() of TotalOrders

SELECT CustomerID, COUNT(*) AS TotalOrders,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS DenseRank
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;


-- Example of RANK function:

SELECT SalesOrderID, OrderDate,
       RANK() OVER (ORDER BY OrderDate) AS Rank
FROM Sales.SalesOrderHeader;

-- Example of DENSE_RANK function:

SELECT SalesOrderID, OrderDate,
       DENSE_RANK() OVER (ORDER BY OrderDate) AS DenseRank
FROM Sales.SalesOrderHeader;


--Explain the purpose of the EXISTS and NOT EXISTS operators in SQL. Provide an example scenario where they can be useful.

	--The EXISTS operator checks for the existence of a record in the subquery, while the NOT EXISTS operator checks for the non-existence of a record.
	--These operators can be useful in scenarios where you want to filter records based on a condition in a correlated subquery.

SELECT ProductID, Name
FROM Production.Product
WHERE EXISTS 
(SELECT 1 
	FROM Production.ProductReview 
	WHERE ProductID = Production.Product.ProductID);


--Write a query to retrieve the customers who have not placed any orders in the AdventureWorks2016 database.



SELECT DISTINCT CONCAT(C.FirstName, ' ', C.LastName) AS Customer_Name, C.FirstName, C.LastName
FROM Person.Person AS C
LEFT JOIN Sales.SalesOrderHeader AS O ON C.BusinessEntityID = O.CustomerID
WHERE O.CustomerID IS NULL;

-- Count of Customer who did not order

SELECT COUNT(DISTINCT CONCAT(C.FirstName, ' ', C.LastName)) AS Customer_COunt
FROM Person.Person AS C
LEFT JOIN Sales.SalesOrderHeader AS O ON C.BusinessEntityID = O.CustomerID
WHERE O.CustomerID IS NULL;



--Advanced Questions:

--Write a SQL query to find the top 5 best-selling product categories based on the total quantity sold.

--How would you calculate the percentage contribution of each product to the total revenue in the AdventureWorks2016 database?

--Write a query to find the top 3 most profitable products based on the profit margin (selling price minus cost) in AdventureWorks2016.

--Explain the concept of window functions in MSSQL. Provide an example query that uses a window function to calculate a running total.

--Write a query to find the average time it takes for an order to be shipped from the AdventureWorks2016 database, considering the order date and shipped date.