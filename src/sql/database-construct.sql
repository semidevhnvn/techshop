create database techshop
character set utf8mb4
collate utf8mb4_unicode_ci;

use techshop;

--

create table administrator (
    id       int         not null auto_increment primary key,
    username varchar(32) not null unique,
    password varchar(32) not null
);

insert into administrator
    (id, username , password)
values
    ( 1, 'admin'  , '123456789'),
    ( 2, 'semidev', '123456789');

--

create table brand (
    id          int         not null auto_increment primary key,
    name        varchar(64) not null,
    image_url   mediumtext  not null,
    slug        varchar(64) not null unique,
    edited_date datetime    not null,
    edited_by   varchar(32) not null
);

create table product (
    id            int          not null auto_increment primary key,
    brand_id      int          not null,
    name          varchar(128) not null,
    price         float        not null,
    feature       mediumtext,
    promotion_id  int,
    description   mediumtext,
    specification mediumtext,
    slug          varchar(128) not null unique,
    edited_date   datetime     not null,
    edited_by     varchar(32)  not null
);

create table promotion (
    id          int        not null auto_increment primary key,
    description mediumtext not null,
    discount    float      not null
);

alter table product
add constraint fk_product_brand
foreign key (brand_id) references brand(id);

alter table product
add constraint fk_product_promotion
foreign key (promotion_id) references promotion(id);

--

create table product_image (
    id         int        not null auto_increment primary key,
    product_id int        not null,
    image_url  mediumtext not null
);

alter table product_image
add constraint fk_product_image_product
foreign key (product_id) references product(id);

--

create table campaign (
    id          int        not null auto_increment primary key,
    description mediumtext not null,
    discount    float      not null
);

create table campaign_product_detail (
    campaign_id int not null,
    product_id  int not null
);

alter table campaign_product_detail
add constraint fk_campaign_product_detail_campaign
foreign key (campaign_id) references campaign(id);

alter table campaign_product_detail
add constraint fk_campaign_product_detail_product
foreign key (product_id) references product(id);

--

create table category (
    id          int         not null auto_increment primary key,
    name        varchar(64) not null,
    slug        varchar(64) not null unique,
    edited_date datetime    not null,
    edited_by   varchar(32) not null
);

create table category_product_detail (
    category_id int not null,
    product_id  int not null
);

alter table category_product_detail
add constraint fk_category_product_detail_category
foreign key (category_id) references category(id);

alter table category_product_detail
add constraint fk_category_product_detail_product
foreign key (product_id) references product(id);

--

create table collection (
    id          int         not null auto_increment primary key,
    name        varchar(64) not null,
    slug        varchar(64) not null unique,
    `order`     int         not null,
    edited_date datetime    not null,
    edited_by   varchar(32) not null
);

create table collection_product_detail (
    collection_id int not null,
    product_id    int not null,
    `order`       int not null
);

alter table collection_product_detail
add constraint fk_collection_product_detail_collection
foreign key (collection_id) references collection(id);

alter table collection_product_detail
add constraint fk_collection_product_detail_product
foreign key (product_id) references product(id);

--

create table related_product (
    id              INT NOT NULL,
    main_product_id INT NOT NULL,
    `order`         INT NOT NULL
);

alter table related_product
add constraint fk_related_product_product_main
foreign key (id) references product(id);

alter table related_product
add constraint fk_related_product_product_related
foreign key (main_product_id) references product(id);