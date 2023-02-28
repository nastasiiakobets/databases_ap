--Kobets Anastasiia--
--*1&2*--
create table klienci (idklienta integer,Imie varchar(30),Nazwisko varchar(40),Miejscowość varchar(20));
insert into klienci values
(1,'Adam','Adamowski','Sopot'),
(2,'Ewa','Musiał','Gdańsk'),
(3,'Marian','Malinowski','Gdynia'),
(4,'Adam','Nowakowski','Gdańsk'),
(5,'Jan','Kowalski','Gdańsk');

create table ksiazki (idksiazki integer,imieautora varchar(20),nazwiskoautora Varchar(15),tytul  Varchar(20));
insert into ksiazki values
(1, 'Loght','Hfudb','Hfcsycwef'),
(2, 'Giyght','Jdbc','Kojdci'),
(3, 'Nkfkwf','Bhunef','Njufcne'),
(4, 'Lkjuwefhcl','Hdhbf','Nekfkuwef'),
(5, 'Koef','Loofb','MLijifw');

create table wypozyczenia (idwyp varchar(20),idklienta integer,idksiazki integer, statuss  varchar(20), data_wyp Date);
insert into wypozyczenia values
('125', 1,1,'Jest','2022-08-05'),
('223', 2,2,'Nie','2021-10-02'),
('322', 3,3,'Nie','2022-08-30'),
('427', 4,4,'Jest','2022-12-07'),
('523', 5,5,'Jest','2020-06-22');

--*3*--
--a--
SELECT tytul, imieautora, nazwiskoautora
FROM ksiazki
ORDER By nazwiskoautora ASC

--b--

SELECT W.idwyp, K.Imie, K.Nazwisko, KS.tytul
FROM Wypozyczenia AS W JOIN Klienci AS K 
ON W.idklienta =  K.idklienta
JOIN Ksiazki AS KS
ON  W.idksiazki= KS.idksiazki
WHERE W.[statuss] = 'Jest';

-- SELECT idwyp
-- FROM wypozyczenia 
-- WHERE statuss = 'Jest';


--c--

SELECT *
FROM ksiazki
INNER JOIN wypozyczenia ON ksiazki.idksiazki = wypozyczenia.idksiazki
WHERE wypozyczenia.data_wyp =  
 ( 
     SELECT MIN(wypozyczenia.data_wyp) 
     FROM wypozyczenia
     WHERE wypozyczenia.[statuss] = 'Jest'
)
UNION ALL
SELECT *
FROM ksiazki
INNER JOIN wypozyczenia ON ksiazki.idksiazki=wypozyczenia.idksiazki
WHERE wypozyczenia.data_wyp =   ( SELECT MAX(wypozyczenia.data_wyp) 
    FROM wypozyczenia
    WHERE wypozyczenia.[statuss] = 'Jest');

--d--

SELECT H.idksiazki, H.tytul, H.imieautora, H.nazwiskoautora
FROM   
(SELECT 
    ksiazki.idksiazki,  ksiazki.tytul, ksiazki.imieautora, ksiazki.nazwiskoautora, 
    ROW_NUMBER() OVER (ORDER BY wypozyczenia.idwyp) AS row_num
    FROM wypozyczenia
    INNER JOIN ksiazki ON ksiazki.idksiazki = wypozyczenia.idksiazki) AS H
WHERE H.row_num IN (1, 3);
