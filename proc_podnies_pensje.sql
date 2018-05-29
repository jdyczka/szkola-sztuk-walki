-- Procedura podnosząca stawkę o podaną kwotę trenerom, którzy prowadzą zajęcia z określonych sztuk walki
-- Pierwszy parametr to wysokość podwyżki, drugi to sztuka walki.

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'podniesStawke')
DROP PROCEDURE podniesStawke;
GO
CREATE PROCEDURE podniesStawke
	@pozwyzka money = 7.50,
	@sztukaWalki varchar (20)	
AS
BEGIN
	DECLARE @idTrenera int, @iterator int;
	DECLARE kursor CURSOR FOR
		SELECT t.id
		FROM SSW..trenerzy AS t
		JOIN SSW..kwalifikacje AS k ON k.trenerId = t.id
		JOIN SSW..sztuki_walki AS sw ON sw.id = k.sztuki_walkid
		WHERE sw.nazwa = @sztukaWalki	

	SET @iterator = 0;

	OPEN kursor;
	FETCH NEXT FROM kursor INTO @idTrenera;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE SSW..trenerzy
		SET stawka = stawka + @pozwyzka
		WHERE id = @idTrenera

		SET @iterator = @iterator + 1;

		FETCH NEXT FROM kursor INTO @idTrenera;
	END
	CLOSE kursor;
	DEALLOCATE kursor;

	INSERT INTO SSW..dziennik_zdarzen 
	VALUES ('trenerzy',
			'Wprowadzono podwyżke: ' + CAST(@pozwyzka AS varchar) +' zł dla trenerów w liczbie: ' + CAST(@iterator AS varchar),
			GETDATE())
			
END

-- WYWOŁANIE --
BEGIN
	EXEC podniesStawke 3.00, 'karate';
END
GO
SELECT * FROM SSW..dziennik_zdarzen