Create database quan_li_nhan_vien;
Use quan_li_nhan_vien;
Create table nhanvien(
	maNV int PRIMARY KEY,
	hoten varchar(50),
	NS datetime,
	GT varchar(3) CHECK(GT='Nam' or GT='Nữ'),
	HSL float DEFAULT(3),
	DC varchar(150),
	maPB int,
	ngayVL datetime
)
Create table phongban(
	maPB int PRIMARY KEY,
	tenDV varchar(50),
	maTP int,
	ngayBD datetime,
	soNV int
)
Create table diadiem(
	maPB int,
	diadiem varchar(150),
	Constraint maPB_diadiem_phongban foreign key (maPB) references phongban(maPB)
)
Create table duan(
	maDA int PRIMARY KEY,
	tenDA varchar(50),
	diadiem varchar(150),
	ngayBD datetime,
	maPB int,
	Constraint maPB_duan_phongban foreign key (maPB) references phongban(maPB)
)
Create table thannhan(
	hoten varchar(50),
	NS datetime,
	GT varchar(3) CHECK(GT='Nam' or GT='Nữ'),
	quanhe varchar(6) CHECK(quanhe='Chồng' or quanhe='Vợ' or quanhe='Bố' or quanhe='Mẹ' or quanhe='Con'),
	maNV int,
	Constraint maNV_thannhan_nhanvien foreign key (maNV) references nhanvien(maNV)
)
Create table phancong(
	maDA int,
	maNV int,
	sogio float CHECK( sogio>2 and sogio<10 ),
	ngaylamDA datetime,
	Constraint maNV_phancong_nhanvien foreign key (maNV) references nhanvien(maNV),
	Constraint maDA_phancong_duan foreign key (maDA) references duan(maDA)
)
alter table nhanvien 
add constraint nhanvien_maPB foreign key (maPB) references phongban(maPB);

alter table phongban
add constraint _maNV foreign key (maNV) references phongban(maPB);