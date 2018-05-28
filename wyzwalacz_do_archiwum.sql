-- Wyzwalacz który przenosi trenera po jego usuniêciu do tablei trenerzyArchiwum
-- Usuwa równie¿ wszystkie inne powi¹zania

USE SSW
GO
if exists (SELECT 1 FROM sys.objects WHERE type='TR' AND name='do_archiwum')
DROP TRIGGER do_archiwum
GO
CREATE TRIGGER do_archiwum
ON SSW..trenerzy
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM SSW..zapisy
	WHERE zajeciaId IN (SELECT z.id FROM SSW..zajecia AS z WHERE z.trenerId IN (SELECT d.id FROM deleted AS d));

	DELETE FROM SSW..zajecia
	WHERE trenerId IN (SELECT d.id FROM deleted AS d);

	DELETE FROM SSW..kwalifikacje
	WHERE trenerId IN (SELECT d.id FROM deleted AS d);

	DELETE FROM SSW..trenerzy
	WHERE id IN (SELECT d.id FROM deleted AS d);

	DECLARE @ilosc int;
	SET @ilosc = (SELECT COUNT(*) FROM deleted AS d)

	INSERT INTO SSW..trenerzyArchiwum SELECT * FROM deleted;

	UPDATE SSW..trenerzyArchiwum
	SET dataZwol = GETDATE()
	WHERE id IN (SELECT d.id FROM deleted AS d)
	
	INSERT INTO SSW..dziennik_zdarzen
	VALUES ('trenerzy',
			'Zwolniono ' + CAST(@ilosc AS varchar) + ' trenerów',
			GETDATE());
END
GO
-------------------------------------------------------------------------
-- SPRAWDZENIE --
SELECT * FROM SSW..trenerzy
SELECT * FROM SSW..trenerzyArchiwum

DELETE FROM SSW..trenerzy
WHERE id = 2; 

SELECT * FROM SSW..dziennik_zdarzen
