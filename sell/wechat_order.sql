drop database if exists wechat_order;
create database wechat_order default character set utf8 collate utf8_general_ci;
use wechat_order;

/*类目表*/
create table product_category(
	category_id int not null auto_increment comment '类目id' ,
	category_name varchar(64) not null comment '类目名称' ,
	category_type int not null comment '类目编号' ,
	create_time timestamp not null default current_timestamp comment '创建时间' ,
	update_time timestamp not null default current_timestamp on update current_timestamp comment '修改时间' ,
	primary key(category_id),
	unique key uqe_category_type (category_type)
) comment '类目表' ;


/*商品表*/
create table product_info(
	product_id varchar(32) not null comment '商品id' ,
	product_name varchar(64) not null comment '商品名称' ,
	product_price decimal(8,2) not null comment '商品单价' ,
	product_stock int not null comment '库存' ,
	product_icon varchar(512) comment '商品图片' ,
	product_description varchar(64) comment '商品描述' ,
	product_status tinyint(3) default '0' comment '商品状态 , 0正常 , 1下架' ,
	category_type int not null comment '类目编号' ,
	create_time timestamp not null default current_timestamp comment '创建时间' ,
	update_time timestamp not null default current_timestamp on update current_timestamp comment '修改时间' ,
	primary key (product_id)
	/*foreign key(category_type) references product_category(category_type)*/
) comment '商品表' ;



/*订单表*/
create table order_master(
	order_id varchar(32) not null comment '订单id' ,
	buyer_name varchar(32) not null comment '买家名称' ,
	buyer_phone varchar(32) not null comment '买家电话' ,
	buyer_address varchar(128) not null comment '买家地址' ,
	buyer_openid varchar(64) not null comment '买家微信的openid' ,
	order_amount decimal(8,2) not null comment '订单总金额' ,
	order_status tinyint(3) not null default '0' comment '订单状态 , 默认0为新订单' ,
	pay_status tinyint(3) not null default '0' comment '支付状态 , 默认0为未支付' ,
	create_time timestamp not null default current_timestamp comment '创建时间' ,
	update_time timestamp not null default current_timestamp on update current_timestamp comment '修改时间' ,
	primary key (order_id) ,
	key idx_buyer_openid (buyer_openid)
) comment '订单表' ;

/*订单详情表*/
create table order_detail(
	detail_id varchar(32) not null comment '订单详情表的id' ,
	order_id varchar(32) not null comment '订单id' ,
	product_id varchar(32) not null comment '商品id' ,
	product_name varchar(64) not null comment '商品名称' ,
	product_price decimal(8,2) not null comment '商品价格' ,
	product_quantity int not null comment '商品数量' ,
	product_icon varchar(512) not null comment '商品图片' ,
	create_time timestamp not null default current_timestamp comment '创建时间' ,
	update_time timestamp not null default current_timestamp on update current_timestamp comment '修改时间' ,
	primary key (detail_id) ,
	key idx_order_id (order_id)
) comment '订单详情表' ;
	

/*商家信息表*/
create table seller_info(
    seller_id int  not null auto_increment comment '商家信息表id' ,
    username varchar(32) not null comment '商家名称' ,
    password varchar(332) not null comment '商家密码' ,
    phone varchar(64) not null comment '用户手机号' ,
    create_time timestamp not null default current_timestamp comment '创建时间' ,
    update_time timestamp not null default current_timestamp on update current_timestamp comment '修改时间' ,
    primary key (seller_id)
) comment '商家信息表' ;

/* 评论信息表 */
create table comment(
    comment_id int not null auto_increment comment '评论信息的id' ,
    comment_name varchar(64) not null comment '评论者姓名' ,
    openid varchar(64) not null comment '评论者的openid' ,
    comment_content text not null comment '评论内容' ,
    create_time timestamp not null default current_timestamp comment '评论时间' ,
    primary key (comment_id)
)comment '评论信息表' ;

/* 用户信息表 */
create table user(
    user_id int not null auto_increment comment '用户id' ,
    user_name varchar(32) not null comment '用户名' ,
    user_phone varchar(32) not null comment '用户手机号' ,
    openid varchar(64) not null comment '用户微信openid' ,
    user_table varchar(64) comment '桌号' ,
    user_number varchar(64) comment '就餐人数' ,
    create_time timestamp not null default current_timestamp comment '创建时间' ,
    update_time timestamp not null default current_timestamp on update current_timestamp comment '修改时间' ,
    primary key (user_id)
)comment '用户就餐信息表' ;

/* 轮播图片 */
create table picture(
    pic_id int not null auto_increment comment '图片id' ,
    pic_url varchar(256) not null comment '图片路径' ,
    pic_message varchar(64) not null comment '图片信息' ,
    create_time timestamp not null default current_timestamp comment '创建时间' ,
    primary key (pic_id)
) comment '轮播图表' ;


