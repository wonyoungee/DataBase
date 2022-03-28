/******************** Trigger ***********************/

use KosaDB

create table Oops
(
   Message varchar(100) default 'dept ���̺� �����Ͱ� �ԷµǾ����ϴ�.'
)

select * from Oops


/*** Ʈ���� �ۼ� ***/
--dept���̺� insert�۾��� �Ͼ�� Oops ���̺� default���� �ڵ����� insert�ϴ� Ʈ����
create trigger dept_insert
on dept
for insert
as
   insert into Oops default values

/*** Ʈ���� ���� ***/
insert into dept(DEPTNO, DNAME, LOC) values(50,'it','seoul')

-- Ʈ���� ���� Ȯ��
select * from Oops
select * from dept


-- �����̺��� as �� ���̺���� insert�Ǵ� ������ �ϳ��� Ʈ�����.
-- ���� �����ϸ� rollback
-- Ʈ���Ŵ� ª�� �Ŵ� ���� ����.


/*** Ʈ���� ���� ***/
alter trigger dept_insert
on dept
for insert, delete, update         -- INSERT�Ӹ� �ƴ϶�, UPDATE, DELETE�Ǿ��� ���� ���� �۾��� �Ͼ���� ����
as
   insert into Oops default values

-- insert��
insert into dept 
values(60, 'Internet','Pusan')

-- update��
update dept
set loc='Daegu'
where deptno=60

-- delete��
delete from dept
where deptno in(50,60)


/*** Ʈ���� ��Ȱ��ȭ ***/
alter table dept             --DEPT ���̺� ���ӵǾ� �ִ� Ʈ���Ÿ�
disable trigger dept_insert   --�Ͻ������� ������Ų��.

insert into dept
values(50, 'marketing', 'seoul')

select * from dept                          
select * from Oops    


/*** Ʈ���� Ȱ��ȭ ***/
alter table dept            -- DEPT ���̺� ���ӵǾ� �ִ� Ʈ���Ÿ�
enable trigger dept_insert   -- �ٽ� Ȱ��ȭ��Ų��.

insert into dept
values(60, 'marketing', 'seoul')

select * from dept     --�������̺� DML�۾��� ����
select * from Oops      -- Oops ���̺� insert �۾� �ٽ� �簳


/*** Ʈ���� ���� ***/
drop trigger dept_insert



/*** INSERTED, DELETED ���̺� ***/
-- Trigger�� ���ӵ� ���̺��� ���� �߰��ǰų�(insert��) ���ŵ�(delete��) ���ڵ�� �����Ǵ� ������ �ӽ� ���̺�ν� �޸𸮿� ����Ǿ� �ִ�.
create table test1
(num int, note varchar(100))

create table test2
(num int, note varchar(100))


create trigger tri1      -- test1�̶�� ���̺��� insert �̺�Ʈ�� �߻����� ��
on test1                 -- as ������ ������ �����ų trigger tri1�� �ۼ��ϰڴ�.
for insert
as
   insert into test2(num, note)        -- inserted ���̺� �ִ� ���ڵ带 �����ٰ�
   select num, note from inserted      -- test2�� insert�ϰڴ�. (�������̺�)

insert into test1 values(1, '�Է¿Ϸ�')
insert into test1 values(2, '�Է¿Ϸ�')
insert into test1 values(3, '�Է¿Ϸ�')

select * from test1       -- test1 ���̺� �����͸� �Է��Ͽ��� ��
select * from test2       -- test2 ���̺��� ���� �����Ͱ� �Էµ�.



-- test1 ���̺��� �����Ͱ� �����Ǿ��� �� test2 ���̺����� ���� �����Ͱ� �����ǵ��� �ϴ� trigger
create trigger tri2
on test1
for delete
as 
  delete from test2
  where num in(select num from deleted) -- deleted��� �������̺� ���

delete from test1
where num=2

select * from test1       -- test1 ���̺� �����͸� �����Ͽ��� ��
select * from test2       -- test2 ���̺��� ���� �����Ͱ� ������.



-- test1 ���̺��� �����Ͱ� ������Ʈ�Ǿ��� ��, test2���� ���� �����ͷ� ������Ʈ�ǵ��� �ϴ� trigger
create trigger tri3
on test1
for update
as
  if update(note)                            -- note �÷��� update �Ǿ��� ���
  begin
      update test2                           -- Join�� ���� num�� ��ġ�ϴ� ��츸
           set test2.note=inserted.note      -- note�� ������Ʈ
           from test2, inserted
           where test2.num=inserted.num
  end
  else if update(num)                       -- num �÷��� update �Ǿ��� ���
  begin
      update test2                          -- Join�� ���� note�� ��ġ�ϴ� ��츸
           set test2.num=inserted.num       -- num�� ������Ʈ
           from test2, inserted
           where test2.note=inserted.note
  end
go

update test1
set note='������Ʈ �Ϸ�'
where num=3

select * from test1
select * from test2

update test1
set num=4
where note= '������Ʈ �Ϸ�'

select * from test1
select * from test2


/*** Trigger�� Nesting ***/
-- ������ �����ҿ� ���Ի���� �Ի� ���� ���, 
-- �̱������� �λ����̺�� ���ﺻ���� �λ����̺� �� ����� ���� ���ڵ尡 �ڵ����� �Էµǵ��� Trigger�� �ۼ�
create table ������_�λ�
(
  �����ȣ int constraint PK_emp06 primary key,
  �̸� varchar(20) not null,
  �ֹε�Ϲ�ȣ char(13) constraint UK_emp06 unique,
  �Ի��� datetime not null,
  ���� money not null,
  �μ���ȣ int not null
)

create table �̱�_�λ�
(
  �����ȣ int constraint PK_emp03 primary key,
  �̸� varchar(20) not null,
  �ֹε�Ϲ�ȣ char(13) constraint UK_emp03 unique,
  �Ի��� datetime not null,
  ���� money not null,
  �μ���ȣ int not null
)

create table ����_�λ�
(
  �����ȣ int constraint PK_emp01 primary key,
  �̸� varchar(20) not null,
  �ֹε�Ϲ�ȣ char(13) constraint UK_emp01 unique,
  �Ի��� datetime not null,
  ���� money not null,
  �μ���ȣ int not null
)

create trigger ������_insert
on ������_�λ�
for insert
as
   insert into �̱�_�λ�(�����ȣ,�̸�,�ֹε�Ϲ�ȣ,�Ի���,����,�μ���ȣ)
   select * from inserted

create trigger �̱�_insert
on �̱�_�λ�
for insert
as
   insert into ����_�λ�(�����ȣ,�̸�,�ֹε�Ϲ�ȣ,�Ի���,����,�μ���ȣ)
   select * from inserted

select * from ������_�λ�
select * from �̱�_�λ�
select * from ����_�λ�

insert into ������_�λ�
values(111, 'ȫ�浿', '7001011721618',getdate(), 2000, 10)

insert into ������_�λ�
values(112, '�Ӳ���', '7010011721514',getdate(), 2000, 10)

select * from ������_�λ�
select * from �̱�_�λ�
select * from ����_�λ�

insert into �̱�_�λ�
values(113, '������', '7003041721516',getdate(), 2000, 10)

select * from ������_�λ�
select * from �̱�_�λ�
select * from ����_�λ�


-- ���� ������ �������� DELETE, UPDATE�Ǿ��� ��, Nesting Fire�� �ǵ��� Trigger�� ���� �ۼ��Ͽ���.
create trigger ������_delete
on ������_�λ�
for delete
as
  delete from �̱�_�λ�
  where �����ȣ = (select �����ȣ from deleted) -- deleted��� �������̺� ���

create trigger �̱�_delete
on �̱�_�λ�
for insert
as
   delete from ����_�λ�
   where �����ȣ = (select �����ȣ from deleted)

delete from ������_�λ�
where �����ȣ=111

select * from ������_�λ�
select * from �̱�_�λ�
select * from ����_�λ�




-- update
create trigger ������_update
on ������_�λ�
for update
as
  if update(����)
  begin
      update �̱�_�λ� 
           set �̱�_�λ�.����=inserted.����
           from �̱�_�λ�, inserted
           where �̱�_�λ�.�����ȣ=inserted.�����ȣ
  end
  else if update(�μ���ȣ) 
  begin
      update �̱�_�λ�                     
           set �̱�_�λ�.�μ���ȣ=inserted.�μ���ȣ    
           from �̱�_�λ�, inserted
           where �̱�_�λ�.�����ȣ=inserted.�����ȣ
  end


 create trigger �̱�_update
on �̱�_�λ�
for update
as
  if update(����)
  begin
      update ����_�λ� 
           set ����_�λ�.����=inserted.����
           from ����_�λ�, inserted
           where ����_�λ�.�����ȣ=inserted.�����ȣ
  end
  else if update(�μ���ȣ) 
  begin
      update ����_�λ�                     
           set ����_�λ�.�μ���ȣ=inserted.�μ���ȣ    
           from ����_�λ�, inserted
           where ����_�λ�.�����ȣ=inserted.�����ȣ
  end


update ������_�λ�
set �μ���ȣ=100
where �����ȣ =112

select * from ������_�λ�
select * from �̱�_�λ�
select * from ����_�λ�



/*********************** INDEX ***********************/
-- �����͸� ���� ã�� ���� ����

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
-- ���� �б� 1 : �� ���� �ϳ��� page�ȿ� 100���� �����Ͱ� �� ����ִٴ� ��.


SET STATISTICS IO ON
SELECT * FROM test1 WHERE col1 = 10
SET STATISTICS IO OFF


-- �ε��� ���� ���� (�� ����)
CREATE INDEX idx_test1_01 ON test1(col1)
GO

SET STATISTICS IO ON
SELECT * FROM test1
SET STATISTICS IO OFF
-- ���� �б� 1 : �� ���� �ϳ��� page�ȿ� 100���� �����Ͱ� �� ����ִٴ� ��.
-- ��ó�� �����;��� �������� �ε����� �ʿ� X

SET STATISTICS IO ON
SELECT * FROM test1 WHERE col1 = 10
SET STATISTICS IO OFF


-- �����;� �ø���
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
-- ���� �б� 24

SELECT * FROM TestIndex_01 WHERE col1 < 100
SELECT * FROM TestIndex_01 WHERE col1 < 10
SELECT * FROM TestIndex_01 WHERE col1 = 100


