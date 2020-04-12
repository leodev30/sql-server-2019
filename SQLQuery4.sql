Create database quan_li_ban_hang;
Use	quan_li_ban_hang;

Create table nhanvien(
	manv int primary key,
	hoten nvarchar(50),
	diachi nvarchar(100),
	sdt varchar(10),
	ngaysinh datetime,
	gt nvarchar(3) check(gt=N'nữ' OR gt='nam'),
	HSL float
)
Create table hang(
	mahang int primary key,
	tenhang nvarchar(50),
	nhasx nvarchar(50),
	tgianbaohanh nvarchar(20),
)
Create table khachhang(
	makh int primary key,
	tenkh nvarchar(50),
	cmt nvarchar(12),
	diachi nvarchar(100),
	sdt varchar(10),
	email varchar(20)
)
Create table hoadonxuat(
	mahd int primary key,
	makh int,
	ngaylaphd datetime,
	manv int,
	phuongthuctt varchar(10),
)
Create table ct_hoadon(
	mahd int ,
	mahang int,
	soluongmua int,
	dongia float,
)
alter table hoadonxuat
add Constraint hoadonxuat_makh foreign key (makh) references khachhang(makh);
alter table hoadonxuat
add Constraint hoadonxuat_manv foreign key (manv) references nhanvien(manv);
alter table ct_hoadon
add Constraint ct_hoadon_mahang foreign key (mahang) references hang(mahang);
alter table ct_hoadon
add Constraint ct_hoadon_mahd foreign key (mahd) references hoadonxuat(mahd);

Insert into nhanvien values 
(1,N'Nguyễn Văn A',N'Hải Phòng','0123456789','06/28/1993',N'nam',5.5),
(2,N'Nguyễn Thị B',N'Vĩnh Phúc','0123456789','07/28/1996',N'nữ',5.0),
(3,N'Phạm Thị C',N'Hà Nội','0123456789','09/24/1995','nữ',7.0);

Insert into hang values 
(1,N'Điện thoại','SAMSUNG',N'12 tháng'),
(2,N'Máy giặt','Toshiba',N'18 tháng'),
(3,N'Ti-vi','LG',N'6 tháng'),
(4,N'Tủ lạnh','Hitachi',N'2 tháng'),
(5,N'Bình nóng lạnh','Ferroli',N'12 tháng');

Insert into khachhang values 
(1,N'Đào Thị Thu Huyền',N'0123456789',N'Hà Đông','0987654321','meocon@gmail.com'),
(2,N'Phạm Nhật Lệ',N'0123456789',N'Hà Nam','0987654321','meocon@gmail.com'),
(3,N'Hoàng Khánh Vy',N'0123456789',N'Mai Dịch','0987654321','meocon@gmail.com');

Insert into hoadonxuat values 
(1,3,'10/02/2013',2,'Money'),
(2,1,'07/29/2013',1,'Money'),
(3,2,'10/02/2014',3,'Bank');

Insert into ct_hoadon values (1,1,2,3000000),(1,2,1,10000000),(2,3,1,5000000),(3,1,4,3000000);

Select hoten,month(ngaysinh)AS[Thang sinh] from nhanvien where month(ngaysinh)=6 OR month(ngaysinh)=9;

Select tenkh,diachi,email from khachhang where email !='';

Select hoten from nhanvien where manv=(select manv from nhanvien having min(year(ngaysinh)) );

Select *from khachhang where diachi != N'Đống Đa' AND diachi != N'Hoàng Mai';

Select *from hang where mahang not in(Select mahang from ct_hoadon );

Select mahd,sum(soluongmua*dongia)AS[Tong tien] from ct_hoadon group by mahd;

Select

Select *from hang where mahang =ANY(Select mahang from ct_hoadon where (dongia*soluongmua) >= 10000000 AND mahd=ANY(select mahd from hoadonxuat where year(ngaylaphd)=2014));

--TẠO PROC