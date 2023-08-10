CREATE DATABASE `lesson_1`;
USE `lesson_1`;
CREATE TABLE `Student`(
	id int primary key,
    `name` varchar(200)
);
CREATE TABLE `Teacher`(
	id int primary key,
    `name` varchar(200),
    age int,
    country varchar(200)
);