USE SSW;

-- 01 
-- Zajęcia prowadzone przez Tomasza Ulatowskiego
SELECT z.id as id_zajec, z.dzienTygodniaId, CAST (z.godzina AS TIME(0)) as godzina, z.sztuki_walkid, sw.nazwa, z.poziomId, z.sala
FROM zajecia AS z
LEFT JOIN trenerzy AS t ON z.trenerId = t.id
LEFT JOIN sztuki_walki AS sw ON z.sztuki_walkid = sw.id
WHERE t.imie = 'Tomasz' AND t.nazwisko = 'Ulatowski'

-- 02 --
-- Liczba wolnych miejsc na zajęciach
SELECT
	z.dzienTygodniaId, CAST (z.godzina AS TIME(0)) as godzina, sw.nazwa, p.nazwa,
	(s.pojemnosc - (SELECT COUNT(*) FROM SSW..zapisy AS zap 
		WHERE zap.zajeciaId = z.id)) AS wolne_miejsca	
FROM zajecia AS z
LEFT JOIN sale AS s ON z.sala = s.nazwa
LEFT JOIN sztuki_walki AS sw ON z.sztuki_walkid = sw.id
LEFT JOIN poziomy AS p ON z.poziomId = p.id

-- 03 --
-- Łączna liczba osób zapisanych na poszczególne sztuki walki
SELECT COUNT(*) AS liczba_osob, zaj.sztuki_walkid
FROM uczestnicy AS u
LEFT JOIN zapisy AS zap ON zap.uczestnikId = u.id
LEFT JOIN zajecia AS zaj ON zaj.id = zap.zajeciaId
GROUP BY zaj.sztuki_walkid

 
-- 04 --
-- Imie i nazwisko trenera, z którym uczestnik o tożsamości Dorota Epicka ma zajecia 
SELECT(CAST(u.imie AS varchar) + ' ' + CAST(u.nazwisko AS varchar)) AS uczestnik,
	(CAST(t.imie AS varchar) + ' ' + CAST(t.nazwisko AS varchar)) AS trener
FROM uczestnicy AS u
LEFT JOIN zapisy AS zap ON zap.uczestnikId = u.id
LEFT JOIN zajecia AS zaj ON zaj.id = zap.zajeciaId
LEFT JOIN trenerzy AS t ON zaj.trenerId = t.id
WHERE u.imie = 'Dorota' AND u.nazwisko = 'Epicka'

-- 05 --
-- Liczba zajęć w tygodniu każdego trenera
SELECT (CAST(t.imie AS varchar) + ' ' + CAST(t.nazwisko AS varchar)) AS trener, id AS id_trenera, 
(	SELECT COUNT(trenerId)  FROM zajecia
	WHERE t.id=zajecia.trenerId)
	AS liczba_zajec_w_tyg
 FROM trenerzy AS t

-- 06
-- Tygodniowa wypłata każdego trenera
SELECT (CAST(t.imie AS varchar) + ' ' + CAST(t.nazwisko AS varchar)) AS trener, id AS id_trenera, 
(	SELECT (CAST(COUNT(trenerId) AS float)*1.5*t.stawka)  FROM zajecia
	WHERE t.id=zajecia.trenerId)
	AS wypłata_tygodniowa
 FROM trenerzy AS t

-- 07 --
-- Jaka cześć wszystkich osob stanowią kobiety chodzące na kung-fu
SELECT ROUND((COUNT(*) * 1.0) / (SELECT COUNT(*) FROM uczestnicy), 2)
FROM uczestnicy AS u
JOIN zapisy AS z ON z.uczestnikId = u.id
JOIN zajecia AS z2 ON z.zajeciaId = z2.id
JOIN sztuki_walki AS sw ON z2.sztuki_walkid = sw.id
WHERE sw.nazwa = 'kung-fu' AND u.plec = 'K'

-- 08
-- uczestnicy, którzy nie są zapisani na żadne zajęcia
SELECT *
FROM uczestnicy AS u
WHERE NOT EXISTS (
	SELECT *
	FROM zapisy AS z
	WHERE z.uczestnikId = u.id)

-- 09 --
-- Średnia stawka godzinowa wszystkich trenerów
SELECT AVG(t.stawka)
FROM trenerzy AS t

-- 10 --
-- trenerzy oraz jezyki w jakich potrafia nauczać wraz z poziomem
SELECT t.imie, t.nazwisko, sw.nazwa, p.nazwa
FROM kwalifikacje AS k
LEFT JOIN trenerzy AS t ON t.id = k.trenerId
LEFT JOIN sztuki_walki AS sw ON sw.id = k.sztuki_walkid
LEFT JOIN poziomy AS p ON p.id = k.poziomId


-- 11 ŹLE
-- Sprawdzanie, czy dla każdych wpisanych zajęć istnieje przynajmniej jeden uczestnik
SELECT zajecia
FROM zajecia AS z 
LEFT JOIN uczestnicy as u ON u.zajeciaId=z.id
GROUP BY zajecia
HAVING COUNT(z.id)=0