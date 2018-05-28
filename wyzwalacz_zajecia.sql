-- Wyzwalacz, który nie pozwoli na zapisanie uczestnika na zajêcia, jeœli nie ma wolnych miejsc

USE SSW
GO
if exists (SELECT 1 FROM sys.objects WHERE type='TR' AND name='zapis_na_zajecia')
DROP TRIGGER zapis_na_zajecia
GO
CREATE TRIGGER zapis_na_zajecia
ON SSW..zapisy
FOR INSERT
AS
BEGIN
	DECLARE @zajeciaID int, @liczbaUczestnikow int, @wolnych int, @idUczestnika int;
	SELECT @zajeciaID = i.zajeciaId FROM inserted AS i
	SELECT @idUczestnika = u.id FROM inserted AS i, SSW..uczestnicy AS u WHERE u.id = i.uczestnikId

	SELECT @liczbaUczestnikow = COUNT(*) 
	FROM SSW..uczestnicy AS u
	JOIN SSW..zapisy AS z ON z.uczestnikId = u.id
	WHERE z.zajeciaId = @zajeciaID

	SELECT @wolnych = (s.pojemnosc - @liczbaUczestnikow)
	FROM SSW..zajecia AS z, SSW..sale AS s
	WHERE z.id = @zajeciaID AND s.nazwa = z.sala

	IF (@wolnych <= 0)
	BEGIN
		DELETE FROM SSW..zapisy
		WHERE id = (SELECT i.id FROM inserted AS i)

		INSERT INTO SSW..dziennik_zdarzen
		VALUES ('zapisy', 'Zapisywanie uczestnika o id (' + CAST(@idUczestnika AS varchar)  +') nie powiod³o siê ', GETDATE())
	END
END
GO
-------------------------------------------------------------
-- SPRAWDZENIE --
SELECT * FROM SSW..zapisy
SELECT * FROM SSW..dziennik_zdarzen

INSERT INTO SSW..zapisy VALUES (2, 33, GETDATE());