use Northwind
-- 무역회사
select * from Employees
select * from Orders

/*
Employees
그럼 이 테이블을 이용하여 사원의 id와 사원의 이름(lastname),
그리고 그 사원을 관리하는 관리자의 id와 관리자의 이름을 출력하라.
단, 컬럼이름은 각각 사원ID, 사원이름, 관리자ID, 관리자이름이라고 한다.
*/
select e.EmployeeID, e.LastName, m.EmployeeID, m.LastName
from Employees e left outer join Employees m
on e.ReportsTo = m.EmployeeID


---------------------------------------------------------------------------

use pubs

select * from titles
select * from authors
select * from titleauthor

-- 3개의 테이블에서 작가id, 책id, 작가이름(lastname), 책이름, 가격 정보를 출력하세요.
select a.au_id, t.title_id, a.au_lname, t.title, t.price
from titleauthor ta join authors a on ta.au_id=a.au_id
					join titles t on t.title_id=ta.title_id

select *
from titleauthor ta join authors a on ta.au_id=a.au_id
select *
from titleauthor ta join titles t on t.title_id=ta.title_id


use KosaDB
-- 사원의 사번, 이름, 급여, 급여등급, 부서번호, 부서이름을 출력하세요.
select e.EMPNO, e.ENAME, e.SAL, s.GRADE, d.DEPTNO, d.DNAME
from emp e join dept d on e.DEPTNO = d.DEPTNO
			join SALGRADE s on e.sal between s.LOSAL and s.HISAL

-- 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원번호, 사원이름을 출력하라.
select *
from emp e join dept d on e.DEPTNO=d.DEPTNO
where e.DEPTNO=10

-- 부서번호가 20번 이하인 사원들의 부서번호, 부서이름, 사원번호, 사원이름을 출력하되, 부서번호가 낮은 순으로 정렬하라.
select *
from emp e join dept d on e.DEPTNO=d.DEPTNO
where e.DEPTNO <=20
order by d.DEPTNO



-- <연습문제>
-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
select e.ENAME, e.DEPTNO, d.DNAME
from EMP e join DEPT d
on e.DEPTNO = d.DEPTNO

-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.
select e.ENAME, e.JOB, d.DEPTNO, d.DNAME
from EMP e join DEPT d
on e.DEPTNO=d.DEPTNO
where d.LOC='DALLAS'

-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
select e.ename, d.dname
from EMP e join DEPT d
on e.DEPTNO=d.DEPTNO
where e.ENAME like '%A%'

-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 
--출력하는데 월급이 3000이상인 사원을 출력하라.

select e.ENAME, d.DNAME, e.SAL
from EMP e join DEPT d
on e.DEPTNO = d.DEPTNO
where e.sal >= 3000

-- 5. 직위가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
select e.JOB, e.ENAME, d.DNAME
from EMP e join DEPT d
on e.DEPTNO = d.DEPTNO
where e.job='SALESMAN'

-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
select e.EMPNO 사원번호, e.ENAME 사원이름, e.SAL*12 연봉, e.SAL*12+e.COMM 실급여, s.GRADE 급여등급 
from EMP e join DEPT d on e.DEPTNO = d.DEPTNO 
			join SALGRADE s on e.sal between s.LOSAL and s.HISAL
where e.comm is not null

-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
select e.DEPTNO, d.DNAME, e.ENAME, e.SAL, s.GRADE
from EMP e join DEPT d on e.DEPTNO = d.DEPTNO
		   join SALGRADE s on e.sal between s.LOSAL and s.HISAL
where d.DEPTNO= 10

-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름, 
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된 
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로 
-- 정렬하라.
select e.DEPTNO, d.DNAME, e.ENAME, e.SAL, s.GRADE
from EMP e join DEPT d on e.DEPTNO = d.DEPTNO
			join SALGRADE s on e.sal between s.LOSAL and s.HISAL
where d.DEPTNO in (10,20)
order by d.DEPTNO, e.SAL desc

-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
select e.EMPNO 사원번호, e.ENAME 사원이름, e.MGR 관리자번호, m.ENAME 관리자이름
from EMP e left outer join EMP m 
on e.MGR=m.EMPNO


------------------------------------------------------------------------------

/***************** SubQuery ***********************/

-- Jones 가 받는 급여보다 더 많은 급여를 받는 사원의 이름과 급여를 출력하세요
select sal from emp where ename='JONES'	-- 2975
select ename, sal from emp where sal > 2975
-- 이를 하나의 문장으로 합치기
select ename, sal 
from emp 
where sal > (select sal from emp where ename='JONES')

/* 
 <규칙>
	1. 서브쿼리는 괄호 안에 위치해야 함.
	2. 서브쿼리 단독으로 실행 가능해야 함.
	3. 서브쿼리는 단일 컬럼으로 구성돼야함. (select절에 컬럼이 한 개만 올 수 있음)

 <실행순서>
	- 서브쿼리 결과를 통해 -> 메인쿼리 실행

 <종류>
	- single row subquery : 결과가 한 개의 row	( >, <, =, >=)
	- multi row subquery : 결과가 여러 개의 row	(in, not in)
 이렇게 종류를 구분하는 이유는 사용하는 연산자가 달라서...
*/

-- 직종이 salesman인 사원들과 같은 급여를 받는 사원들의 사번, 이름, 급여정보를 출력하세요.
select empno, ename, sal
from emp
where sal in (select sal from emp where job='SALESMAN')

-- 부서번호가 10번인 사원들과 같은 급여를 받는 사원들의 목록을 출력하세요.
select *
from emp
where sal in (select sal from emp where deptno = 10)

-- 부하직원이 있는 사원의 사번과 이름을 출력하세요.
select empno, ename
from emp
where empno in (select mgr from emp)
-- in : empno=7902 or empno=7788 ...

-- 부하직원이 없는 사원의 사번과 이름을 출력하세요.
select empno, ename
from emp
where empno not in (select isnull(mgr,0) from emp)
-- not in : empno!=7902 and empno!=7369 and ... empno!=null...	>> null과의 연산결과는 >> null
-- 따라서 isnull처리 해줘야함...

-- 20번 부서의 사원중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 모든 사원 정보를 출력하세요.
select *
from emp
where sal > (select max(sal) from emp where deptno=20)

select *
from emp
where sal > ALL(select sal from emp where deptno=20)
-- ALL : where sal > data and sal > data2 and...
-- max(sal)쓴 것과 같은 결과

-- 20번 부서의 사원 중 가장 적은 월급을 받는 사원들보다 더 많은 월급을 받는 사원들의 이름과 월급을 출력하라.
select ename, sal 
from emp 
where sal > (select min(sal) from emp where deptno=20)


select *
from emp
where sal > ANY(select sal from emp where deptno=20)
-- ANY : where sal > data or sal > data2 or...
-- min(sal)쓴 것과 같은 결과

-- 직업이 'SALESMAN'인 사원과 같은 부서에서 근무하고 같은 월급을 받는 사원들의 월급, 부서번호를 출력하라.
select sal, deptno
from emp
where sal in (select sal from emp where job = 'SALESMAN') 
		and deptno in (select deptno from emp where job='SALESMAN')

-- 자기 부서의 평균월급보다 더 많은 월급을 받는 사람들의 이름, 월급, 부서번호, 부서별 평균 월급을 구하시오.
-- if 평균월급을 담고 있는 테이블이 존재한다면...
-- in line view : 가상테이블
select e.ename, e.sal, e.deptno, 평균월급
from emp e join
(select deptno, avg(sal) 평균월급
from emp
group by DEPTNO) m
on e.deptno = m.deptno
where e.sal > m.평균월급

-- TIP)
-- 단일 (함수) / 여러개 (JOIN) >> 해결 안되면 >> subquery >> in line view(가상테이블)

-- <Question>
--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
select ename, sal
from emp
where sal > (select sal from emp where ename='SMITH')

--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
select ename, sal, deptno
from emp
where sal in (select sal from emp where deptno=10)

--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.
select ename, hiredate
from emp
where deptno = (select deptno from emp where ename='BLAKE') and ename != 'BLAKE'

--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
order by sal desc

--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
select empno, ename
from emp
where deptno in (select deptno from emp where ename like '%T%')

--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL 또는 ANY 연산자를 사용할 것)
select ename, deptno, sal
from emp
where sal > ALL(select sal from emp where deptno=30)

--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
select ename, deptno, job
from emp
where deptno = (select deptno from DEPT where loc = 'DALLAS')

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.
select e.deptno, ename, job
from emp e join dept d
on e.DEPTNO = d.DEPTNO
where d.DNAME='SALES'

SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
			FROM DEPT
			WHERE DNAME='SALES')

--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라.
select ename, sal
from emp
where MGR = (select empno from emp where ename='KING')

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,
-- 급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
			 FROM EMP)
	AND DEPTNO IN (SELECT DEPTNO
					FROM EMP
					WHERE ENAME LIKE '%S%')

--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
		FROM EMP
		WHERE COMM IS NOT NULL)
AND SAL IN(SELECT SAL
		FROM EMP
		WHERE COMM IS NOT NULL)

--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.
select ename, sal, comm
from emp
where sal not in (select sal 
					from emp 
					where deptno=30)
	and comm not in (select isnull(comm,0) 
					from emp 
					where deptno=30)

--------------------------------------------------------------------------

/************ DML (insert, update, delete) -무조건 암기!! ***********/

create table Test(
	userid int
)

insert into Test(userid) values(100)	-- 실반영

select * from Test

-- 완료 (commit / rollback)
begin tran
	insert into Test(userid) values(200)	-- 실반영 X
rollback	-- 취소(완료)


select * from Test

begin tran
	delete from Test	-- 실반영 X
commit	-- 실반영(완료)

/*
	MSSQL 서버는 DML 작업에 대해 autocommit합니다.
	만약, begin tran이라는 명령어와 함께 DML 작성하시면
	commit, rollback을 할 수 있는 권한이 주어짐.
	이때는 commit, rollback을 하지 않은 상태에선 대기 상태...
	즉, 실반영 X
*/

/*** Transaction (트랜잭션) ***/
-- 하나의 논리적인 작업 단위 (성공 or 실패)
-- ex) 은행업무 - A -> B 계좌이체 여기서...
--		A = A - 1000
--		B = B + 1000
--	여기까지가 하나의 단위 ...



/*** insert ***/
-- 1. 전체 컬럼에 데이터 삽입 (컬럼명 생략 가능)
insert into emp(empno, ename, job, mgr, hiredate,sal, comm, deptno)
values(9999, '홍길동', 'IT', 7902, GETDATE(), 3000, 100, 10)

insert into emp
values(9991, '홍길동', 'IT', 7902,GETDATE(), 3000, 100, 10)

-- 2. 특정 컬럼에 데이터 삽입 (반드시 컬럼명 명시)
-- error!
insert into emp
values(5555, '아무개', 800)
-- OK
insert into emp(EMPNO, ENAME, SAL)
values(9992, '아무개', 800)
-- 데이터를 넣지 않은 컬럼엔 NULL로 표시

select * from emp order by empno desc

insert into emp(empno, ename, hiredate, deptno)
values(9998, '깜부', '2022-01-01', 10)



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

-- 이름이 'SCOTT'인 사원의 월급을 0으로 갱신하라.
begin tran
	update emp set sal=0 
	where ename='SCOTT'
	update emp set sal=1111
	where deptno=10
	update emp set sal = (select max(sal) from emp)
	where deptno=20
rollback
select * from emp
-- begin tran ~ rollback이 하나의 트랜잭션...



/*** DELETE ***/
-- 사원번호 7902 데이터 삭제
begin tran
delete from emp where empno=7902
rollback
select * from emp where empno=7902

begin tran
	delete from emp		-- 모든 데이터 삭제
rollback
	select * from emp



---------------------------------------------------------------------------------
-- 부가적인 옵션 ...

/*** select ... into (테이블 생성 및 데이터 insert까지) ***/

--  1. EMP 테이블의 테이블 구조만 복사하는 작업 
--     ‘A’=’B’는 거짓이므로 EMP테이블의 모든 데이터는 EMP01 테이블에 삽입되지 않는다.
SELECT *
INTO EMP01
FROM EMP
WHERE 'A'='B'      

-- 2. EMP 테이블의 모든 데이터 복사
SELECT *
INTO EMP02
FROM EMP


/*** insert ~ select (대량 데이터 삽입) ***/
insert into emp (empno, ename)
values(1111, 'AAA')

-- values 대신 select 사용
insert into emp02(empno, ename, job, sal)
select empno, ename, job, sal from emp where deptno =10

select * from emp02

--------실습
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



-- <연습문제>
-- 모든 실습문제는 EMP 테이블의 데이터 보존을 위해 BEGIN TRAN...
-- ROLLBACK TRAN 구문을 사용할 것

select * 
	into emptest
from emp 

select *
into testd
from dept
where 'A'='B'

select * from emptest
-- emptest로 연습문제 푸세요.
-- 1. EMP 테이블에서 사원번호가 7499번인 사원의 월급을 5000달러로 바꿔라.
begin tran
	update emptest
	set sal =5000
	where empno = 7499
rollback
-- 2. EMP테이블에서 부서번호가 20번인 사원들의 월급을 4000달러로 바꿔라.
begin tran
	update emptest
	set sal = 4000
	where deptno = 20
rollback
-- 3. DEPT 테이블에 아래의 조건으로 데이터를 입력하라.
-- 부서번호: 50, 부서위치: BOSTON,  부서명: RESERCH

begin tran
	insert into testd(DEPTNO, LOC, DNAME) values(50, 'BOSTON', 'RESEARCH')

-- 4. 사원번호가 7698번인 사원의 부서번호를 7499번 사원의 
--부서번호로 바꿔라.
update emptest
set DEPTNO = (select DEPTNO from emptest where empno=7499)
where empno=7698

-- 5. EMP 테이블에 아래와 같은 데이터를 삽입하라.
-- 사원번호: 9900, 사원이름: JACKSON, 직업: SALESMAN, 부서번호: 10
insert into emptest(EMPNO, ENAME, JOB, DEPTNO) values(9900, 'JACKSON', 'SALESMAN', 10)

-- 6. INSERT...SELECT 문을 이용하여 직업이 'SALESMAN'인
-- 사원의 사원번호, 이름, 직업을 EMP 테이블에 입력하라.
insert into emptest(EMPNO, ENAME, JOB)
select empno, ename, job
from emptest
where job ='SALESMAN'

-- 7. 사원번호가 7369번인 사원과 같은 직업을 가진 사원들의
-- 월급을 7698번 사원의 월급으로 수정하라.
update emptest
set sal = (select sal from emptest where empno = 7398)
where job = (select job from emptest where empno=7369)

-- 8. SCOTT과 같은 직업을 가진 사원을 모두 삭제하라.
delete from emptest
where job = (select job from emptest where ename = 'SCOTT')

-- 9. 'SCOTT'의 월급을 'SMITH'의 월급과 같게 수정하라.
update emptest
set sal = (select sal from emptest where ename='SMITH')
where ename = 'SCOTT'

-- 10. 'ALLEN'의 직업을 'SCOTT'의 직업과 같게 수정하라.
update emptest
set job = (select job from emptest where ename='SCOTT')
where ename = 'ALLEN'

-- 11. 사원번호가 7499번인 사원과 같은 직업을 가진 사원들의
-- 입사일을 오늘날짜로 변경하라.
update emptest
set HIREDATE = GETDATE()
where job = (select job from emptest where empno=7499)

-- 12. SCOTT과 같은 직업을 가진 사원들의 월급을 0으로 수정하라.
update emptest
set sal = 0
where job = (select job from emptest where ENAME='SCOTT')

rollback


-------------------------------------------------------------------------


use pubs

-- 과제 : 조인 문제 만들기
-- 1990 년 이전에 입사한 사원들이 있는 출판사에서 출판한 책들 중
-- 가격이 20달러 이상인 책의 이름과 가격, 그리고 출판사의 이름을 출력하시오.
select t.title, t.price, p.pub_name
from employee e join titles t on e.pub_id = t.pub_id
	join publishers p on e.pub_id = p.pub_id
where e.hire_date<'1990' and t.price>=20



------------------------------------------------------------------------------------------


/*************** DDL (Data Definition Language) *************************/
-- 데이터 정의어	>>  create, alter, drop

-- DB 만들었어요.
-- 그 저장소안에 Table 생성.

use CarDB	-- 현재 작업  DB

sp_helpdb kosadb	-- DB기본정보 조회하기

use KosaDB

-- DDL table 생성
create table emp10(
	empno int,
	ename nvarchar(20),
	hiredate datetime
)

/*
  char(10)	>> 영문, 특수, 공백 10자	>> 한글5자	>> 고정길이 문자열
  varchar(10)	>>  영문, 특수, 공백 10자	>> 한글 5자	>> 가변길이 문자열

  데이터 : '남' 또는 '여'
  create table T ( gender char(2) )	-- char : 크기가 변하지 않을때	>> varchar 보다 내부적으로 성능 더 좋음.
  create table T ( gender varhar(2))

  데이터 : 사람의 이름 (이순신, 김수한무 ...)
  create table T (name char(50))	-- 실제로 6byte 들어가도 50byte 그대로 ...
  create table T (name varchar(50))	-- 6byte 들어가면 6byte로 줄어서 저장 ...

  영문자와 한글을 혼합해서 사용하면?
  unicode : char 앞에 n을 붙임
  create table T ( gender nchar(4) )	-- 4글자 (영문, 한글, 공백 상관없이), 8byte
  create table T ( gender nvarhar(4))
*/

-- 테이블 정보 보기 <암기!!>
sp_help emp10

insert into emp10(empno, ename, hiredate) values(100, '홍길동', GETDATE())
select * from emp10

create table member2(
	id int,
	name varchar(20),
	address varchar(50),
	birth datetime,
	hobby varchar(100)
)

select * from member2

insert into member2(id, name, address, birth) values(1, '이순신', '부산시', '1960-12-12')
-- insert하지 않은 데이터 (hobby)는 null로 표현 ...

insert into member2(id, name, address, birth, hobby) values(1, '이순신', '부산시', '1960-12-12', '말타기')

insert into member2(id) values(3)


-- 1. 기존 테이블에 컬럼 추가하기
	alter table member2
	add gender char(1)

	sp_help member2

-- 2. 기존 컬럼의 타입 변경하기
	alter table member2
	alter column gender char(2);

-- 컬럼 삭제하기
alter table member2
drop column gender

-- 테이블 삭제하기
drop table member2;


create table emp03
(
	empno int not null,	-- 필수 입력
	ename varchar(20)	-- default로 null 입력
)

insert into emp03(empno) values(7788)

select * from emp03

insert into emp03(ename) values('아무개')	-- error! empno는 not null이므로 null허용 X...

insert into emp03(empno,ename) values(7902, '김유신')


create table emp04(
	empno int default 1000,	-- 기본값 1000
	ename varchar(20)
)

sp_help emp04

insert into emp04(empno, ename) values(1111, '김씨')
insert into emp04(ename) values('이씨')
insert into emp04(ename) values('박씨')
select * from emp04

sp_helpconstraint emp04	-- 제약정보 보여줌
-- DF__emp04__empno__3B75D760 :  제약이름 (이름을 가지고 나중에 수정, 삭제 사용)

create table emp05
(
	empno int constraint df_emp04_empno default 1000,
	ename varchar(20)
)

-- df_emp04_empno_ : 관용적 표현

sp_helpconstraint emp05



create table user02
(
	u_id int not null,
	u_name nvarchar(20),
	u_job varchar(50) constraint df_user02_u_job default 'IT'
)

sp_helpconstraint user02

insert into user02(u_id, u_name, u_job) values(10, '홍길동', '도적')
select * from user02
insert into user02(u_id, u_name) values(20, '이순신')

-- 회원테이블 default ... 가입 날짜 (getdate())


--------------------------------------------------------------------------------------------------------


/*********************** Constraint (제약) ***************************/

/*
	#제약 : Data Integrity를 위한 방법

	# 제약의 방법
	1. 테이블 생성시 정의하는 방법: CREATE TABLE문 사용
  * 2. 만들어진 테이블에 정의 하는 방법: ALTER TABLE문 사용	*** 중요!

	# 제약의 종류
	1. NOT NULL

	2. DEFAULT
  
  * 3. PRIMARY KEY (not null + unique) >> 중복 X, null X	 >> ex) 주민번호, 순번, 지문
									   >> 한 개의 row반환 가능 >> 검색 많이(where절)... 속도 향상 필요... >> index 생성
									   >> 테이블 당 한개만 존재 (묶음으로 가능)	>> 복합키(묶음) 가능

	4. UNIQUE (중복X)	>> not null은 강제하지 X
						>> 검색 ... index 생성
						>> 컬럼 수 만큼 생성 가능

	5. CHECK (남 or 여 데이터만 들어올 수 있음 / 1~10만 올 수 있음 ...)	>>  where gender in ('남', '여') 와 같음 
	
  * 6. FOREIGN KEY (외래키/참조키/참조제약)	>> 테이블과 테이블 간의 관계 성립시 사용
											>> 관계 : 부모-자식, master-detail ...
											>> EMP ... DEPT	>>	EMP의 DEPTNO컬럼이 DEPT의 DEPTNO컬럼을 '참조' (FK)	>>	DEPT의 DEPTNO컬럼은 '참조당함' (PK)
*/
select * from emp
select * from dept


/*** PRIMARY KEY ***/

create table emp06(
	empno int constraint pk_emp06_empno primary key,
	ename varchar(20)
)

sp_helpconstraint emp06

insert into emp06(empno, ename) values(100, '김유신')
insert into emp06(empno, ename) values(100, '이순신')	--PRIMARY KEY 제약 조건 'pk_emp06_empno'을(를) 위반했습니다. 개체 'dbo.emp06'에 중복 키를 삽입할 수 없습니다. 중복 키 값은 (100)입니다.
insert into emp06(ename) values('이순신') --테이블 'KosaDB.dbo.emp06', 열 'empno'에 NULL 값을 삽입할 수 없습니다. 열에는 NULL을 사용할 수 없습니다. INSERT이(가) 실패했습니다.

-- 테이블당 1개 (묶어서)
-- 복합키

create table pktable
(
	a int,
	b int,
	c int

	constraint pk_pktable_a_b primary key(a,b)
)
-- 복합키는 순서가 매우 중요!
-- where b=10			-- error! index (X)...
-- where a=10 and b=20	-- good
-- where a=10			-- 가능

sp_helpconstraint pktable

/*
<복합키를 사용하는 경우..>

이력테이블

인사테이블
2000  1  IT
2000  2  SALES

학력테이블
2000  1  인천고
2000  2  인천대
*/



/*** UNIQUE ***/
create table emp07
(
	empno int constraint uk_emp07_empno unique,	--중복 데이터 허락X / non-clustered (index 생성)
	ename varchar(20)
)
sp_helpconstraint emp07

insert into emp07(empno, ename) values(1000,'김씨')
select * from emp07
insert into emp07(ename) values('김씨')	-- unique는 null값 허용
insert into emp07(ename) values('박씨') -- error!! null값도 중복 불가! 중복 키 값은 (<NULL>)입니다.

create table emp08
(
	empno int not null constraint uk_emp08_empno unique,
	ename varchar(20)
)
-- 그러면 empno int not null constraint uk_emp08_empno unique	>>  primary key 같은 거 아니야?	>> NO... primary key는 하나만 생성 가능함..


create table emp09(
	u_id int constraint pk_emp09_u_id primary key,
	u_name varchar(20) not null,
	reg_num1 char(6) not null constraint pk_emp09_reg_num1 unique,
	reg_num2 char(7) not null constraint pk_emp09_reg_num2 unique,
	u_job nvarchar(20) constraint df_emp09_u_job default 'IT'
)

sp_helpconstraint emp09



/*** CHECK ***/

create table emp11
(
	empno int constraint pk_emp11_empno primary key,
	ename varchar(20) not null,
	gender char(2) constraint ck_emp11_emp11_gender check(gender in ('남','여'))	
)

sp_helpconstraint emp11

insert into emp11(empno, ename, gender) values(1000,'김','중')	-- error!! insert into emp11(empno, ename, gender) values(1000,'김','중')
insert into emp11(empno, ename, gender) values(1000,'김','남')



/*** FOREIGN KEY ***/
-- 참조제약-------------
select * from emp
select * from dept



alter table emp
add constraint fk_emp_deptno foreign key(deptno) references dept(deptno)
-- 참조되는 테이블 'dept'에 외래 키 'fk_emp_deptno'의 참조 열 목록과 일치하는 기본 키 또는 후보 키가 없습니다.
-- 반드시 참조되는 테이블에는 [PK]가 선행되어야 한다.

alter table dept
add constraint pk_dept_deptno primary key(deptno)
-- error!!
-- MSSQL서버는 NOT NULL 하지 않은 컬럼에 대해서 PK를 걸 수 X...
-- 컬럼에 not null 걸기
alter table dept
alter column deptno int not null

alter table dept
add constraint pk_dept_deptno primary key(deptno)

alter table emp
add constraint fk_emp_deptno foreign key(deptno) references dept(deptno)


-- 옵션
-- identity(증가분)
-- 채번 (번호표)
-- sequence (객체 번호표)

create table board(
	boardid int identity(1,1),	-- (초기값, 증가값)
	title varchar(20)
)

insert into board(title) values('방가')

select * from board

create table emp20(
	a int,
	b int,
	c as a+b	-- 계산된 컬럼 / 인위적으로 데이터 삽입 불가
)

insert into emp20(a,b) values(100,300)
select * from emp20



--------------------------------------------------------------------
-- 조별과제

create table major(
	mcode int constraint pk_major_mcode primary key,
	mname varchar(20) not null
)

create table student(
	s_id int constraint pk_student_s_id primary key,
	sname varchar(20) not null,
	kor int constraint df_student_kor default 0,
	eng int constraint df_student_eng default 0,
	math int constraint df_student_math default 0,
	s_sum as kor+eng+math,
	s_avg as (kor+eng+math)/3,
	mcode int constraint fk_student_mcode foreign key(mcode) references major(mcode)
)

insert into major(mcode, mname) values(1000, '컴퓨터공학과')
insert into major(mcode, mname) values(2000, '경영학과')
insert into major(mcode, mname) values(3000, '경제학과')
insert into major(mcode, mname) values(4000, '문헌정보학과')
insert into major(mcode, mname) values(5000, '기계공학과')
insert into major(mcode, mname) values(6000, '시각디자인과')
insert into major(mcode, mname) values(7000, '실용음악과')
select * from major

select * from student
insert into student(s_id, sname, kor, eng, math, mcode) values(221001, 'KIM', 90,80,70, 1000)
insert into student(s_id, sname, kor, eng, math, mcode) values(182001, 'LEE', 77,45,72, 2000)
insert into student(s_id, sname, kor, eng, math, mcode) values(203001, 'PARK', 44,22,85, 3000)
insert into student(s_id, sname, kor, eng, math, mcode) values(194001, 'YOO', 100,80,66, 4000)
insert into student(s_id, sname, kor, eng, math, mcode) values(225001, 'KANG', 90,85,75, 5000)
insert into student(s_id, sname, kor, eng, math, mcode) values(226001, 'JUNG', 97,88,35, 6000)
insert into student(s_id, sname, kor, eng, math, mcode) values(227001, 'KIM', 67,80,70, 7000)
insert into student(s_id, sname, kor, eng, math, mcode) values(167001, 'YOON', 10,99,55, 7000)
insert into student(s_id, sname, kor, eng, math, mcode) values(226002, 'MIN', 45,85,90, 6000)
insert into student(s_id, sname, kor, eng, math, mcode) values(225002, 'YANG', 45,85,35, 5000)
insert into student(s_id, sname, kor, eng, math, mcode) values(194002, 'JANG', 65,100,100, 4000)

select s_id 학번, sname 이름, s_sum 총점, s_avg 평균, m.mcode 학과코드, m.mname 학과명
from student s join major m
on s.mcode=m.mcode


-------------------------------------------------------------------------------------------------

/**************** VIEW **********************/
-- view (가상테이블), (sql 문장 덩어리)
-- view 객체 (create ... drop 전까지는 영속적)
-- 뷰는 데이터를 가지고 있는 것이 X, sql문장 덩어리일뿐..

create view tbl_emp
as
	select empno, ename, job, deptno from emp

-- 사용법 : *** 가상 테이블	>> 테이블처럼 사용가능 >> 뷰를 통해서
select * from tbl_emp	-- 뷰가 가지고 있는 sql문장이 실행
-- 뷰를 통해 볼 수 있는 데이터 ... 가지고 놀 수 있음.

sp_help tbl_emp	-- type : view

sp_helptext tbl_emp

--*** "편리성" (쿼리 단순화 >> 물리적인 테이블이 없는 경우 >> view 가상테이블 만들어서	 >> JOIN)
create view v_emp	-- 부서번호, 부서이름, 사번 ..... 매번 join하지 않아도됨
as
	select empno, ename, e.deptno, dname
	from emp e inner join dept d
	on e.deptno=d.deptno

select * from v_emp


-- 직업이 salesman 인 사람들의 이름, 월급, 직업만 보여주는 view 작성하시오.
create view v_emp2
as
	select ename, sal, job
	from emp
	where job='salesman'

select * from v_emp2

-- 부서 번호가 30번인 사원의 이름, 급여, 부서번호를 보여주는 뷰를 작성해보세요.
create view v_dept
as
	select ename, sal, deptno
	from emp
	where DEPTNO = 30

select * from v_dept

-- 뷰도 테이블이면 DML 작업
-- 뷰 [통해서] 뷰가 볼 수 있는 것만 원본 테이블에서 insert, update, delete 작업 가능하다.
-- 그러나 하지 마세요.
-- 뷰의 목적은 DML 아님!

begin tran
	update v_dept
	set sal = 0
rollback

select * from emp
select * from v_dept

-- 부서별 최대 월급을 담고 있는 뷰를 작성하라.
-- subquery	 :	from (select deptno, avg(sal) as svgsal from emp) e
-- view :
create view empavg
as
 select deptno, avg(sal) from emp group by deptno
 --열 2에 대해 열 이름이 지정되지 않았으므로 뷰 또는 함수를 만들지 못했습니다.
create view empavg
as
 select deptno, avg(sal) as avgsal from emp group by deptno

select * from emp e join empavg s on e.DEPTNO=s.DEPTNO and e.sal > s.avgsal

-- 사원 테이블에서 이름과 월급만 담는 뷰를 작성하되, 월급이 높은 순으로 출력하라.
-- 뷰 생성시 order by절 사용하지 마세요.
create view v_emp3
as
	select top 20 ename, sal
	from emp
	order by sal desc

select * from v_emp3


-- <연습문제>-----------------------------------------------------------------------------------

-- 1. 30번 부서 사원들의 직위, 이름, 월급을 담는 view를 만들어라
create view v0
as
	select job, ename, sal
	from emp
	where deptno = 30

select * from v0


-- 2. 30번 부서 사원들의 직위, 이름, 월급을 담는 뷰를 만드는데, 각각의 컬럼명을 직위, 사원이름, 월급으로  alias를 주고 월급이 300보다 많은 사원들만 추출하도록 하라,
 create view v
 as
	select job 직위, ename 사원이름, sal 월급
	from emp
	where deptno = 30 and sal > 300

select * from v


-- 3. 부서별 평균월급을 담는 뷰를 만들되, 평균월급이 2000이상인 부서만 출력하도록 하라.
create view v3
as
	select deptno, avg(sal) 평균월급
	from emp
	group by deptno
	having avg(sal) >= 2000

select * from v3

---------------------------------------------------------------------------------------------------------------------------------------------------------

-- <다른조 문제 풀기>

-- <1조>

use Northwind

--shipCity가 'LONDON'인 주문id, 제품id, 주문날짜, 제품가격, 주문량을 출력하세요, 제품번호 낮은 순으로 정렬하세요
 select o.OrderID, od.ProductID, o.OrderDate, od.UnitPrice, od.Quantity
 from Orders o join [Order Details] od
 on o.OrderID = od.OrderID
 where o.ShipCity='LONDON'
 order by od.ProductID 
​

-- 사번, lastname, 관리자의 사번, 관리자의 lastname 출력하기 (lastname 오름차순)
select e.EmployeeID, e.LastName, m.EmployeeID, m.LastName
from Employees e join Employees m
on e.ReportsTo = m.EmployeeID
order by e.LastName


 --Customer 테이블에서 CustomerID가 다르고 도시가 같은 Customer ID A와 B를 도시 기준으로 정렬하여 출력하세요
 select c.CustomerID A, u.CustomerID B, c.City
 from Customers c join Customers u
 on c.City = u.City
 where c.CustomerID != u.CustomerID
 order by c.City​ 


 --<4조>

 use pubs

 -- 1. 스토어 아이디가 8042인 스토어에서 판매한 주문 중, 책 제목이 T로 시작하는 책을 주문한 총 횟수를 구하여라.
 select count(*)
 from stores s join sales a on s.stor_id = a.stor_id
				join titles t on a.title_id=t.title_id
 where s.stor_id = 8042 and t.title = 'T%'

 -- 2. 'Sushi, Anyone?'의 책에 대한 저자들의 first name과 주소, city와 퍼블리셔의 이름과 위치 그리고 나라를 가져오시오
 select u.au_fname, u.address, u.city, p.pub_name, p.city, p.country
 from titles t join titleauthor a
 on t.title_id = a.title_id
 join authors u on u.au_id=a.au_id
 join publishers p on p.pub_id = t.pub_id
 where t.title = 'Sushi, Anyone?'
 

 -- 3. 평균치 이상의 로열티가 부과된 책의 저자들의 이름(lastname)과 책 제목, royaltyper을 출력
 select u.au_lname, t.title, a.royaltyper
 from titles t join titleauthor a
 on t.title_id = a.title_id
 join authors u on u.au_id = a.au_id
 where royalty >= (select avg(royalty) from titles)


 ------------------------------------------------------------------------------------

-- # ROW_NUMBER() : select 결과에 순번을 매겨줌.
-- rownum between A and B : pagesize = B-A+1

use KosaDB

select rownum, empno
from (
select row_number() over (order by empno) as rownum , empno
from emp
) T where t.rownum between 1 and 5	-- pagesize = 5


select row_number() over (order by empno asc) as rownum , empno	-- over(기반)
from emp

/*	# OFFSET
	- 양식 
	ORDER BY {정렬 대상 컬럼} 
	OFFSET {건너 뛸 행의 수} ROWS 
	FETCH NEXT {가져올 행의 수} ROWS ONLY

	ORDER BY를 통해 정렬 기준을 정한 뒤
	OFFSET을 통해 건너 뛸 행의 수를 먼저 설정하고
	(1부터 가져올 경우 OFFSET 0 ROWS, 11부터 가져올 경우 OFFSET 10 ROWS)
	FETCH NEXT 에서 몇 개의 행을 가져올 지 결정하게 됩니다.

	(한 페이지 내에 10개를 가져올 경우 FETCH NEXT 10 ROWS ONLY)
​*/

​

select empno ,ename
from emp
order by empno offset 0 rows fetch next 5 rows only

select empno , ename
from emp
order by empno offset 5 rows fetch next 5 rows only


select empno , ename
from emp
order by empno offset 10 rows fetch next 5 rows only


/*** WITH절과 CTE***/

with T(deptno,total)
as
    (select deptno , sum(sal+isnull(comm,0)) from emp group by deptno)
select * from T order by total desc;




/*** TRANSACT-SQL의 확장 ***/

-- DATETIME 데이터 타입을 가지는 @ymd 변수를 선언하고, 
-- 이 변수에 GETDATE()함수를 사용하여 현재 날짜시간을 저장한 다음 화면에 출력하라.

DECLARE @ymd datetime
SET @ymd=GETDATE()
SELECT @ymd

-- INT 데이터 타입을 가지는 @sal 변수를 선언하고, 이 변수에 5000이라는 초기값을 담도록 지정하라. 
-- 그리고 EMP 테이블에서 월급이 @sal인 사원의 이름과 월급을 출력하라.
DECLARE @sal int
SET @sal=5000
	SELECT ENAME, SAL
	FROM EMP
	WHERE SAL=@sal

-- EMP 테이블로부터 평균월급을 담는 변수를 선언하고, 
-- 이 변수를 이용해 평균월급보다 더 많은 월급을 받는 사원의 모든 정보를 출력하는 쿼리문을 작성하라.
DECLARE @AVGSAL INT
SET @AVGSAL = (SELECT AVG(SAL) FROM EMP)
SELECT *
FROM EMP
WHERE SAL > @AVGSAL