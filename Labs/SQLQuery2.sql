use Northwind
-- ����ȸ��
select * from Employees
select * from Orders

/*
Employees
�׷� �� ���̺��� �̿��Ͽ� ����� id�� ����� �̸�(lastname),
�׸��� �� ����� �����ϴ� �������� id�� �������� �̸��� ����϶�.
��, �÷��̸��� ���� ���ID, ����̸�, ������ID, �������̸��̶�� �Ѵ�.
*/
select e.EmployeeID, e.LastName, m.EmployeeID, m.LastName
from Employees e left outer join Employees m
on e.ReportsTo = m.EmployeeID


---------------------------------------------------------------------------

use pubs

select * from titles
select * from authors
select * from titleauthor

-- 3���� ���̺��� �۰�id, åid, �۰��̸�(lastname), å�̸�, ���� ������ ����ϼ���.
select a.au_id, t.title_id, a.au_lname, t.title, t.price
from titleauthor ta join authors a on ta.au_id=a.au_id
					join titles t on t.title_id=ta.title_id

select *
from titleauthor ta join authors a on ta.au_id=a.au_id
select *
from titleauthor ta join titles t on t.title_id=ta.title_id


use KosaDB
-- ����� ���, �̸�, �޿�, �޿����, �μ���ȣ, �μ��̸��� ����ϼ���.
select e.EMPNO, e.ENAME, e.SAL, s.GRADE, d.DEPTNO, d.DNAME
from emp e join dept d on e.DEPTNO = d.DEPTNO
			join SALGRADE s on e.sal between s.LOSAL and s.HISAL

-- �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, �����ȣ, ����̸��� ����϶�.
select *
from emp e join dept d on e.DEPTNO=d.DEPTNO
where e.DEPTNO=10

-- �μ���ȣ�� 20�� ������ ������� �μ���ȣ, �μ��̸�, �����ȣ, ����̸��� ����ϵ�, �μ���ȣ�� ���� ������ �����϶�.
select *
from emp e join dept d on e.DEPTNO=d.DEPTNO
where e.DEPTNO <=20
order by d.DEPTNO



-- <��������>
-- 1. ������� �̸�, �μ���ȣ, �μ��̸��� ����϶�.
select e.ENAME, e.DEPTNO, d.DNAME
from EMP e join DEPT d
on e.DEPTNO = d.DEPTNO

-- 2. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸���
-- ����϶�.
select e.ENAME, e.JOB, d.DEPTNO, d.DNAME
from EMP e join DEPT d
on e.DEPTNO=d.DEPTNO
where d.LOC='DALLAS'

-- 3. �̸��� 'A'�� ���� ������� �̸��� �μ��̸��� ����϶�.
select e.ename, d.dname
from EMP e join DEPT d
on e.DEPTNO=d.DEPTNO
where e.ENAME like '%A%'

-- 4. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������ 
--����ϴµ� ������ 3000�̻��� ����� ����϶�.

select e.ENAME, d.DNAME, e.SAL
from EMP e join DEPT d
on e.DEPTNO = d.DEPTNO
where e.sal >= 3000

-- 5. ������ 'SALESMAN'�� ������� ������ �� ����̸�, �׸���
-- �� ����� ���� �μ� �̸��� ����϶�.
select e.JOB, e.ENAME, d.DNAME
from EMP e join DEPT d
on e.DEPTNO = d.DEPTNO
where e.job='SALESMAN'

-- 6. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,
-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',
-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.
select e.EMPNO �����ȣ, e.ENAME ����̸�, e.SAL*12 ����, e.SAL*12+e.COMM �Ǳ޿�, s.GRADE �޿���� 
from EMP e join DEPT d on e.DEPTNO = d.DEPTNO 
			join SALGRADE s on e.sal between s.LOSAL and s.HISAL
where e.comm is not null

-- 7. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,
-- ����, �޿������ ����϶�.
select e.DEPTNO, d.DNAME, e.ENAME, e.SAL, s.GRADE
from EMP e join DEPT d on e.DEPTNO = d.DEPTNO
		   join SALGRADE s on e.sal between s.LOSAL and s.HISAL
where d.DEPTNO= 10

-- 8. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�, 
-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ� 
-- ������� �μ���ȣ�� ���� ������, ������ ���� ������ 
-- �����϶�.
select e.DEPTNO, d.DNAME, e.ENAME, e.SAL, s.GRADE
from EMP e join DEPT d on e.DEPTNO = d.DEPTNO
			join SALGRADE s on e.sal between s.LOSAL and s.HISAL
where d.DEPTNO in (10,20)
order by d.DEPTNO, e.SAL desc

-- 9. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� �������� 
-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',
-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.
select e.EMPNO �����ȣ, e.ENAME ����̸�, e.MGR �����ڹ�ȣ, m.ENAME �������̸�
from EMP e left outer join EMP m 
on e.MGR=m.EMPNO


------------------------------------------------------------------------------

/***************** SubQuery ***********************/

-- Jones �� �޴� �޿����� �� ���� �޿��� �޴� ����� �̸��� �޿��� ����ϼ���
select sal from emp where ename='JONES'	-- 2975
select ename, sal from emp where sal > 2975
-- �̸� �ϳ��� �������� ��ġ��
select ename, sal 
from emp 
where sal > (select sal from emp where ename='JONES')

/* 
 <��Ģ>
	1. ���������� ��ȣ �ȿ� ��ġ�ؾ� ��.
	2. �������� �ܵ����� ���� �����ؾ� ��.
	3. ���������� ���� �÷����� �����ž���. (select���� �÷��� �� ���� �� �� ����)

 <�������>
	- �������� ����� ���� -> �������� ����

 <����>
	- single row subquery : ����� �� ���� row	( >, <, =, >=)
	- multi row subquery : ����� ���� ���� row	(in, not in)
 �̷��� ������ �����ϴ� ������ ����ϴ� �����ڰ� �޶�...
*/

-- ������ salesman�� ������ ���� �޿��� �޴� ������� ���, �̸�, �޿������� ����ϼ���.
select empno, ename, sal
from emp
where sal in (select sal from emp where job='SALESMAN')

-- �μ���ȣ�� 10���� ������ ���� �޿��� �޴� ������� ����� ����ϼ���.
select *
from emp
where sal in (select sal from emp where deptno = 10)

-- ���������� �ִ� ����� ����� �̸��� ����ϼ���.
select empno, ename
from emp
where empno in (select mgr from emp)
-- in : empno=7902 or empno=7788 ...

-- ���������� ���� ����� ����� �̸��� ����ϼ���.
select empno, ename
from emp
where empno not in (select isnull(mgr,0) from emp)
-- not in : empno!=7902 and empno!=7369 and ... empno!=null...	>> null���� �������� >> null
-- ���� isnulló�� �������...

-- 20�� �μ��� ����߿��� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ��� ��� ������ ����ϼ���.
select *
from emp
where sal > (select max(sal) from emp where deptno=20)

select *
from emp
where sal > ALL(select sal from emp where deptno=20)
-- ALL : where sal > data and sal > data2 and...
-- max(sal)�� �Ͱ� ���� ���

-- 20�� �μ��� ��� �� ���� ���� ������ �޴� ����麸�� �� ���� ������ �޴� ������� �̸��� ������ ����϶�.
select ename, sal 
from emp 
where sal > (select min(sal) from emp where deptno=20)


select *
from emp
where sal > ANY(select sal from emp where deptno=20)
-- ANY : where sal > data or sal > data2 or...
-- min(sal)�� �Ͱ� ���� ���

-- ������ 'SALESMAN'�� ����� ���� �μ����� �ٹ��ϰ� ���� ������ �޴� ������� ����, �μ���ȣ�� ����϶�.
select sal, deptno
from emp
where sal in (select sal from emp where job = 'SALESMAN') 
		and deptno in (select deptno from emp where job='SALESMAN')

-- �ڱ� �μ��� ��տ��޺��� �� ���� ������ �޴� ������� �̸�, ����, �μ���ȣ, �μ��� ��� ������ ���Ͻÿ�.
-- if ��տ����� ��� �ִ� ���̺��� �����Ѵٸ�...
-- in line view : �������̺�
select e.ename, e.sal, e.deptno, ��տ���
from emp e join
(select deptno, avg(sal) ��տ���
from emp
group by DEPTNO) m
on e.deptno = m.deptno
where e.sal > m.��տ���

-- TIP)
-- ���� (�Լ�) / ������ (JOIN) >> �ذ� �ȵǸ� >> subquery >> in line view(�������̺�)

-- <Question>
--1. 'SMITH'���� ������ ���� �޴� ������� �̸��� ������ ����϶�.
select ename, sal
from emp
where sal > (select sal from emp where ename='SMITH')

--2. 10�� �μ��� ������ ���� ������ �޴� ������� �̸�, ����,
-- �μ���ȣ�� ����϶�.
select ename, sal, deptno
from emp
where sal in (select sal from emp where deptno=10)

--3. 'BLAKE'�� ���� �μ��� �ִ� ������� �̸��� ������� �̴µ�
-- 'BLAKE'�� ���� ����϶�.
select ename, hiredate
from emp
where deptno = (select deptno from emp where ename='BLAKE') and ename != 'BLAKE'

--4. ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������
-- ����ϵ�, ������ ���� ��� ������ ����϶�.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
order by sal desc

--5. �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϰ�
-- �ִ� ����� �����ȣ�� �̸��� ����϶�.
select empno, ename
from emp
where deptno in (select deptno from emp where ename like '%T%')

--6. 30�� �μ��� �ִ� ����� �߿��� ���� ���� ������ �޴� �������
-- ���� ������ �޴� ������� �̸�, �μ���ȣ, ������ ����϶�.
--(��, ALL �Ǵ� ANY �����ڸ� ����� ��)
select ename, deptno, sal
from emp
where sal > ALL(select sal from emp where deptno=30)

--7. 'DALLAS'���� �ٹ��ϰ� �ִ� ����� ���� �μ����� ���ϴ� �����
-- �̸�, �μ���ȣ, ������ ����϶�.
select ename, deptno, job
from emp
where deptno = (select deptno from DEPT where loc = 'DALLAS')

--8. SALES �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ����϶�.
select e.deptno, ename, job
from emp e join dept d
on e.DEPTNO = d.DEPTNO
where d.DNAME='SALES'

SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
			FROM DEPT
			WHERE DNAME='SALES')

--9. 'KING'���� �����ϴ� ��� ����� �̸��� �޿��� ����϶�.
select ename, sal
from emp
where MGR = (select empno from emp where ename='KING')

--10. �ڽ��� �޿��� ��� �޿����� ����, �̸��� 'S'�� ����
-- ����� ������ �μ����� �ٹ��ϴ� ��� ����� �����ȣ, �̸�,
-- �޿��� ����϶�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
			 FROM EMP)
	AND DEPTNO IN (SELECT DEPTNO
					FROM EMP
					WHERE ENAME LIKE '%S%')

--11. Ŀ�̼��� �޴� ����� �μ���ȣ, ������ ���� �����
-- �̸�, ����, �μ���ȣ�� ����϶�.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
		FROM EMP
		WHERE COMM IS NOT NULL)
AND SAL IN(SELECT SAL
		FROM EMP
		WHERE COMM IS NOT NULL)

--12. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ����
-- ������� �̸�, ����, Ŀ�̼��� ����϶�.
select ename, sal, comm
from emp
where sal not in (select sal 
					from emp 
					where deptno=30)
	and comm not in (select isnull(comm,0) 
					from emp 
					where deptno=30)

--------------------------------------------------------------------------

/************ DML (insert, update, delete) -������ �ϱ�!! ***********/

create table Test(
	userid int
)

insert into Test(userid) values(100)	-- �ǹݿ�

select * from Test

-- �Ϸ� (commit / rollback)
begin tran
	insert into Test(userid) values(200)	-- �ǹݿ� X
rollback	-- ���(�Ϸ�)


select * from Test

begin tran
	delete from Test	-- �ǹݿ� X
commit	-- �ǹݿ�(�Ϸ�)

/*
	MSSQL ������ DML �۾��� ���� autocommit�մϴ�.
	����, begin tran�̶�� ��ɾ�� �Բ� DML �ۼ��Ͻø�
	commit, rollback�� �� �� �ִ� ������ �־���.
	�̶��� commit, rollback�� ���� ���� ���¿��� ��� ����...
	��, �ǹݿ� X
*/

/*** Transaction (Ʈ�����) ***/
-- �ϳ��� ������ �۾� ���� (���� or ����)
-- ex) ������� - A -> B ������ü ���⼭...
--		A = A - 1000
--		B = B + 1000
--	��������� �ϳ��� ���� ...



/*** insert ***/
-- 1. ��ü �÷��� ������ ���� (�÷��� ���� ����)
insert into emp(empno, ename, job, mgr, hiredate,sal, comm, deptno)
values(9999, 'ȫ�浿', 'IT', 7902, GETDATE(), 3000, 100, 10)

insert into emp
values(9991, 'ȫ�浿', 'IT', 7902,GETDATE(), 3000, 100, 10)

-- 2. Ư�� �÷��� ������ ���� (�ݵ�� �÷��� ���)
-- error!
insert into emp
values(5555, '�ƹ���', 800)
-- OK
insert into emp(EMPNO, ENAME, SAL)
values(9992, '�ƹ���', 800)
-- �����͸� ���� ���� �÷��� NULL�� ǥ��

select * from emp order by empno desc

insert into emp(empno, ename, hiredate, deptno)
values(9998, '����', '2022-01-01', 10)



/*** update ***/
/*
UPDATE table_name
SET column_name = value
WHERE search_condition
*/

begin tran
	update emp set sal = 0
	select * from emp
rollback

begin tran
	update emp set sal=0, comm=0, deptno=100
	where deptno=10
rollback
	select * from emp where deptno=10

-- �̸��� 'SCOTT'�� ����� ������ 0���� �����϶�.
begin tran
	update emp set sal=0 
	where ename='SCOTT'
	update emp set sal=1111
	where deptno=10
	update emp set sal = (select max(sal) from emp)
	where deptno=20
rollback
select * from emp
-- begin tran ~ rollback�� �ϳ��� Ʈ�����...



/*** DELETE ***/
-- �����ȣ 7902 ������ ����
begin tran
delete from emp where empno=7902
rollback
select * from emp where empno=7902

begin tran
	delete from emp		-- ��� ������ ����
rollback
	select * from emp



---------------------------------------------------------------------------------
-- �ΰ����� �ɼ� ...

/*** select ... into (���̺� ���� �� ������ insert����) ***/

--  1. EMP ���̺��� ���̺� ������ �����ϴ� �۾� 
--     ��A��=��B���� �����̹Ƿ� EMP���̺��� ��� �����ʹ� EMP01 ���̺� ���Ե��� �ʴ´�.
SELECT *
INTO EMP01
FROM EMP
WHERE 'A'='B'      

-- 2. EMP ���̺��� ��� ������ ����
SELECT *
INTO EMP02
FROM EMP


/*** insert ~ select (�뷮 ������ ����) ***/
insert into emp (empno, ename)
values(1111, 'AAA')

-- values ��� select ���
insert into emp02(empno, ename, job, sal)
select empno, ename, job, sal from emp where deptno =10

select * from emp02

--------�ǽ�
select *
into empclone
from emp

select * from empclone

delete from empclone

insert into empclone
select * from emp


select * from emp
----------------------------------------
delete from emp where empno in(9999, 9991, 9992, 9998, 1111)



-- <��������>
-- ��� �ǽ������� EMP ���̺��� ������ ������ ���� BEGIN TRAN...
-- ROLLBACK TRAN ������ ����� ��

select * 
	into emptest
from emp 

select *
into testd
from dept
where 'A'='B'

select * from emptest
-- emptest�� �������� Ǫ����.
-- 1. EMP ���̺��� �����ȣ�� 7499���� ����� ������ 5000�޷��� �ٲ��.
begin tran
	update emptest
	set sal =5000
	where empno = 7499
rollback
-- 2. EMP���̺��� �μ���ȣ�� 20���� ������� ������ 4000�޷��� �ٲ��.
begin tran
	update emptest
	set sal = 4000
	where deptno = 20
rollback
-- 3. DEPT ���̺� �Ʒ��� �������� �����͸� �Է��϶�.
-- �μ���ȣ: 50, �μ���ġ: BOSTON,  �μ���: RESERCH

begin tran
	insert into testd(DEPTNO, LOC, DNAME) values(50, 'BOSTON', 'RESEARCH')

-- 4. �����ȣ�� 7698���� ����� �μ���ȣ�� 7499�� ����� 
--�μ���ȣ�� �ٲ��.
update emptest
set DEPTNO = (select DEPTNO from emptest where empno=7499)
where empno=7698

-- 5. EMP ���̺� �Ʒ��� ���� �����͸� �����϶�.
-- �����ȣ: 9900, ����̸�: JACKSON, ����: SALESMAN, �μ���ȣ: 10
insert into emptest(EMPNO, ENAME, JOB, DEPTNO) values(9900, 'JACKSON', 'SALESMAN', 10)

-- 6. INSERT...SELECT ���� �̿��Ͽ� ������ 'SALESMAN'��
-- ����� �����ȣ, �̸�, ������ EMP ���̺� �Է��϶�.
insert into emptest(EMPNO, ENAME, JOB)
select empno, ename, job
from emptest
where job ='SALESMAN'

-- 7. �����ȣ�� 7369���� ����� ���� ������ ���� �������
-- ������ 7698�� ����� �������� �����϶�.
update emptest
set sal = (select sal from emptest where empno = 7398)
where job = (select job from emptest where empno=7369)

-- 8. SCOTT�� ���� ������ ���� ����� ��� �����϶�.
delete from emptest
where job = (select job from emptest where ename = 'SCOTT')

-- 9. 'SCOTT'�� ������ 'SMITH'�� ���ް� ���� �����϶�.
update emptest
set sal = (select sal from emptest where ename='SMITH')
where ename = 'SCOTT'

-- 10. 'ALLEN'�� ������ 'SCOTT'�� ������ ���� �����϶�.
update emptest
set job = (select job from emptest where ename='SCOTT')
where ename = 'ALLEN'

-- 11. �����ȣ�� 7499���� ����� ���� ������ ���� �������
-- �Ի����� ���ó�¥�� �����϶�.
update emptest
set HIREDATE = GETDATE()
where job = (select job from emptest where empno=7499)

-- 12. SCOTT�� ���� ������ ���� ������� ������ 0���� �����϶�.
update emptest
set sal = 0
where job = (select job from emptest where ENAME='SCOTT')

rollback


-------------------------------------------------------------------------


use pubs

-- ���� : ���� ���� �����
-- 1990 �� ������ �Ի��� ������� �ִ� ���ǻ翡�� ������ å�� ��
-- ������ 20�޷� �̻��� å�� �̸��� ����, �׸��� ���ǻ��� �̸��� ����Ͻÿ�.
select t.title, t.price, p.pub_name
from employee e join titles t on e.pub_id = t.pub_id
	join publishers p on e.pub_id = p.pub_id
where e.hire_date<'1990' and t.price>=20