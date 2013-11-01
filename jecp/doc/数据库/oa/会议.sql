SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE OA_MEETINGJOIN;
DROP TABLE OA_MEETINGRECORD;
DROP TABLE OA_MEETING;




/* Create Tables */

CREATE TABLE OA_MEETING
(
	ID BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	TITLE VARCHAR(100) NOT NULL COMMENT '标题',
	FBTIME DATETIME COMMENT 'FBTIME',
	CREATER BIGINT COMMENT '创建人',
	CTIME DATETIME COMMENT '创建时间',
	CONTENT LONGTEXT COMMENT '内容',
	STARTTIME VARCHAR(20) COMMENT '开始时间',
	-- yyyy-MM-dd HH:mm:ss
	-- 
	ENDTIME VARCHAR(20) COMMENT '结束时间',
	-- 0：已取消
	-- 1：筹划中
	-- 2：进行中
	-- 3：归档
	STAT SMALLINT(1) DEFAULT 1 COMMENT '状态',
	GUIDANGREN BIGINT COMMENT '归档人',
	GDTIME DATETIME COMMENT '归档时间',
	GUIDANG LONGTEXT COMMENT '归档内容',
	PRIMARY KEY (ID)
) COMMENT = '会议';


CREATE TABLE OA_MEETINGJOIN
(
	ID BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	UID BIGINT COMMENT '与会人id',
	MID BIGINT NOT NULL COMMENT '会议Id',
	-- 0:已分配
	-- 1:已参与
	-- 2:未参与
	-- 3:中途离开
	STAT SMALLINT(1) DEFAULT 0 COMMENT '参与状态',
	PRIMARY KEY (ID)
) COMMENT = '与会人员';


CREATE TABLE OA_MEETINGRECORD
(
	ID BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	UID BIGINT NOT NULL COMMENT '记录人',
	CONTEXT LONGTEXT NOT NULL COMMENT '内容',
	CTIME DATETIME NOT NULL COMMENT '记录时间',
	MID BIGINT NOT NULL COMMENT '会议ID',
	PRIMARY KEY (ID),
	CONSTRAINT mtr_mid_uid UNIQUE (UID, MID)
) COMMENT = '会议记录';



/* Create Foreign Keys */

ALTER TABLE OA_MEETINGJOIN
	ADD FOREIGN KEY (MID)
	REFERENCES OA_MEETING (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE OA_MEETINGRECORD
	ADD FOREIGN KEY (MID)
	REFERENCES OA_MEETING (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



