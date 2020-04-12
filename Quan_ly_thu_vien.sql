Create database Quan_ly_thu_vien;
Use Quan_ly_thu_vien;
Create table tblDauSach (
	maDS varchar(4) primary key,
	tenSach varchar(50),
	namXB int,
	ngayNhap Datetime,
	soLuong int,
	maLV varchar(10),
	maNXB varchar(10),
	maTG varchar(10)
)
Create table tblDocGia (
	soThe varchar(4) primary key,
	hoten varchar(50),
	ngaySinh Datetime,
	tenLop varchar(5),
	Gt varchar(4)
)
Create table tblLinhVuc (
	maLV varchar(10) primary key,
	tenLV varchar(50)
)
Create table tblNXB (
	maNXB varchar(10) primary key,
	tenNXB varchar(50),
	diaChi varchar(50),
	dienThoai varchar(10)
)
Create table tblPhieuMuon (
	Id varchar(10) primary key,
	soThe varchar(10),
	maSach varchar(10),
	ngayMuon Datetime,
	ngayTra Datetime
)
Create table tblSach(
	maSach varchar(10) primary key,
	maDS varchar(10),
	tinhTrang varchar(10)
)
Create table tblTacGia (
	maTG varchar(10) primary key,
	tenTG varchar(25),
	diaChi varchar(50),
	dienThoai varchar(10)
)
alter table tblDauSach
add constraint tblSach_maDS foreign key (maDS) references tblDausach(maDS);

alter table tblDauSach
add idSach int

Create table nhapSach(
	maPhieuNhap int,
	maDS varchar(4),
	ngayNhap Datetime,
	soLuong int,
	donGia int
)

alter table tblDauSach
drop column ngayNhap,soLuong

alter table tblDauSach
drop column idSach
EXEC SP_Rename 'tblDocGia','DG'