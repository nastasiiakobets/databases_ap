CREATE FUNCTION dbo.PoleKola(@Promien FLOAT)
Returns FLOAT
AS
BEGIN
RETURN PI()*POWER(@Promien,2);
END;

DECLARE @PromienK Int=1, @PoleK Float;
WHILE @PromienK<101
BEGIN
set @PoleK=dbo.PoleKola(@PromienK);
Print 'Pole koła o promieniu '
+Cast(@PromienK AS VARCHAR)+ 'wynosi: '
+Cast(@PoleK AS VARCHAR);
SET @PromienK +=1;
END;


CREATE FUNCTION dbo.Silnia (@Liczba INT =1)
RETURNS DECIMAL (38,0)
WITH RETURNS Null on Null INPUT 
AS
Begin 
RETURN
(CASE
WHEN @Liczba<0 THEN NULL
WHEN @Liczba>1 THEN
                  CAST (@Liczba AS FLOAT)*dbo.Silnia(@Liczba-1)
WHEN @Liczba=0 OR @Liczba=1 THEN 1
END);
END;


CREATE  FUNCTION [dbo].Lista (@pMiasto Varchar(30))
RETURNS @Wynik TABLE (Nr INT, fImie VARCHAR(20),
                       fNazwisko VARCHAR(30), fMiasto VARCHAR(30))
AS
BEGIN
INSERT INTO @Wynik(Nr, fImie, fNazwisko, fMiasto)
SELECT Numer, Imie, Nazwisko, Miasto 
FROM nazwiska
WHERE Miasto = @pMiasto;
RETURN;
END;    


SELECT * FROM [dbo].Lista('Sopot','Słupsk');


CREATE FUNCTION dbo.Place (@Liczba MONEY)
RETURNS @Wynik TABLE (Nr INT, filmie VARCHAR(20),
                      fNazwisko VARCHAR(30), fPensja MONEY)
AS
BEGIN
INSERT INTO @Wynik (Nr, filmie, fNazwisko, fPensja )
SELECT Numer, Imie, Nazwisko, Pensja
FROM Nazwiska
WHERE Pensja < @Liczba;
RETURN;
END;

SELECT A.Nr, A.filmie, A.fNazwisko, A.fPensja, nowa.Premia
FROM [dbo].Place(4000) AS A
JOIN nowa
ON A.Nr = nowa.Nr_ident
WHERE nowa. Premia < 1000


CREATE FUNCTION dbo.Lista2(@pTop INT,
@pMiasto VARCHAR(30))
RETURNS TABLE
AS
RETURN 
(SELECT TOP(@pTop) Numer, Imie, Nazwisko,
Pensja, Miasto FROM Nazwiska 
WHERE Miasto = @pMiasto
ORDER BY Pensja DESC);


SELECT * FROM dbo.Lista2(5,'Gdańsk')
SELECT * FROM dbo.Lista2(3,'Gdynia')


CREATE PROCEDURE dbo.Podwyzka
AS
BEGIN
SELECT Nazwisko, Pensja FROM Nazwiska;
UPDATE Nazwiska SET Pensja=Pensja+100;
SELECT Nazwisko, Pensja FROM Nazwiska;
END;



ALTER PROCEDURE dbo.Podwyzka @pKwota Money
AS
BEGIN
SElECT Nazwisko , Pensja FROM nazwiska;
UPDATE nazwiska SET Pensja=Pensja+@pKwota;
SELECT Nazwisko, Pensja FROM Nazwiska;
END;

EXECUTE Podwyzka 100;


ALTER PROCEDURE dbo.Podwyzka
@pKwota Money, @pMiasto VARCHAR(30)
AS
BEGIN
SELECT Nazwisko, Pensja, Miasto FROM nazwiska
WHERE Miasto = @pMiasto;
UPDATE Nazwiska SET Pensja=Pensja+@pKwota
WHERE Miasto=@pMiasto
SELECT Nazwisko, Pensja, Miasto FROM nazwiska
WHERE Miasto=@pMiasto
END;


EXECUTE Podwyzka @pMiasto = 'Sopot',
                @pKwota = 100;



ALTER PROCEDURE dbo.Podwyzka
@pKwota Money, @pMiasto VARCHAR(30) = 'Słupsk'
AS
BEGIN
SELECT Nazwisko, Pensja, Miasto FROM nazwiska
WHERE Miasto = @pMiasto;
UPDATE Nazwiska SET Pensja=Pensja+@pKwota
WHERE Miasto=@pMiasto
SELECT Nazwisko, Pensja, Miasto FROM nazwiska
WHERE Miasto=@pMiasto
END;

EXECUTE Podwyzka 100;


CREATE PROCEDURE dbo.Osoba
    @pNumer INT,
    @pNazwisko VARCHAR(30) OUTPUT,
    @pImie VARCHAR(30) OUTPUT
AS
BEGIN
SELECT @pNazwisko=Nazwisko, @pImie=Imie
FROM nazwiska
WHERE Numer=@pNumer
END;

DECLARE @w1 VARCHAR(30),
        @w2 VARCHAR(30)
BEGIN
EXECUTE Osoba 6,    @pNazwisko=@w1 OUT,
                    @pImie=@w2 OUT

PRINT @w1;
PRINT @w2
END;


CREATE PROCEDURE dbo.Ile 
AS
BEGIN
DECLARE @ile INT 
SELECT @ile = COUNT(*) FROM nazwiska
RETURN @ile
END;


DECLARE @ilu_prac INT 
EXECUTE @ilu_prac = Ile;
PRINT @ilu_prac;


CREATE PROCEDURE dbo.podwyzka1
AS
BEGIN
DECLARE @srednia MONEY
SELECT @srednia = AVG(Pensja) FROM nazwiska;
UPDATE Nazwiska SET Pensja = 1.1*Pensja
WHERE Pensja <@srednia;
UPDATE nowa SET Premia = Premia+500
FROM nazwiska
WHERE Pensja >@srednia +500;
END;

EXECUTE dbo.podwyzka1;

---------19.01.2023---------

Create Procedure dbo.dodajPracownika
@pImie VARCHAR(30) = NULL,
@pNazwisko VARCHAR(40) = NULL,
@pStanowisko VARCHAR(20) = NULL,
@pPensja MONEY = NULL,
@pMiasto VARCHAR(30) = NULL,
@pZawod VARCHAR(20) = NULL,
@pTelefon VARCHAR(15) = NULL,
@pData DATE = NULL,
@pPremia MONEY = NULL,
@pUwagi TEXT = NULL

AS
BEGIN
IF @pImie IS NULL OR @pNazwisko IS NULL OR @pStanowisko IS NULL OR
@pPensja IS NULL OR @pMiasto IS NULL OR @pZawod IS NULL OR
@pTelefon IS NULL OR @pData IS NULL OR @pPremia IS NULL OR @pUwagi IS NULL
BEGIN
DECLARE @blad INT = 100;
RETURN @blad;
END
INSERT INTO nazwiska
VALUES ((SELECT MAX(Numer) FROM Nazwiska)+1, @pImie, @pNazwisko, @pStanowisko, @pPensja, @pMiasto);
INSERT INTO Nowa
VALUES ((SELECT MAX(Numer) FROM Nazwiska)+1, @pZawod, @pTelefon, @pData, @pPremia, @pUwagi);
END;

DECLARE @test INT;
EXEC @test = dodajPracownika @pImie = 'Adam', @pNazwisko = 'Kowalski',
@pStanowisko = 'programista',@pPensja = 4500, @pMiasto = 'Koszalin',
@pZawod = 'informatyk',
@pTelefon = '898989890', @pData = '2001-11-11', @pPremia
= 1000, @pUwagi ='brak uwag';
IF @test=100 PRINT 'Dane sa niepelne';


CREATE PROCEDURE dbo. TestError (@e int OUTPUT) AS BEGIN
INSERT INTO Nazwiska(Numer) VALUES (1)
PRINT 'Kod bledu w procedurze = ' + CAST(@@error AS
varchar(10));
SET @e = @@error;
END;


go
declare @ret int, @e int;
exec @ret = dbo.TestError @e output;
print 'Zwrócony kod błedu = ' + cast (@e as varchar(30));
print 'Zwrócona wartość = ' + cast (@ret as varchar(30));


CREATE PROCEDURE dbo. TestError (@e int OUTPUT) AS BEGIN
INSERT INTO Nazwiska(Numer) VALUES (1)
PRINT 'Kod bledu w procedurze = ' + CAST(@@error AS
varchar(10));
SET @e = @@error;
END;
GO

CREATE PROCEDURE dbo. TestError2 (@e int OUTPUT) AS BEGIN
INSERT INTO Nazwiska(Numer) VALUES (1);
SET @e = @@error;
PRINT 'Kod bledu w procedurze =
= ' + CAST(@e AS nvarchar(10));
END;
GO
DECLARE @ret int, @e int;
EXEC @ret = dbo. TestError @e OUTPUT;
PRINT 'Zwrocony kod bledu = ' + CAST(@e AS varchar(10));
PRINT 'Zwrócona wartosc = ' + CAST(@ret AS varchar(10));

CREATE PROCEDURE dbo. TestError3 (@e int OUTPUT) AS BEGIN
SET @e = 0;
BEGIN TRY
INSERT INTO Nazwiska(Numer)
VALUES (1);
END TRY

BEGIN CATCH
SET @e = ERROR_NUMBER();
PRINT 'Kod bledu = ' + CAST(@e AS varchar(10));
PRINT 'Blad w procedurze = ' + ERROR_PROCEDURE();
PRINT 'Komunikat o bledzie = ' + ERROR_MESSAGE();
END CATCH
END
GO


DECLARE @ret int, @e int;
EXEC @ret = dbo.TestError3 @e OUTPUT;
PRINT 'Kod bledu = ' + CAST(@e AS varchar(10));
PRINT'Zwrócona wartosc = ' +CAST(@ret AS varchar(10));

DECLARE @test AS VARCHAR(10)
SET @test = '123456'
SELECT TRY_CONVERT(INT, @test)
SELECT TRY_CONVERT(DATE, @test)
SELECT IIF(TRY_CONVERT(binary,@test) IS NULL, 'FALSE', 'TRUE')

BEGIN TRY
INSERT INTO nazwiska(Numer)
Values(1);
END TRY
BEGIN CATCH
PRINT 'To jest błąd';
THROW
END CATCH;

THROW 52000, 'To tez jest blad', 1
BEGIN TRY
INSERT INTO nazwiska(Numer)
VALUES (1);
END TRY
BEGIN CATCH
THROW
END CATCH