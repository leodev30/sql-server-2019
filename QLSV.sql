Create database QLDIEM;
Use QLDIEM;
drop database QLDIEM
Create table khoa(
	makhoa int primary key,
	tenkhoa nvarchar(50)
)
Create table monhoc(
	mamh int primary key,
	tenmh nvarchar(50),
	heso float
)
Create table sinhvien(
	masv int primary key,
	tensv nvarchar(50),
	gioitinh nvarchar(3) check(gioitinh=N'nữ' OR gioitinh='nam'),
	makhoa int,
	somondk int,
	diemTB float,
)
Create table ketqua(
	masv int,
	mamh int,
	diem float
)

alter table sinhvien
add constraint sinhvien_makhoa foreign key (makhoa) references khoa(makhoa);

alter table ketqua
add constraint ketqua_masv foreign key (masv) references sinhvien(masv);

alter table ketqua
add constraint ketqua_mamh foreign key (mamh) references monhoc(mamh);

Insert into khoa values (1,N'Công nghệ thông tin');
insert into khoa values (2,N'Công nghệ Đa phương tiện');
insert into khoa values (3,N'Quản trị kinh doanh');
insert into khoa values (4,N'Kế toán');

Insert into monhoc values (1,N'Thể dục',3);
Insert into monhoc values (2,N'Vật lý và Thí nghiệm',3);
Insert into monhoc values (3,N'Hóa học hữu cơ',3);
Insert into monhoc values (4,N'Toán cao cấp',3);
Insert into monhoc values (5,N'Tư tưởng Hồ Chí Minh',2);
Insert into monhoc values (6,N'Đường lối Cách mạng của Đảng Cộng sản Việt Nam',2);
Insert into monhoc values (7,N'Ngôn ngữ lập trình C++',3);

Insert into sinhvien values (1,N'Nguyễn Văn A',N'nam',2,2,'');
Insert into sinhvien values (2,N'Lê Thị B',N'nữ',1,3,'');
Insert into sinhvien values (3,N'Phạm Thị C',N'nữ',4,3,'');
Insert into sinhvien values (4,N'Trần Văn D',N'nam',3,7,'');
Insert into sinhvien values (5,N'Đinh Văn E',N'nam',1,7,'');
Insert into sinhvien values (6,N'Lương Thị G',N'nữ',4,7,'');
Insert into sinhvien values (7,N'Trịnh Thị H',N'nữ',2,7,'');

Insert into ketqua values (1,3,7.0);
Insert into ketqua values (1,6,6.5);
Insert into ketqua values (1,1,'');
Insert into ketqua values (1,2,6.5);
Insert into ketqua values (1,4,6.5);
Insert into ketqua values (1,7,6.5);
Insert into ketqua values (1,5,6.5);

Insert into ketqua values (2,1,6.0);
Insert into ketqua values (2,5,6.7);
Insert into ketqua values (2,6,8.5);
Insert into ketqua values (2,2,4);
Insert into ketqua values (2,3,3.0);
Insert into ketqua values (2,7,6.0);
Insert into ketqua values (2,4,6.0);

Insert into ketqua values (3,4,6.0);
Insert into ketqua values (3,1,4.0);
Insert into ketqua values (3,5,4.0);
Insert into ketqua values (3,7,4.9);
Insert into ketqua values (3,2,9.0);
Insert into ketqua values (3,3,3.5);
Insert into ketqua values (3,6,8.5);

Insert into ketqua values (4,1,4);
Insert into ketqua values (4,3,6);
Insert into ketqua values (4,2,8.5);
Insert into ketqua values (4,4,9.5);
Insert into ketqua values (4,7,7.5);
Insert into ketqua values (4,5,8.5);
Insert into ketqua values (4,6,5.5);

Insert into ketqua values (5,1,5.5);
Insert into ketqua values (5,5,6);
Insert into ketqua values (5,4,7);
Insert into ketqua values (5,3,3);
Insert into ketqua values (5,2,6.5);
Insert into ketqua values (5,7,6.5);
Insert into ketqua values (5,6,6.5);

Insert into ketqua values (6,1,9);
Insert into ketqua values (6,7,8.5);
Insert into ketqua values (6,6,8.5);
Insert into ketqua values (6,3,6);
Insert into ketqua values (6,2,9.5);
Insert into ketqua values (6,4,9.5);
Insert into ketqua values (6,5,8.5);

Insert into ketqua values (7,1,6.5);
Insert into ketqua values (7,2,6.5);
Insert into ketqua values (7,5,5);
Insert into ketqua values (7,3,8);
Insert into ketqua values (7,4,6.5);
Insert into ketqua values (7,7,9.5);
Insert into ketqua values (7,6,5.5);

--TẠO VIEW
--câu 1:Lấy ra danh sách sinh viên nữ học môn Lý thuyết cơ sở dữ liệu và điểm thi tương ứng. 
Create view SVNu_Theduc
as
	select a.masv,tensv,diem
	from (sinhvien as a join ketqua as b on a.masv = b.masv) join monhoc as c on b.mamh=c.mamh
	where gioitinh=N'nữ' and tenmh=N'Thể dục'
select *from SVNu_Theduc
drop view SVNu_Theduc

--câu 2:Cho biết số sinh viên thi đỗ môn Hóa học hữu cơ
Create view SVQuaMon3
as
	select tensv,diem
	from (sinhvien as a join ketqua as b on a.masv = b.masv) join monhoc as c on b.mamh=c.mamh
	where tenmh=N'Hóa học hữu cơ' and diem>=5
select *from SVQuaMon3
drop view SVQuaMon3


--câu 3:Lấy ra tên sinh viên và điểm trung bình của các sinh viên theo từng lớp
Create view Diemtrungbinh
as
	Select sinhvien.masv,tensv,(sum(heso*diem)/sum(heso)) AS[Diem trung binh] 
	from sinhvien,ketqua,monhoc 
	where sinhvien.masv=ketqua.masv and monhoc.mamh=ketqua.mamh 
	group by tensv,sinhvien.masv
select *from Diemtrungbinh


--câu 4:Cho biết số sinh viên thi lại của từng môn
Create view Thilai
as
	select monhoc.mamh,tenmh,count (ketqua.masv) as [Số SV học lại]
	from sinhvien,ketqua,monhoc
	where sinhvien.masv=ketqua.masv and monhoc.mamh= ketqua.mamh and diem<5
	group by monhoc.mamh,tenmh
select *from Thilai
drop view Thilai

--câu 5:Cho biết mã số và tên môn của những môn học mà tất cả các sinh viên đều đạt điểm >=5
Create view QuaMon
as
	select monhoc.mamh,tenmh
	from monhoc,sinhvien,ketqua
	where monhoc.mamh=ketqua.mamh and sinhvien.masv = ketqua.masv
	group by monhoc.mamh,tenmh
	having count (sinhvien.masv) = (select count(masv)
	from ketqua
	where diem>=5 and mamh =monhoc.mamh);
select *from QuaMon
drop view QuaMon

--câu 6:Cho biết mã số và tên những sinh viên có điểm trung bình chung học tập cao hơn điểm trung bình chung của mỗi lớp
Create view SVXuatsac
as
	select tenkhoa,sinhvien.masv,tensv,(sum(heso*diem)/sum(heso)) AS[Diem trung binh] 
	from sinhvien,ketqua,monhoc,khoa
	where sinhvien.masv=ketqua.masv and monhoc.mamh=ketqua.mamh and sinhvien.makhoa = khoa.makhoa
	group by tensv,sinhvien.masv,tenkhoa
	having sum(heso*diem)/sum(heso) >= any(select tenkhoa,sum(heso*diem)/sum(heso)
	from monhoc,ketqua,khoa,sinhvien
	where ketqua.mamh=monhoc.mamh and sinhvien.masv=ketqua.masv and khoa.makhoa=sinhvien.makhoa
	group by tenkhoa)
select *from SVXuatsac
drop view SVXuatsac

--câu 7:Cho biết mã số và tên nhưng sinh viên có hơn một nửa số điểm >=5
Create view NuaDiemHon5
as
	select sinhvien.masv,tensv,count(mamh) AS [Số lượng điểm hơn 5]count(ketqua.masv) AS [Số sinh viên] 
	from  ketqua,sinhvien
	where sinhvien.masv=ketqua.masv and diem > 5
	group by sinhvien.masv,tensv
	having count(mamh) > (select count(masv)/2 from ketqua where masv=sinhvien.masv)
select *from NuaDiemHon5
drop view NuaDiemhon5

--câu 8:Cho biết mã số và số điểm lớn hơn 7 của những sinh viên có hơn một nửa số điểm là >=7
Create view NuaDiemHon7
as
	select tensv,sinhvien.masv,count(ketqua.masv) AS [Số điểm hơn 7] 
	from  ketqua,sinhvien
	where sinhvien.masv=ketqua.masv and diem > 7
	group by sinhvien.masv,tensv
	having count(mamh) > (select count(masv)/2 from ketqua where masv=sinhvien.masv)
select *from NuaDiemHon7
drop view NuaDiemHon7

alter table sinhvien add ngaysinh datetime

create proc DSSV_cung_nam_sinh (@nam int)
as
	select *from sinhvien
	where datepart(yyyy,ngaysinh)=@nam;
execute DSSV_cung_nam_sinh 2000;
drop proc DSSV_cung_nam_sinh

create proc compare(@x int,@y int)
as
begin
	declare @ngaysinh1 int,@ngaysinh2 int
	select @ngaysinh1=year(ngaysinh) from sinhvien where masv=@x
	select @ngaysinh2=year(ngaysinh) from sinhvien where masv=@y
	if @ngaysinh1>@ngaysinh2 
		print N'SV mã ' + str(@x,1) + N' sinh sau sinh viên mã ' + str(@y,1)
	else
		print N'SV mã ' + str(@x,1) + N' sinh trước sinh viên mã ' + str(@y,1)
end
execute compare 2,3;
drop proc compare

create function kt_thangsinh(@mamh int)
returns @thang table (tensv nvarchar(50),thang int)
as
	begin
		insert into @thang 
		select tensv,month(ngaysinh) as [Tháng]
		from sinhvien,ketqua 
		where sinhvien.masv=ketqua.masv and mamh=@mamh
		return
	end
select *from kt_thangsinh(1);