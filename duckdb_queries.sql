-- Q1: List all customers along with the total number of orders they have placed
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') c
LEFT JOIN read_json_auto('orders.json') o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;

-- Q2: Find the top 3 customers by total order value
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_value
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT p.product_name
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
ON c.customer_id = o.customer_id
JOIN read_parquet('products.parquet') p
ON o.order_id = p.order_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
SELECT c.name AS customer_name, o.order_date, p.product_name, p.quantity
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
ON c.customer_id = o.customer_id
JOIN read_parquet('products.parquet') p
ON o.order_id = p.order_id
ORDER BY o.order_date;

## Products Parquet Schema

The `products.parquet` file should contain structured product-level details linked to each order. A recommended schema is:

- **order_id** (STRING)  
  Unique identifier for the order. This will join with `orders.json`.

- **product_id** (STRING)  
  Unique identifier for the product.

- **product_name** (STRING)  
  Name of the product purchased (e.g., "Rice 5kg", "Smartwatch").

- **category** (STRING)  
  Standardized product category (e.g., "Electronics", "Clothing", "Grocery").

- **quantity** (INTEGER)  
  Number of units purchased in the order.

- **unit_price** (DECIMAL)  
  Price per unit of the product.

- **total_price** (DECIMAL)  
  Derived field: `quantity × unit_price`.

---

### Example Rows

| order_id | product_id | product_name | category     | quantity | unit_price | total_price |
|----------|------------|--------------|--------------|----------|------------|-------------|
| ORD2001  | PROD101    | Smartwatch   | Electronics  | 1        | 2397.00    | 2397.00     |
| ORD2002  | PROD102    | Rice 5kg     | Grocery      | 3        | 2065.67    | 6197.00     |
| ORD2003  | PROD103    | Saree        | Clothing     | 1        | 9897.00    | 9897.00     |

---

This schema ensures:
- **Joins**: `order_id` links directly to `orders.json`.  
- **Analytics**: You can group by `category`, calculate revenue, and track product trends.  
- **Flexibility**: Supports multiple products per order (one row per product).  

---
