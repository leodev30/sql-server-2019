Create database quan_li_nhan_su;
Use quan_li_nhan_su;
Create table nhanvien(
	maNV int primary key,
	hoten varchar(50),
	NS datetime,
	GT varchar(3) CHECK(GT='Nam' or GT='Nữ'),
	QQ varchar(50),
	DT varchar(10),
	maPB int
)
Create table phongban(
	maPB int references nhanvien(maPB),
	tenPB varchar(50),
	dienthoai int
)
/*Alter table phongban
Add soluong int*/

/*Alter table phongban
Drop Column soluong*/

/*Alter table phongban
alter column maPB float*/

/*EXEC SP_RENAME 'chucvu.maCV', 'maCongVan','Column'*/
/*EXEC SP_RENAME 'phongban', 'pb'*/
Create table chucvu(
	maCV int,
	tenCV varchar(50) CHECK(tenCV='GĐ' or tenCV='PGĐ' or tenCV='TP' or tenCV='PP' or tenCV='NV'),
	HSPC float
)
Create table TD_HV(
	maTDHV int,
	tenTD varchar(50),
	chuyennganh varchar(50)
)
Create table bacluong(
	maBL int,
	HS float Default(2.54),
	HSPC float,
	Constraint CK_HSL CHECK(HS>=2.54 and HS<=12),
	Constraint CK_HSPC CHECK(HSPC>=0.4 and HSPC<=1.2)
)
Create table DC_PB(
	maPB int,
	diachi varchar(100)
)
Create table NV_Chucvu(
	maNV int,
	maCV int,
	ngayQD datetime
)
Create table NV_TDHV(
	maNV int,
	maTD int,
	ngayBD datetime
)
Create table NV_Bacluong(
	maNV int,
	maBL int,
	ngayQD datetime
)