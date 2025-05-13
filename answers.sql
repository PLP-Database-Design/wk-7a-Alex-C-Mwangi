--Question1
CREATE TABLE ProductDetail(
    orderId INT,
    customerName VARCHAR(100),
    products VARCHAR(100)
);

INSERT INTO ProductDetail(orderId, customerName, products)
VALUES
(101, 'John Doe', 'Laptop', 'Mouse'),
(102, 'Jane Smith', 'Tablet', 'Keyboard', 'Mouse'),
(103, 'Emily Clark', 'Phone');

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10
),
split_products AS (
    SELECT t1.orderId, t1.customerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(t1.products, ',', numbers.n), ',', -1))
    AS product
    FROM ProductDetail t1
    JOIN numbers ON CHAR_LENGTH(t1.products) - CHAR_LENGTH(REPLACE(t1.products, ',', ''))>= numbers.n - 1
)
SELECT * FROM split_products;

--Question2
CREATE TABLE Orders(
    orderId INT PRIMARY KEY,
    customerName VARCHAR(100)
);

INSERT INTO Orders (orderId, customerName)
VALUES 
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

/*making the orderdetails table now without
partialdependencies*/
CREATE TABLE OrderDetails (
    orderId INT,
    product VARCHAR(100),
    quantity INT,
    PRIMARY KEY (orderId, product),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
);

INSERT INTO Orderdetails (orderId, product, quantity)
VALUES 
(101, 'Laptop', 2),
(101, 'Mouse', 2),
(102, 'Tablet', 2),
(102, 'Keyboard', 2),
(102, 'Mouse', 2),
(103, 'Phone', 1),