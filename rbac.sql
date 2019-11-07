# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.35)
# Database: tp51
# Generation Time: 2019-11-07 10:45:22 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table tp_auth_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tp_auth_admin`;

CREATE TABLE `tp_auth_admin` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user` varchar(32) NOT NULL COMMENT '账号',
  `name` varchar(64) NOT NULL COMMENT '用户名',
  `head` varchar(255) DEFAULT NULL COMMENT '头像',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `login_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `last_login_ip` varchar(32) NOT NULL DEFAULT '0.0.0.0' COMMENT '最后登录ip地址',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否禁用；0: 禁用 1:正常',
  `updatapassword` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `user_unique` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tp_auth_admin` WRITE;
/*!40000 ALTER TABLE `tp_auth_admin` DISABLE KEYS */;

INSERT INTO `tp_auth_admin` (`uid`, `user`, `name`, `head`, `password`, `login_count`, `last_login_ip`, `last_login_time`, `status`, `updatapassword`, `create_time`, `update_time`)
VALUES
	(1,'admin','admin',NULL,'$2y$10$HLh4UHoluqLvwsNN6vQxz.tuKMA5xYp6rH2vOpA.74sxiQbjwm2My',95,'::1',1573117251,1,1,0,1573117251),
	(2,'admin1','admin1',NULL,'$2y$10$HLh4UHoluqLvwsNN6vQxz.tuKMA5xYp6rH2vOpA.74sxiQbjwm2My',14,'::1',1573117228,1,1,0,1573117228);

/*!40000 ALTER TABLE `tp_auth_admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tp_auth_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tp_auth_group`;

CREATE TABLE `tp_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `rules` varchar(128) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id， 多个规则","隔开',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tp_auth_group` WRITE;
/*!40000 ALTER TABLE `tp_auth_group` DISABLE KEYS */;

INSERT INTO `tp_auth_group` (`id`, `title`, `status`, `rules`, `create_time`, `update_time`)
VALUES
	(1,'管理员组',1,'1,2,3,4,5,6,8,9,10',0,1494407780),
	(2,'普通用户组',1,'1,6,7,8',0,1494308736);

/*!40000 ALTER TABLE `tp_auth_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tp_auth_group_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tp_auth_group_access`;

CREATE TABLE `tp_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tp_auth_group_access` WRITE;
/*!40000 ALTER TABLE `tp_auth_group_access` DISABLE KEYS */;

INSERT INTO `tp_auth_group_access` (`uid`, `group_id`)
VALUES
	(1,1),
	(2,2);

/*!40000 ALTER TABLE `tp_auth_group_access` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tp_auth_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tp_auth_rule`;

CREATE TABLE `tp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `pid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  `menu` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否是菜单；0:否，1:是',
  `icon` varchar(255) DEFAULT NULL COMMENT '菜单图标',
  `sort` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tp_auth_rule` WRITE;
/*!40000 ALTER TABLE `tp_auth_rule` DISABLE KEYS */;

INSERT INTO `tp_auth_rule` (`id`, `name`, `title`, `pid`, `status`, `condition`, `menu`, `icon`, `sort`)
VALUES
	(1,'#','首页',0,1,'',1,'layui-icon layui-icon-home',1),
	(2,'#','管理用户管理',0,1,'',1,'layui-icon layui-icon-user',1),
	(3,'admin/userList','管理用户列表',2,1,'',1,NULL,1),
	(4,'admin/groupList','管理用户组列表',2,1,'',1,NULL,1),
	(5,'admin/edit','添加用户',2,1,'',0,'',1),
	(6,'#','系统管理',0,1,'',1,'layui-icon layui-icon-set',1),
	(7,'admin/cleanCache','清除缓存',6,1,'',1,'',1),
	(8,'admin/menu','菜单管理',6,1,'',1,'',1),
	(9,'admin/home','系统信息',1,1,'',1,'',1),
	(10,'admin/log','日志管理',6,1,'',1,'',1),
	(11,'admin/editMenu','编辑菜单',6,1,'',0,'',1),
	(12,'admin/deleteMenu','删除菜单',6,1,'',0,'',1),
	(13,'admin/config','系统配置',6,1,'',1,'',1),
	(14,'admin/siteConfig','站点配置',6,1,'',1,'',1),
	(15,'admin/editGroup','添加编辑用户组',2,1,'',0,'',1),
	(16,'admin/disableGroup','禁用用户组',2,1,'',0,'',1),
	(17,'admin/ruleList','规则列表',2,1,'',0,'',1),
	(18,'admin/editRule','修改规则',2,1,'',0,'',1);

/*!40000 ALTER TABLE `tp_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tp_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tp_config`;

CREATE TABLE `tp_config` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '配置字段名',
  `title` varchar(64) NOT NULL COMMENT '配置标题名称',
  `value` varchar(255) NOT NULL COMMENT '配置参数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tp_config` WRITE;
/*!40000 ALTER TABLE `tp_config` DISABLE KEYS */;

INSERT INTO `tp_config` (`id`, `name`, `title`, `value`, `status`, `create_time`, `update_time`)
VALUES
	(1,'system_config','系统配置','{\"debug\": \"1\", \"trace\": \"0\", \"trace_type\": \"0\"}',0,1523414007,1531729547),
	(2,'site_config','站点配置','{\"title\":\"thinkphp51\",\"name\":\"thinkphp51\",\"copyright\":\"copyright @2019 qymagic\",\"icp\":\"粤ICP备18016905号-1\"}',1,1523414007,1573118200);

/*!40000 ALTER TABLE `tp_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tp_login_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tp_login_log`;

CREATE TABLE `tp_login_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `user` varchar(64) NOT NULL COMMENT '账号',
  `name` varchar(64) NOT NULL COMMENT '用户名',
  `last_login_ip` varchar(32) NOT NULL COMMENT '登录ip',
  `create_time` int(11) unsigned NOT NULL COMMENT '登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tp_login_log` WRITE;
/*!40000 ALTER TABLE `tp_login_log` DISABLE KEYS */;

INSERT INTO `tp_login_log` (`id`, `uid`, `user`, `name`, `last_login_ip`, `create_time`)
VALUES
	(1,1,'admin','admin','::1',1573031642),
	(2,1,'admin','admin','::1',1573040757),
	(3,1,'admin','admin','::1',1573041477),
	(4,1,'admin','admin','::1',1573054969),
	(5,1,'admin','admin','::1',1573107351),
	(6,1,'admin','admin','::1',1573113867),
	(7,1,'admin','admin','::1',1573114703),
	(8,2,'admin1','admin1','::1',1573117228),
	(9,1,'admin','admin','::1',1573117251);

/*!40000 ALTER TABLE `tp_login_log` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
