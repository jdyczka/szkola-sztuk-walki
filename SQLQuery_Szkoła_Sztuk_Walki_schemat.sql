--SZKO£A SZTUK WALKI 
--JOANNA DYCZKA, DOROTA SACHAJKO

if exists(select 1 from master.dbo.sysdatabases where name = 'SSW') drop database SSW
GO
CREATE DATABASE SSW
GO

CREATE TABLE SSW..sztuki_walki ( 
	id		varchar(2)  NOT NULL,
	nazwa	varchar(20)	NOT NULL,

	CONSTRAINT sztuki_walkiId_pk PRIMARY KEY (id),
);
GO

CREATE TABLE SSW..poziomy ( 
	id		int			IDENTITY(1,1),
	nazwa	varchar(20)	NOT NULL,

	CONSTRAINT poziomyId_pk PRIMARY KEY (id)
);
GO

CREATE TABLE SSW..trenerzy ( 
	id				int				IDENTITY(1,1),
	imie			varchar(20)		NOT NULL,
	nazwisko		varchar(30)		NOT NULL,
	email			varchar(30),
	nr_tel			varchar(9)		NOT NULL,
	przelozonyId	int,
	dataZatr		datetime		DEFAULT GETDATE(),	
	dataZwol		datetime		DEFAULT NULL,
	stawka			money			DEFAULT 30.00,

	CONSTRAINT trenerzyId_pk PRIMARY KEY (id),
	CONSTRAINT stawka_check CHECK (stawka >= 0.00),
	CONSTRAINT trenerzyPrzelozonyId_fk FOREIGN KEY (przelozonyId) REFERENCES SSW..trenerzy(id)
);
GO

CREATE TABLE SSW..trenerzyArchiwum ( 
	id				int,
	imie			varchar(20),
	nazwisko		varchar(30),
	email			varchar(100),
	nr_tel			varchar(9),
	przelozonyId	int,
	dataZatr		datetime,	
	dataZwol		datetime,
	stawka			money,

	CONSTRAINT data_check CHECK (dataZatr < dataZwol)
);
GO

CREATE TABLE SSW..dni_tygodnia ( 
	id		varchar(3),
	nazwa	varchar(15)	NOT NULL,

	CONSTRAINT dniTygodniaId_pk PRIMARY KEY (id),
	CONSTRAINT dniTygodniaId_check CHECK (id IN ('PN', 'WT', 'ŒR', 'CZ', 'PT', 'SB', 'NDZ'))	
);
GO

CREATE TABLE SSW..sale ( 
	nazwa		varchar(10)	NOT NULL,
	pojemnosc	int			NOT NULL,

	CONSTRAINT nazwa_pk PRIMARY KEY (nazwa),
	CONSTRAINT salePojemnosc_check CHECK (pojemnosc > 0)
);
GO

CREATE TABLE SSW..zajecia ( 
	id				int			IDENTITY(1,1),
	sztuki_walkid	varchar(2)	NOT NULL,
	poziomId		int			NOT NULL,
	trenerId		int			NOT NULL,
	sala			varchar(10)	NOT NULL,
	dzienTygodniaId	varchar(3)	NOT NULL,
	godzina			time		NOT NULL,

	CONSTRAINT zajeciaId_pk PRIMARY KEY (id),
	CONSTRAINT zajeciasztuki_walkid_fk	FOREIGN KEY (sztuki_walkid)	REFERENCES SSW..sztuki_walki(id),
	CONSTRAINT zajeciaPoziomId_fk	FOREIGN KEY (poziomId)	REFERENCES SSW..poziomy(id),
	CONSTRAINT zajeciatrenerId_fk	FOREIGN KEY (trenerId)	REFERENCES SSW..trenerzy(id),
	CONSTRAINT zajeciasala_fk		FOREIGN KEY (sala)	REFERENCES SSW..sale(nazwa),
	CONSTRAINT zajeciaDzienTygodniaId_fk FOREIGN KEY (dzienTygodniaId) REFERENCES SSW..dni_tygodnia(id),
);
GO

CREATE TABLE SSW..uczestnicy ( 
	id			int			IDENTITY(1,1),
	imie		varchar(30) NOT NULL,
	nazwisko	varchar(30) NOT NULL,
	plec		varchar(1)	NOT NULL,
	pesel		varchar(11) NOT NULL,
	nr_tel		varchar(9) NOT NULL,

	CONSTRAINT uczestnicyId_pk PRIMARY KEY (id),
	CONSTRAINT uczestnicyPesel_unique UNIQUE (pesel),
	CONSTRAINT uczestnicyPesel_check CHECK (pesel LIKE ('[0-9][0-9][0-1][0-9][0-3][0-9][0-9][0-9][0-9][0-9][0-9]')),
	CONSTRAINT uczestnicyPlec_check CHECK (plec IN ('M', 'K'))
);
GO

CREATE TABLE SSW..zapisy ( 
	id			int			IDENTITY(1,1),
	zajeciaId	int			NOT NULL,
	uczestnikId	int			NOT NULL,
	dataZapisu	datetime	DEFAULT GETDATE(),

	CONSTRAINT zapisyId_pk PRIMARY KEY (id),
	CONSTRAINT zapisyZajeciaId_fk FOREIGN KEY (zajeciaId) REFERENCES SSW..zajecia(id),
	CONSTRAINT zapisyUczestnikId_fk FOREIGN KEY (uczestnikId) REFERENCES SSW..uczestnicy(id)
);
GO

CREATE TABLE SSW..kwalifikacje ( 
	id			int			IDENTITY(1,1),
	sztuki_walkid		varchar(2)	NOT NULL,
	trenerId	int			NOT NULL,
	poziomId	int			NOT NULL,

	CONSTRAINT kwalifikacjeId_pk PRIMARY KEY (id),
	CONSTRAINT kwalifikacjesztuki_walkid_fk FOREIGN KEY (sztuki_walkid) REFERENCES SSW..sztuki_walki(id),
	CONSTRAINT kwalifikacjePoziomId_fk FOREIGN KEY (poziomId) REFERENCES SSW..poziomy(id),
	CONSTRAINT kwalifikacjetrenerId_fk FOREIGN KEY (trenerId) REFERENCES SSW..trenerzy(id)
);
GO

CREATE TABLE SSW..dziennik_zdarzen ( 
	id			int				IDENTITY(1,1),
	tabela		varchar(15)		NOT NULL,
	komunikat	varchar(300)	NOT NULL,
	dataZmian	datetime		DEFAULT GETDATE(),
);
GO
