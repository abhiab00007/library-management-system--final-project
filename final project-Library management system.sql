-- creating and using the database
create database library;
use library;

-- creating branch table
create table branch (
    branch_no int primary key,
    manager_id int,
    branch_address varchar(255),
    contact_no varchar(15)
);

-- creating employee table
create table employee (
    emp_id int primary key,
    emp_name varchar(100),
    position varchar(50),
    salary decimal(10,2),
    branch_no int,
    foreign key (branch_no) references branch(branch_no)
);

-- creating books table
create table books (
    isbn int primary key,
    book_title varchar(255),
    category varchar(50),
    rental_price decimal(10,2),
    status varchar(20),  -- 'available' or 'not available'
    author varchar(100),
    publisher varchar(100)
);

-- creating customer table
create table customer (
    customer_id int primary key,
    customer_name varchar(100),
    customer_address varchar(255),
    reg_date date
);

-- creating issue status table
create table issuestatus (
    issue_id int primary key,
    issued_cust int,
    issued_book_name varchar(255),
    issue_date date,
    isbn_book int,
    foreign key (issued_cust) references customer(customer_id),
    foreign key (isbn_book) references books(isbn)
);

-- creating return status table
create table returnstatus (
    return_id int primary key,
    return_cust int,
    return_book_name varchar(255),
    return_date date,
    isbn_book2 int,
    foreign key (return_cust) references customer(customer_id),
    foreign key (isbn_book2) references books(isbn)
);

-- inserting into branch table
insert into branch values (1, 201, 'main street, city center', '1234567890');
insert into branch values (2, 203, 'elm street, downtown', '0987654321');
insert into branch values (5, 206, 'oak avenue, uptown', '1122334455');
insert into branch values (6, 207, 'pine road, suburb', '6677889900');
insert into branch values (9, 210, 'maple drive, business district', '4455667788');

-- inserting into employee table
insert into employee values (201, 'alice', 'manager', 60000, 1);
insert into employee values (202, 'bob', 'librarian', 55000, 1);
insert into employee values (203, 'charlie', 'assistant', 30000, 2);
insert into employee values (204, 'diana', 'clerk', 35000, 1);
insert into employee values (205, 'eve', 'assistant', 30000, 1);
insert into employee values (206, 'frank', 'manager', 65000, 5);
insert into employee values (207, 'grace', 'librarian', 51000, 6);
insert into employee values (208, 'hank', 'clerk', 32000, 1);
insert into employee values (209, 'ivy', 'assistant', 31000, 1);
insert into employee values (210, 'jack', 'manager', 70000, 9);

-- inserting into books table
insert into books values (101, 'introduction to algorithms', 'computer science', 50, 'available', 'cormen', 'mit press');
insert into books values (102, 'data structures in python', 'computer science', 40, 'not available', 'gupta', 'pearson');
insert into books values (103, 'world history', 'history', 30, 'available', 'thompson', 'oxford');
insert into books values (104, 'modern india', 'history', 35, 'not available', 'guha', 'penguin');
insert into books values (105, 'linear algebra', 'mathematics', 45, 'available', 'strang', 'cambridge');
insert into books values (106, 'calculus made easy', 'mathematics', 50, 'available', 'thomas', 'pearson');
insert into books values (107, 'microeconomics', 'economics', 30, 'available', 'varian', 'norton');
insert into books values (108, 'macroeconomics', 'economics', 35, 'not available', 'blanchard', 'pearson');
insert into books values (109, 'quantitative methods', 'business', 40, 'available', 'anderson', 'mcgraw hill');
insert into books values (110, 'financial accounting', 'business', 30, 'not available', 'williams', 'mcgraw hill');

-- inserting into customer table
insert into customer values (301, 'john doe', '123 oak lane', '2020-11-15');
insert into customer values (302, 'jane smith', '456 pine street', '2021-12-20');
insert into customer values (303, 'mary johnson', '789 maple road', '2023-06-10');
insert into customer values (304, 'peter brown', '321 elm street', '2021-02-15');
insert into customer values (305, 'lucy black', '654 willow drive', '2022-03-25');
insert into customer values (306, 'james white', '987 spruce avenue', '2023-08-30');
insert into customer values (307, 'michael green', '159 cedar street', '2021-01-05');
insert into customer values (308, 'susan yellow', '753 birch road', '2020-07-11');
insert into customer values (309, 'william blue', '864 chestnut boulevard', '2023-11-10');
insert into customer values (310, 'anna red', '951 poplar lane', '2022-05-05');

-- inserting into issuestatus table
insert into issuestatus values (1, 301, 'introduction to algorithms', '2023-01-15', 101);
insert into issuestatus values (2, 302, 'data structures in python', '2023-02-10', 102);
insert into issuestatus values (3, 303, 'world history', '2023-06-15', 103);
insert into issuestatus values (4, 304, 'modern india', '2023-03-10', 104);
insert into issuestatus values (5, 305, 'linear algebra', '2023-07-20', 105);
insert into issuestatus values (6, 306, 'calculus made easy', '2023-08-05', 106);

-- inserting into returnstatus table
insert into returnstatus values (1, 301, 'introduction to algorithms', '2023-02-01', 101);
insert into returnstatus values (2, 302, 'data structures in python', '2023-02-20', 102);
insert into returnstatus values (3, 303, 'world history', '2023-07-01', 103);
insert into returnstatus values (4, 304, 'modern india', '2023-04-15', 104);
insert into returnstatus values (5, 305, 'linear algebra', '2023-08-10', 105);
insert into returnstatus values (6, 306, 'calculus made easy', '2023-09-01', 106);

-- 1. Retrieve the book title, category, and rental price of all available books
select book_title, category, rental_price
from books
where status = 'available';

-- 2. List the employee names and their respective salaries in descending order of salary
select emp_name, salary
from employee
order by salary desc;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books
select books.book_title, customer.customer_name
from issuestatus
join books on issuestatus.isbn_book = books.isbn
join customer on issuestatus.issued_cust = customer.customer_id;

-- 4. Display the total count of books in each category
select category, count(*) as total_books
from books
group by category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
select emp_name, position
from employee
where salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet
select customer_name
from customer
where reg_date < '2022-01-01'
and customer_id not in (select issued_cust from issuestatus);

-- 7. Display the branch numbers and the total count of employees in each branch
select branch_no, count(*) as total_employees
from employee
group by branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023
select customer.customer_name
from issuestatus
join customer on issuestatus.issued_cust = customer.customer_id
where issue_date between '2023-06-01' and '2023-06-30';

-- 9. Retrieve book_title from the book table containing history
select book_title
from books
where category = 'history';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select branch_no, count(*) as total_employees
from employee
group by branch_no
having count(*) > 5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses
select emp_name, branch.branch_address
from employee
join branch on employee.branch_no = branch.branch_no
where position = 'manager';

-- 12. Display the names of customers who have issued books with a rental price higher than Rs. 25
select customer.customer_name
from issuestatus
join books on issuestatus.isbn_book = books.isbn
join customer on issuestatus.issued_cust = customer.customer_id
where books.rental_price > 25;
