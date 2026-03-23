--01: Total order value for customers in Mumbai 
SELECT 
    c.customer_name,
    SUM(p.unit_price * o.quantity) AS total_order_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Products p ON o.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_name;

--02. Top 3 products by total quantity sold 
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

--03. Number of unique customers served by each sales representative
SELECT 
    s.sales_rep_name,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM SalesReps s
LEFT JOIN Orders o ON s.sales_rep_id = o.sales_rep_id
GROUP BY s.sales_rep_name;

--04: Orders with a total value greater than 10,000, sorted descending
SELECT 
    o.order_id,
    (p.unit_price * o.quantity) AS total_order_value
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
WHERE (p.unit_price * o.quantity) > 10000
ORDER BY total_order_value DESC;

--05: List products that have never been ordered
SELECT product_name
FROM Products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM Orders);