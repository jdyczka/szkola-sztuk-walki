-- Procedura która zlicza uczestników danej sztuki walki z podzia³em na p³eæ
-- Przyjmuje jeden prametr - sztukê walki

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'zliczUczestnikow')
DROP PROCEDURE zliczUczestnikow;
GO
CREATE PROCEDURE zliczUczestnikow
	@sztukaWalki varchar(20)
AS
BEGIN
	DECLARE @kobiety int, @mezczyzni int, @razem int;

	SELECT @kobiety = COUNT(*)
	FROM SSW..uczestnicy AS u
	JOIN SSW..zapisy AS z ON z.uczestnikId = u.id
	JOIN SSW..zajecia AS z2 ON z.zajeciaId = z2.id
	JOIN SSW..sztuki_walki AS sw ON z2.sztuki_walkid = sw.id
	WHERE sw.nazwa = @sztukaWalki AND u.plec = 'K'

	SELECT @mezczyzni = COUNT(*)
	FROM SSW..uczestnicy AS u
	JOIN SSW..zapisy AS z ON z.uczestnikId = u.id
	JOIN SSW..zajecia AS z2 ON z.zajeciaId = z2.id
	JOIN SSW..sztuki_walki AS sw ON z2.sztuki_walkid = sw.id
	WHERE sw.nazwa = @sztukaWalki AND u.plec = 'M'

	SET @razem = @kobiety + @mezczyzni;

	SELECT @mezczyzni AS mezczyzn, @kobiety AS kobiet, @razem AS razem
END
GO
-------------------------------------------------------------
--SPRAWDZENIE--
BEGIN
	EXEC zliczUczestnikow 'karate'
END
GO