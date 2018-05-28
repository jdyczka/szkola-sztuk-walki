-- Wyzwalacz, który nie pozwoli na zaktualizowanie stawki trenera, która by by³a wieksza od stawki jego szefa

USE SSW
GO
if exists (SELECT 1 FROM sys.objects WHERE type='TR' AND name='stawka')
DROP TRIGGER stawka
GO
CREATE TRIGGER stawka
ON SSW..trenerzy
FOR UPDATE
AS
BEGIN
	DECLARE @stawkaSzefa money, @nowaStawkaTrenera money, @staraStawkaTrenera money, @idTrenera int;
	SELECT @stawkaSzefa = l.stawka FROM deleted AS d, SSW..trenerzy AS l WHERE l.id = d.przelozonyId;
	SELECT @staraStawkaTrenera = d.stawka FROM deleted AS d;
	SELECT @nowaStawkaTrenera = i.stawka FROM inserted AS i;
	SELECT @idTrenera = d.id FROM deleted AS d

	IF (@stawkaSzefa <= @nowaStawkaTrenera)
	BEGIN
		UPDATE SSW..trenerzy
		SET stawka = @staraStawkaTrenera
		WHERE id = @idTrenera

		INSERT INTO SSW..dziennik_zdarzen
		VALUES ('trenerzy', 
				'Zmiana stawki godzinowej trenera o ID: ' + CAST(@idTrenera AS varchar)  +' nie powiod³a siê ', 
				GETDATE())
	END
END
GO
-------------------------------------------
-- SPRAWDZENIE --
SELECT * FROM SSW..trenerzy
SELECT * FROM SSW..dziennik_zdarzen

UPDATE SSW..trenerzy
SET stawka = 200.0
WHERE id = 3