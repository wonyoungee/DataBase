use KosaDB
/*
CREATE TABLE EMP
(EMPNO int not null,
ENAME VARCHAR(10),
JOB VARCHAR(9),
MGR int,
HIREDATE datetime,
SAL int,
COMM int,
DEPTNO int);

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

CREATE TABLE DEPT
(DEPTNO int,
DNAME VARCHAR(14),
LOC VARCHAR(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE BONUS
(
ENAME VARCHAR(10),
JOB VARCHAR(9),
SAL int,
COMM int
);


CREATE TABLE SALGRADE
( GRADE int,
LOSAL int,
HISAL int );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);


select * from EMP;
select * from DEPT;
select * from SALGRADE;
*/


/*
 # DDL(Data Definition Language): ������ ���� ���, �����ͺ��̽� "��ü" �� ����/����/������ �������� ����ϴ� ���

 Create ... ����

 Alter ... ����

 Drop ... ����


 # DCL(Data Control Language): ������ ���� ���, ������ ��� �����ϰ� ����ϴ� ���, ���� �����͸� ������ �� �ִ����� �����ϴ� ���.

 Grant ... ���

 Revoke ... Grant �ߴٰ� ... �ٽ� ������

 Deny ... ���� ���� ...


 # DML(Data Manipulation Language): ������ ���� ���, ������ ��ü�� ó���ϰ� �����ϱ� ���� ���
 �����ڰ� �ؾ� �ϴ� ���� ...

 select (60%) >> �Լ�, ����, ��������, �� ...

 insert

 update

 delete

*/

select * from emp;

select * from dept;

select * from salgrade;

-- 1. ��� ���̺� �ִ� ��� ��������͸� ����ϼ���.
select *
from emp;

--2. Ư�� �÷�(���, �̸�, �޿�) �� ����ϼ���.
select empno, ename, sal from emp;

--3. �μ� ���̺� �ִ� �μ���ȣ, �μ��̸��� ����ϼ���.
select deptno, dname from dept;

--4. �����ȣ, ����̸� �÷����� ��½�, �ѱ۷� ����ϼ���.
select empno �����ȣ, ename ����̸� from emp;		-- ��Ī�� �ٿ���

-- select empno ��� ��ȣ, ename ��� �̸� from emp;		-- ���� error

select empno as '��� ��ȣ', ename as '��� �̸�' from emp;	-- as '��Ī' ���� �ۼ��ϸ� �����ص� �ϳ��� �ܾ�� ����

--5. ��� ���̺��� ������ ����ϼ���.
select job from emp;

--5-1. �츮 ȸ�翡 ������ ��� ���� ...
	-- �ߺ��� �� �����ϰ� ���
select distinct job from emp;	-- distinct : �ߺ� ������ ����

/* # SQL(���) : ���ǰ� ������ ���
   # ������ : ���, ��, ��			*/

-- 6. ��� ���̺��� ���, �̸�, �޿�, 300�޷��� �λ�� �޿��� ����ϼ���.
select empno, ename, sal, sal+300 as '�λ�޿�' from emp;

--7. ��� ���̺��� ���, �̸�, �޿�, ����(�޿�*12)�� ����ϼ���.
select empno, ename, sal, sal*12 as'����' from emp;

--8. NULL (�ʿ��)
-- ex) ȸ�� ���̺� >> ȸ����ȣ, ȸ����, �ڵ�����ȣ, ���	>> �ʼ� �Է� or �ɼ�(NULL ���)
select empno, sal, comm from emp;
-- comm ������ NULL	>> comm�� ���� �ʴ� ����
-- 7844 1500 0	>> ���� �ʴ� �������� ������ Ȯ��

--9. ��� ���̺��� ���, �̸�, ����, �޿�, ����, �޿�+������ ����ϼ���.
select empno, ename, job, sal, comm, sal+comm as'�ѱ޿�' from emp;	-- !!**** NULL���� ��� ������ ����� NULL ****!!

/* NULL�� ó���ϴ� �Լ�
		- Oracle : nvl()
		- Mysql : ifnull() 
 !!****	- Mssql : isnull() ****!!
*/

select sal + isnull(comm, 0) as'�ѱ޿�' from emp;	-- isnull(comm, 0) : comm���� null�̸� 0���� ġȯ 
select empno, ename, job, sal, comm,  sal + isnull(comm, 0) as'�ѱ޿�' from emp;	

/* <�������>
 select		-3
 from		-1
 where		-2
*/

-- ������̺��� ����� 7788�� ����� ���, �̸�, �޿��� ����ϼ���.
select empno, ename, sal
from emp
where empno=7788;

-- ������̺��� ����̸��� SMITH�� ����� ��� ������ ����ϼ���.
select *
from emp
where ename = 'SMITH';
-- Mssql�� Oracle�� �޸� ��/�ҹ��ڸ� �������� [����]!!

-- ������̺��� �Ի����� 1980�� 12�� 17���� ����� ��� ������ ����ϼ���.
-- ��¥ �����͵� ���ڿ� ó�� '' ����ؼ� ó��
select * from emp
where hiredate='1980-12-17';

-- ������ salesman�� ����� ���, �̸�, �޿�, ������ ����ϼ���.
select empno, ename, sal, job
from emp
where job = 'SALESMAN';

-- �μ� ��ȣ�� 10���� ����� �μ���ȣ, �̸�, �޿� ������ ����ϼ���.
select deptno, ename, sal
from emp
where deptno = 10;

-- <�� ����>
-- ������̺��� �޿��� 3000[�̻�]�� ����� �̸��� �޿��� ����ϼ���.
select ename, sal
from emp
where sal>=3000;

-- ������̺��� ������ SALESMAN�� �ƴ� ����� ���, �̸�, ������ ����ϼ���.
select empno, ename, job
from emp
where job != 'SALESMAN';

select empno, ename, job
from emp
where job <> 'SALESMAN';	-- <> : is not


-- ������ 3000�̻��� ����� ���, �̸�, �޿�, ������ ����ϼ���.
select empno, ename, sal, sal*12 as '����'
from emp
where (sal*12) >=3000;

-- ������ salesman�̰� �޿��� 2000�̻��� ����� ���, �̸�, �޿�, ������ ����ϼ���.
select * from emp
where job = 'SALESMAN' and sal >= 1500;

-- ������ salesman�̰ų� �޿��� 2000�̻��� ����� ���, �̸�, �޿�, ������ ����ϼ���.
select * from emp
where job = 'SALESMAN' or sal >= 1500;

-- ��� ���̺��� �޿��� 1000�޷� �̻� 3000�޷� ������ ����� ���, �̸�, �޿��� ����ϼ���.
select empno, ename, sal
from emp
where sal >= 1000 and sal<=3000;

/*	between A and B	: A,B�� ������ ���̰�  */
select *
from emp
where sal between 1000 and 3000;

-- ��� ���̺��� �޿��� 1000�޷� �ʰ� 3000�޷� �̸��� ����� ���, �̸�, �޿��� ����ϼ���. 
select empno, ename, sal
from emp
where sal > 1000 and sal<3000;

-- ��� ���̺��� ����� 7788, 7902, 7369�� ����� ����� �̸��� ����ϼ���.
select empno, ename
from emp
where empno = 7788 or empno=7902 or empno=7369;

/*	in ������ : ���� ������  */
select empno, ename
from emp
where empno in (7788, 7902, 7369);

-- ��� ���̺��� ����� 7788, 7902, 7369�� �ƴ� ����� ����� �̸��� ����ϼ���.
select empno, ename
from emp
where empno not in (7788, 7902, 7369);


-- like ������ (���� : ���ڿ�)
-- like �����ڸ� �����ִ� wild card
-- % : ��� �� (�ƹ��͵� ���� ��쵵 ����)
-- _ : �� ���� (�긦 �̿��Ͽ� ���� ��ġ ���� ����)
-- [] : �ȿ� �ִ� ������ �ϳ�
-- [^] : ^������ �ִ� ���� ����

-- ������̺��� �̸��� S�� �����ϴ� ����� ����� �̸��� ����ϼ���.
select empno, ename
from emp
where ename like 'S%';

-- �̸��� �ι��� ���ڰ� A�� ����� ����� �̸��� ����ϼ���.
select empno, ename
from emp
where ename like '_A%';

-- �̸��� T�� �ι� ����ִ� ���
select *
from emp
where ename like '%T%T%';

-- �̸��� ù ���ڰ� A, B, S �� �����ϴ� �������
select *
from emp
where ename like '[ABS]%'

-- �̸��� ù ���ڰ� A or S �� �����ϰ� �ι�° ���ڰ� C�� �ƴ� ���
select *
from emp
where ename like '[AS][^C]%'






--QUESTION
--1. ������̺��� ��� �����͸� ����϶�
select * from emp;

--2. ������̺��� �����ȣ, ����̸�, ������ ����϶�
select empno, ename, sal from emp;

--3. ������̺��� ������ �̴µ� �ߺ��� �����Ͱ� ���� ����϶�
select distinct sal from emp;

--4. ������̺��� ����̸��� ������ ����ϴµ� ������ �÷�����
-- '�� ��','�� ��'���� �ٲ㼭 ����϶�. ��, ALIAS�� �����߰�
select empno as '�� ��', sal as '�� ��' from emp;

--5. ������̺��� ����̸�, ������ �̰�, ���ް� Ŀ�̼���  ���� ����
-- ����ϴµ� �÷����� '�Ǳ޿�'�̶�� �ؼ� ����϶�.
-- ��, NULL���� ��Ÿ���� �ʰ� �϶�.
select ename, sal, sal+ isnull(comm, 0) as '�Ǳ޿�' from emp; 

--6. ������̺��� 'SCOTT'�̶�� ����� �����ȣ, �̸�, ������ ����϶�
select empno, ename, sal from emp where ename = 'SCOTT';

--7. ������̺��� ������ 'SALESMAN'�� ����� �����ȣ, �̸�, ������
-- ����϶�
select empno, ename, job from emp where job = 'SALESMAN';


--8. ������̺��� �����ȣ�� 7499, 7521, 7654�� ����� �����ȣ, �̸�
-- ������ ����϶�
select empno, ename, sal from emp where empno in (7499, 7521, 7654)

--9. ������̺��� ������ 1500���� 3000������ ����� �����ȣ, �̸�,
-- ������ ����϶�.
select empno, ename, sal from emp where sal between 1500 and 3000;

--10. ������̺��� �̸��� ù���ڰ� A�̰� ������ ���ڰ� N�� �ƴ� �����
-- �̸��� ����϶�
select ename from emp where ename like 'A%[^N]';



create table Tlike(
	col1 int,
	col2 varchar(10) -- 10byte : �ѱ� 5��/��,Ư������,���� 10��
)
go	-- �տ� ������ ������ ������ ���� �������� ����.
insert into Tlike(col1, col2) values(10, '10')
insert into Tlike(col1, col2) values(20, '10%')
insert into Tlike(col1, col2) values(30, '20')

select * from Tlike

select * from Tlike where col2 like '%10%%'

-- '10%' �˻��ϱ�
select * from Tlike where col2 like '%10E%%' ESCAPE 'E'	-- c#���� \Ư������ => EƯ������	 ESCAPE 'E' : E ���� ���� �����ͷ� �ν�

-- ������̺��� Ŀ�̼��� å���Ǿ� ���� ����(���� �ʴ�) ����� �̸��� Ŀ�̼��� ����ϼ���.
-- (��, comm > �ΰ� �޴� ������ ����)
-- null ������ is null / is not null ����ؾ���.
select ename, comm from emp where comm is null

-- ������ �޴� �������
select * from emp where comm is not null


-- <�Լ�>
-- �����Լ�, �����Լ�, ��¥�Լ�, ����Լ�, �ý��� �Լ� ...

/*** 1. �����Լ� ***/
select lower('ABC')	-- �빮�� -> �ҹ���
select upper('abc')	-- �ҹ��� -> �빮��
select upper(ename) as 'ename' from emp

select ename + 'is a' + job from emp	-- + �� ���굵 ������ ���յ� ��(���ڿ��� ���)

select substring('abcd', 1,3)	-- ����(1)���� (3)�� (1 ����)
select substring('abcd', 3,1)
select LEFT('abcd', 3)	--���ʿ������� 3��
select RIGHT('abcd',3)	-- �����ʿ������� 3��

select len('abcd')	-- ���ڿ� ���� ����
select len('a     b')
select len('     a')
select len('a     ')	-- 1�� ��µ�. ��, len�Լ��� ���� ���鰪�� ���� X

select datalength('abc')	-- datalength�� byte���� ����
select datalength('ȫ�浿')

-- ������̺��� ����� �̸����� ù ���ڴ� �빮�ڷ� �������� �ҹ��ڷ� ����ϼ���.
select upper(left(ename, 1)) + lower(substring(ename, 2, len(ename))) as 'ename' from emp;


-- ���� ����
select '>'+'     a'+'<'
select '>'+ltrim('     a')+'<'	-- ���� ���� ����
select '>'+rtrim('a     ')+'<'	-- ������ ���� ����
select '>'+rtrim(ltrim('  a  '))+'<'	-- ���� ���� ����


-- replace
select replace('abcd', 'a', 'NEWNEW')	-- abcd���� a�� ã�� NEWNEW�� ��ü

-- ������ ���̻����� ���� ����
select '>'+'ȫ      ��      ��'+'<'
select replace('ȫ      ��      ��', ' ', '')



/*** 2. ���� �Լ� ***/

-- �ݿø� �Լ�
select round(123.45, 1)	-- 123.50	�ݿø��Ͽ� �Ҽ��� ù��° �ڸ����� ��Ÿ��
select round(123.45, 2)	-- 123.45	�ݿø��Ͽ� �Ҽ��� �ι�° �ڸ����� ��Ÿ��
select round(123.45, 0)	-- 123.00	�ݿø��Ͽ� �Ҽ��� 0��° �ڸ����� ��Ÿ��(����)

select power(2,4)	-- 2^4

-- CEILING : ������ ���ں��� ū �ּ� ������ ��ȯ�Ͽ� ���
select CEILING(1234.5678), CEILING(123.45), CEILING(-1234.56)

-- FLOOR : ������ ���ں��� ���� �ִ� ������ ��ȯ�Ͽ� ���
select FLOOR(1234.5678), FLOOR(123.45), FLOOR(-1234.56)



/*** 3. ��¥ �Լ� ***/
select getdate()	-- ����. oracle : select sysdate()

-- ��¥ ���ϱ�
select dateadd(yy,10,getdate())
select dateadd(dd,100,getdate())
select dateadd(mm, 5, getdate())
select dateadd(yy, 10, '2022-01-01')

-- ��¥ ����
select datediff(yy, '2010-12-12', '2022-1-13')
select datediff(mm, '2010-12-12', '2022-1-13')
select datediff(dd, '2010-12-12', '2022-1-13')

-- ����� �ٹ����� �󸶳� �Ƴ���?
-- ��, ������ ���� 30�ϱ���
select ename,
	DATEDIFF(dd, hiredate, GETDATE()) / 365 as '��',
	(DATEDIFF(dd, hiredate, GETDATE()) % 365)/30 as '����',
	(DATEDIFF(dd, hiredate, GETDATE()) % 365) % 30 as '��'
from emp

-- ���ú��� ���� 12-31���� ��ĥ ���ҳ���?
select DATEDIFF(dd, getdate(), '2022-12-31')


select year(GETDATE())	-- �⸸ ���
select month(GETDATE())	-- ���� ���
select day(GETDATE())	-- �ϸ� ���


-- ����, ����, ��¥ �Լ� �⺻���� ���...

/******* 4. ����ȯ �Լ� *******�ſ��߿�!!*/ 
select CONVERT(int, '100')+100	-- ���� -> ����
select CONVERT(int, '100A')+100	-- error!!! varchar �� '100A'��(��) ������ ���� int(��)�� ��ȯ���� ���߽��ϴ�.
select CONVERT(varchar(20), sal) + '�޿��Դϴ�' from emp		-- ���� -> ����

select ename + ' �� ����� '+ Convert(varchar(20),empno) + '�Դϴ�.' as 'fullname' from emp



/*** 5. �����Լ� ***/
-- sum(), avg(), max(), min(), count()
select sum(sal) from emp
select avg(sal) from emp
select max(sal) from emp
select min(sal) from emp
select count(sal) from emp


-- <�����Լ��� Ư¡ (�ܿ��)>
-- 1) �����Լ��� null ���� �����Ѵ�. (��, count(*) ����)
-- 2) select ���� �����Լ� �ܿ� �ٸ� �÷��� ���� �ݵ�� �� �÷��� group by ���� ��õǾ�� �Ѵ�.

select comm from emp
select count(comm) from emp	-- count()�� null�� ������.
select comm from emp where comm is not null

-- comm ���
select avg(comm) from emp	-- 721	�츮 ȸ��� �޴� ����� ����... �����Լ��� null ����
select avg(isnull(comm, 0)) from emp	-- 309	�츮 ȸ��� ������� ����...	null�� ���� ����� count

-- �����Լ��� ����� 1���̴�.
select avg(sal),  sum(sal), max(sal), min(sal), count(sal) from emp

select deptno, sum(sal) from emp;	-- error!! �� 'emp.DEPTNO'��(��) ���� �Լ��� GROUP BY ���� �����Ƿ� SELECT ��Ͽ��� ����� �� �����ϴ�.

-- select ���� �����Լ� �ܿ� �ٸ� �÷��� ���� �ݵ�� �� �÷��� group by ���� ��õǾ�� �Ѵ�.
select deptno, sum(sal) from emp group by deptno	-- deptno�� �׷��� ����
select deptno, avg(sal),  sum(sal), max(sal), min(sal), count(sal) from emp group by deptno

select deptno, job, avg(sal) from emp group by deptno, job	-- depto -> job ������ ����

-- order by : ����
select deptno, job, avg(sal) from emp group by deptno, job order by deptno
select deptno, job, avg(sal) from emp group by deptno, job order by deptno asc
select deptno, job, avg(sal) from emp group by deptno, job order by deptno desc


/*
select		-4
from		-1
where		-2
group by	-3
order by	-5
*/

-- ������ ��տ����� ���ϵ� �÷� ����Ī�� '���', ��տ����� ���� ������ �����͸� �����ϼ���.
select job, avg(sal) as '���' from emp group by job order by ��� desc	-- order by ���� select�� ���� ����ǹǷ� alias ��� ����

-- Top n ���� : �� ������ n�� : mssql ���� ������ �ִ� ���
-- ��� ���̺��� ������ ���� ���� �޴� ��� 5���� �̸��� �޿��� ����϶�.
select top 5 ename, sal from emp order by sal desc
select top 2 with ties ename, sal from emp order by sal desc	-- ���� ó���ϱ�
select top 50 percent ename, sal from emp order by sal desc
select ename, sal from emp order by sal desc


-- from ���� �������� where ��
-- group by�� �������� having ��

/*
select		-5
from		-1
where		-2
group by	-3
having		-4
order by	-6
*/

-- ������ �ѿ����� ���ϰ� �ѿ����� 5000�̻��� ��� ��� �����͸� ����ϼ���.
select job, sum(sal) as 'sumsal' from emp where deptno != 10 group by job having sum(sal) >= 5000 order by sumsal desc

-- �μ��� ������ ���� ���ϰ� �� ������ 10000�̻��� ��� �����͸� ����ϼ���.
select deptno, sum(sal) from emp group by deptno having sum(sal) >= 10000

-- �μ��� �ѿ����� ���ϵ� 30�� �μ��� �����ϰ�,
-- �� �ѿ����� 8000�޷� �̻��� �μ��� ������ �ϰ�,
-- �� ������ ���� ������ ����϶�.
select deptno, sum(sal) as '�ѿ���' from emp where deptno != 30 group by deptno having sum(sal) >= 8000 order by �ѿ��� desc


-- �μ��� ��� ������ ���ϵ� Ŀ�̼��� å���� ����� ��������,
-- �� ��տ����� 2000�޷� �̻��� �μ��� ������ �ϰ�,
-- ��տ����� ���� ������ ����϶�
select deptno, avg(sal) as '��տ���' from emp where comm is not null group by deptno having avg(sal) >= 2000 order by ��տ��� desc





--QUESTION
--1. ��� ���̺��� ����̸��� ù���ڴ� �빮�ڷ�, �������� �ҹ��ڷ� ����϶�
select upper(left(ename,1))+lower(substring(ename, 2, len(ename))) from emp

--2. ������̺��� ����̸��� �̰� �� �̸��� �ι�° ���ں��� �׹�° ���ڱ���
-- ����϶�.
select ename, SUBSTRING(ename,2,3) from emp

--3. ������̺��� ��� �̸��� ö�� ������ ����϶�.
select len(ename) from emp

--4. ������̺��� ��� �̸��� �� ���� �ϳ��� ������ ���� �ϳ��� ����ϵ� 
-- ��� �ҹ��ڷ� ���� ����϶�.
select LOWER(left(ename,1)) as '�ձ���', LOWER(RIGHT(ename,1)) as '����������' from emp

--5. 3456.78�� �Ҽ��� ù��° �ڸ����� �ݿø��϶�.
select ROUND(3456.78,0)

--6. 3�� 4������ ���ϰ�, 64�� �������� ���϶�. => ���ص���.

--7. ���ó�¥�� ���ó�¥���� 10���� ���� ��¥�� ����϶�.
select GETDATE() as '����', dateadd(dd,10,getdate()) as '10����'
--or
select getdate(), getdate()+10

--8. ���� ǥ������ ���� ��¥�� ����϶�. => ��������

--9. ������̺��� ����̸��� ������� ���� ��¥������ �ٹ��ϼ��� ���϶�.
select ename, DATEDIFF(dd, hiredate, GETDATE()) as '�ٹ��ϼ�' from emp

--10. �� �������� �ٹ��ϼ��� 00�� 00���� 00�� �ٹ��Ͽ�����
--Ȯ���� �� �ֵ��� ��ȯ�϶�.(��, �� ���� 30�Ϸ� ����϶�)
-- ��)
--  | ENAME	| �ٹ��ϼ�		|
--  | KING		| 00�� 00���� 00��	|
select ename as 'ENAME', Convert(varchar(20),DATEDIFF(dd, hiredate, GETDATE())/365) +'��'+ Convert(varchar(20),(DATEDIFF(dd, hiredate, GETDATE())%365)/30) + '����'+ Convert(varchar(20),(DATEDIFF(dd, hiredate, GETDATE())%365)%30) + '��' as '�ٹ��ϼ�'
from emp




--QUESTION
--1. ������̺��� �μ��� �ִ� ������ ����϶�.
select deptno, max(sal) �ִ���� from emp group by deptno

--2. ������̺��� ������ �ּ� ������ ���ϵ� ������ 
-- CLERK�� �͸� ����϶�.
select job, min(sal) �ּҿ��� from emp where job = 'CLERK' group by job

--3. Ŀ�̼��� å���� ����� ��� �� ���ΰ�?
select count(comm) from emp

--4. ������ 'SALESMAN'�̰� ������ 1000�̻��� �����
-- �̸��� ������ ����϶�.
select ename, sal from emp where job = 'SALESMAN' and sal >= 1000

--5. �μ��� ��տ����� ����ϵ�, ��տ����� 2000����
-- ū �μ��� �μ���ȣ�� ��տ����� ����϶�.
select deptno, avg(sal) ��տ��� from emp group by deptno having avg(sal)>2000

--6. ������̺��� Ŀ�̼��� ���� ���� �޴� ��� 2����
-- ����ϵ� ��ŷ�� �ߺ��� ��� ����ó���� �Ͽ� ����϶�.
select top 2 with ties ename, comm from emp order by comm desc

--7. ������ MANAGER�� ����� �̴µ� ������ ���� ���
-- ������ �̸�, ����, ������ ����϶�.
select ename, job, sal from emp where job = 'MANAGER' order by sal desc

--8. �� �������� �ѿ����� ����ϵ� ������ ���� ������
-- ����϶�.
select job, sum(sal) �ѿ��� from emp group by job order by �ѿ���

--9. ������ �ѿ����� ����ϵ�, ������ 'MANAGER'��
-- ������� �����϶�. �׸��� �� �ѿ����� 5000���� 
-- ū ������ �ѿ��޸� ����϶�.
select job, sum(sal) �ѿ��� from emp where job != 'MANAGER' group by job having sum(sal)>5000

--10. ������ �ִ������ ����ϵ�, ������ 'CLERK'�� 
-- ������� �����϶�. �׸��� �� �ִ������ 2000 �̻���
-- ������ �ִ������ �ִ� ������ ���� ������ �����Ͽ� 
-- ����϶�.
select job, max(sal) �ִ���� from emp where job != 'CLERK' group by job having max(sal)>=2000 order by �ִ���� desc





/******************* JOIN *******************/
-- ���� �ǽ� ���̺� �����
/*
CREATE TABLE M
(M1 CHAR(6), M2 VARCHAR(10))

CREATE TABLE S
(S1 CHAR(6), S2 VARCHAR(10))

CREATE TABLE X
(X1 CHAR(6), X2 VARCHAR(10))
*/
 

INSERT INTO M VALUES('A','1')
INSERT INTO M VALUES('B','1')
INSERT INTO M VALUES('C','3')
INSERT INTO M VALUES(NULL, '3')

INSERT INTO S VALUES('A','X')
INSERT INTO S VALUES('B','Y')
INSERT INTO S VALUES(NULL, 'Z')
 
INSERT INTO X VALUES('A','DATA')

select * from m
select * from s
select * from x

-- # ���� : �� �� �̻��� ���̺��� �����͸� �������� ���
-- <����>
-- 1. inner join
-- 2. cross join
-- 3. outer join
-- 4. self join
-- 5. nonequal join

-- <ǥ����>
-- �� ���� (oracle, mysql, mssql) ������ ����
-- ǥ�ع��� : ansi ���� ^^

-- !! null������ join (X)

/*** 1. inner join ***/
-- �� ���̺��� �����÷�(�����÷�)�� ���Ͽ� ���������� �����ϴ� ���ڵ常 ����
-- 1:1 ���� ... ������ ���̴� ��...

-- SQL ���� -> �ٶ������� X
select * from m, s where m1=s1

select m1, m2, s2
from m, s
where m1=s1

-- ANSI ���� -> �̰� ���!
select * from m inner join s on m1=s1	-- on�� join�� ������
select m.M1, m.M2, s.S1, s.S2 from m inner join s on m.M1=s.S1	-- ���� ���� ǥ����

-- ������̺��� ���, �̸�, �μ���ȣ, �μ��̸��� ����ϼ���.
select * from emp
select * from dept

select emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
from emp inner join dept
on emp.DEPTNO = dept.DEPTNO

-- join�� default : inner join
-- alias ���̸� ����
select e.EMPNO, e.ENAME, e.DEPTNO, d.DNAME
from emp e  join dept d	-- inner join
on e.DEPTNO = d.DEPTNO



/*** 2. cross join (���� �Ⱦ��� ����) ***/
-- ������ ���� ����. ��� Ȯ���� �� �̴� ��.
select * from m,s

-- ANSI
select * from m cross join s



/*** 3. outer join ***/
-- ���ο� �������� �ʴ� �����Ͱ� ����
-- ���������� inner join�� �����ϰ�, �������踦 �ľ��ؼ� ���� �����͸� �������� ���
-- �������� : left, right ���� �ľ�
select * 
from m left outer join s	-- m�� �������� ���� ������ ������
on m.m1 = s.s1

select * 
from m right outer join s	-- s�� �������� ���� ������ ������
on m.m1 = s.s1

-- full outer join
select *
from m full outer join s	-- left join�� right join�� union(������)
on m.M1=s.S1



-------------------- union (������) ---------------------------

-- 1. �����Ǵ� �÷��� ���� ��ġ�Ͽ��� �Ѵ�.
-- 2. �����Ǵ� �÷��� �ڷ���(Ÿ��) ��ġ
-- data�� ������ ����.
-- ù��° ���̺� �ؿ� �ι�° ���̺��� �ٿ���.

select empno, ename from emp
union
select deptno, dname from dept

-- error!! �����Ǵ� �÷��� ���� ��ġ X�̱� ����...
select empno, ename, job from emp
union
select deptno, dname from dept

-- null �� �ذ�!
select empno, ename, job from emp
union
select deptno, dname, null from dept

-- error!! �����Ǵ� �÷��� Ÿ���� ��ġ�ؾ���...
select ename, empno from emp	-- ename�� varchar
union
select deptno, dname from dept	-- deptno�� int

select * from emp
union				-- union : �⺻������ �ߺ�����
select * from emp

select * from emp
union all			-- union all : �ߺ����� X
select * from emp

--------------------------------------------------------------

/*** 4. self join ***/
-- �ڽ��� Ư�� �÷��� �ڽ��� Ư�� �÷��� ����
-- �� ���� ���̺��� 2�� ó�� ���

--  ���, �̸�, �����ڻ��, ������ �̸��� ����ϼ���.
select e.EMPNO, e.ENAME, m.EMPNO, m.ENAME
from emp e inner join emp m	-- ����Ī�� ���� �ϳ��� ���̺��� 2��ó�� ���
on e.MGR=m.EMPNO
-- ���� �߻� : ����� 14���ε� ���� �����ʹ� 13��
-- null�� join�� ����� �ƴϾ ����� ����
-- [outer join]�� ���� �����ذ�!
select e.EMPNO, e.ENAME, m.EMPNO, m.ENAME
from emp e left outer join emp m	-- ����Ī�� ���� �ϳ��� ���̺��� 2��ó�� ���
on e.MGR=m.EMPNO



/*** 5. nonequal join ***/
-- join�� ��Ģ�� 1:1 ����
-- ������ �÷��� ���� ���� nonequal�� ����Ͽ� ���� ���� �÷��� ����

-- between�� inner join ���...
select e.EMPNO, e.ENAME, e.SAL, s.GRADE
from emp e inner join SALGRADE s
on e.SAL between s.LOSAL and s.HISAL


/*********** ���̺� 2, 3, 4�� �����ϱ� **************/

-- 3�� ���̺� �����ϱ�
select m.m1, m.m2, s.s2, x.x2
from m join s on m.m1 = s.s1
	   join x on s.s1 = x.x1

