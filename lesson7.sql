 -- задание 1
 
 create database les7;
 use les7;
 
 CREATE TABLE  users (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
`last_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
`email` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `email` (`email`));


create table orders (
`id`int(10) unsigned NOT NULL,
`user_id` int(10) unsigned NOT NULl);
drop table orders; 
SELECT id from users;

-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select user_id, count(user_id) as count from orders group by user_id order by count(user_id);
-- по идее каунт 0 не выводит, поэтому выполнение соответствует поставленной задаче 

-- задание 2

select p.name, c.name 
	from catalogs as c join products as p 
    on c.id=p.catalog.id;


-- задание 3

drop table flights;
create table flights (
`id`int(10) unsigned NOT NULL,
`from`varchar(100) not null,
`to` varchar(100) not null);

create table cities (
`label`varchar(100) not null,
`name` varchar(100) not null);

insert into flights values ('1', 'moscow', 'omsk');
insert into flights values ('2', 'novgorod', 'kazan');
insert into flights values ('3', 'irkutsk', 'moscow');


insert into cities values( 'moscow', 'москва');
insert into cities values( 'omsk', 'омск');
insert into cities values( 'kazan', 'казань');
insert into cities values( 'novgorod', 'новгород');
insert into cities values( 'irkutsk', 'иркутск');

select a.id, a.fr as 'from', b.tu as 'to'
	from (
    select f.id as id, f.from, c.name as fr
	from flights as f join cities as c
	on f.from=c.label) as a, 
    
	(select f.id, f.to, c.name as tu
	from flights as f join cities as c
	on f.to=c.label) as b
    where a.id=b.id; 

    
 