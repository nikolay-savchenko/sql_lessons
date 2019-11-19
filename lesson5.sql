create database lesson5;
use lesson5;

-- пункт 1.
drop table users;
create table users(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	created_at DATETIME DEFAULT NOW(), -- заполняю текущим датой и временем
	updated_at DATETIME DEFAULT NOW()
);

Insert into users 
SELECT
	FLOOR (1+(RAND()*10)),
    NOW(),
    NOW();
-- пришлось много раз нажимать для создания 10 строчек.  На прошлом уроке создавали таким образом строчки, но в этом примере нет второй таблицы.
-- подскажите, пожалуйста, как правильно создавть такие строчки в таблице...
-- INSERT INTO relations 
-- SELECT
-- 	id,
-- 	FLOOR (1+(RAND()*100)),
-- 	FLOOR (1+(RAND()*100)),
-- 	FLOOR (1+(RAND()*6))
-- FROM relation_statuses;


-- преобразование в варчар 
SELECT * FROM USERS ;
desc users;
ALTER TABLE users MODIFY COLUMN updated_at VARCHAR(100);
ALTER TABLE users MODIFY COLUMN created_at VARCHAR(100);

-- обратное преобразование в дэйттайм. Пункт 2

ALTER TABLE users MODIFY COLUMN updated_at DATETIME;
ALTER TABLE users MODIFY COLUMN created_at DATETIME;

--  пункт 3
SELECT * FROM storehouses_products ORDER BY value=0 asc, value asc;


-- пункт 4 для БД ВК
use VK;
SELECT users.id, CONCAT(users.first_name, ' ', users.last_name) AS full_name,
	monthname(profiles.birthday) AS birthday_month
    FROM USERS, PROFILES
    WHERE users.id = profiles.user_id and (MONTHNAME(profiles.birthday)='August' or MONTHNAME(profiles.birthday)= 'May') ;


 -- пункт5 
 SELECT * FROM users WHERE id IN (5, 1, 2) ORDER BY FIELD (id, 5, 1, 2);

-- задания по агрегации данных 

-- задание 1 

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, profiles.birthday, NOW()))) FROM profiles;

SELECT users.id, CONCAT(users.first_name, ' ', users.last_name) AS full_name, 
TIMESTAMPDIFF(YEAR, profiles.birthday, NOW()) AS AGE
	FROM USERS, PROFILES
	WHERE users.id = profiles.user_id; 
-- потренировался выводить данные из разных таблиц

-- задание 2

select DAYNAME(CONCAT(YEAR(NOW()),'-', MONTH(profiles.birthday),'-', DAY(profiles.birthday))) AS DAYS, 
	COUNT(DAYNAME(CONCAT(YEAR(NOW()),'-', MONTH(profiles.birthday),'-', DAY(profiles.birthday)))) AS BIRTHDAY_DAYS 
FROM profiles
GROUP BY DAYNAME(CONCAT(YEAR(NOW()),'-', MONTH(profiles.birthday),'-', DAY(profiles.birthday)));


-- задание 3
SELECT EXP(SUM(LOG(users.id))) FROM USERS;
-- не знал произведение какого столбца можно посчитать






