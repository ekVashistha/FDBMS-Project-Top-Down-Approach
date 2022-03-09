drop database if exists gupta_empire;
create database gupta_empire ;
use gupta_empire;

/*creating entity tables */
create table customers(
 			cust_id varchar(7) primary key,
 			email varchar (30) check (email like '%_@__%.__%') not null,
 			name varchar (30) not null,
 			phn bigint(10) not null,
 			address varchar(200) not null
 			);

insert into customers values ('C893','muskankaur25@gmail.com','Muskan Kaur',9058923006,'420/69, Nice Avenue ,Ukraine');
/*
+---------+------------------------+-------------+------------+------------------------------+
| cust_id | email                  | name        | phn        | address                      |
+---------+------------------------+-------------+------------+------------------------------+
| C893    | muskankaur25@gmail.com | Muskan Kaur | 9058923006 | 420/69, Nice Avenue ,Ukraine |
+---------+------------------------+-------------+------------+------------------------------+
*/	
insert into customers values ('C893','muskankaur25gmail.com','Muskan Kaur',9058923006,'420/69, Nice Avenue ,Ukraine');
/*
The above code is tried to see if the check constraint is working or not this shows error as shown below
ERROR 3819 (HY000): Check constraint 'customers_chk_1' is violated.
*/
/*creating table products*/
create table products(
			p_id varchar(7) primary key,
			p_name varchar(15) not null
			);
create index p_name_o on products(p_name);

insert into products values ('P569' , 'T-shirts');
select * from products;
/*
+------+----------+
| p_id | p_name   |
+------+----------+
| P569 | T-shirts |
+------+----------+
*/
create table categories(
			cat_id varchar(5) primary key,
			cat_type varchar(15) not null
			);
			
insert into categories values ('TRE45','Fashion');

select * from categories;
/*
+--------+----------+
| cat_id | cat_type |
+--------+----------+
| TRE45  | Fashion  |
+--------+----------+
*/
create table merchant(
			m_id varchar(7) primary key,
			m_name  varchar(10) not null
			);
create index name_m on merchant(m_name);
insert into merchant values ('EK420','xyz');
select * from merchant;	
/*
+-------+--------+
| m_id  | m_name |
+-------+--------+
| EK420 | xyz    |
+-------+--------+
*/
drop table if exists cart;
create table cart(
		order_id varchar(7) primary key,
		date_order DATE not null);
create index date_o on cart(date_order);
insert into cart values ('LSC69','2022-03-01');
select * from cart;
/*
+----------+------------+
| order_id | date_order |
+----------+------------+
| LSC69    | 2022-03-01 |
+----------+------------+
*/
create table payments(
			pay_id varchar(7) primary key,
			date_pay DATE not null,
			pay_mode ENUM('cash','upi','debit card','credit card','net banking')
			);
create index date_p on payments(date_pay);
create index pay_m on payments(pay_mode);
insert into payments values('ABC77', '2022-03-02','2');
select * from payments;
/*
+--------+------------+----------+
| pay_id | date_pay   | pay_mode |
+--------+------------+----------+
| ABC77  | 2022-03-02 | upi      |
+--------+------------+----------+
*/

create table deliveries(
			d_id varchar(5) primary key,
			date_delivered DATE not null
			);
create index date_d on deliveries(date_delivered);
insert into deliveries values('QWERT','2022-03-10');
select * from deliveries ;
/*
+-------+----------------+
| d_id  | date_delivered |
+-------+----------------+
| QWERT | 2022-03-10     |
+-------+----------------+
*/

create table transactions(
			report_id varchar(10) primary key
			);
insert into transactions values('LOL11');
select * from transactions ;	
/*
+-----------+
| report_id |
+-----------+
| LOL11     |
+-----------+
*/

drop table  if exists rel_customers_cart;
create table rel_customers_cart(
				order_id varchar (7) not null,
				cust_id varchar(7) not null,
				date_order DATE not null,
				foreign key (cust_id) references customers(cust_id),
				foreign key (order_id) references cart(order_id),
				foreign key (date_order) references cart(date_order),
				primary key (order_id, cust_id));
insert into rel_customers_cart values('LSC69', 'C893', '2022-03-01');
select * from rel_customers_cart;
/*
+----------+---------+------------+
| order_id | cust_id | date_order |
+----------+---------+------------+
| LSC69    | C893    | 2022-03-01 |
+----------+---------+------------+
*/

drop table rel_customers_deliveries;
create table rel_customers_deliveries(
				d_id varchar (5) not null,
				cust_id varchar(7) not null,
				date_delivered DATE not null,
				foreign key (cust_id) references customers(cust_id),
				foreign key (d_id) references deliveries(d_id),
				foreign key (date_delivered) references deliveries(date_delivered),
				primary key (d_id, cust_id)
				);
insert into rel_customers_deliveries values('QWERT', 'C893', '2022-03-10');
select * from rel_customers_deliveries;
/*
+-------+---------+----------------+
| d_id  | cust_id | date_delivered |
+-------+---------+----------------+
| QWERT | C893    | 2022-03-10     |
+-------+---------+----------------+
*/

create table rel_customers_transactions(
				report_id varchar (10) not null,
				cust_id varchar(7) not null,
				foreign key (cust_id) references customers(cust_id),
				foreign key (report_id) references transactions(report_id),
				primary key (report_id, cust_id)
				);
insert into rel_customers_transactions values('LOL11', 'C893');


select * from rel_customers_transactions;
/*
+-----------+---------+
| report_id | cust_id |
+-----------+---------+
| LOL11     | C893    |
+-----------+---------+
*/


drop table rel_products_categories;
create table rel_products_categories(
				p_id varchar (7) not null,
				p_name varchar(15) not null,
				cat_id varchar(5) not null ,
				constraint fk1 foreign key (p_id) references products(p_id),
				constraint fk2 foreign key (p_name) references products(p_name),
				constraint fk3 foreign key (cat_id) references categories(cat_id),
				primary key (p_id, cat_id)
				);
insert into rel_products_categories values('P569', 'T-shirts','TRE45' );
select * from rel_products_categories;
/*
+------+----------+--------+
| p_id | p_name   | cat_id |
+------+----------+--------+
| P569 | T-shirts | TRE45  |
+------+----------+--------+
*/
drop table rel_payments_categories;
create table rel_payments_categories(
				pay_id varchar (7) not null,
				date_pay DATE not null,
				pay_mode ENUM('cash','upi','debit card','credit card','net banking'),
				cat_id varchar(5) not null ,
				foreign key (pay_id) references payments(pay_id),
				foreign key (cat_id) references categories(cat_id),
				foreign key(date_pay) references payments(date_pay),
				foreign key(pay_mode) references payments(pay_mode),
				primary key(pay_id, cat_id)
				);
insert into rel_payments_categories values('ABC77', '2022-03-02','2','TRE45');

select * from rel_payments_categories ;
/*
+--------+------------+----------+--------+
| pay_id | date_pay   | pay_mode | cat_id |
+--------+------------+----------+--------+
| ABC77  | 2022-03-02 | upi      | TRE45  |
+--------+------------+----------+--------+
*/

drop table rel_transactions_cart;
create table rel_transactions_cart(
				report_id varchar(10) not null,
				order_id varchar (7) not null,
				foreign key (report_id) references transactions(report_id),
				foreign key (order_id) references cart(order_id),
				primary key(report_id, order_id)
				);
insert into rel_transactions_cart values('LOL11','LSC69');
select * from rel_transactions_cart;

/*
+-----------+----------+
| report_id | order_id |
+-----------+----------+
| LOL11     | LSC69    |
+-----------+----------+
*/

drop table rel_products_merchant;
create table rel_products_merchant(
				m_id varchar(7) not null,
				m_name  varchar(10) not null,
				p_id varchar(7) not null,
				foreign key(m_id) references merchant(m_id),
				foreign key(m_name) references merchant(m_name),
				foreign key(p_id) references products(p_id),
				primary key(m_id, p_id)
				);
insert into rel_products_merchant values('EK420','xyz','P569');
select * from rel_products_merchant;
/*
+-------+--------+------+
| m_id  | m_name | p_id |
+-------+--------+------+
| EK420 | xyz    | P569 |
+-------+--------+------+
*/

drop table rel_products_transactions;
create table rel_products_transactions(
				p_id varchar(7) not null,
				report_id varchar(10) not null,
				foreign key(p_id) references products(p_id),
				foreign key (report_id) references transactions(report_id),
				primary key(p_id, report_id)
				);
insert into rel_products_transactions values('P569','LOL11');
select * from rel_products_transactions;
/*
+------+-----------+
| p_id | report_id |
+------+-----------+
| P569 | LOL11     |
+------+-----------+
*/

drop table rel_payments_transactions;
create table rel_payments_transactions(
				report_id varchar(10) not null,
				pay_id varchar (7) not null,
				foreign key (report_id) references transactions(report_id),
				foreign key (pay_id) references payments(pay_id),
				primary key(pay_id, report_id)
				);
insert into rel_payments_transactions values('LOL11','ABC77');
select * from rel_payments_transactions;
/*
+-----------+--------+
| report_id | pay_id |
+-----------+--------+
| LOL11     | ABC77  |
+-----------+--------+
*/

/*
creating users
*/

create user 'gupta'@'localhost' identified by 'gupta';
create user 'ekansh'@'localhost' identified by 'ekansh';
create user 'muskan'@'localhost' identified by 'muskan';

-- dba
grant create,drop,select on *.* to 'gupta'@'localhost' with grant option ;

--merchant
grant select on gupta_empire.customers to 'ekansh'@'localhost';
grant select on gupta_empire.transactions to 'ekansh'@'localhost';
grant update on gupta_empire.merchant to 'ekansh'@'localhost';
grant select, insert, delete, update on gupta_empire.products to 'ekansh'@'localhost';
grant select, insert, delete, update on gupta_empire.rel_products_merchant to 'ekansh'@'localhost';
grant select on gupta_empire.deliveries to 'ekansh'@'localhost';

--customers
grant select, insert, delete, update on gupta_empire.customers to 'muskan'@'localhost';
grant select, insert, delete, update on gupta_empire.cart to 'muskan'@'localhost';
grant select, insert, delete, update on gupta_empire.payments to 'muskan'@'localhost';
grant select on gupta_empire.transactions to 'muskan'@'localhost';
grant select on gupta_empire.products to 'muskan'@'localhost';
grant select, insert, delete, update on gupta_empire.rel_customers_cart to 'muskan'@'localhost';
grant select on gupta_empire.rel_customers_transactions to 'muskan'@'localhost';
grant select on gupta_empire.rel_customers_deliveries to 'muskan'@'localhost';













