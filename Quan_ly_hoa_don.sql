Create database quan_li_ban_hang;
Use	quan_li_ban_hang;
drop database quan_li_ban_hang
Create table nhanvien(
	manv int primary key,
	hoten nvarchar(50),
	diachi nvarchar(100),
	sdt varchar(10),
	ngaysinh datetime,
	gt nvarchar(3) check(gt=N'nữ' OR gt=N'nam'),
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
	phuongthuctt varchar(10)
)
Create table ct_hoadon(
	mahd int ,
	mahang int,
	soluongmua int,
	dongia float,
)
alter table hoadonxuat
add constraint fk_makh_hoadonxuat_khachhang foreign key (makh) references khachhang(makh);
alter table hoadonxuat
add constraint fk_manv_hoadonxuat_nhanvien foreign key (manv) references nhanvien(manv)
alter table ct_hoadon
add constraint fk_mahang_cthoadon_nhanvien foreign key (mahang) references hang(mahang);
alter table ct_hoadon
add constraint fk_mahd_cthoadon_hoadonxuat foreign key (mahd) references hoadonxuat(mahd);

Insert into nhanvien values
(1,N'Nguyễn Văn A',N'Hải Phòng','0123456789','06/28/1993',N'nam',5.5),
(2,N'Nguyễn Thị B',N'Vĩnh Phúc','0123456789','07/28/1996',N'nữ',5.0),
(3,N'Phạm Thị C',N'Hà Nội','0123456789','09/24/1995',N'nữ',7.0);

Insert into hang values	
(1,N'Điện thoại','SAMSUNG',N'12 tháng'),
(2,N'Máy giặt','Toshiba',N'13 tháng'),
(3,N'Ti-vi','LG',N'14 tháng'),
(4,N'Tủ lạnh','Hitachi',N'2 tháng'),
(5,'Bình nóng lạnh','Ferroli',N'24 tháng'),
(6,'Điều hòa','Asanzo',N'6 tháng');

Insert into khachhang values 
(1,N'Lê Thị A',N'0123456789',N'Hà Đông','0987654321','meocon@gmail.com'),
(2,N'Phạm Văn B',N'0123456789',N'Hà Nam','0987654321','meocon@gmail.com'),
(3,N'Hoàng Văn C',N'0123456789',N'Mai Dịch','0987654321','meocon@gmail.com'),
(4,N'Nguyễn Thị D',N'0123456789',N'Hoàng Mai','0987654321','meocon@gmail.com'),
(5,N'Trần Văn B',N'0123456789',N'Cầu Giấy','0987654321','meocon@gmail.com'),
(6,N'Vũ Thị A',N'0123456789',N'Trường Chinh','0987654321','meocon@gmail.com'),
(7,N'Trịnh Văn B',N'0123456789',N'Lĩnh Nam','0987654321','meocon@gmail.com');

Insert into hoadonxuat values 
(1,3,'10/06/2013',2,'Money'),
(2,1,'07/29/2013',1,'Money'),
(3,2,'10/03/2014',3,'Bank'),
(4,5,'10/04/2013',3,'Money'),
(5,7,'07/30/2013',2,'Money'),
(6,6,'10/02/2013',3,'Money'),
(7,4,'07/31/2013',1,'Money');

Insert into ct_hoadon values
(1,1,2,3000000),
(1,2,1,10000000),
(2,3,1,5000000),
(3,1,4,3000000),
(4,1,2,3000000),
(4,1,2,3000000),
(4,2,1,10000000),
(5,2,1,10000000),
(5,3,1,6000000),
(5,1,4,3000000),
(6,3,1,7000000),
(7,1,4,2000000);


Select hoten,month(ngaysinh)AS[Thang sinh] from nhanvien where month(ngaysinh)=6 OR month(ngaysinh)=9;
Select tenkh,diachi,email from khachhang where email !='';
Select hoten from nhanvien where manv=(select manv from nhanvien having min(year(ngaysinh)) );
Select *from khachhang where diachi != N'Đống Đa' AND diachi != N'Hoàng Mai';
Select *from hang where mahang not in(Select mahang from ct_hoadon );
Select mahd,sum(soluongmua*dongia)AS[Tong tien] from ct_hoadon group by mahd;
Select Max(year(getdate())-year(ngaysinh)) AS[Tuoi cao nhat] from nhanvien ;
Select *from hang 
where mahang =ANY(Select mahang from ct_hoadon where (dongia*soluongmua) >= 10000000 AND mahd=ANY(select mahd from hoadonxuat where year(ngaylaphd)=2014));




--TẠO PROC
create proc tong_tien_1_khach_mua (@makh int)
as
begin
	select tenkh,khachhang.makh,sum(soluongmua*dongia) as[TỔNG TIỀN]
	from khachhang,hoadonxuat,ct_hoadon,hang
	where khachhang.makh=hoadonxuat.makh
		and hoadonxuat.mahd=ct_hoadon.mahd
		and hang.mahang=ct_hoadon.mahang
		and hoadonxuat.makh=@makh
	group by tenkh,khachhang.makh
end
execute tong_tien_1_khach_mua 2;
drop proc tong_tien_1_khach_mua


create proc tong_tien_1_hoa_don (@mahd int)
as
begin
	select hoadonxuat.mahd,sum(soluongmua*dongia) as[TỔNG TIỀN]
	from hoadonxuat,ct_hoadon
	where hoadonxuat.mahd=ct_hoadon.mahd
		and hoadonxuat.mahd=@mahd
	group by hoadonxuat.mahd
end
execute tong_tien_1_hoa_don 3;


create proc tong_tien_1_thang (@month float,@year float)
as
begin
	select month(ngaylaphd),year(ngaylaphd),sum(soluongmua*dongia) as[TỔNG TIỀN]
	from hoadonxuat,ct_hoadon
	where hoadonxuat.mahd=ct_hoadon.mahd
		and month(ngaylaphd)=@month
		and year(ngaylaphd)=@year
	group by month(ngaylaphd),year(ngaylaphd)
end
execute tong_tien_1_thang 7,2013;


create proc nhan_vien_tuoi_max
as
begin
	declare @maxTuoi float
	set @maxTuoi = (Select max(year(getdate())-year(ngaysinh)) from nhanvien)
	select *from nhanvien where (year(getdate())-year(ngaysinh))=@maxTuoi
end
execute nhan_vien_tuoi_max
