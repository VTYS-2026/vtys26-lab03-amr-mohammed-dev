-- uyeler
INSERT INTO uyeler (uye_id, ad)
SELECT DISTINCT uye_id, uye_ad
FROM duz_kayitlar
ORDER BY uye_id;

-- egitmenler
INSERT INTO egitmenler (ad, brans)
SELECT DISTINCT egitmen_ad, egitmen_brans
FROM duz_kayitlar
ORDER BY egitmen_ad;

-- salonlar
INSERT INTO salonlar (ad, kapasite)
SELECT DISTINCT salon_ad, salon_kapasite
FROM duz_kayitlar
ORDER BY salon_ad;

-- telefonlar
INSERT INTO telefonlar (uye_id, numara)
SELECT DISTINCT
    tek.uye_id,
    TRIM(unnest(string_to_array(tek.uye_telefonlar, ';'))) AS numara
FROM (
    SELECT DISTINCT uye_id, uye_telefonlar
    FROM duz_kayitlar
) AS tek
ORDER BY tek.uye_id;

-- dersler
INSERT INTO dersler (ders_id, ad, egitmen_id, salon_id, ucret)
SELECT
    d.ders_id,
    d.ders_ad,
    e.egitmen_id,
    s.salon_id,
    MIN(d.ucret) AS ucret
FROM duz_kayitlar d
JOIN egitmenler e ON e.ad = d.egitmen_ad
JOIN salonlar s ON s.ad = d.salon_ad
GROUP BY d.ders_id, d.ders_ad, e.egitmen_id, s.salon_id
ORDER BY d.ders_id;

-- kayitlar
INSERT INTO kayitlar (uye_id, ders_id, tarih)
SELECT uye_id, ders_id, tarih
FROM duz_kayitlar
ORDER BY kayit_id;
