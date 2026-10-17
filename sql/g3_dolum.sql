-- ============================================================
-- sql/g3_dolum.sql  |  Gorev 3 - Veriyi Temiz Semaya Tasima
-- Ogrenci: 240541612
--
-- NOT: Betigi ikinci kez calistirmadan once tablolari bosaltin:
-- TRUNCATE telefonlar, kayitlar, dersler, egitmenler, salonlar, uyeler
--          RESTART IDENTITY CASCADE;
-- ============================================================

-- ------------------------------------------------------------
-- Adim 1: uyeler  (uye_id ve ad dogrudan tasiniyor)
-- ------------------------------------------------------------
INSERT INTO uyeler (uye_id, ad)
SELECT DISTINCT uye_id, uye_ad
FROM duz_kayitlar
ORDER BY uye_id;

-- ------------------------------------------------------------
-- Adim 2: egitmenler  (SERIAL id PostgreSQL tarafindan uretilir)
-- ------------------------------------------------------------
INSERT INTO egitmenler (ad, brans)
SELECT DISTINCT egitmen_ad, egitmen_brans
FROM duz_kayitlar
ORDER BY egitmen_ad;

-- ------------------------------------------------------------
-- Adim 3: salonlar  (SERIAL id PostgreSQL tarafindan uretilir)
-- ------------------------------------------------------------
INSERT INTO salonlar (ad, kapasite)
SELECT DISTINCT salon_ad, salon_kapasite
FROM duz_kayitlar
ORDER BY salon_ad;

-- ------------------------------------------------------------
-- Adim 4: telefonlar  — unnest teknigi ile her numara ayri satir
--   Once uye basina tek satira indir (DISTINCT uye_id, uye_telefonlar),
--   sonra noktali virgul ile bol ve her numarayi ayri satira ac.
-- ------------------------------------------------------------
INSERT INTO telefonlar (uye_id, numara)
SELECT DISTINCT
    tek.uye_id,
    TRIM(unnest(string_to_array(tek.uye_telefonlar, ';'))) AS numara
FROM (
    SELECT DISTINCT uye_id, uye_telefonlar
    FROM duz_kayitlar
) AS tek
ORDER BY tek.uye_id;

-- ------------------------------------------------------------
-- Adim 5: dersler  — egitmen ve salon SERIAL id'lerini JOIN ile bul,
--   ucret tutarsizligini MIN() ile coz (yonetim karari: uyeyi magdur etme)
-- ------------------------------------------------------------
INSERT INTO dersler (ders_id, ad, egitmen_id, salon_id, ucret)
SELECT DISTINCT
    dk.ders_id,
    dk.ders_ad,
    e.egitmen_id,
    s.salon_id,
    min_u.min_ucret
FROM duz_kayitlar dk
JOIN egitmenler e ON e.ad = dk.egitmen_ad
JOIN salonlar   s ON s.ad = dk.salon_ad
JOIN (
    SELECT ders_id, MIN(ucret) AS min_ucret
    FROM duz_kayitlar
    GROUP BY ders_id
) AS min_u ON min_u.ders_id = dk.ders_id
ORDER BY dk.ders_id;

-- Dogrulama: dersler tablosundaki ucretler
-- Sabah Yogasi  → 150.00  (160 ile 150 arasinda MIN)
-- CrossFit Pro  → 240.00  (250 ile 240 arasinda MIN)

-- ------------------------------------------------------------
-- Adim 6: kayitlar  (uye_id + ders_id + tarih tasiniyor)
-- ------------------------------------------------------------
INSERT INTO kayitlar (uye_id, ders_id, tarih)
SELECT uye_id, ders_id, tarih
FROM duz_kayitlar
ORDER BY kayit_id;
