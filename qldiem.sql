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

--câu 1
Select monhoc.mamh,tenmh,diem 
from monhoc,ketqua 
where monhoc.mamh=ketqua.mamh AND masv=1;

--câu 2
Select monhoc.mamh,tenmh,diem 
from monhoc,ketqua 
where monhoc.mamh=ketqua.mamh AND masv=2 AND diem<6.5;

--câu 3
Select sinhvien.masv,tensv 
from sinhvien,ketqua 
where sinhvien.masv=ketqua.masv AND mamh=ANY(select mamh from ketqua where diem<6.5 AND mamh=ANY(select mamh from monhoc where tenmh=N'Thể dục' OR tenmh=N'Hóa học hữu cơ' OR tenmh=N'Toán cao cấp'));

--câu 4
Select monhoc.mamh,tenmh 
from monhoc,ketqua 
where masv=1 AND monhoc.mamh=ketqua.mamh AND diem=0;

--câu 5
Select a.masv, tensv, diem 
from sinhvien as a join ketqua as b on a.masv=b.masv 
where mamh=1 and diem = (select Max(diem) from ketqua where mamh=1);

--câu 6
Select a.masv,tensv 
from (sinhvien as a join ketqua as b on a.masv=b.masv) join monhoc as c on b.mamh=c.mamh 
where c.mamh=2 AND diem > (select min(diem) from ketqua where mamh=2);

--câu 7
Select a.masv,tensv 
from (sinhvien as a join ketqua as b on a.masv=b.masv) join monhoc as c on b.mamh=c.mamh 
where c.mamh=1 AND diem > (select diem from ketqua where masv=3 AND mamh=1);

--câu 8
Select count(masv) AS [So sinh vien thi lai] 
from ketqua 
where mamh=7 and diem<5;

--câu 9
Select tenmh,count(masv) AS [So sinh vien ] 
from monhoc,ketqua 
where monhoc.mamh=ketqua.mamh AND diem <5 group by tenmh having count(masv)>=2;

---câu 10
Select a.masv,tensv,c.tenkhoa 
from (sinhvien as a join ketqua as b on a.masv=b.masv) join khoa as c on a.makhoa=c.makhoa 
where mamh=7 AND diem >= (select max(diem) from ketqua where mamh=7);

--câu 11
Select sinhvien.masv,tensv,(sum(heso*diem)/sum(heso)) AS[Diem trung binh] 
from sinhvien,ketqua,monhoc 
where sinhvien.masv=ketqua.masv and monhoc.mamh=ketqua.mamh 
group by tensv,sinhvien.masv;

--câu 12
Select sinhvien.masv,tensv,(sum(heso*diem)/sum(heso)) AS[Diem trung binh] 
from sinhvien,ketqua,monhoc,khoa
where sinhvien.masv=ketqua.masv and monhoc.mamh=ketqua.mamh and khoa.makhoa = sinhvien.makhoa and khoa.makhoa = 1
group by tensv,sinhvien.masv;

--câu 13
Select sinhvien.masv,tensv,count(mamh) AS[Số môn thi lại]
from sinhvien,ketqua
where sinhvien.masv = ketqua.masv and diem<5
group by sinhvien.masv,tensv
having count(mamh)>=2;

--câu 14
select sinhvien.masv,tensv,count(mamh) AS[Tất cả các môn]
from sinhvien,ketqua
where sinhvien.masv=ketqua.masv
group by sinhvien.masv,tensv
having count(mamh)=7;

--câu 15
select sinhvien.masv,tensv,(sum(heso*diem)/sum(heso)) AS[Điểm trung bình]
from sinhvien,ketqua,monhoc
where sinhvien.masv=ketqua.masv and monhoc.mamh=ketqua.mamh
group by sinhvien.masv,tensv
having (sum(heso*diem)/sum(heso))>=5

--câu 16
Select  a.masv, tensv 
from (sinhvien as a join ketqua as b on a.masv=b.masv) join monhoc as c on b.mamh=c.mamh 
where a.masv !=3 and diem<5 and c.mamh=any(select mamh from ketqua where diem<5 and masv=3);

--câu 17
select sinhvien.masv,tensv,count(mamh) AS [Số lượng điểm hơn 5],count(ketqua.masv) AS [Số sinh viên] 
from  ketqua,sinhvien
where sinhvien.masv=ketqua.masv and diem > 5
group by sinhvien.masv,tensv
having count(mamh) > (select count(masv)/2 from ketqua where masv=sinhvien.masv)

--câu 18
select sinhvien.masv,count(mamh) AS [Số lượng điểm hơn 7] 
from  ketqua,sinhvien
where sinhvien.masv=ketqua.masv and diem > 7
group by sinhvien.masv,tensv
having count(mamh) > (select count(masv)/2 from ketqua where masv=sinhvien.masv)

--câu 19
Select sinhvien.masv,tensv,(sum(heso*diem)/sum(heso)) AS[Diem trung binh] 
from sinhvien,ketqua,monhoc 
where sinhvien.masv=ketqua.masv and monhoc.mamh=ketqua.mamh 
group by tensv,sinhvien.masv
having ((sum(heso*diem)/sum(heso)) > (select (sum(heso*diem)/sum(heso) 
from monhoc,ketqua 
where ketqua.mamh=monhoc.mamh)));

--TẠO VIEW
	
-- Lấy ra danh sách sinh viên nữ học môn thể dục và kết quả
Create view SinhVienNu
as
	select a.masv,tensv,gioitinh,tenmh 
	from (sinhvien as a join ketqua as b on a.masv = b.masv) join monhoc as c on b.mamh=c.mamh
	where gioitinh=N'nữ' and tenmh=N'Thể dục'

select *from SinhVienNu

Create view SVQuaMon
as
	select tensv
	from (sinhvien as a join ketqua as b on a.masv = b.masv) join monhoc as c on b.mamh=c.mamh
	where tenmh=N'Hóa học hữu cơ' and diem>=5

select *from SVQuaMon

Create view DanhSachSV
as
	select tensv,sinhvien.masv,(sum(heso*diem)/sum(heso)) AS[Diem trung binh]
	from sinhvien,monhoc,ketqua
	where sinhvien.masv=ketqua.masv and monhoc.mamh = ketqua.mamh
	group by tensv,sinhvien.masv

select *from DanhSachSV

Create view HocLai
as
	select monhoc.mamh,tenmh,count(ketqua.masv) as [Số SV học lại]
	from sinhvien,ketqua,monhoc
	where sinhvien.masv=ketqua.masv and monhoc.mamh= ketqua.mamh and diem<5
	group by monhoc.mamh,tenmh

select *from HocLai



--TẠO VIEW
--Lấy ra danh sách sinh viên nữ học môn Lý thuyết cơ sở dữ liệu và điểm thi tương ứng. 
Create view SVNu_Theduc
as
	select a.masv,tensv,diem
	from (sinhvien as a join ketqua as b on a.masv = b.masv) join monhoc as c on b.mamh=c.mamh
	where gioitinh=N'nữ' and tenmh=N'Thể dục'
select *from SVNu_Theduc
drop view SVNu_Theduc

--Cho biết số sinh viên thi đỗ môn Hóa học hữu cơ
Create view SVQuaMon3
as
	select tensv,diem
	from (sinhvien as a join ketqua as b on a.masv = b.masv) join monhoc as c on b.mamh=c.mamh
	where tenmh=N'Hóa học hữu cơ' and diem>=5
select *from SVQuaMon3
drop view SVQuaMon3


--Lấy ra tên sinh viên và điểm trung bình của các sinh viên theo từng lớp
Create view Diemtrungbinh
as
	Select sinhvien.masv,tensv,(sum(heso*diem)/sum(heso)) AS[Diem trung binh] 
	from sinhvien,ketqua,monhoc 
	where sinhvien.masv=ketqua.masv and monhoc.mamh=ketqua.mamh 
	group by tensv,sinhvien.masv
select *from Diemtrungbinh


--Cho biết số sinh viên thi lại của từng môn
Create view Thilai
as
	select monhoc.mamh,tenmh,count (ketqua.masv) as [Số SV học lại]
	from sinhvien,ketqua,monhoc
	where sinhvien.masv=ketqua.masv and monhoc.mamh= ketqua.mamh and diem<5
	group by monhoc.mamh,tenmh
select *from Thilai
drop view Thilai

--Cho biết mã số và tên môn của những môn học mà tất cả các sinh viên đều đạt điểm >=5
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

--Cho biết mã số và tên những sinh viên có điểm trung bình chung học tập cao hơn điểm trung bình chung của mỗi lớp
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

--Cho biết mã số và tên nhưng sinh viên có hơn một nửa số điểm >=5
Create view NuaDiemHon5
as
	select sinhvien.masv,tensv,count(mamh) AS [Số lượng điểm hơn 5]count(ketqua.masv) AS [Số sinh viên] 
	from  ketqua,sinhvien
	where sinhvien.masv=ketqua.masv and diem > 5
	group by sinhvien.masv,tensv
	having count(mamh) > (select count(masv)/2 from ketqua where masv=sinhvien.masv)
select *from NuaDiemHon5
drop view NuaDiemhon5

--Cho biết mã số và số điểm lớn hơn 7 của những sinh viên có hơn một nửa số điểm là >=7
Create view NuaDiemHon7
as
	select tensv,sinhvien.masv,count(ketqua.masv) AS [Số điểm hơn 7] 
	from  ketqua,sinhvien
	where sinhvien.masv=ketqua.masv and diem > 7
	group by sinhvien.masv,tensv
	having count(mamh) > (select count(masv)/2 from ketqua where masv=sinhvien.masv)
select *from NuaDiemHon7
drop view NuaDiemHon7

