-- Procedura która wyœwietla iloœc wolnych miejsc
-- Przyjmuje 2 parametry: sztukê walki oraz poziom zaawansowania grupy

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'wolneMiejsca')
DROP PROCEDURE wolneMiejsca;
GO
CREATE PROCEDURE wolneMiejsca
	@sztukaWalki	varchar(20),
	@poziom			varchar(20)
AS
BEGIN
	
	DECLARE @sala varchar(10), @zajeciaID int, @poziomID int, @sztukaWalkiID varchar(2), @liczbaUczestnikow int;
	
	SELECT @poziomID = p.id FROM SSW..poziomy AS p WHERE p.nazwa = @poziom;
	SELECT @sztukaWalkiID = sw.id FROM SSW..sztuki_walki AS sw WHERE sw.nazwa = @sztukaWalki;
	
	DECLARE kursor CURSOR FOR 
		SELECT z.id, z.sala FROM SSW..zajecia AS z WHERE z.poziomId = @poziomID AND z.sztuki_walkid = @sztukaWalkiID;
	
	OPEN kursor;
	FETCH NEXT FROM kursor INTO @zajeciaID, @sala;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @liczbaUczestnikow = COUNT(*) 
		FROM SSW..uczestnicy AS u
		JOIN SSW..zapisy AS z ON z.uczestnikId = u.id
		WHERE z.zajeciaId = @zajeciaID

		SELECT DISTINCT
			z.dzienTygodniaId, 
			z.godzina ,
			(CAST(t.imie AS varchar) + ' ' + CAST(t.nazwisko AS varchar)) AS prowadzacy,
			(s.pojemnosc - @liczbaUczestnikow) AS wolnychMiejsc
		FROM SSW..zajecia AS z, SSW..sale AS s, SSW..trenerzy AS t
		WHERE z.id = @zajeciaID AND z.trenerId = t.id AND s.nazwa = z.sala

		FETCH NEXT FROM kursor INTO @zajeciaID, @sala;
	END
	CLOSE kursor;
	DEALLOCATE kursor;
END
GO
-----------------------------------------------------------
-- SPRAWDZENIE --
BEGIN
	EXEC wolneMiejsca 'kung-fu', 'Zaawansowany'
END
GO