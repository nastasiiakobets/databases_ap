--Kolokwium 02.02.23 Kobets Anastasiia--

--^-- zadanie 1 --^--

CREATE PROCEDURE nowyPracownik 
@fNumer AS INT, @fImie AS VARCHAR(30),  @fNazwisko AS VARCHAR(30), @fStanowisko AS VARCHAR(20) = 'menedzer',
@fPensja AS MONEY, @fMiasto AS VARCHAR(30)  = 'Gdańsk',

@fNr_ident AS INT, @fZawód AS CHAR(20), @fTelefon AS VARCHAR(15), @fData_rozp AS DATE = '2023-02-02', 
@fPremia AS MONEY, @fUwagi AS TEXT     = "-"

AS
INSERT 
INTO nazwiska(Numer, Imie, Nazwisko, Stanowisko, Pensja, Miasto)    
VALUES  (@fNumer, @fImie, @fNazwisko, @fStanowisko, @fPensja, @fMiasto)

INSERT 
INTO nowa (Nr_ident, Zawód, Telefon, Data_rozp, Premia, Uwagi)      
VALUES  (@fNr_ident, @fZawód, @fTelefon, @fData_rozp, @fPremia, @fUwagi)

EXECUTE nowyPracownik
@fNumer = 57, @fImie = "Adam", @fNazwisko = "Lurikovich", @fStanowisko = 'menedzer', @fPensja = 4300, @fMiasto = 'Słupsk',
@fNr_ident = 57, @fZawód = "informatyk", @fTelefon = "888888888", @fPremia = 1500


 --^-- zadanie 2 --^--

CREATE FUNCTION funkcjęskalarna (@liczba INT)
RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @uzt VARCHAR(20)
IF (@liczba % 5 = 0)
    SET @uzt = 'podzielna liczba'
ELSE
    SET @uzt = 'niepodzielna liczba'

RETURN @uzt
END

DECLARE @tabela TABLE (liczba INT, komentarz VARCHAR(20))
DECLARE @czisło INT = 1

WHILE (@czisło <= 10)
BEGIN
DECLARE @rezlicz INT = ROUND(((100 - 1) * RAND() + 1), 0)
INSERT INTO @tabela (liczba, komentarz)
VALUES (@rezlicz, dbo.funkcjęskalarna(@rezlicz))

SET @czisło = @czisło + 1
END

SELECT * FROM @tabela


 --^-- zadanie 3 --^--

CREATE TRIGGER operacji
ON zlecenia
FOR INSERT, UPDATE, DELETE
AS
BEGIN
IF EXISTS (SELECT * FROM inserted)
BEGIN
 IF EXISTS (SELECT * FROM deleted)
     PRINT 'UPDATE sukces!'
 ELSE
     PRINT 'INSERT sukces!'
 END
ELSE
      PRINT 'DELETE sukces!'
END

SELECT * FROM zlecenia;


--*--  operacji  --*--

-- INSERT --
INSERT INTO zlecenia (nr_zlec, nr_prac, kod_zlecenia, wartosc_zlecenia)
 VALUES (15, 1, 'Z-045', 1000);

-- UPDATE --
UPDATE zlecenia SET wartosc_zlecenia = 2000
 WHERE nr_zlec = 1;

-- DELETE --
DELETE FROM zlecenia
 WHERE nr_zlec = 15;
