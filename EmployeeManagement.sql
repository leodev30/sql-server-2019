create database EmployeeManagement;
use EmployeeManagement;

create table dept(
	deptno int primary key not null,
	dname nvarchar(14),
	loc nvarchar(20)
)
create table salgrade(
	grade float primary key,
	losal float,
	hisal float
)
create table emp(
	empno int primary key not null,
	ename nvarchar(30),
	job nvarchar(20),
	mgr int,
	hiredate datetime,
	sal float,
	comm float,
	deptno int
)

alter table emp
add constraint fk_mgr foreign key (empno) references emp(empno);

alter table emp
add constraint emp_deptno foreign key (deptno) references dept(deptno);

insert into dept values
(10,'Headquater','R101'),
(20,'Marketing','R102'),
(30,'Sales','R103')

insert into salgrade values
(1,700,1200),
(2,1201,1400),
(3,1401,2000),
(4,2001,3000),
(5,3001,9999)

insert into emp values
(7839,'king','president','','11/17/1981',5000,'',10),
(7698,'blake','manager',7839,'05/01/1981',2850,'',30),
(7782,'clark','manager',7839,'06/09/1981',2450,'',10),
(7566,'jones','manager',7839,'04/02/1981',2975,'',20),
(7654,'martin','salesman',7698,'09/28/1981',1250,1400,30),
(7499,'allen','salesman',7698,'02/20/1981',1600,300,30),
(7844,'turner','salesman',7698,'09/08/1981',1500,'',30),
(7900,'james','clerk',7698,'12/03/1981',950,'',30),
(7521,'ward','salesman',7698,'02/22/1981',1250,500,30),
(7902,'ford','analyst',7566,'12/03/1981',3000,'',20),
(7369,'smith','clerk',7902,'12/17/1980',800,'',20),
(7788,'scott','analyst',7566,'12/09/1982',3000,'',20),
(7876,'adams','clerk',7788,'01/12/1983',1100,'',20),
(7934,'miller','clerk',7782,'01/23/1981',1300,'',10)

--câu a
select ename,deptno,sal
from emp
where sal>1000 and sal<2000;

--câu b
select deptno,dname from dept order by dname asc;

--câu c
select ename,empno from emp where deptno=10 or deptno=20;

--câu d
select ename from emp where job='clerk' and deptno=20;

--câu e
select empno,ename from emp where ename like '%th%' or ename like '%ll%'; 

--câu f
select ename,job,sal from emp where mgr!=0;

--câu g
select ename,deptno,hiredate from emp where year(hiredate)=1983;

--câu h
select ename,hiredate,(hiredate+365) from emp order by hiredate asc;

--câu i
select min(sal) as[Lương thấp nhất],max(sal) as[Lương cao nhất],avg(sal) as[Lương trung bình] 
from emp 
where mgr!=0;

--câu j
select job,min(sal) as[Lương nhỏ nhất],max(sal) as[Lương lớn nhất] 
from emp 
group by job;

--câu k
select count(empno) as[Số giám đốc] from emp where job='manager';

--câu l
select dname,count(empno) as[Số nhân viên] 
from dept,emp 
where dept.deptno=emp.deptno 
group by dname 
having count(empno)>3;

--câu m
select ename,sal 
from emp
where empno=any(select empno from emp where mgr=(select empno from emp where mgr=0)) order by sal asc;

select ename,sal from emp where mgr='7839';

--câu n
select ename,loc,dname from emp,dept where emp.deptno=dept.deptno and sal>1500;

--câu o
select ename,job,sal,grade,dname 
from emp,salgrade,dept 
where emp.deptno=dept.deptno and job!='clerk' and sal>losal and sal<hisal
order by sal desc;

--câu p
select distinct job 
from emp 
where year(hiredate)=1981 and year(hiredate)!=1994;

--câu q
select ename
from emp 
where mgr!=0 and hiredate<(select hiredate from emp where mgr=0);
select ename
from emp 
where mgr!=0 and hiredate<any(select hiredate from emp where mgr=7839) and job='salesman';