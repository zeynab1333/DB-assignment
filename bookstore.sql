CREATE DATABASE bookStore;
USE bookStore;



-- CREATE TABLE country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

SELECT * FROM country;

-- INSERT INTO country
INSERT INTO country (country_name) VALUES 
('Kenya'), ('Nigeria'), ('Ghana'), ('USA'), ('Rwanda');


-- CREATE TABLE address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_name VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- INSERT INTO address
INSERT INTO address (street_name, city, postal_code,country_id) VALUES 
('123 Koinange St', 'Nairobi', '00100',1),
('456 Broadstreet', 'Lagos', '10001',2),
('789 Oxford Rd', 'Accra', 'SW1A 1AA',3);

-- CREATE TABLE address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- INSERT INTO address_status
INSERT INTO address_status (status_name) VALUES 
('current'), ('old');

-- CREATE TABLE customer
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_no INT
);

ALTER TABLE customer ADD COLUMN phone VARCHAR(20);

-- INSERT INTO customer
INSERT INTO customer (first_name, last_name, email, phone) VALUES 
('Zainab', 'Faysal', 'zainabfaysal@gmail.com', '0712345678'),
('Priscilla', 'Okoro', 'priscillaokoro@gmail.com', '0722334455'),
('George', 'Ceasar', 'georgeceasar@gmail.com', '0712234455');


-- CREATE TABLE customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (address_id) REFERENCES address(address_id),
	FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- INSERT INTO customer_address
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES 
(1, 1, 1),
(2, 2, 1);

-- CREATE TABLE AUTHOR
CREATE TABLE author(
	author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(255),
    bio TEXT
);

-- INSERT INTO author
INSERT INTO author (author_name) VALUES 
('Chinua Achebe'), 
('J.K. Rowling'), 
('Ben Carson');

-- CREATE TABLE book_language
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(50)
);

-- INSERT INTO book_language
INSERT INTO book_language (language_name) VALUES 
('English'), 
('Swahili'),
('Yoruba');

-- CREATE TABLE publisher
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(255)
);

-- INSERT INTO publisher
INSERT INTO publisher (publisher_name) VALUES 
('Penguin Books'), 
('Macmillan'), 
('East African Publishers');


-- CREATE BOOK TABLE
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_title VARCHAR(255),
    isbn VARCHAR(20),
    language_id INT,
    publisher_id INT,
    price DECIMAL(10,2),
    stock INT,
	FOREIGN KEY (language_id) REFERENCES book_language(language_id),
	FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- INSERT INTO book
INSERT INTO book (book_title, isbn, language_id, publisher_id, price, stock) VALUES 
('Things Fall Apart', '9780435905255', 1, 3, 12.99, 100),
('Harry Potter and the Sorcerer\'s Stone', '9780590353427', 1, 1, 15.50, 200),
('The Shining', '9780307743657', 1, 2, 13.75, 150),
('Gifted Hands', '1234567898744', 1, 2, 17.89, 100);


-- CREATE TABLE book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
	FOREIGN KEY (book_id) REFERENCES book(book_id),
	FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- INSERT INTO book_author
INSERT INTO book_author (book_id, author_id) VALUES 
(5, 1),
(6, 2),
(7, 3);

-- CREATE TABLE shipping_method
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(10,2)
);

-- INSERT INTO shipping_method
INSERT INTO shipping_method (method_name, cost) VALUES 
('Standard Shipping', 5.00),
('Express Shipping', 10.00);

-- CREATE TABLE order_status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

INSERT INTO order_status (status_name) 
VALUES ('Pending'),
('Shipped'),
('Delivered');

-- CREATE TABLE cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
     FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	 FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
     FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- INSERT INTO cust_order
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id) VALUES 
(1, '2025-04-10', 1, 1),
(2, '2025-04-11', 2, 2);


-- CREATE TABLE order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_id, book_id),
	FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
	FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- INSERT INTO order_line
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES 
(1, 5, 1, 12.99),
(2, 6, 2, 15.50);



-- CREATE TABLE order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    updated_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- INSERT INTO order_history
INSERT INTO order_history (order_id, status_id, updated_at) VALUES 
(1, 1, '2025-04-10 08:30:00'),
(2, 2, '2025-04-11 10:45:00');



-- CREATE ROLES
CREATE ROLE 'admin';
CREATE ROLE 'customer';
CREATE ROLE 'developer';

-- CREATE USERS
-- Admin users
CREATE USER 'zablon'@'localhost' IDENTIFIED BY 'zablon123';
CREATE USER 'gerald'@'localhost' IDENTIFIED BY 'gerald123';

-- Developer users
CREATE USER 'ceasar'@'localhost' IDENTIFIED BY 'dev1';
CREATE USER 'zainab'@'localhost' IDENTIFIED BY 'dev2';
CREATE USER 'priscilla'@'localhost' IDENTIFIED BY 'dev3';

-- Customer user
CREATE USER 'customer_user'@'localhost' IDENTIFIED BY 'cust123';

-- ASSIGN ROLES TO USERS
-- Admins
GRANT 'admin' TO 'zablon'@'localhost';
GRANT 'admin' TO 'gerald'@'localhost';

-- Developers
GRANT 'developer' TO 'ceasar'@'localhost';
GRANT 'developer' TO 'zainab'@'localhost';
GRANT 'developer' TO 'priscilla'@'localhost';

-- Customer
GRANT 'customer' TO 'customer_user'@'localhost';

-- GRANT PRIVILEGES TO ROLES

-- All privileges
GRANT ALL PRIVILEGES ON bookstore.* TO 'admin' WITH GRANT OPTION;

--  Set Default Role for a User
SET DEFAULT ROLE 'admin' TO 'zablon'@'localhost';
SET DEFAULT ROLE 'admin' TO 'gerald'@'localhost';

-- Only can read/write on bookstore
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'developer';

SET DEFAULT ROLE 'developer' TO 'ceasar'@'localhost';
SET DEFAULT ROLE 'developer' TO 'priscilla'@'localhost';
SET DEFAULT ROLE 'developer' TO 'zainab'@'localhost';


-- Only select from customers and order table
GRANT SELECT ON bookstore.book TO 'customer';
GRANT SELECT, INSERT ON bookstore.cust_order TO 'customer';