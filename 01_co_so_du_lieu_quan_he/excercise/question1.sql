CREATE DATABASE `lesson_1`;
USE `lesson_1`;
CREATE TABLE `Classes`(
	id int primary key auto_increment,
    `name` varchar(200)
);
CREATE TABLE `Teachers`(
	`id` int primary key auto_increment,
    `name` varchar(200),
    `age` int,
    `country` varchar(200)
);
INSERT INTO `Classes`(`name`)
values 
	("Lớp 1"),
	("Lớp 2"),
	("Lớp 3"),
	("Lớp 4");
INSERT INTO `Teachers`(`name`,`age`,`country`)
values ("Thắng",18,"Việt Nam")