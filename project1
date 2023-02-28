--create table nazwiska (Numer integer,Imie varchar(30),Nazwisko varchar(40),Stanowisko varchar(20),Pensja money,Miasto varchar(30),Primary key(Numer));
--insert into nazwiska values 
--(1,'Jan','Kowalski','urzędnik',2900,'Gdańsk'),
--(2,'Adam','Adamowski','kierownik',4500,'Sopot'),
--(3,'Marian','Malinowski','urzędnik',2300,'Gdynia'),
--(4,'Adam','Nowakowski','księgowy',2400,'Gdańsk'),
--(5,'Ewa','Musiał','stażysta',1800,'Gdańsk'),
--(6,'Zenon','Miller','stażysta',1800,'Gdynia'),
--(7,'Piotr','Piotrowski','prezes',8000,'Słupsk'),
--(8,'Mieczysław','Dobija','kontroler',4000,'Warszawa'),
--(9,'Peter','Norton','informatyk',4500,'Gdańsk'),
--(10,'Jan','Jankowski','księgowy',2400,'Słupsk'),
--(11,'Alina','Kowalska','informatyk',4200,'Gdańsk'),
--(12,'Jan','Małolepszy','księgowy',2500,'Słupsk'),
--(13,'Adam','Kowalski','urzędnik',2700,'Warszawa'),
--(14,'Adrian','Kowal','urzędnik',2700,'Sopot');

--create table nowa (Nr_ident integer,Zawód char(20),Telefon Varchar(15),Data_rozp Date,Premia Money,Uwagi Text,Unique(Telefon),Primary Key(Nr_ident));
--insert into nowa values
--(1, 'ekonomista','345899822','1999-08-05',500,'w czerwcu odchodzi na emeryture'),
--(2, 'menedżer', '111111111', '1999-12-12',1200,''),
--(3, 'prawnik','222222222','1990-08-01',700,'w tym roku premia jubileuszowa'),
--(4, 'ekonomista', '333333333','2000-08-01',500,''),
--(5, 'student','444444444','2019-10-01',600,'zaproponować zatrudnienie'),
--(6, 'student', '555555555','2000-08-01',200,'nie zatrudniać'),
--(7, 'prawnik', '666666666','2000-08-01',4000,''),
--(8, 'nauczyciel', '777777777','2000-08-01',2200,''),
--(9, 'informatyk', '888888888','2000-08-01',1000,''),
--(10, 'księgowy dyplomowany', '999999999','2000-08-01',1200,'za dwa miesiące przechodzi na 1/2 etatu'),
--(11, 'programista', '121212121','2000-08-01',12500,''),
--(12, 'ekonomista', '232323232','2000-08-01',800,''),
--(13, 'historyk', '343434343','2000-08-01',600,''),
--(14, 'prawnik', '454545454','2000-08-01',700,'');

--create table zlecenia(nr_zlec integer, nr_prac integer, kod_zlecenia char(10), wartosc_zlecenia money, primary key (nr_zlec));
--insert into zlecenia values
--(1, 1, 'K-001', 500),
--(2, 2, 'Z-045', 3000),
--(3, 3, 'P-003', 700),
--(4, 4, 'Z-004', 300),
--(5, 1, 'Z-005', 400),
--(6, 3, 'K-006', 500),
--(7, 3, 'P-003', 900),
--(8, 2, 'Z-008', 1000),
--(9, 7, 'Z-004', 555),
--(10, 7, 'P-340', 650),
--(11, 4, 'K-007', 450),
--(12, 5, 'Z-045', 888),
--(13, 6, 'P-003', 345),
--(14, 7, 'Z-004', 750),
--(15, 6, 'Z-005', 543),
--(16, 7, 'K-006', 456),
--(17, 8, 'P-003', 450),
--(18, 1, 'Z-010', 890),
--(19, 2, 'Z-004', 2000),
--(20, 3, 'P-340', 1250);


SELECT N.Numer,N.Imie, N.Nazwisko,
COUNT(Z.Wartosc_zlecenia) AS Ilosc_zlecen,
SUM (Z.Wartosc_zlecenia) AS Suma_zlecen
FROM nazwiska AS N JOIN Zlecenia AS Z
ON N.Numer=Z.Nr_prac
WHERE Z.Wartosc_zlecenia >= 900
GROUP BY N.Numer, N.Imie, N.Nazwisko
ORDER BY N.Numer;

SELECT  N.Numer,N.Imie, N.Nazwisko,
Z.Kod_zlecenia, Z.Wartosc_zlecenia
FROM Nazwiska AS N RIGHT JOIN Zlecenia AS Z
ON N.Numer=Z.Nr_prac
--AND Z.Wartosc_zlecenia >900;

--SELECT * FROM Nazwiska,Nowa;
--SELECT * FROM Nazwiska CROSS JOIN Nowa;

SELECT N1.Imie, N1.Nazwisko, N1.Pensja, N2.Imie,N2.Nazwisko, N2.Pensja
FROM Nazwiska as N1
CROSS JOIN Nazwiska as N2
WHERE N1.Pensja*4<N2.Pensja


SELECT  N1.Imie, N1.Nazwisko, N2.Imie,N2.Nazwisko
FROM Nazwiska AS N1 JOIN Nazwiska AS N2
ON N1.Numer>N2.Numer
WHERE N1.Imie = N2.Imie 



--SELECT  N1.Imie, N1.Nazwisko, N1.Stanowisko, N3.Zawod, N2.Kod_zlecenia, N2.Wartosc_zlecenia
--FROM Nazwiska AS N1, Zlecenia AS N2, LEFT JOIN Nowa AS N3
--ON N.Number = N2


SELECT  N.Imie, N.Nazwisko, Z.Kod_zlecenia
FROM Nazwiska AS N JOIN Zlecenia AS Z 
ON N.Numer = Z.Nr_prac
WHERE Z.Kod_zlecenia LIKE 'K%'
ORDER BY N.Nazwisko ASC, Z.Kod_zlecenia ASC;



SELECT  N.Imie, N.Nazwisko,
SUM(Z.Wartosc_zlecenia) AS Suma_zlecen
FROM Nazwiska AS N JOIN Zlecenia AS Z 
ON N.Numer = Z.Nr_prac
WHERE Z.Kod_zlecenia LIKE 'K%'
GROUP BY N.Nazwisko, N.Imie
ORDER BY N.Nazwisko ASC;


SELECT Z.Kod_zlecenia, N.imie, N.Nazwisko, N.Miasto
From Nazwiska AS N JOIN Zliecenia AS Z
ON N.Numer = Z.Nr_prac
Where N.Miasto NOT IN ('Gdansk','Sopot','Gdynia')

--2--

INSERT INTO Nazwiska
VALUES 
(15,'Ewa','Ewkowska','księgowy',2500,NULL)
(16,'Krysztof','Krzysztofowicz','księgowy',2500,NULL);

SELECT *FROM Nazwiska
WHERE Miasto <> NULL;

SELECT 10 + NULL as wynik1,
(10+4)*2 - NULL as wynik2,
'Ala ma' + 'kota' + NULL + '!' as wynik3;

SELECT Imie, Nazwisko,
ISNULL(Miasto, 'nie podano') as Miejscowość
FROM Nazwiska;

SELECT Imie, Nazwisko,
COALESCE(Miasto, Imie+' nie podał.') as Miejscowość
FROM Nazwiska;

SELECT NULLIF(10,10) as wynik1,
NULLIF(10,5) as wynik2,
NULLIF('Ala ma','kota') as wynik3;

SET ANSI_NULLS ON
SET ANSI_NULLS OF

SELECT
LEN(Nazwisko) as wynik_1,
LEN(Imie) as wynik_2
FROM Nazwiska;

SELECT
SUBSTRING(Nazwisko,1,5) as Wynik1,
SUBSTRING('Ala ma kota',8,4) as Wynik2
FROM Nazwiska;

SELECT Nazwisko,
REPLACE(Nazwisko,'i','a') as Wynik1
FROM Nazwiska;

SELECT Nazwisko,
CHARINDEX('ski',nazwisko) as wynik1,
CHARINDEX('o',nazwisko,2) as wynik2
FROM Nazwiska;

SELECT
Nazwisko,
STUFF(Nazwisko,1,0,'vel')
FROM Nazwiska;

SELECT Numer,
CONCAT('Super pracownik - ','Imie',Nazwisko)
as Laurka
FROM Nazwiska 
WHERE stanowisko <>'prezes'


SELECT
SYSDATETIME() as [SYSDATETIME],
SYSDATETIMEOFFSET() as [SYSDATETIMEOFFSET],
GETDATE() as [GETDATE],
GETUTCDATE() as [GETUTCDATE],
CURRENT_TIMESTAMP as [CURRENT_TIMESTAMP],
SYSUTCDATETIME() as [SYSUTCDATETIME];

SELECT
DATEDIFF(DD,'1906-01-01',GETDATE()) as Dni,
DATEDIFF_BIG(ms,'1906-01-01',GETDATE())
as Milisekundy;

CREATE VIEW zleceniaPracownikow AS
SELECT 
N.Numer, N.Imie, N.Nazwisko, N.Stanowisko,
N.Pensja, N.Miasto, K.Zawód, K.Telefon, K.Data_rozp,
K.Premia, K.Uwagi, Z.Kod_zlecenia, Z.Wartosc_zlecenia
FROM Nazwiska AS N
LEFT JOIN Nowa AS K
ON N.Numer = K.Nr_ident
LEFT JOIN Zlecenia AS Z
ON n.Numer=Z.Nr_prac;

SELECT  Imie, Nazwisko
FROM zleceniaPracownikow
WHERE kod_zlecenia is null

SELECT CONCAT(UPPER(SUBSTRING(Stanowisko,1,1))+SUBSTRING(Stanowisko,2,LEN(Stanowisko)),
' ', Imie,' ', Nazwisko,' zarabia ',+ CONVERT(VARCHAR(10),Pensja)) AS Informacja
FROM Nazwiska;

SELECT 
N.Numer, N.Imie, N.Nazwisko, N.Stanowisko,
N.Pensja, K.Premia, Z.Wartosc_zlecenia,
(N.Pensja + K.Premia + Z.Wartosc_zlecenia) AS SUM
FROM Nazwiska AS N
LEFT JOIN Nowa AS K
ON N.Numer = K.Nr_ident
LEFT JOIN Zlecenia AS Z
ON n.Numer=Z.Nr_prac
