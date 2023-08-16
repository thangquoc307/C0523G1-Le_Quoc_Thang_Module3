create database `procedure`;
use `procedure`;
create table `Products`(
	`id` int primary key auto_increment,
    `productCode` varchar(50) not null unique,
	`productName` varchar(50) not null,
	`productPrice` int not null,
	`productAmount` int not null,
	`productDescription` varchar(50),
	`productStatus` varchar(50)
);
insert into `Products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`)
value 
	("SP-001", "xe lăng 2 bánh", 3000000, 5, "Thuận tiện cho bốc đầu", "Suýt thì hết hàng"),
	("SP-002", "xe lăng 4 bánh", 6000000, 5, "Lăng 1 cách old school nhất", "Sắp hết hàng"),
	("SP-003", "xe lăng không có bánh", 1000000, 10, "Hồi còn sống thì các racing boy thường tin dùng", "Gần hết hàng");
    
explain select `productCode` from `Products` where `productCode` = "SP-002" or `productCode` = "SP-003";
    
alter table `Products`
add unique `productCodeIndex` (`productCode`);
alter table  `Products`
add unique `nameAndPriceIndex` (`productName`,`productPrice`);

explain select `productCode` from `Products` where `productCode` = "SP-002" or `productCode` = "SP-003";

create view `view_draft` as
select `productCode`, `productName`, `productPrice`, `productStatus`
from `Products`;
drop view `view_draft`;

delimiter //
create procedure `show_all_products`()
begin
	select * from `Products`;
end //
delimiter ;
call `show_all_products`();

set @`code` = "SP-004";
set @`name` = "Xe lăng bay được";
set @`price` = 10000000;
set @`amount` = 1;
set @`description` = "Bay mà không cần cánh";
set @`status` = "Chỉ còn 1 sản phẩm duy nhất";

delimiter //
create procedure `enter_product`(
	`code` varchar(50), 
    `name` varchar(50), 
    `price` int, 
    `amount`int, 
    `description` varchar(50), 
    `status` varchar(50)
    )
begin
	insert into `Products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`)
	value (`code`, `name`, `price`, `amount`, `description`, `status`);
end //
delimiter ;
call `enter_product`(@`code`,@`name`,@`price`,@`amount`,@`description`, @`status`);

set @`code_id` = 4;
set @`code_edit` = "SP-004";
set @`name_edit` = "Xe lăng còn pin thì bay được";
set @`price_edit` = 20000000;
set @`amount_edit` = 5;
set @`description_edit` = "Bay không cần cánh";
set @`status_edit` = "Chỉ còn 10 sản phẩm duy nhất";

delimiter //
create procedure `edit_by_id`(
	`id_edit` int, 
	`code_edit` varchar(50), 
    `name_edit` varchar(50), 
    `price_edit` int, 
    `amount_edit`int, 
    `description_edit` varchar(50), 
    `status_edit` varchar(50)
)
begin
update `products`
    set `productCode` = `code_edit`,
		`productName` = `name_edit`,
		`productPrice` = `price_edit`,
		`productAmount` = `amount_edit`,
		`productDescription` = `description_edit`,
		`productStatus` = `status_edit`
where (`id` = `id_edit`);
end //
delimiter ;
call `edit_by_id`(@`code_id`,@`code_edit`,@`name_edit`,@`price_edit`,@`amount_edit`,@`description_edit`,@`status_edit`);

set @`delete_id` = 4;
delimiter //
create procedure `delete_product`(`id_del` int)
begin
	delete from `products`
    where `products`.`id` = `id_del`;
end //
delimiter ;
call `delete_product`(@`delete_id`);