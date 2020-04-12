Create database Books;
Use Books;
Create table SACH (
	Masach int primary key,
	Tensach nvarchar(50),
	Tentacgia nvarchar(50),
	Nhaxuatban nvarchar(50),
	Soluong int
)
Create table DOCGIA (
	Sothe int primary key,
	Tendocgia nvarchar(50),
	Khoa nvarchar(20),
	Khoahoc nvarchar(20),
	Thoihanthe nvarchar(10) default ('6 tháng')
)
Create table PHIEUMUON (
	Masach int,
	Sothe int,
	Ngaymuon datetime,
	Ngaytra datetime,
	Datra varchar(3),
	Ghichu nvarchar(50)
)
alter table PHIEUMUON
add constraint PHIEUMUON_Masach foreign key (Masach) references SACH(Masach);
alter table PHIEUMUON
add constraint PHIEUMUON_Sothe foreign key (Sothe) references DOCGIA(Sothe);

insert into SACH values (1,N'Tư tưởng Hồ Chí Minh',N'Đinh Huy Dương',N'Trẻ',100);
insert into SACH values (2,N'Đường lối Cách mạng của Đảng CSVN',N'Dương Xuân Đức',N'Giáo dục',250);
insert into SACH values (3,N'Mắt biếc',N'Nguyễn Nhật Ánh',N'Sư phạm',500);
insert into SACH values (4,N'Xác suất thống kê','Đinh Huy Dương',N'ĐHQG',300);
insert into SACH values (5,N'Đại số-Giải tích','Đinh Huy Dương',N'Kim Đồng',200);

insert into DOCGIA values (1,N'Nguyễn Văn A',N'Công nghệ thông tin','D18','1 tháng');
insert into DOCGIA values (2,N'Trần Văn B',N'An toàn thông tin','D16','4 tháng');
insert into DOCGIA values (3,N'Phạm Văn C',N'Đa phương tiện','D19','5 tháng');
insert into DOCGIA values (4,N'Lê Thị D','Marketing','D15','2 tháng');
insert into DOCGIA values (5,N'Đặng Thị E','Kế toán','D17','3 tháng');

insert into PHIEUMUON values (1,5,'11/11/2019','12/26/2019','YES','Không');
insert into PHIEUMUON values (2,3,'11/11/2019','12/27/2019','NO','Không');
insert into PHIEUMUON values (3,4,'11/13/2019','12/28/2019','NO','Không');
insert into PHIEUMUON values (3,1,'11/13/2019','12/29/2019','YES','Không');
insert into PHIEUMUON values (2,2,'11/15/2019','12/30/2019','YES','Không');

drop database Books; 
select *from SACH
select *from DOCGIA
select *from PHIEUMUON

delete from PHIEUMUON where sothe>=4;
update DOCGIA set Tendocgia=N'Vũ Thị G' where Sothe='4';

select Tendocgia,khoa from DOCGIA order by khoa DESC;

select Tendocgia,Khoa from DOCGIA,PHIEUMUON where DOCGIA.Sothe=ANY(select Sothe from PHIEUMUON where Ngaymuon='11/13/2019') and PHIEUMUON.Masach=1;

select Tendocgia,Sothe,Tensach from DOCGIA,SACH where DOCGIA.Sothe=ANY(select Sothe from PHIEUMUON where month(Ngaymuon)=11 and day(Ngaymuon)=11) and Masach=ANY(select Masach from PHIEUMUON where month(Ngaymuon)=11 and day(Ngaymuon)=11);

select Tensach from SACH where Masach not in (select Masach from PHIEUMUON);

select count(Masach) AS [Số sách] from PHIEUMUON where Masach=4 and Sothe=1;