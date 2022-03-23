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
 # DDL(Data Definition Language): 데이터 정의 언어, 데이터베이스 "개체" 의 생성/변경/삭제을 목적으로 사용하는 언어

 Create ... 생성

 Alter ... 수정

 Drop ... 삭제


 # DCL(Data Control Language): 데이터 제어 언어, 데이터 제어를 정의하고 기술하는 언어, 누가 데이터를 제어할 수 있는지를 지정하는 언어.

 Grant ... 허락

 Revoke ... Grant 했다가 ... 다시 가져옴

 Deny ... 접근 금지 ...


 # DML(Data Manipulation Language): 데이터 조작 언어, 데이터 자체를 처리하고 조작하기 위한 언어
 개발자가 해야 하는 업무 ...

 select (60%) >> 함수, 조인, 서브쿼리, 뷰 ...

 insert

 update

 delete

*/

select * from emp;

select * from dept;

select * from salgrade;

-- 1. 사원 테이블에 있는 모든 사원데이터를 출력하세요.
select *
from emp;

--2. 특정 컬럼(사번, 이름, 급여) 만 출력하세요.
select empno, ename, sal from emp;

--3. 부서 테이블에 있는 부서번호, 부서이름을 출력하세요.
select deptno, dname from dept;

--4. 사원번호, 사원이름 컬럼명을 출력시, 한글로 출력하세요.
select empno 사원번호, ename 사원이름 from emp;		-- 별칭을 붙여줌

-- select empno 사원 번호, ename 사원 이름 from emp;		-- 띄어쓰면 error

select empno as '사원 번호', ename as '사원 이름' from emp;	-- as '별칭' 으로 작성하면 띄어쓰기해도 하나의 단어로 생각

--5. 사원 테이블에서 직종을 출력하세요.
select job from emp;

--5-1. 우리 회사에 직종이 몇개나 있지 ...
	-- 중복된 열 제거하고 출력
select distinct job from emp;	-- distinct : 중복 데이터 제거

/* # SQL(언어) : 질의가 가능한 언어
   # 연산자 : 산술, 비교, 논리			*/

-- 6. 사원 테이블에서 사번, 이름, 급여, 300달러가 인상된 급여를 출력하세요.
select empno, ename, sal, sal+300 as '인상급여' from emp;

--7. 사원 테이블에서 사번, 이름, 급여, 연봉(급여*12)을 출력하세요.
select empno, ename, sal, sal*12 as'연봉' from emp;

--8. NULL (필요악)
-- ex) 회원 테이블 >> 회원번호, 회원명, 핸드폰번호, 취미	>> 필수 입력 or 옵션(NULL 허용)
select empno, sal, comm from emp;
-- comm 데이터 NULL	>> comm을 받지 않는 구나
-- 7844 1500 0	>> 받지 않는 것이지만 수업용 확인

--9. 사원 테이블에서 사번, 이름, 직종, 급여, 수당, 급여+수당을 출력하세요.
select empno, ename, job, sal, comm, sal+comm as'총급여' from emp;	-- !!**** NULL과의 모든 연산의 결과는 NULL ****!!

/* NULL을 처리하는 함수
		- Oracle : nvl()
		- Mysql : ifnull() 
 !!****	- Mssql : isnull() ****!!
*/

select sal + isnull(comm, 0) as'총급여' from emp;	-- isnull(comm, 0) : comm값이 null이면 0으로 치환 
select empno, ename, job, sal, comm,  sal + isnull(comm, 0) as'총급여' from emp;	

/* <실행순서>
 select		-3
 from		-1
 where		-2
*/

-- 사원테이블에서 사번이 7788인 사원의 사번, 이름, 급여를 출력하세요.
select empno, ename, sal
from emp
where empno=7788;

-- 사원테이블에서 사원이름이 SMITH인 사원의 모든 정보를 출력하세요.
select *
from emp
where ename = 'SMITH';
-- Mssql은 Oracle과 달리 대/소문자를 구분하지 [않음]!!

-- 사원테이블에서 입사일이 1980년 12월 17일인 사원의 모든 정보를 출력하세요.
-- 날짜 데이터도 문자열 처럼 '' 사용해서 처리
select * from emp
where hiredate='1980-12-17';

-- 직종이 salesman인 사원의 사번, 이름, 급여, 직종을 출력하세요.
select empno, ename, sal, job
from emp
where job = 'SALESMAN';

-- 부서 번호가 10번인 사원의 부서번호, 이름, 급여 정보를 출력하세요.
select deptno, ename, sal
from emp
where deptno = 10;

-- <비교 연산>
-- 사원테이블에서 급여가 3000[이상]인 사원의 이름과 급여를 출력하세요.
select ename, sal
from emp
where sal>=3000;

-- 사원테이블에서 직종이 SALESMAN이 아닌 사원의 사번, 이름, 직종을 출력하세요.
select empno, ename, job
from emp
where job != 'SALESMAN';

select empno, ename, job
from emp
where job <> 'SALESMAN';	-- <> : is not


-- 연봉이 3000이상인 사원의 사번, 이름, 급여, 연봉을 출력하세요.
select empno, ename, sal, sal*12 as '연봉'
from emp
where (sal*12) >=3000;

-- 직종이 salesman이고 급여가 2000이상인 사원의 사번, 이름, 급여, 직종을 출력하세요.
select * from emp
where job = 'SALESMAN' and sal >= 1500;

-- 직종이 salesman이거나 급여가 2000이상인 사원의 사번, 이름, 급여, 직종을 출력하세요.
select * from emp
where job = 'SALESMAN' or sal >= 1500;

-- 사원 테이블에서 급여가 1000달러 이상 3000달러 이하인 사원의 사번, 이름, 급여를 출력하세요.
select empno, ename, sal
from emp
where sal >= 1000 and sal<=3000;

/*	between A and B	: A,B를 포함한 사이값  */
select *
from emp
where sal between 1000 and 3000;

-- 사원 테이블에서 급여가 1000달러 초과 3000달러 미만인 사원의 사번, 이름, 급여를 출력하세요. 
select empno, ename, sal
from emp
where sal > 1000 and sal<3000;

-- 사원 테이블에서 사번이 7788, 7902, 7369인 사원의 사번의 이름을 출력하세요.
select empno, ename
from emp
where empno = 7788 or empno=7902 or empno=7369;

/*	in 연산자 : 다중 연산자  */
select empno, ename
from emp
where empno in (7788, 7902, 7369);

-- 사원 테이블에서 사번이 7788, 7902, 7369이 아닌 사원의 사번의 이름을 출력하세요.
select empno, ename
from emp
where empno not in (7788, 7902, 7369);


-- like 연산자 (패턴 : 문자열)
-- like 연산자를 도와주는 wild card
-- % : 모든 것 (아무것도 없는 경우도 포함)
-- _ : 한 문자 (얘를 이용하여 시작 위치 설정 가능)
-- [] : 안에 있는 문자중 하나
-- [^] : ^다음에 있는 문자 제외

-- 사원테이블에서 이름이 S로 시작하는 사원의 사번과 이름을 출력하세요.
select empno, ename
from emp
where ename like 'S%';

-- 이름의 두번재 글자가 A인 사원의 사번과 이름을 출력하세요.
select empno, ename
from emp
where ename like '_A%';

-- 이름에 T가 두번 들어있는 사원
select *
from emp
where ename like '%T%T%';

-- 이름의 첫 글자가 A, B, S 로 시작하는 사원정보
select *
from emp
where ename like '[ABS]%'

-- 이름의 첫 글자가 A or S 로 시작하고 두번째 글자가 C가 아닌 경우
select *
from emp
where ename like '[AS][^C]%'






--QUESTION
--1. 사원테이블에서 모든 데이터를 출력하라
select * from emp;

--2. 사원테이블에서 사원번호, 사원이름, 월급을 출력하라
select empno, ename, sal from emp;

--3. 사원테이블에서 월급을 뽑는데 중복된 데이터가 없게 출력하라
select distinct sal from emp;

--4. 사원테이블에서 사원이름과 월급을 출력하는데 각각의 컬럼명을
-- '이 름','월 급'으로 바꿔서 출력하라. 단, ALIAS에 공백추가
select empno as '이 름', sal as '월 급' from emp;

--5. 사원테이블에서 사원이름, 월급을 뽑고, 월급과 커미션을  더한 값을
-- 출력하는데 컬럼명을 '실급여'이라고 해서 출력하라.
-- 단, NULL값은 나타나지 않게 하라.
select ename, sal, sal+ isnull(comm, 0) as '실급여' from emp; 

--6. 사원테이블에서 'SCOTT'이라는 사원의 사원번호, 이름, 월급을 출력하라
select empno, ename, sal from emp where ename = 'SCOTT';

--7. 사원테이블에서 직위가 'SALESMAN'인 사원의 사원번호, 이름, 직위를
-- 출력하라
select empno, ename, job from emp where job = 'SALESMAN';


--8. 사원테이블에서 사원번호가 7499, 7521, 7654인 사원의 사원번호, 이름
-- 월급을 출력하라
select empno, ename, sal from emp where empno in (7499, 7521, 7654)

--9. 사원테이블에서 월급이 1500에서 3000사이인 사원의 사원번호, 이름,
-- 월급을 출력하라.
select empno, ename, sal from emp where sal between 1500 and 3000;

--10. 사원테이블에서 이름의 첫글자가 A이고 마지막 글자가 N이 아닌 사원의
-- 이름을 출력하라
select ename from emp where ename like 'A%[^N]';



create table Tlike(
	col1 int,
	col2 varchar(10) -- 10byte : 한글 5자/영,특수문자,공백 10자
)
go	-- 앞에 문장이 문제가 없으면 밑의 문장으로 가라.
insert into Tlike(col1, col2) values(10, '10')
insert into Tlike(col1, col2) values(20, '10%')
insert into Tlike(col1, col2) values(30, '20')

select * from Tlike

select * from Tlike where col2 like '%10%%'

-- '10%' 검색하기
select * from Tlike where col2 like '%10E%%' ESCAPE 'E'	-- c#에서 \특수문자 => E특수문자	 ESCAPE 'E' : E 뒤의 문자 데이터로 인식

-- 사원테이블에서 커미션이 책정되어 있지 않은(받지 않는) 사원의 이름과 커미션을 출력하세요.
-- (단, comm > 인것 받는 것으로 인정)
-- null 조건은 is null / is not null 사용해야함.
select ename, comm from emp where comm is null

-- 수당을 받는 사원들은
select * from emp where comm is not null


-- <함수>
-- 문자함수, 숫자함수, 날짜함수, 계산함수, 시스템 함수 ...

/*** 1. 문자함수 ***/
select lower('ABC')	-- 대문자 -> 소문자
select upper('abc')	-- 소문자 -> 대문자
select upper(ename) as 'ename' from emp

select ename + 'is a' + job from emp	-- + 가 연산도 하지만 결합도 함(문자열일 경우)

select substring('abcd', 1,3)	-- 시작(1)부터 (3)개 (1 포함)
select substring('abcd', 3,1)
select LEFT('abcd', 3)	--왼쪽에서부터 3개
select RIGHT('abcd',3)	-- 오른쪽에서부터 3개

select len('abcd')	-- 문자열 길이 리턴
select len('a     b')
select len('     a')
select len('a     ')	-- 1이 출력됨. 즉, len함수는 후행 공백값을 인지 X

select datalength('abc')	-- datalength는 byte개수 리턴
select datalength('홍길동')

-- 사원테이블에서 사원의 이름에서 첫 글자는 대문자로 나머지는 소문자로 출력하세요.
select upper(left(ename, 1)) + lower(substring(ename, 2, len(ename))) as 'ename' from emp;


-- 공백 제거
select '>'+'     a'+'<'
select '>'+ltrim('     a')+'<'	-- 왼쪽 공백 제거
select '>'+rtrim('a     ')+'<'	-- 오른쪽 공백 제거
select '>'+rtrim(ltrim('  a  '))+'<'	-- 양쪽 공백 제거


-- replace
select replace('abcd', 'a', 'NEWNEW')	-- abcd에서 a를 찾아 NEWNEW로 대체

-- 데이터 사이사이의 공백 제거
select '>'+'홍      길      동'+'<'
select replace('홍      길      동', ' ', '')



/*** 2. 숫자 함수 ***/

-- 반올림 함수
select round(123.45, 1)	-- 123.50	반올림하여 소수점 첫번째 자리까지 나타냄
select round(123.45, 2)	-- 123.45	반올림하여 소수점 두번째 자리까지 나타냄
select round(123.45, 0)	-- 123.00	반올림하여 소수점 0번째 자리까지 나타냄(정수)

select power(2,4)	-- 2^4

-- CEILING : 지정된 숫자보다 큰 최소 정수를 반환하여 출력
select CEILING(1234.5678), CEILING(123.45), CEILING(-1234.56)

-- FLOOR : 지정된 숫자보다 작은 최대 정수를 반환하여 출력
select FLOOR(1234.5678), FLOOR(123.45), FLOOR(-1234.56)



/*** 3. 날짜 함수 ***/
select getdate()	-- 참고. oracle : select sysdate()

-- 날짜 더하기
select dateadd(yy,10,getdate())
select dateadd(dd,100,getdate())
select dateadd(mm, 5, getdate())
select dateadd(yy, 10, '2022-01-01')

-- 날짜 빼기
select datediff(yy, '2010-12-12', '2022-1-13')
select datediff(mm, '2010-12-12', '2022-1-13')
select datediff(dd, '2010-12-12', '2022-1-13')

-- 사원이 근무한지 얼마나 됐나요?
-- 단, 조건이 월은 30일까지
select ename,
	DATEDIFF(dd, hiredate, GETDATE()) / 365 as '년',
	(DATEDIFF(dd, hiredate, GETDATE()) % 365)/30 as '개월',
	(DATEDIFF(dd, hiredate, GETDATE()) % 365) % 30 as '일'
from emp

-- 오늘부터 연말 12-31까지 며칠 남았나요?
select DATEDIFF(dd, getdate(), '2022-12-31')


select year(GETDATE())	-- 년만 출력
select month(GETDATE())	-- 월만 출력
select day(GETDATE())	-- 일만 출력


-- 문자, 숫자, 날짜 함수 기본적인 사용...

/******* 4. 형변환 함수 *******매우중요!!*/ 
select CONVERT(int, '100')+100	-- 문자 -> 숫자
select CONVERT(int, '100A')+100	-- error!!! varchar 값 '100A'을(를) 데이터 형식 int(으)로 변환하지 못했습니다.
select CONVERT(varchar(20), sal) + '급여입니다' from emp		-- 숫자 -> 문자

select ename + ' 의 사번은 '+ Convert(varchar(20),empno) + '입니다.' as 'fullname' from emp



/*** 5. 집계함수 ***/
-- sum(), avg(), max(), min(), count()
select sum(sal) from emp
select avg(sal) from emp
select max(sal) from emp
select min(sal) from emp
select count(sal) from emp


-- <집계함수의 특징 (외우기)>
-- 1) 집계함수는 null 값을 무시한다. (단, count(*) 제외)
-- 2) select 절에 집계함수 외에 다른 컬럼이 오면 반드시 그 컬럼은 group by 절에 명시되어야 한다.

select comm from emp
select count(comm) from emp	-- count()는 null을 무시함.
select comm from emp where comm is not null

-- comm 평균
select avg(comm) from emp	-- 721	우리 회사는 받는 사원수 기준... 집계함수는 null 무시
select avg(isnull(comm, 0)) from emp	-- 309	우리 회사는 사원수를 기준...	null을 가진 사원도 count

-- 집계함수의 결과는 1건이다.
select avg(sal),  sum(sal), max(sal), min(sal), count(sal) from emp

select deptno, sum(sal) from emp;	-- error!! 열 'emp.DEPTNO'이(가) 집계 함수나 GROUP BY 절에 없으므로 SELECT 목록에서 사용할 수 없습니다.

-- select 절에 집계함수 외에 다른 컬럼이 오면 반드시 그 컬럼은 group by 절에 명시되어야 한다.
select deptno, sum(sal) from emp group by deptno	-- deptno로 그룹을 묶음
select deptno, avg(sal),  sum(sal), max(sal), min(sal), count(sal) from emp group by deptno

select deptno, job, avg(sal) from emp group by deptno, job	-- depto -> job 순서로 묶음

-- order by : 정렬
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

-- 직종별 평균월급을 구하되 컬럼 가명칭은 '평균', 평균월급이 높은 순으로 데이터를 정렬하세요.
select job, avg(sal) as '평균' from emp group by job order by 평균 desc	-- order by 보다 select가 먼저 실행되므로 alias 사용 가능

-- Top n 쿼리 : 맨 위에서 n개 : mssql 만이 가지고 있는 기능
-- 사원 테이블에서 월급을 가장 많이 받는 사원 5명의 이름과 급여를 출력하라.
select top 5 ename, sal from emp order by sal desc
select top 2 with ties ename, sal from emp order by sal desc	-- 동률 처리하기
select top 50 percent ename, sal from emp order by sal desc
select ename, sal from emp order by sal desc


-- from 절의 조건절은 where 절
-- group by의 조건절은 having 절

/*
select		-5
from		-1
where		-2
group by	-3
having		-4
order by	-6
*/

-- 직업별 총월급을 구하고 총월급이 5000이상인 모든 사원 데이터를 출력하세요.
select job, sum(sal) as 'sumsal' from emp where deptno != 10 group by job having sum(sal) >= 5000 order by sumsal desc

-- 부서별 월급의 합을 구하고 그 총합이 10000이상인 사원 데이터를 출력하세요.
select deptno, sum(sal) from emp group by deptno having sum(sal) >= 10000

-- 부서별 총월급을 구하되 30번 부서를 제외하고,
-- 그 총월급이 8000달러 이상인 부서만 나오게 하고,
-- 총 월급이 높은 순으로 출력하라.
select deptno, sum(sal) as '총월급' from emp where deptno != 30 group by deptno having sum(sal) >= 8000 order by 총월급 desc


-- 부서별 평균 월급을 구하되 커미션이 책정된 사원만 가져오고,
-- 그 평균월급이 2000달러 이상인 부서만 나오게 하고,
-- 평균월급이 높은 순으로 출력하라
select deptno, avg(sal) as '평균월급' from emp where comm is not null group by deptno having avg(sal) >= 2000 order by 평균월급 desc





--QUESTION
--1. 사원 테이블에서 사원이름을 첫글자는 대문자로, 나머지는 소문자로 출력하라
select upper(left(ename,1))+lower(substring(ename, 2, len(ename))) from emp

--2. 사원테이블에서 사원이름을 뽑고 또 이름의 두번째 글자부터 네번째 글자까지
-- 출력하라.
select ename, SUBSTRING(ename,2,3) from emp

--3. 사원테이블의 사원 이름의 철자 개수를 출력하라.
select len(ename) from emp

--4. 사원테이블에서 사원 이름의 앞 글자 하나와 마지막 글자 하나만 출력하되 
-- 모두 소문자로 각각 출력하라.
select LOWER(left(ename,1)) as '앞글자', LOWER(RIGHT(ename,1)) as '마지막글자' from emp

--5. 3456.78의 소수점 첫번째 자리에서 반올림하라.
select ROUND(3456.78,0)

--6. 3의 4제곱을 구하고, 64의 제곱근을 구하라. => 안해도됨.

--7. 오늘날짜와 오늘날짜에서 10일을 더한 날짜를 출력하라.
select GETDATE() as '오늘', dateadd(dd,10,getdate()) as '10일후'
--or
select getdate(), getdate()+10

--8. 국제 표준으로 현재 날짜를 출력하라. => 하지말기

--9. 사원테이블에서 사원이름과 사원들의 오늘 날짜까지의 근무일수를 구하라.
select ename, DATEDIFF(dd, hiredate, GETDATE()) as '근무일수' from emp

--10. 위 문제에서 근무일수를 00년 00개월 00일 근무하였는지
--확인할 수 있도록 변환하라.(단, 한 달을 30일로 계산하라)
-- 예)
--  | ENAME	| 근무일수		|
--  | KING		| 00년 00개월 00일	|
select ename as 'ENAME', Convert(varchar(20),DATEDIFF(dd, hiredate, GETDATE())/365) +'년'+ Convert(varchar(20),(DATEDIFF(dd, hiredate, GETDATE())%365)/30) + '개월'+ Convert(varchar(20),(DATEDIFF(dd, hiredate, GETDATE())%365)%30) + '일' as '근무일수'
from emp




--QUESTION
--1. 사원테이블에서 부서별 최대 월급을 출력하라.
select deptno, max(sal) 최대월급 from emp group by deptno

--2. 사원테이블에서 직위별 최소 월급을 구하되 직위가 
-- CLERK인 것만 출력하라.
select job, min(sal) 최소월급 from emp where job = 'CLERK' group by job

--3. 커미션이 책정된 사원은 모두 몇 명인가?
select count(comm) from emp

--4. 직위가 'SALESMAN'이고 월급이 1000이상인 사원의
-- 이름과 월급을 출력하라.
select ename, sal from emp where job = 'SALESMAN' and sal >= 1000

--5. 부서별 평균월급을 출력하되, 평균월급이 2000보다
-- 큰 부서의 부서번호와 평균월급을 출력하라.
select deptno, avg(sal) 평균월급 from emp group by deptno having avg(sal)>2000

--6. 사원테이블에서 커미션을 가장 많이 받는 사원 2명을
-- 출력하되 랭킹이 중복될 경우 동률처리를 하여 출력하라.
select top 2 with ties ename, comm from emp order by comm desc

--7. 직위가 MANAGER인 사원을 뽑는데 월급이 높은 사람
-- 순으로 이름, 직위, 월급을 출력하라.
select ename, job, sal from emp where job = 'MANAGER' order by sal desc

--8. 각 직위별로 총월급을 출력하되 월급이 낮은 순으로
-- 출력하라.
select job, sum(sal) 총월급 from emp group by job order by 총월급

--9. 직위별 총월급을 출력하되, 직위가 'MANAGER'인
-- 사원들은 제외하라. 그리고 그 총월급이 5000보다 
-- 큰 직위와 총월급만 출력하라.
select job, sum(sal) 총월급 from emp where job != 'MANAGER' group by job having sum(sal)>5000

--10. 직위별 최대월급을 출력하되, 직위가 'CLERK'인 
-- 사원들은 제외하라. 그리고 그 최대월급이 2000 이상인
-- 직위와 최대월급을 최대 월급이 높은 순으로 정렬하여 
-- 출력하라.
select job, max(sal) 최대월급 from emp where job != 'CLERK' group by job having max(sal)>=2000 order by 최대월급 desc





/******************* JOIN *******************/
-- 조인 실습 테이블 만들기
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

-- # 조인 : 한 개 이상의 테이블에서 데이터를 가져오는 방법
-- <종류>
-- 1. inner join
-- 2. cross join
-- 3. outer join
-- 4. self join
-- 5. nonequal join

-- <표현법>
-- 각 벤더 (oracle, mysql, mssql) 문법이 존재
-- 표준문법 : ansi 문법 ^^

-- !! null끼리는 join (X)

/*** 1. inner join ***/
-- 각 테이블의 조인컬럼(공통컬럼)을 비교하여 조인조건을 만족하는 레코드만 선택
-- 1:1 맵핑 ... 옆으로 붙이는 것...

-- SQL 문법 -> 바람직하지 X
select * from m, s where m1=s1

select m1, m2, s2
from m, s
where m1=s1

-- ANSI 문법 -> 이거 사용!
select * from m inner join s on m1=s1	-- on은 join의 조건절
select m.M1, m.M2, s.S1, s.S2 from m inner join s on m.M1=s.S1	-- 가장 좋은 표현법

-- 사원테이블에서 사번, 이름, 부서번호, 부서이름을 출력하세요.
select * from emp
select * from dept

select emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
from emp inner join dept
on emp.DEPTNO = dept.DEPTNO

-- join의 default : inner join
-- alias 붙이면 편함
select e.EMPNO, e.ENAME, e.DEPTNO, d.DNAME
from emp e  join dept d	-- inner join
on e.DEPTNO = d.DEPTNO



/*** 2. cross join (거의 안쓰는 조인) ***/
-- 조건이 없는 조인. 모든 확률을 다 뽑는 것.
select * from m,s

-- ANSI
select * from m cross join s



/*** 3. outer join ***/
-- 조인에 만족하지 않는 데이터가 생성
-- 내부적으로 inner join을 선행하고, 주종관계를 파악해서 남는 데이터를 가져오는 방법
-- 주종관계 : left, right 으로 파악
select * 
from m left outer join s	-- m을 기준으로 남는 데이터 가져옴
on m.m1 = s.s1

select * 
from m right outer join s	-- s를 기준으로 남는 데이터 가져옴
on m.m1 = s.s1

-- full outer join
select *
from m full outer join s	-- left join과 right join의 union(합집합)
on m.M1=s.S1



-------------------- union (합집합) ---------------------------

-- 1. 대응되는 컬럼의 수가 일치하여야 한다.
-- 2. 대응되는 컬럼의 자료형(타입) 일치
-- data를 밑으로 붙임.
-- 첫번째 테이블 밑에 두번째 테이블이 붙여짐.

select empno, ename from emp
union
select deptno, dname from dept

-- error!! 대응되는 컬럼의 수가 일치 X이기 때문...
select empno, ename, job from emp
union
select deptno, dname from dept

-- null 로 해결!
select empno, ename, job from emp
union
select deptno, dname, null from dept

-- error!! 대응되는 컬럼의 타입이 일치해야함...
select ename, empno from emp	-- ename은 varchar
union
select deptno, dname from dept	-- deptno는 int

select * from emp
union				-- union : 기본적으로 중복제거
select * from emp

select * from emp
union all			-- union all : 중복제거 X
select * from emp

--------------------------------------------------------------

/*** 4. self join ***/
-- 자신의 특정 컬럼이 자신의 특정 컬럼을 참조
-- 한 개의 테이블을 2개 처럼 사용

--  사번, 이름, 관리자사번, 관리자 이름을 출력하세요.
select e.EMPNO, e.ENAME, m.EMPNO, m.ENAME
from emp e inner join emp m	-- 가명칭을 통해 하나의 테이블을 2개처럼 사용
on e.MGR=m.EMPNO
-- 문제 발생 : 사원은 14명인데 현재 데이터는 13명
-- null이 join의 대상이 아니어서 생기는 문제
-- [outer join]을 통해 문제해결!
select e.EMPNO, e.ENAME, m.EMPNO, m.ENAME
from emp e left outer join emp m	-- 가명칭을 통해 하나의 테이블을 2개처럼 사용
on e.MGR=m.EMPNO



/*** 5. nonequal join ***/
-- join의 원칙은 1:1 맵핑
-- 동등한 컬럼이 없을 때는 nonequal을 사용하여 여러 개의 컬럼을 맵핑

-- between과 inner join 사용...
select e.EMPNO, e.ENAME, e.SAL, s.GRADE
from emp e inner join SALGRADE s
on e.SAL between s.LOSAL and s.HISAL


/*********** 테이블 2, 3, 4개 조인하기 **************/

-- 3개 테이블 조인하기
select m.m1, m.m2, s.s2, x.x2
from m join s on m.m1 = s.s1
	   join x on s.s1 = x.x1

