use vk;
show tables;
 
SELECT * FROM USERS limit 10;
ALTER TABLE users DROP COLUMN is_banned;
ALTER TABLE users ADD COLUMN is_banned BOOLEAN DEFAULT false AFTER phone;
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT TRUE AFTER is_banned;
UPDATE users SET is_banned = true where id in(15, 54,66,88);
UPDATE users SET is_active = false where id in(3, 33,44,77);
 
SELECT * FROM profiles limit 10;
DESCRIBE profiles;                -- не применял, так как изначально внес правильный пол в столбец 
-- CREATE TEMPORARY TABLE sex (sex CHAR(1));
-- SELECT * FROM sex;
-- DELETE FROM sex;
-- INSERT INTO sex values ('M'), ('F');
-- UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);


 SELECT * FROM messages limit 10;
 select count(*) from users;
 
 UPDATE messages SET
	from_user_id=FLOOR (1+(RAND()*100)),
    to_user_id=FLOOR (1+(RAND()*100)),
	to_user_id=from_user_id+1 where to_user_id=from_user_id;
    
select * from media limit 10;
update media set user_id = FLOOR (1+ (RAND() * 100));
update media set metadata= CONCAT('{"', filename, '":"', size, '"}');
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- ALTER TABLE media DROP COLUMN metadata;
-- ALTER TABLE media ADD COLUMN metadata JSON AFTER size;

SELECT * FROM media_types;
DELETE FROM media_types;
-- TRUNCATE media_types;
INSERT INTO `media_types` (`id`, `name`) VALUES (1, 'audio');
INSERT INTO `media_types` (`id`, `name`) VALUES (2, 'photo');
INSERT INTO `media_types` (`id`, `name`) VALUES (3, 'video');
UPDATE media SET media_type_id=FLOOR(1+(rand()*3));


SELECT * FROM friendnship limit 10;
UPDATE friendnship SET
	user_id=FLOOR (1+(RAND()*100)),
    friend_id=FLOOR (1+(RAND()*100)),
	user_id=friend_id+1 where user_id=friend_id; 
    
    
INSERT INTO friendship_statuses VALUES (DEFAULT, "Rejected");
SELECT * FROM friendship_statuses limit 10;

ALTER TABLE communities ADD COLUMN created_at TIMESTAMP DEFAULT current_timestamp AfTER name;
ALTER TABLE communities ADD COLUMN is_closed BOOLEAN AFTER created_at;
ALTER TABLE communities ADD COLUMN closed_at TIMESTAMP AFTER is_closed;
ALTER TABLE communities ADD COLUMN user_id INT UNSIGNED;

DESC communities;

UPDATE communities SET is_closed= TRUE WHERE id IN (2, 8,10);
UPDATE communities SET closed_at = NOW() where is_closed IS TRUE;

DESC communities_users;
ALTER TABLE communities_users ADD COLUMN is_banned BOOLEAN DEFAULT false AFTER user_id;
ALTER TABLE communities_users ADD COLUMN is_admin BOOLEAN DEFAULT false AFTER user_id;

UPDATE communities_users SET is_banned= TRUE WHERE user_id IN (1, 43,69,74);
UPDATE communities_users SET is_admin= TRUE WHERE id IN (8, 23, 45,82);


DESC messages;
ALTER TABLE messages ADD COLUMN header VARCHAR (255) AFTER to_user_id;
UPDATE messages set header=substring(body, 1,50);

ALTER TABLE messages ADD COLUMN attached_media_id INT UNSIGNED after body;
UPDATE messages SET attached_media_id = (
	SELECT id FROM media WHERE user_id = from_user_id limit 1);


create table relations (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    USER_ID INT UNSIGNED NOT NULL,
    RELATIVE_ID INT UNSIGNED NOT NULL,
    RELATION_STATUS_ID INT UNSIGNED NOT NULL
);


CREATE TABLE relation_statuses(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);


INSERT INTO relation_statuses (name) VALUES 
	('son'),
    ('daughter'),
    ('mother'),
    ('father'),
    ('wife'), 
    ('husband');


-- TRUNCATE relations;
INSERT INTO relations 
SELECT
	id,
	FLOOR (1+(RAND()*100)),
	FLOOR (1+(RAND()*100)),
	FLOOR (1+(RAND()*6))
FROM relation_statuses;

select * from relations;


-- --------likes
drop table liked_media;
CREATE TABLE liked_media (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    media_id INT UNSIGNED NOT NULL,
    liked_by_user_id INT UNSIGNED NOT NULL,
    liked_at TIMESTAMP DEFAULT current_timestamp);
    
select count(*) from MEDIA; -- 250 
select count(*) from MESSAGES; -- 400

select * from liked_media;

UPDATE liked_media  SET media_id= FLOOR(1+(RAND()*250));
UPDATE liked_media  SET liked_by_user_id= FLOOR (1+(RAND()*100));

-- но почему то таблица не заполняется, видимо нужно определить количество строк?

-- message likes
desc messages;
select * from messages;
ALTER TABLE messages add COLUMN liked_by_sender BOOLEAN DEFAULT false after is_delivered;
ALTER TABLE messages add COLUMN liked_by_recipient BOOLEAN DEFAULT false after is_delivered;
UPDATE messages SET liked_by_sender = TRUE WHERE id IN (45, 88,69,100);
UPDATE messages SET liked_by_recipient = TRUE WHERE id IN (53, 67, 102,105);




    