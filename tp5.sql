DROP TABLE IF EXISTS `tp_banner`;
CREATE TABLE `tp_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img_id` int(11) NOT NULL COMMENT '外键，关联image表',
  `url` varchar(100) NOT NULL COMMENT '根据不同的type含义,填写跳转链接',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '跳转类型，可能导向商品，可能导向专题，可能导向其他。0，无导向；1：导向商品;2:导向专题',
  `delete_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='banner表';

DROP TABLE IF EXISTS `tp_image`;
CREATE TABLE `tp_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL COMMENT '图片路径',
  `from` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 来自本地，2 来自公网',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 banner图,1 产品图,2 评论图',
  `delete_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COMMENT='图片总表';

DROP TABLE IF EXISTS `tp_user`;
CREATE TABLE `tp_user` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `openid` varchar(255) NOT NULL DEFAULT '' COMMENT '微信openid(唯一标示)',
  `nickname` varchar(255) NOT NULL DEFAULT '' COMMENT '微信昵称',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '微信头像链接',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `country` varchar(50) NOT NULL DEFAULT '' COMMENT '国家',
  `province` varchar(50) NOT NULL DEFAULT '' COMMENT '省份',
  `city` varchar(50) NOT NULL DEFAULT '' COMMENT '城市',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `delete_time` int(11) DEFAULT NULL,
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  KEY `openid` (`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='小程序用户表';

DROP TABLE IF EXISTS `tp_address`;
-- ----------------------------
-- 一个用户可以有多个地址
-- ----------------------------
CREATE TABLE `tp_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '收获人姓名',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `country` varchar(20) DEFAULT NULL COMMENT '区',
  `detail` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 非默认, 1为默认显示地址',
  `user_id` int(11) NOT NULL COMMENT '外键',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COMMENT='用户地址表';

CREATE TABLE `tp_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品分类id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(100) DEFAULT NULL COMMENT '类目描述',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类id',
  `img_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '外键，关联image表的id',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序方式(数字越小越靠前)',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

CREATE TABLE `tp_goods` (
  `goods_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `selling_point`  varchar(500) NOT NULL DEFAULT '' COMMENT '商品卖点',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `spec_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '商品规格(1单规格 2多规格)',
  `deduct_stock_type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '库存计算方式(1下单减库存 2付款减库存)',
  `content` longtext NOT NULL COMMENT '商品详情',
  `sales_initial` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '初始销量',
  `sales_actual` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '实际销量',
  `goods_sort` int(11) unsigned NOT NULL DEFAULT '100' COMMENT '商品排序(数字越小越靠前)',
  `goods_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '商品状态(1上架 2下架)',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除(0未删除 1删除)',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`goods_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='商品记录表';

CREATE TABLE `tp_goods_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `img_id` int(11) NOT NULL COMMENT '图片id(关联文件记录表)',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='商品图片记录表';

CREATE TABLE `tp_goods_sku` (
  `goods_sku_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品规格id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `spec_sku_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '商品sku记录索引 (由规格id组成)',
  `img_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格图片id',
  `goods_no` varchar(100) NOT NULL DEFAULT '' COMMENT '商品编码',
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `line_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品划线价',
  `stock_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前库存数量',
  `goods_sales` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品销量',
  `goods_weight` double unsigned NOT NULL DEFAULT '0' COMMENT '商品重量(Kg)',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`goods_sku_id`),
  UNIQUE KEY `sku_idx` (`goods_id`,`spec_sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='商品规格表';


CREATE TABLE `tp_goods_spec_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `spec_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格组id',
  `spec_value_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格值id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='商品与规格值关系记录表';

