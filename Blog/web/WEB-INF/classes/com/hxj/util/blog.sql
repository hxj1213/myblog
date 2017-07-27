DROP DATABASE IF EXISTS myblog;
CREATE DATABASE myblog CHARACTER SET UTF8;
use myblog;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
  id INT AUTO_INCREMENT,
  uname VARCHAR(20) NOT NULL ,
  passw VARCHAR(20) NOT NULL ,
  PRIMARY KEY (id)
);

INSERT INTO users(uname, passw) VALUES ('admin','admin');
INSERT INTO users(uname, passw) VALUES ('zhangsan','zhangsan');

DROP TABLE IF EXISTS entries;
CREATE TABLE entries (
  id INT AUTO_INCREMENT,
  title TEXT,
  content TEXT,
  posted_on DATETIME,
  user_id INT,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS comment;
CREATE TABLE comment(
  id INT AUTO_INCREMENT,
  entries_id INT,
  postuser_id INT,
  content TEXT,
  posted_on DATETIME,
  PRIMARY KEY(id)
);

INSERT INTO entries(id,title,content,posted_on,user_id) VALUES(5,'张三小传','哈哈哈哈',now(),1);

INSERT INTO comment(entries_id, postuser_id, content, posted_on) VALUES(1,2,'赞同',now());
INSERT INTO comment(entries_id, postuser_id, content, posted_on) VALUES(2,2,'有同感',now());

select et.*,ut.uname from entries et INNER JOIN users ut on et.user_id=ut.id;

select *,(select uname from users where id=user_id) uname from entries where id=1;

select * from ( select et.*,ut.uname from entries et INNER JOIN users ut on et.user_id=ut.id order by id desc) tb limit 0,2;

select basetb.*,users.uname from (select * from comment where entries_id=2) basetb INNER JOIN users on basetb.postuser_id=users.id;


select id from users where uname=?;