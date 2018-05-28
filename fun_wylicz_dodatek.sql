-- Funkcja, która wylicza dodatek do stawki trenera w zale¿noœci od tego, ile osób ma pod sob¹
-- Wzór wyliczania dodatku to 10% od ka¿dej stawki osoby razy liczba tych osób
-- Przyjmuje jeden prametr: id trenera którego rozmatrujemy

--USE SSW;
--GO
--DROP FUNCTION wyliczDodatek
--GO
CREATE FUNCTION wyliczDodatek (@idTrenera int) RETURNS money
AS
BEGIN
	DECLARE @dodatek money, @liczbaPodwladnych int, @stawkaPodwladnego money, @a money, @srednia money;
	SET @a = 0.0;
	SET @dodatek = 0.0;

	IF EXISTS (SELECT * FROM SSW..trenerzy AS t WHERE t.przelozonyId = @idTrenera)
	BEGIN
		SELECT @liczbaPodwladnych = COUNT(*)
		FROM SSW..trenerzy AS t
		WHERE t.przelozonyId = @idTrenera

		DECLARE kursor CURSOR FOR
			SELECT t.stawka 
			FROM SSW..trenerzy AS t
			WHERE t.przelozonyId = @idTrenera

		OPEN kursor;
		FETCH NEXT FROM kursor INTO @stawkaPodwladnego;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @a += (@stawkaPodwladnego * 0.10);
		
			FETCH NEXT FROM kursor INTO @stawkaPodwladnego;
		END
		CLOSE kursor;
		DEALLOCATE kursor;

		SET @srednia = @a / (@liczbaPodwladnych * 1.0);
		SET @dodatek = @liczbaPodwladnych * @srednia;
	END
		
	RETURN @dodatek;
END
GO

----------------------------------------------------------
-- SPRAWDZENIE --
SELECT t.imie, t.nazwisko, dbo.wyliczDodatek(t.id) AS dodatek
FROM SSW..trenerzy AS t



