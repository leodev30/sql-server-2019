create database QLBH;
drop database QLBH
create table HOA_DON(
	SoHD int identity(1,1) primary key,
	NgayHD datetime not null,
	TenKH nvarchar(50) not null,
	DiaChi nvarchar(100),
	DienThoai varchar(10)
)

create table HANG(
	MaHang char(6) primary key,
	TenHang nvarchar(50) not null,
	DonViTinh nvarchar(50),
	DonGia float,
	SoLuong int
)

create table CHI_TIET_DH(
	SoHD int,
	MaHang char(6),
	GiaBan float,
	SoLuong int,
	MucGiamGia float
)

alter table HOA_DON add constraint NgayHD_D default getdate() for NgayHD

alter table HANG
add constraint DonGia_CHECK check(DonGia>=0)

alter table HANG
add constraint SoLuong_CHECK check(SoLuong>=0)

alter table CHI_TIET_DH
add constraint DH_SoHD foreign key (SoHD) references HOA_DON(SoHD);

alter table CHI_TIET_DH
add constraint DH_MaHang foreign key (MaHang) references HANG(MaHang)

alter table CHI_TIET_DH
add constraint GiaBan_CHECK check(GiaBan>=0)

alter table CHI_TIET_DH
add constraint SoLuong_CHECK check(SoLuong>=0)

insert into HOA_DON values
('01/15/2020',N'Phạm Song Hào',N'Thanh Xuân - Hà Nội','0988888888'),
('01/17/2020',N'Võ Anh Tuấn',N'Phủ Lý - Hà Nam','0969696969'),
('10/10/2019',N'Nguyễn Trọng Bắc',N'Đồng Văn - Hà Giang','0977777777'),
('10/18/2019',N'Nguyễn Tấn Tra',N'Cẩm Xuyên - Hà Tĩnh','0944556677'),
('10/28/2019',N'Nguyễn Tâm Thủy',N'Ký Sơn - Hòa Bình','0912345678')

insert into HANG values
('LT001',N'Máy tính Laptop',N'Chiếc',17000000,10),
('DT001',N'Máy tính desktop',N'Chiếc',15000000,20),
('CQ001',N'Chuột quang không dây',N'Chiếc',200000,100),
('BP001','Bàn phím thường không dây',N'Chiếc',150000,200),
('BP002',N'Bàn phím cơ không dây',N'Chiếc',500000,50)

insert into CHI_TIET_DH values
(1,'LT001',17000000,2,10),
(2,'LT001',16000000,3,0),
(3,'CQ001',200000,5,0),
(4,'BP001',150000,6,0),
(5,'BP002',500000,4,20)

--Phần II--

--Câu 1--
Create view Result1 
as
	Select TenKH, DiaChi, DienThoai
	from HOA_DON
	group by TenKH, DiaChi, DienThoai
	having count(NgayHD) = 2
	
select * from Result1
drop view Result1

select Row_number() over(order by NgayHD) STT, * from HOA_DON


--Câu 2--
Create view Result2 
as
	Select HANG.MaHang, TenHang, DonViTinh, CHI_TIET_DH.GiaBan, CHI_TIET_DH.SoLuong, (GiaBan*CHI_TIET_DH.SoLuong-GiaBan*CHI_TIET_DH.SoLuong*MucGiamGia/100) AS[Thành tiền]
	from HOA_DON, HANG, CHI_TIET_DH
	where HOA_DON.SoHD=CHI_TIET_DH.SoHD and HANG.MaHang=CHI_TIET_DH.MaHang 

select * from Result2	
--Câu 3--
Create view Result3
as
	SELECT HANG.MaHang,TenHang,SUM(CHI_TIET_DH.SoLuong*DonGia) as TongTien
	FROM HOA_DON, HANG, CHI_TIET_DH
	WHERE CHI_TIET_DH.MaHang = HANG.MaHang and HOA_DON.SoHD = CHI_TIET_DH.SoHD
	GROUP BY HANG.MaHang,TenHang
select * from Result3
--Câu 4--
Create view Result4
as
	Select HOA_DON.TenKH,DiaChi,DienThoai,COUNT(HOA_DON.SoHD) AS tongsohoadon
	from HOA_DON LEFT OUTER JOIN CHI_TIET_DH
	on HOA_DON.SoHD=CHI_TIET_DH.SoHD
	group by HOA_DON.TenKH,DiaChi,DienThoai

Select * from Result4

--Phần III--
--câu 1--
create proc TenKhachHang (@TenKH nvarchar(50))
as
begin
	select TenKH,TenHang,CHI_TIET_DH.SoLuong
	from HOA_DON,HANG,CHI_TIET_DH
	where CHI_TIET_DH.SoHD=HOA_DON.SoHD and	CHI_TIET_DH.MaHang=HANG.MaHang and TenKH=@TenKH
end
execute TenKhachHang N'Phạm Song Hào';
--caau2--
create proc spdel_XoaMatHang (@MaHang char(6))
as
begin
	delete from CHI_TIET_DH
	where CHI_TIET_DH.MaHang=(select MaHang from Hang where HANG.MaHang=@MaHang)
	delete from HANG
	where MaHang=@MaHang
end
execute spdel_XoaMatHang 'LT001';

--PHẦN IV--
drop trigger tg_CHI_TIETDH
Create trigger tg_CHI_TIETDH ON CHI_TIET_DH
INSTEAD OF INSERT 
as
	if not exists (select * from HOA_DON join inserted on HOA_DON.SoHD = inserted.SoHD)
	begin 
		print N'Số hóa đơn vừa nhập không có trong bảng Hóa Đơn'
		rollback tran
	end
	else if not exists (select *from HANG join inserted on HANG.MaHang = inserted.MaHang)
	begin 
		print N'Mã hàng vừa nhập không có trong bảng Hàng Hóa'
		rollback tran
	end
		else 
			begin 
				declare @sohd int
				declare @mahang char(6)
				declare @giaban float
				declare @soluong int
				declare @mucgiamgia float
				set @sohd = (select SoHD from inserted)
				set @mahang = (select MaHang from inserted)
				set @giaban = (select GiaBan from inserted)
				set @soluong = (select SoLuong from inserted)
				set @mucgiamgia = (select MucGiamGia from inserted)
				insert into CHI_TIET_DH values (@sohd,@mahang,@giaban,@soluong,@mucgiamgia)
			end
