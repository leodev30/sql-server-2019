Create Database Truy_van;
Use Truy_van;
Create table khachhang(
	MK int primary key,
	TenK varchar(50),
	DChi varchar(50),
	SoDT int
)
Create table baochi(
	MB int primary key,
	TenBao varchar(50),
	Gia int
)
Create table datbao(
	MK int,
	MB int,
	NgayDat datetime,
	SoLuong int
)
alter table datbao
add constraint datbao_MK foreign key (MK) references khachhang(MK);

alter table datbao 
add constraint datbao_MB foreign key (MB) references baochi(MB);

insert into baochi values (1,N'An ninh',10000);
insert into baochi values (2,'Dan tri',7000);
insert into baochi values (3,'Vietnamnet',8000);
insert into khachhang values (1,N'Đinh Huy Dương','123 ABC',0966459326);
insert into khachhang values (2,N'Đinh Dương','124 ABC',0964659326);
insert into khachhang values (3,N'Dương Đinh','125 ABC',0965649326);
insert into khachhang values (4,N'Huy Dương','126 ABC',0969645326);
insert into datbao values (1,2,'12/12/2019',10);
insert into datbao values (3,3,'11/11/2009',30);
insert into datbao values (3,2,'01/01/2000',20);
insert into datbao values (4,3,'08/12/2000',50);

select TenK,NgayDat,Gia,SoLuong,Gia*SoLuong AS[Thanh tien] from khachhang,baochi,datbao where khachhang.MK=datbao.MK and baochi.MB=datbao.MB;

select TenK,DChi from khachhang where MK= any(select MK from datbao where MB=(select MB from baochi where MB=2));

select *from baochi where MB= any(select MB from datbao where year(ngaydat)=2000);

select *from baochi where Gia=(select max(Gia) from baochi);

select *from khachhang
select *from baochi
select *from datbao