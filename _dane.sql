
INSERT INTO SSW..sztuki_walki VALUES ('KF', 'kung-fu');
INSERT INTO SSW..sztuki_walki VALUES ('K', 'karate');
INSERT INTO SSW..sztuki_walki VALUES ('J', 'judo');
INSERT INTO SSW..sztuki_walki VALUES ('A', 'aikido');
INSERT INTO SSW..sztuki_walki VALUES ('TC', 'taichi');
INSERT INTO SSW..sztuki_walki VALUES ('JJ', 'jujitsu');
INSERT INTO SSW..sztuki_walki VALUES ('T', 'taekwondo');
INSERT INTO SSW..sztuki_walki VALUES ('C', 'capoeira');
SELECT * FROM SSW..sztuki_walki

------------------------------------------------------------------------

INSERT INTO SSW..poziomy VALUES ('Początkujący');
INSERT INTO SSW..poziomy VALUES ('Średnio zaawansowany');
INSERT INTO SSW..poziomy VALUES ('Zaawansowany');
SELECT * FROM SSW..poziomy

------------------------------------------------------------------------
INSERT INTO SSW..trenerzy VALUES ('Piotr', 'Rabęcki', 'prabecki@onet.pl', '501501501', NULL, '1999-03-15', NULL, 30.00 );
INSERT INTO SSW..trenerzy VALUES ('Robert', 'Smoliński', 'rsmolinski@gmail.pl', '502502502', 1, '2000-10-12', NULL, 35.00 );
INSERT INTO SSW..trenerzy VALUES ('Sylwia', 'Trzeszczak', 'strzeszczak@interia.pl', '503503503', 1, '2002-04-03', NULL, 40.00 );
INSERT INTO SSW..trenerzy VALUES ('Tomasz', 'Ulatowski', 'tulatowski@gmail.pl', '504504504', 1, '2005-08-25', NULL, 50.00 );
INSERT INTO SSW..trenerzy VALUES ('Urszula', 'Wieteska', 'uwieteska@onet.pl', '505505505', 1, '1998-07-08', NULL, 50.00 );
SELECT * FROM SSW..trenerzy

------------------------------------------------------------------------


INSERT INTO SSW..trenerzyArchiwum VALUES (10, 'Wladimir', 'Yatsymirsky', 'wyat@gmail.pl', '601601601', NULL, '1998-02-15', '2001-02-03', 40.00 );
INSERT INTO SSW..trenerzyArchiwum VALUES (11, 'Yan', 'Xandinho', 'yxan@onet.pl', '601601601', NULL, '1999-07-30', '2005-06-03', 30.00 );
SELECT * FROM SSW..trenerzyArchiwum

------------------------------------------------------------------------
INSERT INTO SSW..dni_tygodnia VALUES ('PN', 'Poniedziałek');
INSERT INTO SSW..dni_tygodnia VALUES ('WT', 'Wtorek');
INSERT INTO SSW..dni_tygodnia VALUES ('ŚR', 'Środa');
INSERT INTO SSW..dni_tygodnia VALUES ('CZ', 'Czwartek');
INSERT INTO SSW..dni_tygodnia VALUES ('PT', 'Piątek');
INSERT INTO SSW..dni_tygodnia VALUES ('SB', 'Sobota');
INSERT INTO SSW..dni_tygodnia VALUES ('NDZ', 'Niedziela');
SELECT * FROM SSW..dni_tygodnia

------------------------------------------------------------------------
INSERT INTO SSW..sale VALUES ('mała', '25');
INSERT INTO SSW..sale VALUES ('duża', '40');
SELECT * FROM SSW..sale

------------------------------------------------------------------------
INSERT INTO SSW..zajecia VALUES ('KF', 1, 1, 'mała', 'PN', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('KF', 2, 1, 'mała', 'PN', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('K', 3, 2, 'mała', 'PN', '19:45:00');
INSERT INTO SSW..zajecia VALUES ('K', 1, 2, 'mała', 'WT', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('K', 2, 2, 'mała', 'WT', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('KF', 3, 1, 'mała', 'WT', '19:45:00');

INSERT INTO SSW..zajecia VALUES ('J', 1, 3, 'duża', 'PN', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('J', 2, 3, 'duża', 'PN', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('C', 3, 5, 'duża', 'PN', '19:45:00');
INSERT INTO SSW..zajecia VALUES ('C', 1, 5, 'duża', 'WT', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('C', 2, 5, 'duża', 'WT', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('J', 3, 3, 'duża', 'WT', '19:45:00');

INSERT INTO SSW..zajecia VALUES ('A', 1, 4, 'mała', 'ŚR', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('A', 2, 4, 'mała', 'ŚR', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('TC', 3, 5, 'mała', 'ŚR', '19:45:00');
INSERT INTO SSW..zajecia VALUES ('TC', 1, 5, 'mała', 'CZ', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('TC', 2, 5, 'mała', 'CZ', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('A', 3, 4, 'mała', 'CZ', '19:45:00');

INSERT INTO SSW..zajecia VALUES ('T', 1, 4, 'duża', 'ŚR', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('T', 2, 4, 'duża', 'ŚR', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('JJ', 3, 3, 'duża', 'ŚR', '19:45:00');
INSERT INTO SSW..zajecia VALUES ('JJ', 1, 3, 'duża', 'CZ', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('JJ', 2, 3, 'duża', 'CZ', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('T', 3, 4, 'duża', 'CZ', '19:45:00');

INSERT INTO SSW..zajecia VALUES ('T', 1, 4, 'mała', 'PT', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('T', 2, 4, 'mała', 'PT', '18:00:00');
INSERT INTO SSW..zajecia VALUES ('J', 1, 3, 'duża', 'PT', '16:15:00');
INSERT INTO SSW..zajecia VALUES ('J', 2, 3, 'duża', 'PT', '18:00:00');

SELECT * FROM SSW..zajecia

------------------------------------------------------------------------
INSERT INTO SSW..uczestnicy VALUES ('Adam', 'Bednarski', 'M', '62102116371', '501712936');
INSERT INTO SSW..uczestnicy VALUES ('Beata', 'Cedrowska', 'K', '09121323133', '502712936');
INSERT INTO SSW..uczestnicy VALUES ('Cezary', 'Długosz', 'M', '80090414815', '503712936');
INSERT INTO SSW..uczestnicy VALUES ('Dorota', 'Epicka', 'K', '75072112319', '504712936');
INSERT INTO SSW..uczestnicy VALUES ('Elżebita', 'Frątczak', 'K', '82072703928', '505712936');
INSERT INTO SSW..uczestnicy VALUES ('Franciszek', 'Gołembiewski', 'M', '52082906752', '506712936');
INSERT INTO SSW..uczestnicy VALUES ('Grażyna', 'Halicka', 'K', '53080202581', '507712936');
INSERT INTO SSW..uczestnicy VALUES ('Henryk', 'Iwański', 'M', '95120916690', '508712936');
INSERT INTO SSW..uczestnicy VALUES ('Irena', 'Jodłowska', 'K', '95041909674', '509712936');
INSERT INTO SSW..uczestnicy VALUES ('Jolanta', 'Kowalska', 'K', '73103013376', '510712936');
INSERT INTO SSW..uczestnicy VALUES ('Krzysztof', 'Ludwisiak', 'M', '73031002152', '511712936');
INSERT INTO SSW..uczestnicy VALUES ('Lena', 'Łukasik', 'K', '97041324431', '512712936');
INSERT INTO SSW..uczestnicy VALUES ('Łucja', 'Marczak', 'K', '58060210509', '513712936');
INSERT INTO SSW..uczestnicy VALUES ('Mirosław', 'Nowak', 'M', '02102922499', '514712936');
INSERT INTO SSW..uczestnicy VALUES ('Natalia', 'Olczak', 'K', '55021821196', '515712936');
INSERT INTO SSW..uczestnicy VALUES ('Oleg', 'Pavlyshyn', 'M', '70051500699', '516712936');

INSERT INTO SSW..uczestnicy VALUES ('Andrzej', 'Bednarski', 'M', '72102116371', '517712936');
INSERT INTO SSW..uczestnicy VALUES ('Barbara', 'Cedrowska', 'K', '99011323133', '518712936');
INSERT INTO SSW..uczestnicy VALUES ('Czesław', 'Długosz', 'M', '90090414815', '519712936');
INSERT INTO SSW..uczestnicy VALUES ('Dagmara', 'Epicka', 'K', '85072112319', '520712936');
INSERT INTO SSW..uczestnicy VALUES ('Aliza', 'Frątczak', 'K', '72072703928', '521712936');
INSERT INTO SSW..uczestnicy VALUES ('Faustyn', 'Gołembiewski', 'M', '62082906752', '522712936');
INSERT INTO SSW..uczestnicy VALUES ('Gaja', 'Halicka', 'K', '63080202581', '523712936');
INSERT INTO SSW..uczestnicy VALUES ('Horacy', 'Iwański', 'M', '85120916690', '524712936');
INSERT INTO SSW..uczestnicy VALUES ('Irmina', 'Jodłowska', 'K', '85041909674', '525712936');
INSERT INTO SSW..uczestnicy VALUES ('Jadwiga', 'Kowalska', 'K', '83103013376', '526712936');
INSERT INTO SSW..uczestnicy VALUES ('Konstantty', 'Ludwisiak', 'M', '93031002152', '527712936');
INSERT INTO SSW..uczestnicy VALUES ('Lara', 'Łukasik', 'K', '87041324431', '528712936');
INSERT INTO SSW..uczestnicy VALUES ('Łukasz', 'Marczak', 'M', '68060210509', '529712936');
INSERT INTO SSW..uczestnicy VALUES ('Marek', 'Nowak', 'M', '92032922499', '530712936');
INSERT INTO SSW..uczestnicy VALUES ('Nikola', 'Olczak', 'K', '65021821196', '531712936');
INSERT INTO SSW..uczestnicy VALUES ('Olgierd', 'Piotrowicz', 'M', '80051500699', '532712936');
SELECT * FROM SSW..uczestnicy

------------------------------------------------------------------------

INSERT INTO SSW..kwalifikacje VALUES ('KF', 1, 1);
INSERT INTO SSW..kwalifikacje VALUES ('KF', 1, 2);
INSERT INTO SSW..kwalifikacje VALUES ('KF', 1, 3);
INSERT INTO SSW..kwalifikacje VALUES ('K', 2, 1);
INSERT INTO SSW..kwalifikacje VALUES ('K', 2, 2);
INSERT INTO SSW..kwalifikacje VALUES ('K', 2, 3);
INSERT INTO SSW..kwalifikacje VALUES ('J', 3, 1);
INSERT INTO SSW..kwalifikacje VALUES ('J', 3, 2);
INSERT INTO SSW..kwalifikacje VALUES ('J', 3, 3);
INSERT INTO SSW..kwalifikacje VALUES ('A', 4, 1);
INSERT INTO SSW..kwalifikacje VALUES ('A', 4, 2);
INSERT INTO SSW..kwalifikacje VALUES ('A', 4, 3);
INSERT INTO SSW..kwalifikacje VALUES ('TC', 5, 1);
INSERT INTO SSW..kwalifikacje VALUES ('TC', 5, 2);
INSERT INTO SSW..kwalifikacje VALUES ('TC', 5, 3);
INSERT INTO SSW..kwalifikacje VALUES ('JJ', 3, 1);
INSERT INTO SSW..kwalifikacje VALUES ('JJ', 3, 2);
INSERT INTO SSW..kwalifikacje VALUES ('JJ', 3, 3);
INSERT INTO SSW..kwalifikacje VALUES ('T', 4, 1);
INSERT INTO SSW..kwalifikacje VALUES ('T', 4, 2);
INSERT INTO SSW..kwalifikacje VALUES ('T', 4, 3);
INSERT INTO SSW..kwalifikacje VALUES ('C', 5, 1);
INSERT INTO SSW..kwalifikacje VALUES ('C', 5, 2);
INSERT INTO SSW..kwalifikacje VALUES ('C', 5, 3);
SELECT * FROM SSW..kwalifikacje

------------------------------------------------------------------------

INSERT INTO SSW..zapisy VALUES (1, 1, '2018-04-02');
--INSERT INTO SSW..zapisy VALUES (1, 2, '2018-04-04');
INSERT INTO SSW..zapisy VALUES (1, 3, '2018-04-06');
INSERT INTO SSW..zapisy VALUES (1, 4, '2018-04-08');
INSERT INTO SSW..zapisy VALUES (1, 5, '2018-04-10');
INSERT INTO SSW..zapisy VALUES (1, 6, '2018-04-01');
INSERT INTO SSW..zapisy VALUES (1, 7, '2018-04-03');
INSERT INTO SSW..zapisy VALUES (1, 8, '2018-04-05');
INSERT INTO SSW..zapisy VALUES (1, 9, '2018-04-07');
INSERT INTO SSW..zapisy VALUES (1, 10, '2018-04-09');

INSERT INTO SSW..zapisy VALUES (2, 11, '2018-04-11');
INSERT INTO SSW..zapisy VALUES (2, 12, '2018-04-11');
INSERT INTO SSW..zapisy VALUES (2, 13, '2018-04-12');
INSERT INTO SSW..zapisy VALUES (2, 14, '2018-04-13');
INSERT INTO SSW..zapisy VALUES (2, 15, '2018-04-14');
INSERT INTO SSW..zapisy VALUES (2, 16, '2018-04-15');
INSERT INTO SSW..zapisy VALUES (2, 17, '2018-04-16');
INSERT INTO SSW..zapisy VALUES (2, 18, '2018-04-17');
INSERT INTO SSW..zapisy VALUES (2, 19, '2018-04-18');
INSERT INTO SSW..zapisy VALUES (2, 20, '2018-04-19');

INSERT INTO SSW..zapisy VALUES (3, 21, '2018-04-20');
INSERT INTO SSW..zapisy VALUES (3, 22, '2018-04-21');
INSERT INTO SSW..zapisy VALUES (3, 23, '2018-04-22');
INSERT INTO SSW..zapisy VALUES (3, 24, '2018-04-23');
INSERT INTO SSW..zapisy VALUES (3, 25, '2018-04-24');
INSERT INTO SSW..zapisy VALUES (3, 26, '2018-04-25');
INSERT INTO SSW..zapisy VALUES (3, 27, '2018-04-26');
INSERT INTO SSW..zapisy VALUES (3, 28, '2018-04-27');
INSERT INTO SSW..zapisy VALUES (3, 29, '2018-04-28');
INSERT INTO SSW..zapisy VALUES (3, 30, '2018-04-29');

INSERT INTO SSW..zapisy VALUES (4, 31, '2018-04-01');
INSERT INTO SSW..zapisy VALUES (4, 32, '2018-04-02');
INSERT INTO SSW..zapisy VALUES (4, 16, '2018-04-03');
INSERT INTO SSW..zapisy VALUES (4, 17, '2018-04-04');
INSERT INTO SSW..zapisy VALUES (4, 18, '2018-04-05');
INSERT INTO SSW..zapisy VALUES (4, 19, '2018-04-06');
INSERT INTO SSW..zapisy VALUES (4, 1, '2018-04-07');
INSERT INTO SSW..zapisy VALUES (4, 2, '2018-04-08');
INSERT INTO SSW..zapisy VALUES (4, 3, '2018-04-09');
INSERT INTO SSW..zapisy VALUES (4, 4, '2018-04-01');

INSERT INTO SSW..zapisy VALUES (5, 5, '2018-04-11');
INSERT INTO SSW..zapisy VALUES (5, 6, '2018-04-12');
INSERT INTO SSW..zapisy VALUES (5, 7, '2018-04-13');
INSERT INTO SSW..zapisy VALUES (5, 8, '2018-04-14');
INSERT INTO SSW..zapisy VALUES (5, 9, '2018-04-15');
INSERT INTO SSW..zapisy VALUES (5, 10, '2018-04-16');
INSERT INTO SSW..zapisy VALUES (5, 11, '2018-04-17');
INSERT INTO SSW..zapisy VALUES (5, 12, '2018-04-18');
INSERT INTO SSW..zapisy VALUES (5, 13, '2018-04-19');
INSERT INTO SSW..zapisy VALUES (5, 14, '2018-04-10');
INSERT INTO SSW..zapisy VALUES (5, 15, '2018-04-11');

SELECT * FROM SSW..zapisy