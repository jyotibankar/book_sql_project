create table books(
Book_ID	serial primary key,
Title	varchar(100),
Author	varchar(100),
Genre	varchar(50),
Published_Year	int,
Price	numeric(10,2),
Stock	int
);

create table Customers(
Customer_ID	serial primary key,
Name	varchar(100),
Email	varchar(100),
Phone	varchar(50),
City	varchar(30),
Country	varchar(50)
);

ALTER TABLE Customers 
ALTER COLUMN Country TYPE VARCHAR(150);

Create table Orders(
Order_ID	serial primary key,
Customer_ID	int REFERENCES Customers(Customer_ID),
Book_ID	int REFERENCES Books(Book_ID),
Order_Date	Date,
Quantity	int,
Total_Amount	numeric(10,2)
);

--import data from books files
copy books(Book_ID	,Title,	Author,	Genre,	Published_Year,	Price	,Stock)
from 'C:\Program Files\PostgreSQL\Books (1).csv'
csv header;



--import data from customers files
copy Customers(Customer_ID,	Name,	Email,	Phone,	City,Country)
from 'C:\Program Files\PostgreSQL\Customers (1).csv'
csv header;


--import data from book files
copy Orders(Order_ID	,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
from 'C:\Program Files\PostgreSQL\Orders (1).csv'
csv header;


select * from Customers
select * from books
select * from Orders


-- 1) Retrieve all books in the "Fiction" genre:

select * from books
where genre='Fiction';


--2) Find books published after the year 1950:

select  * from books 
where published_year>=1950;


3) List all customers from the Canada:
select city from Customers
where country='Canada';


select * from Orders;


 Show orders placed in November 2023:
select order_date
from Orders
where order_date between '01-11-2023' and '30-11-2023';


-- 5) Retrieve the total stock of books available:
select * from books;
select * from Customers;

select sum(stock) as total_stock
from books;

6) Find the details of the most expensive book:
select *
from books
order by price desc
limit 1;


- 7) Show all customers who ordered more than 1 quantity of a book:
select * from Orders
where quantity>1;


 8) Retrieve all orders where the total amount exceeds $20:
 select * from orders;
 select total_amount
 from orders
 where total_amount<20;

 9) List all genres available in the Books table:
 select distinct genre from books;

 10) Find the book with the lowest stock:
select * from books;

 select * from books 
order by stock 
limit 1;


 11) Calculate the total revenue generated from all orders:
 select * from orders;

 select sum(total_amount) as total_revenue
 from orders;


-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select * from orders;

select b.genre,sum(o.quantity) as total_book_sold
from orders o join books b
on o.book_id=b.book_id
group by b.genre;

 2) Find the average price of books in the "Fantasy" genre:

select * from customers;
select * from orders;
select avg(price) as average_price 
from books
where genre='Fantasy';


- 3) List customers who have placed at least 2 orders:
select o.customer_id,c.name,count(o.order_id) as order_count
from orders o inner join customers c
on o.customer_id=c.customer_id
group by o.customer_id,c.name
having count(o.order_id)>=2;

select * from orders;
select * from books;
 4) Find the most frequently ordered book:
select c.name,o.order_id,count(o.order_id) as order_book
from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.name,o.order_id
order by order_book desc 
limit 1;


Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where genre='Fantasy'
order by price desc limit 3;

select * from orders;

- 6) Retrieve the total quantity of books sold by each author:
select b.author,sum(o.quantity) as total_quanity
from orders o join  books b
on b.book_id = o.book_id
group by author;


- 7) List the cities where customers who spent over $30 are located:
select * from customers;
select * from orders;

select distinct c.city,o.total_amount
from customers c join orders o
on c.customer_id=o.customer_id
where o.total_amount>30

- 8) Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount) as total_amount
from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.name
order by total_amount desc limit 1;

--9) Calculate the stock remaining after fulfilling all orders:
select * from books;

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;


select b.book_id,b.title,b.stock 
from books b join orders o
on b.book_id = o.orders



















