-- CREATING DATABASE
Create database influencer_db;
use influencer_db;

-- CREATING TABLES
create table users(
user_id int primary key,
username varchar(50),
followers int,
category varchar(50)
);

create table posts(
post_id int primary key,
user_id int,
post_date date,
content_type varchar(20),
foreign key(user_id) references users(user_id)
);

create table likes(
like_id int primary key,
post_id int,
user_id int,
foreign key(post_id) references posts(post_id),
foreign key(user_id) references users(user_id)
);

create table comments(
comment_id int primary key,
post_id int,
user_id int,
foreign key(post_id) references posts(post_id),
foreign key(user_id) references users(user_id)
);

-- DATA INSERTION
Insert into users values
(1, 'Bindu', 10000, 'beauty'),
(2, 'Krishna', 8000, 'fitness'),
(3, 'Meher', 15000, 'fashion'),
(4, 'Kaushik', 5000, 'food');
select * from users;

Insert into posts values
(101, 1, '2026-03-01', 'reel'),
(102, 1, '2026-03-05', 'photo'),
(103, 2, '2026-03-02', 'video'),
(104, 3, '2026-03-06', 'reel'),
(105, 4, '2026-03-07', 'photo');
select * from posts;

Insert into likes values
(1, 101, 2),
(2, 101, 3),
(3, 102, 3),
(4, 103, 1),
(5, 104, 2),
(6, 104, 1),
(7, 105, 3);
select * from likes;

Insert into comments values
(1, 101, 3),
(2, 101, 2),
(3, 104, 1),
(4, 105, 2);
select * from comments;

-- TO FIND TOTAL LIKES PER POST
select post_id, count(*) as total_likes from likes group by post_id;

-- TO SHOW USERNAME AND THIER POSTS
select u.username, p.post_id , p.content_type from users u join posts p on u.user_id = p.user_id;

-- TO SHOW TOTAL LIKES RECEIVED BY EACH USER
select u.username, count(l.like_id) as total_likes from users u 
join posts p on u.user_id = p.user_id
left join likes l on p.post_id = l.post_id
group by u.username;

-- TO FIND TOP INFLUENCER
select u.username, count(l.like_id) as total_likes from users u 
join posts p on u.user_id = p.user_id
left join likes l on p.post_id = l.post_id
group by u.username
order by total_likes desc
limit 1;

-- TO FIND BEST CONTENT TYPE
select p.content_type, count(l.like_id) as total_likes from posts p
left join likes l on p.post_id = l.post_id
group by p.content_type
order by total_likes desc;



