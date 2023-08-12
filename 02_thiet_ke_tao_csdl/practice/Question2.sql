CREATE DATABASE lesson2;
USE lesson2;
CREATE TABLE `customer` (
	`customer id` int primary key auto_increment,
    `full name` varchar(200),
    `address` varchar(200),
    `telephone number` char(15)
);
CREATE TABLE `order` (
	`order id` int primary key auto_increment,
    `full name` varchar(200),
    `customer id` int,
    FOREIGN KEY (`customer id`) REFERENCES `customer` (`customer id`)
);
CREATE TABLE `receive` (
	`receive id` int primary key auto_increment,
    `full name` varchar(200),
	`customer id` int,
    FOREIGN KEY (`customer id`) REFERENCES `customer` (`customer id`)
);
CREATE TABLE `item` (
	`item id` int primary key auto_increment,
    `item name` varchar(200),
    `slot` varchar(200),
    `description`varchar(1000)
);
CREATE TABLE `shipper` (
	`shipper id` int primary key auto_increment,
	`shipper name` varchar(200)
);
CREATE TABLE `location` (
	`location id` int primary key auto_increment,
    `address name` varchar(1000)
);
CREATE TABLE `ordering` (
	`order id` int,
    `item id` int,
    FOREIGN KEY (`order id`) REFERENCES `order` (`order id`),
    FOREIGN KEY (`item id`) REFERENCES `item` (`item id`),
	`ordering id` int primary key auto_increment,
    `date` DATETIME,
    `amount` int
);
CREATE TABLE `shipping` (
	`item id` int,
	`receive id` int,
    `shipper id` int,
    `location id` int,
    FOREIGN KEY (`item id`) REFERENCES `item` (`item id`),
    FOREIGN KEY (`receive id`) REFERENCES `receive` (`receive id`),
    FOREIGN KEY (`shipper id`) REFERENCES `shipper` (`shipper id`),
    FOREIGN KEY (`location id`) REFERENCES `location` (`location id`),
	`shipping id` int primary key auto_increment,
    `date` DATETIME,
    `amount` int,
    `price` int

);