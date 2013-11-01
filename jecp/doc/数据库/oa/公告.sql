SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE OA_GGREADLIST;
DROP TABLE OA_GONGGAO;
DROP TABLE OA_GGLAN;




/* Create Tables */

CREATE TABLE OA_GGLAN
(
	ID BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	NAME VARCHAR(20) NOT NULL COMMENT 'name',
	DESCP VARCHAR(200) COMMENT '描述',
	-- 0:不可用 1可用
	ENABLE SMALLINT DEFAULT 1 NOT NULL COMMENT '是否生效',
	PRIMARY KEY (ID)
) COMMENT = '公告栏';


CREATE TABLE OA_GGREADLIST
(
	UID BIGINT COMMENT '用户id',
	RDATE DATETIME COMMENT '查阅时间',
	GGID BIGINT NOT NULL COMMENT 'ggid'
) COMMENT = '公告查阅列表';


CREATE TABLE OA_GONGGAO
(
	ID BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	TITLE VARCHAR(100) COMMENT '标题',
	CONTEXT LONGTEXT COMMENT '内容',
	CTIME DATETIME COMMENT '创建时间日期',
	CREATER BIGINT COMMENT '创建人',
	FBDATE DATETIME COMMENT '发布日期时间',
	CXDATE DATETIME COMMENT '撤销日期时间',
	-- 1:置顶
	ZD SMALLINT DEFAULT 0 COMMENT '置顶',
	STARTDATE DATE COMMENT '开始日期时间',
	ENDDATE DATE COMMENT '结束日期时间',
	SHOWCONT INT COMMENT '阅读次数',
	UDATE DATETIME COMMENT '更新时间',
	GGLID BIGINT NOT NULL COMMENT '公告栏',
	PRIMARY KEY (ID)
) COMMENT = '公告';



/* Create Foreign Keys */

ALTER TABLE OA_GONGGAO
	ADD FOREIGN KEY (GGLID)
	REFERENCES OA_GGLAN (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE OA_GGREADLIST
	ADD FOREIGN KEY (GGID)
	REFERENCES OA_GONGGAO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



