Create Database NhanVien;
Use NhanVien;
Create table nhanvien(
	MaNV int primary key,
	Hoten nvarchar(50),
	DiaChi nvarchar(50),
	SDT nvarchar(10),
	NgaySinh datetime,
	HSL int
)
Create table hang(
	MaHang int,
	TenHang nvarchar(50),
	NhaSX nvarchar(50),
	TGianBaoHanh nvarchar(10)
)
Create table khachhang(
	MaKH int,
	TenKH nvarchar(50),
	CMT nvarchar(15),
	DiaChi nvarchar(50),
	SDT nvarchar(10),
	Email nvarchar(50)
)
Create table hoadonxuat(
	MaHD int primary key,
	MaKH int,
	NgayLapHD datetime,
	MaNV int,
	PhuongThucTT nvarchar(20)
)
Create table ct_hoadon(
	MaHD int,
	MaHang int,
	SoLuongMua int,
	DonGia int
)
alter table hoadonxuat
add constraint hoadonxuat_MaNV foreign key (MaNV) references nhanvien(MaNV);
alter table ct_hoadon
add constraint ct_hoadonxuat_MaHD foreign key (MaHD) references hoadonxuat(MaHD);

insert into nhanvien values (1,'Nguyễn Văn A','123 ABC','1234567890','01/01/2000',4);
insert into nhanvien values (2,'Nguyễn Văn B','124 ABC','1234567891','02/02/2000',7);
insert into nhanvien values (3,'Nguyễn Văn C','125 ABC','1234567892','03/02/2000',5);
insert into nhanvien values (4,'Nguyễn Văn D','126 ABC','1234567893','04/03/2000',6);
insert into nhanvien values (5,'Nguyễn Văn E','127 ABC','1234567894','04/02/2000',8);

insert into hang values (1,'Tivi','LG','1 năm');
insert into hang values (2,'Tủ lạnh','LG','2 năm');
insert into hang values (3,'Máy tính','LG','6 tháng');
insert into hang values (4,'Điện thoại','LG','2 tháng');
insert into hang values (5,'Bếp điện','LG','5 năm');

insert into khachhang

insert into hoadonxuat

insert into ct_hoadon