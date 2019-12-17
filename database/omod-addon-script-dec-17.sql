create table facility_has_location(
uuid varchar(64) not null,
location_id int not null,
location_name varchar(64) not null,
datimCode varchar(64) not null,
facility_name varchar(64) not null,
date_created date not null,
creator varchar(64) not null,
date_modified date null,
modified_by varchar(64) null,

primary key (location_id,datimCode),
foreign key (location_id) references location(location_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
