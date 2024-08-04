-- Napraviti 5 jednostavnih upita 
SELECT *
FROM DODATNI_MATERIJALI;

SELECT *
FROM ZAPOSLENIK
WHERE tip_zaposlenika = 'Osoblje';

SELECT proizvod_id, naziv, cijena, kategorija_id
FROM PROIZVOD
WHERE cijena > 2;

SELECT naziv
FROM PROIZVOD
WHERE kategorija_id = 2;

SELECT *
FROM RACUN
WHERE EXTRACT(YEAR FROM datum) = 2024;

-- Napraviti 5 upita nad više tablica

SELECT Z.ime, Z.prezime, Z.pozicija, CB.ime "Caffe_bar", CB.grad
FROM ZAPOSLENIK Z JOIN CAFFE_BAR CB ON Z.caffe_id = CB.caffe_id;

SELECT N.narudzba_id, P.naziv "Proizvod", S.kolicina, P.cijena, S.kolicina * P.cijena "Ukupna_cijena"
FROM NARUDZBA N JOIN STAVKA S USING(narudzba_id)
JOIN PROIZVOD P USING(proizvod_id)
ORDER BY N.narudzba_id, P.naziv;

SELECT K.naziv "Kategorija", P.naziv "Proizvod", P.cijena
FROM KATEGORIJA K JOIN PROIZVOD P USING(kategorija_id)
ORDER BY K.naziv, P.naziv;

SELECT N.narudzba_id, Z.ime || ' ' || Z.prezime "Ime prezime zaposlenika"
FROM NARUDZBA N JOIN ZAPOSLENIK Z ON N.zaposlenik_id = Z.zaposlenik_id;
				
SELECT Z.ime, Z.prezime, SUM(PP.iznos) "Ukupna_zarada"
FROM ZAPOSLENIK Z JOIN POVIJEST_PLACE PP ON Z.zaposlenik_id = PP.zaposlenik_id
GROUP BY Z.ime, Z.prezime;

-- Napraviti 5 upita koristeći agregirajuće funkcije 

SELECT N.narudzba_id, SUM(S.kolicina * P.cijena) "Ukupna_cijena_narudzbe"
FROM NARUDZBA N JOIN STAVKA S ON N.narudzba_id = S.narudzba_id
                JOIN PROIZVOD P ON S.proizvod_id = P.proizvod_id
GROUP BY N.narudzba_id;

SELECT K.naziv "Kategorija", COUNT(P.proizvod_id) "Broj_proizvoda"
FROM KATEGORIJA K LEFT JOIN PROIZVOD P USING(kategorija_id)
GROUP BY K.naziv;

SELECT AVG(broj_sati) "Prosjecni_broj_sati" 
FROM POVIJEST_PLACE;

SELECT K.naziv "Kategorija", MAX(P.cijena) "Maksimalna_cijena"
FROM KATEGORIJA K LEFT JOIN PROIZVOD P USING(kategorija_id)
GROUP BY K.naziv;

SELECT K.naziv "Kategorija", SUM(S.kolicina) "Ukupan_broj_prodanih"
FROM KATEGORIJA K JOIN PROIZVOD P USING(kategorija_id)
                  JOIN STAVKA S USING(proizvod_id)
GROUP BY K.naziv;

-- Napraviti 5 upita u kojima će se koristiti nešto od sljedećeg: podupiti, ugniježđeni upiti ili skupovne operacije
SELECT ime, prezime
FROM ZAPOSLENIK
WHERE zaposlenik_id IN (
    SELECT zaposlenik_id
    FROM POVIJEST_PLACE
    WHERE broj_sati > 80
);
---------------------------------------------------------------------------------------------------
SELECT K.kupac_id, (
    SELECT SUM(R.ukupan_iznos)
    FROM NARUDZBA N JOIN RACUN R ON N.racun_id = R.racun_id
    WHERE N.kupac_id = K.kupac_id
) "Ukupan_iznos"
FROM KUPAC K;
---------------------------------------------------------------------------------------------------
SELECT naziv, cijena
FROM PROIZVOD
WHERE kategorija_id = (
    SELECT kategorija_id
    FROM KATEGORIJA
    WHERE naziv = 'Bezalkoholna pića' ) 
	AND cijena > (
    SELECT AVG(cijena)
    FROM PROIZVOD
);
---------------------------------------------------------------------------------------------------
SELECT kontakt
FROM ZAPOSLENIK
UNION
SELECT kontakt
FROM KUPAC;
---------------------------------------------------------------------------------------------------
SELECT ime, prezime
FROM ZAPOSLENIK
EXCEPT
	SELECT Z.ime, Z.prezime
	FROM NARUDZBA N JOIN ZAPOSLENIK Z USING (zaposlenik_id);
---------------------------------------------------------------------------------------------------
	
	
	
--Dodajte zadanu vrijednost na nekoliko atributa unutar baze (smisleno odabrati atribute na kojima će se dodati)
ALTER TABLE NARUDZBA
ALTER COLUMN datum SET DEFAULT CURRENT_DATE;
---------------------------------------------------------------------------------------------------
ALTER TABLE CAFFE_BAR
ALTER COLUMN drzava SET DEFAULT 'Hrvatska';
---------------------------------------------------------------------------------------------------
ALTER TABLE KATEGORIJA
ALTER COLUMN opis SET DEFAULT 'Nema opisa';
---------------------------------------------------------------------------------------------------
INSERT INTO KATEGORIJA (kategorija_id, naziv)
VALUES (100, 'Test kategorija');
SELECT * FROM KATEGORIJA;
DELETE FROM KATEGORIJA
WHERE kategorija_id = 100;
---------------------------------------------------------------------------------------------------



-- Dodajte nekoliko uvjeta (smislenih, na način da pronađete stvari koje ima smisla provjeriti kod unosa)
ALTER TABLE STAVKA
ADD CONSTRAINT stavka_kolicina_ck
CHECK (kolicina > 0);
---------------------------------------------------------------------------------------------------
ALTER TABLE PROIZVOD
ADD CONSTRAINT proizvod_cijena_ck
CHECK (cijena > 0);
---------------------------------------------------------------------------------------------------
ALTER TABLE PROIZVOD
ALTER COLUMN naziv SET NOT NULL;
---------------------------------------------------------------------------------------------------
ALTER TABLE KUPAC
ADD CONSTRAINT kupac_email_unique
UNIQUE (email);
---------------------------------------------------------------------------------------------------



--Dodajte komentare na tablice unutar modela
COMMENT ON TABLE CAFFE_BAR IS 'Tablica sadrži informacije o Caffe Baru.';
COMMENT ON TABLE DOBAVLJAC IS 'Tablica sadrži informacije o dobavljaču proizvoda.';
COMMENT ON TABLE DOBAVLJANJE_PROIZVODA IS 'Tablica sadrži informacije o dobavljanju proizvoda.';
COMMENT ON TABLE DODATNI_MATERIJALI IS 'Tablica sadrži informacije o dodatnim materijalima.';
COMMENT ON TABLE KATEGORIJA IS 'Tablica sadrži informacije o kategorijama proizvoda.';
COMMENT ON TABLE KUPAC IS 'Tablica sadrži informacije o kupcima.';
COMMENT ON TABLE NARUDZBA IS 'Tablica sadrži informacije o narudžbi.';
COMMENT ON TABLE POVIJEST_PLACE IS 'Tablica sadrži povijest plaće zaposlenika.';
COMMENT ON TABLE PROIZVOD IS 'Tablica sadrži detalje proizvoda.';
COMMENT ON TABLE RACUN IS 'Tablica sadrži informacije računa.';
COMMENT ON TABLE STAVKA IS 'Tablica sadrži informacije o količini proizvoda u narudžbi.';
COMMENT ON TABLE ZAPOSLENIK IS 'Tablica sadrži informacije o zaposlenicima.';
---------------------------------------------------------------------------------------------------



--Dodajte neke od indeksa koji bi mogli dovesti do ubrzanja upita na Vašoj bazi
CREATE INDEX povijest_place_datum_index ON POVIJEST_PLACE (datum);
CREATE INDEX proizvod_kategorija_index ON PROIZVOD (kategorija_id);
CREATE INDEX proizvod_cijena_index ON PROIZVOD (cijena);
---------------------------------------------------------------------------------------------------



--Napraviti barem dva okidača (sami odlučujete kakva)
CREATE OR REPLACE FUNCTION provjeri_cijenu()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.cijena <= 0 THEN
        RAISE EXCEPTION 'Cijena proizvoda mora biti veća od 0!';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER provjeri_cijenu_trigger
BEFORE INSERT OR UPDATE ON PROIZVOD
FOR EACH ROW
EXECUTE FUNCTION provjeri_cijenu();

INSERT INTO PROIZVOD (naziv, cijena, dobavljac_id, kategorija_id) 
VALUES ('Okidač 1', -10.00, 1, 1);
---------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION provjeri_racun()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
					SELECT 1 
					FROM RACUN
					WHERE racun_id = NEW.racun_id) 
	THEN
        RAISE EXCEPTION 'Narudžba mora imati povezan račun!';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER provjeri_racun_trigger
BEFORE INSERT ON NARUDZBA
FOR EACH ROW
EXECUTE FUNCTION provjeri_racun();

INSERT INTO NARUDZBA (datum, kupac_id, zaposlenik_id) VALUES ('2024-06-28', 1, 1);
---------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION provjeri_kolicinu()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
   dostupno INTEGER;
BEGIN
    SELECT (kolicina) INTO dostupno
    FROM DOBAVLJANJE_PROIZVODA
    WHERE proizvod_id = NEW.proizvod_id;
    IF dostupno < NEW.kolicina THEN
        RAISE EXCEPTION 'Nema dovoljne količine proizvoda sa ID-jem %.', NEW.proizvod_id;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER kolicina_trigger
BEFORE INSERT ON STAVKA
FOR EACH ROW
EXECUTE FUNCTION provjeri_kolicinu();

INSERT INTO STAVKA (narudzba_id, proizvod_id, kolicina) 
VALUES (1, 1, 1000);
---------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION azuriraj_ukupnu_cijenu()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE RACUN
    SET ukupan_iznos = ukupan_iznos + (NEW.kolicina * (SELECT cijena 
													   FROM PROIZVOD 
													   WHERE proizvod_id = NEW.proizvod_id))
    WHERE racun_id = NEW.narudzba_id;
    RETURN NEW;
END;
$$;

CREATE TRIGGER cijena_trigger
AFTER INSERT ON STAVKA
FOR EACH ROW
EXECUTE FUNCTION azuriraj_ukupnu_cijenu();

SELECT * 
FROM RACUN 
WHERE racun_id = 1;

INSERT INTO STAVKA (narudzba_id, proizvod_id, kolicina)
VALUES (1, 10, 3);  

SELECT * 
FROM RACUN 
WHERE racun_id = 1;

SELECT
    RACUN.racun_id,
    RACUN.naziv_caffe_bara,
    RACUN.adresa,
    RACUN.datum,
    RACUN.vrijeme,
    PROIZVOD.naziv "naziv_proizvoda",
	PROIZVOD.cijena "cijena_proizvoda",
    STAVKA.kolicina
FROM
    RACUN JOIN NARUDZBA USING(racun_id)
	JOIN STAVKA USING (narudzba_id)
    JOIN PROIZVOD  USING (proizvod_id)
WHERE  RACUN.racun_id = 1;
---------------------------------------------------------------------------------------------------



--Napraviti barem dvije procedure (sami odlučujete za što i kakve)
CREATE OR REPLACE PROCEDURE dodaj_proizvod(
	IN p_id INTEGER,
    IN p_naziv VARCHAR(100),
    IN p_cijena DECIMAL(10, 2),
    IN p_opis TEXT,
    IN p_dobavljac_id INTEGER,
    IN p_kategorija_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO PROIZVOD (proizvod_id, naziv, cijena, opis, dobavljac_id, kategorija_id)
    VALUES (p_id, p_naziv, p_cijena, p_opis, p_dobavljac_id, p_kategorija_id);
END;
$$;
---------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE obrisi_proizvod(
    IN p_proizvod_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM PROIZVOD 
	WHERE proizvod_id = p_proizvod_id;
END;
$$;
---------------------------------------------------------------------------------------------------

CALL dodaj_proizvod(623,'Novi proizvod', 3.50, 'Ovo je novi proizvod', 1, 1);
SELECT * FROM PROIZVOD;
CALL obrisi_proizvod(623);
SELECT * FROM PROIZVOD;
---------------------------------------------------------------------------------------------------

