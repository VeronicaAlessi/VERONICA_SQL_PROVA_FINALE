-- creazione del database 
create database Prova_Finale_Database;
use Prova_Finale_Database;

-- creazione delle tabelle con vincoli della primary key e foreign key

-- drop table Product;
create table Product(
JoyID int primary key
, JoyName varchar(50)
, UnitePrice decimal (5,2));


create Table Category(
CategoryID int primary Key
,JoyID int
, Category varchar(50)
,constraint FK_Category_Product foreign key (JoyID)
references Product (JoyID));


-- drop table Region;
create table Region(
RegionID varchar(10) primary key
, Country varchar(50)
, Region varchar(50));

create table Address(
AddressLine varchar(100)
, Cap int
, Province char(5)
, RegionID varchar(10)
, constraint FK_Address_Region foreign key (RegionID)
references Region (RegionID));

-- drop table Sales;
create table  Sales(
TransactionID int primary key
, JoyID int
, DateTransaction date
, RegionID varchar(10)
, Quantity int
, SalesAmount decimal (10,2)
, constraint FK_Sales_Product foreign key (JoyID)
references Product (JoyID)
, constraint FK_Sales_Region foreign key (RegionID)
references Region (RegionID));

-- popolazione delle tabelle precedentemente create

insert into Product values
(84,'Cubo Rubik','8.50')
,(85,'Labirinto25','36.80')
,(89,'La Ghigliottina','32.75')
,(90,'Rompicapo','13.70');

insert into Region values
('N45','NorhEurope','Norvergia')
,('N46','NorhEurope','Svezia')
,('N47','NorhEurope','Islanda')
,('W54','WestEurope','Francia') 
,('W55','WestEurope','Germania')
,('W56','WestEurope','Regno Unito')
,('E74','EastEurope','Albania')
,('E75','EastEurope','Armenia')
,('S47','SouthEurope','Italia')
,('S48','SouthEurope','Grecia');

insert into Sales values
(1056003, 89, '2014-07-25', 'N47', 3, 98.25),
(1056004, 90, '2014-07-25', 'W55', 9, 123.30),
(1056005, 85, '2014-07-25', 'N47', 13, 478.40),
(1056006, 90, '2014-07-26', 'S47', 72, 1233.00),
(1056007, 85, '2025-03-27', 'E75', 2, 73.60);

INSERT INTO Address VALUES
('Via Roma 12',0184,'RM','N45'),
('Corso Milano 45',20122,'MI', 'W54'),
('Via Napoli 78',80133,'NA','S47'),
('Via Firenze 5',50123,'FI','E74'),
('Piazza Torino 3',10121,'TO','N47');
 
insert into category values
(14084,84,'Cubo di Rubik')
,(15085,85,'Da tavola')
,(15089,89,'Da tavola')
,(16090,90,'Logica');






