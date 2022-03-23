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