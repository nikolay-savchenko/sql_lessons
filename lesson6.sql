use vk;
drop table liked_media;
CREATE TABLE liked_media (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    media_id INT UNSIGNED NOT NULL,
    media_type_id INT UNSIGNED NOT NULL,
    liked_by_user_id INT UNSIGNED NOT NULL,
    liked_at TIMESTAMP DEFAULT current_timestamp);
select* from liked_media;

  
  select * from liked_media ;
  select * from messages;

ALTER TABLE messages add COLUMN liked_by_sender BOOLEAN DEFAULT false after is_delivered;
ALTER TABLE messages add COLUMN liked_by_recipient BOOLEAN DEFAULT false after is_delivered;
-- в уроке был задан вопрос по данным строчкам
-- я подразумевал, что отправитель сможет с помощью лайков добавлять в избранное, чтоб в будущем быстро находить необходимые отрывки из диалога, для этого лайки для себя релевантны. Наверно...)
-- а для других сущнустей (медии) создана специальная таблица

CREATE TABLE posts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
	header VARCHAR(255),
	body TEXT,
	attached_media_id INT UNSIGNED,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO posts
	SELECT 
		id,
		FLOOR(1 + (RAND() * 100)),
		header,
		body,
		NULL,
		CURRENT_TIMESTAMP
		FROM messages;

select * from users where id = 3;
desc profiles;
SELECT first_name, last_name, 'main_photo', 'city' FROM users WHERE id = 3;
SELECT 
	first_name, 
	last_name, 
	(select photo_id from profiles WHERE user_id = 3) as photo_id, 
	( select hometown from profiles where user_id=3) as city
	 FROM users WHERE id = 3;

describe media;
SELECT * FROM media;

SELECT filename FROM media
  WHERE user_id = 3
    AND media_type_id = (
      SELECT id FROM media_types WHERE name = 'photo'
    );
    

SELECT CONCAT(
  'Пользователь ', 
  (SELECT CONCAT(first_name, ' ', last_name)
    FROM users WHERE id = 3
),
  ' добавил фото ', 
  filename, ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 3 
      AND media_type_id = (
        SELECT id FROM media_types WHERE name LIKE 'photo');


SELECT user_id, filename, size 
  FROM media 
  ORDER BY size DESC
  LIMIT 10;

SELECT * FROM liked_media LIMIT 10;

rename table friendnship to friendship;

SELECT * FROM friendship;
(SELECT friend_id FROM friendship WHERE user_id = 3)
UNION
(SELECT user_id FROM friendship WHERE friend_id = 3);


SELECT * FROM friendship_statuses;

(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 3
    AND confirmed_at IS NOT NULL 
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name != 'Rejected'
    )
)
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 3
    AND confirmed_at IS NOT NULL 
    AND status_id IN (
      SELECT id FROM friendship_statuses 
        WHERE name != 'Rejected'
    )
);


SELECT user_id, SUM(size) AS total
  FROM media
  GROUP BY user_id
  HAVING total > 1000
  ORDER BY total DESC;
  
  

-- hw

-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем
    
select interlocuter, count(interlocuter)as count from 
(
	select from_user_id as user, to_user_id as interlocuter from messages
	where from_user_id=2
	union all
	select to_user_id as user, from_user_id as interlocuter from messages
	where to_user_id= 2
) as tbl
    group by interlocuter order by count desc limit 1;
 
 
-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

select count(id) from liked_media 
	where id in 
		(select id from media 
			where user_id in 
					(select * from (
						select user_id from profiles order by birthday desc limit 10 
									)as t
					)
		);

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

select sex, count(sex) as count from (	
	select liked_media.liked_by_user_id, profiles.sex as sex 
		from liked_media, profiles 
			where liked_media.liked_by_user_id=profiles.user_id) as t
group by sex order by count desc limit 1;

-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

describe profiles; 
describe liked_media;
describe users;
describe messages;
describe media;

 select user, count(user)from
	 (select from_user_id as user from messages
	 union all
	 select to_user_id as user from messages
	 union all 
	 select liked_by_user_id as user from liked_media 
	 union all
	 select user_id as user from media
	 ) as b
 group by user order by count(user) limit 10;
 

