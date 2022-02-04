create database Library_task1
use  Library_task1
create table Author(
Id int primary key identity,
Name nvarchar(35),
Surname nvarchar(45)

)
insert into Author
values('Paul','Auster'),
('Vladimir','Nobakov'),
('Haruki','Murakami'),
('Fyodr','Dostoyevski'),
('Dino','Buzzati')
create table Books(
Id int primary key identity,
Name nvarchar(100) check(len(Name)>2),
PageCount int check(PageCount>=10),
AuthorId int foreign key references Author(Id)
)
insert into Books
values('Tatar Colu',250,5),
('Sahilde Kafka',150,3),
('1Q84',450,3),
('Goz',200,2),
('Brooklyn Cilginliklari',330,1),
('New York Uclemesi',250,1),
('Idiot',500,4)

select b.Id, b.Name, b.PageCount, a.Name+ '' +a.Surname as AuthorFullname from Books b
join Author a
on b.AuthorId=a.Id
 create view vw_AuthorandBooks
 as
 select* from (select b.Id, b.Name, b.PageCount, a.Name+ '' +a.Surname as AuthorFullname from Books b
join Author a
on b.AuthorId=a.Id) as AuthorandBooks


create procedure usp_selectbookswithAuthorName
@AuthorFullname nvarchar(50)
as
select * from vw_AuthorandBooks
where AuthorFullname=@AuthorFullname
exec usp_selectbookswithAuthorName DinoBuzzati

create procedure usp_deleteSurname
@Id int
as
delete from Author
where @Id=Id
exec usp_deleteSurname @Id=3
drop procedure usp_deleteSurname

create procedure usp_deleteSurname
@Surname nvarchar(45)
as delete from Author
where Surname=@Surname
exec usp_deleteSurname DinoBuzzati

create procedure usp_addSurname
@Surname nvarchar(45)
as 
insert into Author(Surname)
values(@Surname)
exec usp_addSurname Surname

create procedure usp_adddata

@Name nvarchar(35),
@Surname nvarchar(45)
as
insert into Author(Name,Surname)
values (@Name,@Surname)
exec usp_adddata 'Yasunari','Kavabata'
drop procedure usp_adddata

create procedure usp_deletedata
@Id int,
@Name nvarchar(35),
@Surname nvarchar(45)
as
delete from Author
where Id=@Id
exec usp_deletedata 6,Yasunari,Kavabata

create procedure usp_updatedata
@Surname nvarchar(45),
@Id int
as
update Author
set Surname=@Surname
where Id=@Id
drop procedure usp_updatedata

exec usp_updatedata @Id=7 ,@Surname=Kawabata

select a.Id, (a.Name + ' ' + a.Surname) as Author,Count(b.Name) as BooksCount, Max(b.PageCount) as MaxPageCount from Books b
join Author a
on a.Id=b.AuthorId
group by a.Id,a.Name,a.Surname

create view vw_AuthorBooks
as
select* from (select a.Id, (a.Name + ' ' + a.Surname) as Author,Count(b.Name) as BooksCount, Max(b.PageCount) as MaxPageCount from Books b
join Author a
on a.Id=b.AuthorId
group by a.Id,a.Name,a.Surname) as AuthorBooks

