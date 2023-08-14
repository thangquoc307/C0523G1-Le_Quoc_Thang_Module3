create database lesson_2_2;
use lesson_2_2;
create table `products` (
	`product_id` int primary key auto_increment,
    `product_name` varchar(200),
    `product_price` int
);
create table `customers` (
	`customer_id` int primary key auto_increment,
    `customer_name` varchar(200),
    `customer_age` int
);
create table `orders` (
	`order_id` int primary key auto_increment,
    `customer_id` int,
    `order_date` datetime,
    `order_total_price` int,
    foreign key (`customer_id`) references `customer`(`customer_id`)
);
create table `order_details`(
	`order_id` int,
    `product_id` int,
    primary key(`order_id`, `product_id`),
    foreign key (`order_id`) references `order` (`order_id`),
    foreign key (`product_id`) references `product` (`product_id`)
);