/******************** Trigger ***********************/

use KosaDB

create table Oops
(
   Message varchar(100) default 'dept 테이블에 데이터가 입력되었습니다.'
)

select * from Oops


/*** 트리거 작성 ***/
--dept테이블에 insert작업이 일어나면 Oops 테이블에 default값을 자동으로 insert하는 트리거
create trigger dept_insert
on dept
for insert
as
   insert into Oops default values

/*** 트리거 실행 ***/
insert into dept(DEPTNO, DNAME, LOC) values(50,'it','seoul')

-- 트리거 적용 확인
select * from Oops
select * from dept


-- 원테이블에서 as 뒤 테이블까지 insert되는 과정이 하나의 트랜잭션.
-- 따라서 실패하면 rollback
-- 트리거는 짧게 거는 것이 좋음.


/*** 트리거 수정 ***/
alter trigger dept_insert
on dept
for insert, delete, update         -- INSERT뿐만 아니라, UPDATE, DELETE되었을 때도 같은 작업이 일어나도록 수정
as
   insert into Oops default values

-- insert시
insert into dept 
values(60, 'Internet','Pusan')

-- update시
update dept
set loc='Daegu'
where deptno=60

-- delete시
delete from dept
where deptno in(50,60)


/*** 트리거 비활성화 ***/
alter table dept             --DEPT 테이블에 종속되어 있는 트리거를
disable trigger dept_insert   --일시적으로 중지시킨다.

insert into dept
values(50, 'marketing', 'seoul')

select * from dept                          
select * from Oops    


/*** 트리거 활성화 ***/
alter table dept            -- DEPT 테이블에 종속되어 있는 트리거를
enable trigger dept_insert   -- 다시 활성화시킨다.

insert into dept
values(60, 'marketing', 'seoul')

select * from dept     --종속테이블에 DML작업을 수행
select * from Oops      -- Oops 테이블에 insert 작업 다시 재개


/*** 트리거 삭제 ***/
drop trigger dept_insert



/*** INSERTED, DELETED 테이블 ***/
-- Trigger가 종속된 테이블에서 새로 추가되거나(insert된) 제거된(delete된) 레코드로 구성되는 일종의 임시 테이블로써 메모리에 저장되어 있다.
create table test1
(num int, note varchar(100))

create table test2
(num int, note varchar(100))


create trigger tri1      -- test1이라는 테이블에서 insert 이벤트가 발생했을 때
on test1                 -- as 이하의 구문을 실행시킬 trigger tri1을 작성하겠다.
for insert
as
   insert into test2(num, note)        -- inserted 테이블에 있는 레코드를 가져다가
   select num, note from inserted      -- test2에 insert하겠다. (가상테이블)

insert into test1 values(1, '입력완료')
insert into test1 values(2, '입력완료')
insert into test1 values(3, '입력완료')

select * from test1       -- test1 테이블에 데이터를 입력하였을 때
select * from test2       -- test2 테이블에도 같은 데이터가 입력됨.



-- test1 테이블에서 데이터가 삭제되었을 때 test2 테이블에서도 같은 데이터가 삭제되도록 하는 trigger
create trigger tri2
on test1
for delete
as 
  delete from test2
  where num in(select num from deleted) -- deleted라는 가상테이블 사용

delete from test1
where num=2

select * from test1       -- test1 테이블에 데이터를 삭제하였을 때
select * from test2       -- test2 테이블에도 같은 데이터가 삭제됨.



-- test1 테이블에서 데이터가 업데이트되었을 때, test2에도 같은 데이터로 업데이트되도록 하는 trigger
create trigger tri3
on test1
for update
as
  if update(note)                            -- note 컬럼이 update 되었을 경우
  begin
      update test2                           -- Join을 통해 num이 일치하는 경우만
           set test2.note=inserted.note      -- note를 업데이트
           from test2, inserted
           where test2.num=inserted.num
  end
  else if update(num)                       -- num 컬럼이 update 되었을 경우
  begin
      update test2                          -- Join을 통해 note가 일치하는 경우만
           set test2.num=inserted.num       -- num을 업데이트
           from test2, inserted
           where test2.note=inserted.note
  end
go

update test1
set note='업데이트 완료'
where num=3

select * from test1
select * from test2

update test1
set num=4
where note= '업데이트 완료'

select * from test1
select * from test2


/*** Trigger의 Nesting ***/
-- 워싱턴 영업소에 신입사원이 입사 했을 경우, 
-- 미국지사의 인사테이블과 서울본사의 인사테이블에 이 사원에 대한 레코드가 자동으로 입력되도록 Trigger를 작성
create table 워싱턴_인사
(
  사원번호 int constraint PK_emp06 primary key,
  이름 varchar(20) not null,
  주민등록번호 char(13) constraint UK_emp06 unique,
  입사일 datetime not null,
  월급 money not null,
  부서번호 int not null
)

create table 미국_인사
(
  사원번호 int constraint PK_emp03 primary key,
  이름 varchar(20) not null,
  주민등록번호 char(13) constraint UK_emp03 unique,
  입사일 datetime not null,
  월급 money not null,
  부서번호 int not null
)

create table 본사_인사
(
  사원번호 int constraint PK_emp01 primary key,
  이름 varchar(20) not null,
  주민등록번호 char(13) constraint UK_emp01 unique,
  입사일 datetime not null,
  월급 money not null,
  부서번호 int not null
)

create trigger 워싱턴_insert
on 워싱턴_인사
for insert
as
   insert into 미국_인사(사원번호,이름,주민등록번호,입사일,월급,부서번호)
   select * from inserted

create trigger 미국_insert
on 미국_인사
for insert
as
   insert into 본사_인사(사원번호,이름,주민등록번호,입사일,월급,부서번호)
   select * from inserted

select * from 워싱턴_인사
select * from 미국_인사
select * from 본사_인사

insert into 워싱턴_인사
values(111, '홍길동', '7001011721618',getdate(), 2000, 10)

insert into 워싱턴_인사
values(112, '임꺽정', '7010011721514',getdate(), 2000, 10)

select * from 워싱턴_인사
select * from 미국_인사
select * from 본사_인사

insert into 미국_인사
values(113, '일지매', '7003041721516',getdate(), 2000, 10)

select * from 워싱턴_인사
select * from 미국_인사
select * from 본사_인사


-- 위의 예제를 바탕으로 DELETE, UPDATE되었을 때, Nesting Fire가 되도록 Trigger를 각각 작성하여라.
create trigger 워싱턴_delete
on 워싱턴_인사
for delete
as
  delete from 미국_인사
  where 사원번호 = (select 사원번호 from deleted) -- deleted라는 가상테이블 사용

create trigger 미국_delete
on 미국_인사
for insert
as
   delete from 본사_인사
   where 사원번호 = (select 사원번호 from deleted)

delete from 워싱턴_인사
where 사원번호=111

select * from 워싱턴_인사
select * from 미국_인사
select * from 본사_인사




-- update
create trigger 워싱턴_update
on 워싱턴_인사
for update
as
  if update(월급)
  begin
      update 미국_인사 
           set 미국_인사.월급=inserted.월급
           from 미국_인사, inserted
           where 미국_인사.사원번호=inserted.사원번호
  end
  else if update(부서번호) 
  begin
      update 미국_인사                     
           set 미국_인사.부서번호=inserted.부서번호    
           from 미국_인사, inserted
           where 미국_인사.사원번호=inserted.사원번호
  end


 create trigger 미국_update
on 미국_인사
for update
as
  if update(월급)
  begin
      update 본사_인사 
           set 본사_인사.월급=inserted.월급
           from 본사_인사, inserted
           where 본사_인사.사원번호=inserted.사원번호
  end
  else if update(부서번호) 
  begin
      update 본사_인사                     
           set 본사_인사.부서번호=inserted.부서번호    
           from 본사_인사, inserted
           where 본사_인사.사원번호=inserted.사원번호
  end


update 워싱턴_인사
set 부서번호=100
where 사원번호 =112

select * from 워싱턴_인사
select * from 미국_인사
select * from 본사_인사



/*********************** INDEX ***********************/
-- 데이터를 빨리 찾기 위한 수단

use pubs

sp_helpindex titles


use KosaDB

CREATE TABLE Test1
(
  col1 int,
  col2 char(10) NULL,
)
GO

DECLARE @num int
SET @num = 1
WHILE @num <= 100
BEGIN
INSERT INTO Test1 VALUES(@num, 'A' + CONVERT(char(10),@num))
SET @num = @num + 1
END

select * from test1
sp_helpindex test1


SET STATISTICS IO ON
SELECT * FROM test1
SET STATISTICS IO OFF
-- 논리적 읽기 1 : 이 논리는 하나의 page안에 100건의 데이터가 다 들어있다는 것.


SET STATISTICS IO ON
SELECT * FROM test1 WHERE col1 = 10
SET STATISTICS IO OFF


-- 인덱스 성능 좋대 (다 걸자)
CREATE INDEX idx_test1_01 ON test1(col1)
GO

SET STATISTICS IO ON
SELECT * FROM test1
SET STATISTICS IO OFF
-- 논리적 읽기 1 : 이 논리는 하나의 page안에 100건의 데이터가 다 들어있다는 것.
-- 이처럼 데이터양이 적을때는 인덱스가 필요 X

SET STATISTICS IO ON
SELECT * FROM test1 WHERE col1 = 10
SET STATISTICS IO OFF


-- 데이터양 늘리기
CREATE TABLE TestIndex_01
(
col1 int,
col2 char(05)
)
GO

DECLARE @num int
SET @num = 1
WHILE @num < 10001
BEGIN
INSERT INTO TestIndex_01 VALUES (@num,'AAAAA')
SET @num = @num + 1
END


CREATE NONCLUSTERED INDEX IDX01 ON TestIndex_01(col1)

SET STATISTICS IO ON
SELECT * FROM TestIndex_01
SET STATISTICS IO OFF
-- 논리적 읽기 24

SELECT * FROM TestIndex_01 WHERE col1 < 100
SELECT * FROM TestIndex_01 WHERE col1 < 10
SELECT * FROM TestIndex_01 WHERE col1 = 100


