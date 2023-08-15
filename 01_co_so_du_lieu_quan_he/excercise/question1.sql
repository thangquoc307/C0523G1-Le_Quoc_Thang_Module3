CREATE DATABASE `lesson_1`;
USE `lesson_1`;
CREATE TABLE `classes`(
	id int primary key auto_increment,
    `name` varchar(200)
);
CREATE TABLE `teachers`(
	`id` int primary key auto_increment,
    `name` varchar(200),
    `age` int,
    `country` varchar(200)
);
INSERT INTO `classes`(`name`)
values 
	("Lớp 1"),
	("Lớp 2"),
	("Lớp 3"),
	("Lớp 4");
INSERT INTO `teachers`(`name`,`age`,`country`)
values ("Thắng",18,"Việt Nam")