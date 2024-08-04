
INSERT INTO CAFFE_BAR (caffe_id, ime, adresa, grad, drzava) VALUES
(1, 'Caffe Bar Passagge', 'Trg kralja Tomislava 16', 'Osijek', 'Hrvatska');


INSERT INTO ZAPOSLENIK (zaposlenik_id, ime, prezime, datum_zaposljavanja, kontakt, pozicija, tip_zaposlenika, caffe_id) VALUES
(1, 'Lana', 'Ivanić', '2023-05-05', '095456123', 'Konobar', 'Osoblje', 1),
(2, 'Ivan', 'Ivanić', '2023-07-23', '097257152', 'Konobar', 'Osoblje', 1),
(3, 'Marko', 'Marković', '2021-02-13', '095251054', 'Konobar', 'Upravitelj', 1);


INSERT INTO POVIJEST_PLACE (zaposlenik_id, datum, iznos, broj_sati) VALUES
(1, '2024-05-15', 950, 140),
(2,'2024-05-15', 650, 98),
(3, '2024-05-15', 1070, 152);


INSERT INTO KUPAC (kupac_id, kontakt, adresa, email) VALUES
(1, '095632425', 'Osječka 10', 'kupac1@email.com'),
(5, NULL, NULL, NULL);


INSERT INTO RACUN (racun_id, naziv_caffe_bara, adresa, datum, vrijeme, ime_blagajnika, kolicina, cijena, ukupan_iznos, nacin_placanja, porez, postotak, osnovica_poreza, iznos_poreza, jir, zki) VALUES
(1, 'Caffe Bar Passagge', 'Trg kralja Tomislava 16', '2024-05-31', '18:30', 'Lana Ivanic', 5, 2.00, (5 * 2.00), 'Gotovina', 10.00, 3.00, 3.20, 0.16, '123456789', '987654321'),
(2, 'Caffe Bar Passagge', 'Trg kralja Tomislava 16', '2024-06-01', '10:14', 'Lana Ivanic', 5, 1.90, (5 * 1.90), 'Gotovina', 10.00, 3.00, 50.00, 2.50, '123456789', '987654321');

INSERT INTO NARUDZBA (narudzba_id, datum, kupac_id, zaposlenik_id, racun_id) VALUES
(1, '2024-05-02', 1, 1, 1),
(2, '2024-03-03', 5, 1, 2);


INSERT INTO DOBAVLJAC (dobavljac_id, naziv_tvrtke, adresa, drzava, kontakt) VALUES
(1, 'Dobavljac d.o.o.', 'Ilica 20', 'Hrvatska', '065432197');


INSERT INTO KATEGORIJA (kategorija_id, naziv) VALUES
(1, 'Bezalkoholna pića'),
(2, 'Topli napitci'),
(3, 'Vino'),
(4, 'Pivo'),
(5, 'Alkoholna pića'),
(6, 'Cider'),
(7, 'Kokteli');


INSERT INTO PROIZVOD (proizvod_id, naziv, cijena, opis, dobavljac_id, kategorija_id) VALUES
    (1, 'Coca-Cola', 2.00, NULL, 1, 1),
    (2, 'Coca-Cola Zero Sugar', 2.00, NULL, 1, 1),
    (3, 'Fanta', 2.00, NULL, 1, 1),
    (4, 'Sprite', 2.00, NULL, 1, 1),
    (5, 'Schweppes', 2.00, NULL, 1, 1),
    (6, 'Cedevita', 1.50, NULL, 1, 1),
    (7, 'FUZETEA', 2.00, 'Breskva i hibiskus, Šumsko voće', 1, 1),
    (8, 'Red Bull', 2.50, NULL, 1, 1),
    (9, 'Romeequelle', 1.60, NULL, 1, 1),
    (10, 'Kava mala', 1.40, NULL, 1, 2),
    (11, 'Kava produžena', 1.40, NULL, 1, 2),
    (12, 'Caffe Latte', 1.40, NULL, 1, 2),
    (13, 'Kava šlag-mlijeko', 1.40, NULL, 1, 2),
    (14, 'Cappuccino', 1.50, NULL, 1, 2),
    (15, 'Bijela kava', 1.50, NULL, 1, 2),
    (16, 'Nescafe', 1.50, NULL, 1, 2),
    (17, 'Topla čokolada', 2.00, NULL, 1, 2),
    (18, 'Ledena kava', 2.00, NULL, 1, 2),
    (19, 'Čaj', 1.00, NULL, 1, 2),
    (20, 'Kakao', 1.50, NULL, 1, 2),
    (21, 'Kava bez kofeina', 1.06, NULL, 1, 2),
    (22, 'Vino bijelo', 1.00, NULL, 1, 3),
    (23, 'Vino crno', 1.00, NULL, 1, 3),
    (24, 'Gemišt', 2.00, NULL, 1, 3),
    (25, 'Bambus', 2.00, NULL, 1, 3),
    (26, 'Pol - Pol', 1.30, NULL, 1, 3),
    (27, 'Martini', 2.00, NULL, 1, 3),
    (28, 'Vermouth', 20.00, NULL, 1, 3),
    (29, 'Ožujsko', 2.20, NULL, 1, 4),
    (30, 'Ožujsko radler', 2.20, NULL, 1, 4),
    (31, 'Staropramen', 2.20, NULL, 1, 4),
    (32, 'Tomislav', 2.20, NULL, 1, 4),
    (33, 'Becks', 2.20, NULL, 1, 4),
    (34, 'Stella Artois', 2.20, NULL, 1, 4),
    (35, 'Osječko', 2.20, NULL, 1, 4),
    (36, 'Heineken', 2.20, NULL, 1, 4),
    (37, 'Corona', 3.00, NULL, 1, 4),
    (38, 'Strano craft pivo', 3.00, NULL, 1, 4),
    (39, 'Točeno pivo', 3.00, NULL, 1, 4),
    (40, 'Somersby', 2.40, NULL, 1, 6),
    (41, 'Mojito', 2.39, NULL, 1, 7),
    (42, 'Cuba Libre', 2.39, NULL, 1, 7),
    (43, 'Sex on the beach', 2.39, NULL, 1, 7),
    (44, 'Cosmopolitan', 2.39, NULL, 1, 7),
    (45, 'Vodka', 2.10, NULL, 1, 5),
    (46, 'Vodka voćna', 1.80, NULL, 1, 5),
    (47, 'Rum', 1.50, NULL, 1, 5),
    (48, 'Vilijamovka', 2.50, NULL, 1, 5),
    (49, 'Pelinkovac Antique', 2.20, NULL, 1, 5),
    (50, 'Stock', 2.70, NULL, 1, 5),
    (51, 'Amaro', 2.40, NULL, 1, 5),
    (52, 'Gin', 2.60, NULL, 1, 5),
    (53, 'Jagermeister', 2.30, NULL, 1, 5),
    (54, 'Likeri', 1.90, NULL, 1, 5),
    (55, 'Rakije', 2.00, NULL, 1, 5),
    (56, 'Whiskey', 2.70, NULL, 1, 5),
    (57, 'Jack Daniels', 2.20, NULL, 1, 5),
    (58, 'The Famous Grouse', 1.70, NULL, 1, 5);


INSERT INTO STAVKA (narudzba_id, proizvod_id, kolicina) VALUES
(1, 1, 2),
(1, 2, 1),
(1, 3, 1),
(2, 4, 3),
(2, 5, 2);


INSERT INTO DOBAVLJANJE_PROIZVODA (dobavljanje_id, kolicina, narudzbena_cijena, proizvodac, datum, proizvod_id, dobavljac_id) VALUES
(1, 100, 1.20, 'Coca-Cola Company', '2024-05-01', 1, 1),
(2, 150, 1.20, 'Coca-Cola Company', '2024-05-01', 2, 1),
(3, 80, 1.05, 'Anheuser-Busch InBev', '2024-05-01', 37, 1);


INSERT INTO DODATNI_MATERIJALI (dodatni_id, naziv, cijena, opis, dobavljac_id) VALUES
(1, 'Bijeli šećer', 1.00, 'Bijeli šećer', 1),
(2, 'Smeđi šećer', 1.00, 'Smeđi šećer', 1),
(3, 'Mlijeko', 0.75, 'Mlijeko', 1),
(4, 'Naranče', 1.25, 'Naranče za cijeđeni sok', 1);

SELECT *
FROM PROIZVOD;

ALTER TABLE RACUN
DROP COLUMN cijena;