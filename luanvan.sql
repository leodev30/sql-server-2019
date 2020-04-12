create database luanvan;

create table GIAO_VIEN(
	MaGV Char(5) primary key,
	TenGV nvarchar(100),
	Trinhdo nvarchar(50) default(N'TS')
)
create table SINH_VIEN(
	MaSV char(5) primary key,
	HoTen nvarchar(50),
	NgaySinh datetime,
	GioiTinh nvarchar(3),
	DiaChi nvarchar(1000)
)
drop table LUAN_VAN
create table LUAN_VAN(
	MaLV char(5) primary key,
	TenLV nvarchar(100) not null,
	LoaiDeTai nvarchar(50),
	MaGV char(5),
	CONSTRAINT fk_MaGV
	FOREIGN KEY(MaGV) REFERENCES GIAO_VIEN(MaGV),
	MaSV char(5),
	CONSTRAINT fk_MaSV
	FOREIGN KEY(MaSV) REFERENCES SINH_VIEN(MaSV),
)

drop database luanvan

alter table GIAO_VIEN 
add Constraint GIAO_VIEN_TrinhDo_Check check (Trinhdo = N'Cu Nhan' or Trinhdo = N'Ths' or Trinhdo = N'PGS' or Trinhdo = N'GS' or Trinhdo = 'TS') 

alter table SINH_VIEN
add constraint SINH_VIEN_GIOITINH_CHECK check(GioiTinh = N'Nam' or GioiTinh = N'Nữ')

insert into GIAO_VIEN 
values('GV001',N'Nguyen Thai Son',N'Ths'),
('GV002',N'Le Chi Luan',N'TS'),
('GV003',N'Pham Ngoc Hung',N'PGS'),
('GV004',N'le Trung kien',N'Ths'),
('GV005',N'Tran Ha Thanh',N'TS')
select * from GIAO_VIEN

insert into SINH_VIEN
values('SV001',N'Pham Song Hao','01/15/1981',N'Nữ',N'Thanh Xuân - Hà Nội'),
('SV002',N'Võ Anh Tuấn','01/15/1997',N'Nam',N'Phủ Lý - Hà Nam'),
('SV003',N'Nguyễn Trọng Bắc','10/10/2000',N'Nam',N'Cẩm Xuyên - Hà Tĩnh'),
('SV004',N'Nguyễn Tân Trà','10/18/1987',N'Nữ',N'Đồng Văn - Hà Giang'),
('SV005',N'Nguyễn Tâm Thủy','10/18/1987',N'Nữ',N'Kỳ Sơn - Hòa Bình')

insert into LUAN_VAN
values('LV001',N'Thiết kế website bán linh kiện điện tử',N'CNTT','GV001','SV001'),
('LV002',N'Phân Tích và Thiết kế hệ thống phần mềm hỗ trợ phòng chống dịch corona',N'HTTT','GV003','SV002'),
('LV003',N'Thiết kế mạng máy tính cho trường đại học UTT',N'MMT','GV005','SV003'),
('LV004',N'Thiết kế website giới thiệu và bán quần áo cho công ty may 10',N'CNTT','GV003','SV004'),
('LV005',N'Phân Tích và Thiết kế phần mềm quản lý nhân sự cho trường đại học UTT',N'CNTT','GV001','SV005')

create proc LuanVan_GiaoVien(@TenGV nvarchar(100))
as
begin
	Select HoTen, TenLV
	from SINH_VIEN, LUAN_VAN, GIAO_VIEN
	where TenGV = @TenGV and LoaiDeTai = N'CNTT'and SINH_VIEN.MaSV = LUAN_VAN.MaSV and GIAO_VIEN.MaGV = LUAN_VAN.MaGV
end

execute LuanVan_GiaoVien 'Nguyen Thai Son'
drop proc  spdel_XoaSinhVien
create proc spdel_XoaSinhVien(@HoTen nvarchar(50))
as
begin
	 delete from LUAN_VAN
	 where LUAN_VAN.maSV = (select maSV from SINH_VIEN where SINH_VIEN.HoTen = @HoTen) 
	 
	 delete from SINH_VIEN
	 where HoTen = @HoTen
end

execute spdel_XoaSinhVien 'Pham Song Hao'
select * from SINH_VIEN
select * from LUAN_VAN

drop trigger tg_LUAN_VAN_Them

create trigger tg_LUAN_VAN_Them
on LUAN_VAN
instead of insert 
as
if not exists (select * from  SINH_VIEN join inserted on SINH_VIEN.MaSV=inserted.MaSV)
	begin 
		print N'Mã Sinh viên vừa nhập không có trong bảng sinh viên'
		rollback tran
	end
else if not exists (select * from  GIAO_VIEN join inserted on GIAO_VIEN.MaGV=inserted.MaGV)
	begin 
		print N'Mã Giáo viên vừa nhập không có trong bảng giáo viên'
		rollback tran
	end
else 
	begin
		declare @MaLV varchar(5);
		declare @TenLV nvarchar(100);
		declare @LoaiDeTai nvarchar(50);
		declare @MaSV varchar(5);
		declare @MaGV varchar(5);
		set @MaLV = (select MaLV from inserted);
		set @TenLV = (select TenLV from inserted);
		set @LoaiDeTai = (select LoaiDeTai from inserted);
		set @MaSV = (select MaSV from inserted);
		set @MaGV = (select MaGV from inserted);

		insert into LUAN_VAN values(@MaLV,@TenLV,@LoaiDeTai,@MaGV,@MaSV);
	end

drop trigger tg_LUAN_VAN_Them
insert into LUAN_VAN
values('LV011',N'Thiết kế website bán linh kiện điện tử',N'CNTT','GV001','SV002')

select * from LUAN_VAN