USE SSW;

-- 01 
-- zajęcia prowadzone przez Tomasza Ulatowskiego
SELECT z.id as id_zajec, z.dzienTygodniaId, CAST (z.godzina AS TIME(0)) as godzina, z.sztuki_walkid, sw.nazwa, z.poziomId, z.sala
FROM zajecia AS z
LEFT JOIN trenerzy AS t ON z.trenerId = t.id
LEFT JOIN sztuki_walki AS sw ON z.sztuki_walkid = sw.id
WHERE t.imie = 'Tomasz' AND t.nazwisko = 'Ulatowski'

-- 02 --
-- liczba wolnych miejsc na zajęciach
SELECT
	z.id,
	z.dzienTygodniaId, 
	CAST (z.godzina AS TIME(0)) as godzina, 
	z.sala,
	sw.nazwa, 
	p.nazwa as poziom,
	(s.pojemnosc - 
		(
			SELECT COUNT(*) 
			FROM SSW..zapisy AS zap 
			WHERE zap.zajeciaId = z.id
		)
	) AS wolne_miejsca	
FROM zajecia AS z
LEFT JOIN sale AS s ON z.sala = s.nazwa
LEFT JOIN sztuki_walki AS sw ON z.sztuki_walkid = sw.id
LEFT JOIN poziomy AS p ON z.poziomId = p.id
order by z.id

-- 03 --
-- liczba osób zapisanych na poszczególne sztuki walki
SELECT COUNT(*) AS liczba_osob, zaj.sztuki_walkid
FROM uczestnicy AS u
LEFT JOIN zapisy AS zap ON zap.uczestnikId = u.id
LEFT JOIN zajecia AS zaj ON zaj.id = zap.zajeciaId
GROUP BY zaj.sztuki_walkid

 
-- 04 --
-- imie i nazwisko trenera, z którym ma zajecia uczestnik Helena Danielewska 
SELECT(CAST(u.imie AS varchar) + ' ' + CAST(u.nazwisko AS varchar)) AS uczestnik,
	(CAST(t.imie AS varchar) + ' ' + CAST(t.nazwisko AS varchar)) AS trener
FROM uczestnicy AS u
LEFT JOIN zapisy AS zap ON zap.uczestnikId = u.id
LEFT JOIN zajecia AS zaj ON zaj.id = zap.zajeciaId
LEFT JOIN trenerzy AS t ON zaj.trenerId = t.id
WHERE u.imie = 'Helena' AND u.nazwisko = 'Danielewska'

-- 05 --
-- liczba zajęć w tygodniu prowadzonych przez każdego trenera
SELECT (CAST(t.imie AS varchar) + ' ' + CAST(t.nazwisko AS varchar)) AS trener, id AS id_trenera, 
(	SELECT COUNT(trenerId)  FROM zajecia
	WHERE t.id=zajecia.trenerId)
	AS liczba_zajec_w_tyg
 FROM trenerzy AS t

-- 06
-- tygodniowa wypłata każdego trenera
SELECT (CAST(t.imie AS varchar) + ' ' + CAST(t.nazwisko AS varchar)) AS trener, id AS id_trenera, 
(	SELECT (CAST(COUNT(trenerId) AS float)*1.5*t.stawka)  FROM zajecia
	WHERE t.id=zajecia.trenerId)
	AS wypłata_tygodniowa
 FROM trenerzy AS t

-- 07 --
-- jaka cześć wszystkich osob stanowią kobiety chodzące na kung-fu
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
-- średnia stawka godzinowa wszystkich trenerów
SELECT AVG(t.stawka) as srednia_stawka
FROM trenerzy AS t

-- 10 --
-- trenerzy oraz sztuki walki, jakich uczą wraz z maksymalnym poziomem
SELECT t.imie, t.nazwisko, sw.nazwa, p.nazwa as max_poziom
FROM kwalifikacje AS k
LEFT JOIN trenerzy AS t ON t.id = k.trenerId
LEFT JOIN sztuki_walki AS sw ON sw.id = k.sztuki_walkid
LEFT JOIN poziomy AS p ON p.id = k.poziomId


-- 11
-- zajęcia, na które nie są zapisani żadni uczestnicy
SELECT *
FROM zajecia z 
WHERE NOT EXISTS
(
	SELECT *
	FROM zapisy
	WHERE zajeciaId = z.id
)

-- 12 --
-- w które dni tygodnia najwięcej osób przychodzi na zajecia
SELECT 
	t.nazwa,
	(
		SELECT COUNT(zp.zajeciaId)
		FROM zapisy zp
		WHERE zp.zajeciaId IN 
		(
			SELECT zj.id
			FROM zajecia zj
			WHERE zj.dzienTygodniaId = t.id
		)
	) as ilosc_osob
FROM dni_tygodnia t 
ORDER BY ilosc_osob DESC

-- 13 --
-- rozkład ilości osób na poszczególnych poziomach
SELECT 
	p.nazwa,
	(
		SELECT COUNT(zp.zajeciaId)
		FROM zapisy zp
		WHERE zp.zajeciaId IN 
		(
			SELECT zj.id
			FROM zajecia zj
			WHERE zj.poziomId = p.id
		)
	) as ilosc_osob
FROM poziomy p
ORDER BY ilosc_osob DESC

-- 14 --
-- czy istnieją uczestnicy, którzy chodzą na więcej niż jedne zajęcia
SELECT 
	imie + ' ' + nazwisko AS uczestnik,
	(
		SELECT COUNT(*)
		FROM zapisy
		WHERE uczestnikId = u.id
		GROUP BY uczestnikId
	) AS ilosc_zajec
FROM uczestnicy u
WHERE id IN 
(
	SELECT uczestnikId FROM
	(
		SELECT uczestnikId, COUNT(*) AS ilosc_zajec
		FROM zapisy
		GROUP BY uczestnikId
		HAVING COUNT(*) > 1
	) x 
)
ORDER BY ilosc_zajec DESC

-- 15 --
-- Imiona i nazwiska trenerów, z którym ma zajęcia uczestnik, który chodzi na największą liczbę zajęć
DECLARE @max INT
SELECT @max = MAX(x.ile) FROM
(
	SELECT DISTINCT COUNT(*) AS ile
	FROM zapisy
	GROUP BY uczestnikId
) AS x
print @max

SELECT
	(u.imie + ' ' + u.nazwisko) AS uczestnik,
	(t.imie + ' ' + t.nazwisko) AS trener,
	sw.nazwa AS sztuka_walki,
	p.nazwa AS poziom,
	dt.nazwa AS dzien,
	zaj.godzina
FROM uczestnicy AS u
LEFT JOIN zapisy AS zap ON zap.uczestnikId = u.id
LEFT JOIN zajecia AS zaj ON zaj.id = zap.zajeciaId
LEFT JOIN trenerzy AS t ON zaj.trenerId = t.id
LEFT JOIN sztuki_walki AS sw ON sw.id = zaj.sztuki_walkid
LEFT JOIN dni_tygodnia AS dt ON dt.id = zaj.dzienTygodniaId
LEFT JOIN poziomy AS p ON p.id = zaj.poziomId
WHERE u.id IN 
(
	SELECT x.uczestnikId FROM
	(
		SELECT uczestnikId
		FROM zapisy
		GROUP BY uczestnikId
		HAVING COUNT(uczestnikId) = @max
	) x
)
ORDER BY u.id, sztuka_walki

-- 16 --
-- która sztuka walki jest najbardziej popularna wśród osób na różnych poziomach
SELECT 
	p.nazwa AS poziom, 
	(
		SELECT sw.nazwa
		FROM  sztuki_walki sw
		WHERE sw.id IN 
		(
			SELECT x.sztuki_walkid FROM
			(
				SELECT TOP 1 zj1.sztuki_walkid, COUNT(zp.zajeciaId) ile
				FROM zapisy zp
				LEFT JOIN zajecia zj1 ON zj1.id = zp.zajeciaId
				WHERE zp.zajeciaId IN 
				(
					SELECT zj.id
					FROM zajecia zj
					WHERE zj.poziomId = p.id
				)
				GROUP BY zj1.sztuki_walkid
				ORDER BY ile DESC
			) AS x
			GROUP BY x.sztuki_walkid
		)
	) AS sztuka_walki
FROM poziomy p