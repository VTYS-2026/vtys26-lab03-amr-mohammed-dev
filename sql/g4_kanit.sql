-- ============================================================
-- sql/g4_kanit.sql  |  Gorev 4 - Kazanci Kanitla
-- Ogrenci: 240541612
-- ============================================================

-- ------------------------------------------------------------
-- 4.1  Satir sayisi karsilastirmasi
--      Iki sayi esitse tasimada veri kaybi yok demektir.
-- ------------------------------------------------------------
SELECT
    (SELECT COUNT(*) FROM duz_kayitlar) AS duz_tablo_satir_sayisi,
    (SELECT COUNT(*) FROM kayitlar)     AS temiz_tablo_satir_sayisi;

-- Beklenen: 25 | 25

-- ------------------------------------------------------------
-- 4.2  En cok satirda geçen egitmen: Ahmet Yilmaz (8 satir)
--
--  a) duz_kayitlar'da guncelle  → 8 satir etkilenir
--  b) egitmenler'de guncelle    → 1 satir etkilenir
--
--  Fark normalizasyonun ozeti:
--    Kirli tabloda ayni degisiklik icin 8 satir,
--    temiz semada yalnizca 1 satir!
-- ------------------------------------------------------------

-- a) Kirli tablo
UPDATE duz_kayitlar
SET    egitmen_ad = 'Ahmet Y. (guncellendi)'
WHERE  egitmen_ad = 'Ahmet Yilmaz';

-- b) Temiz sema
UPDATE egitmenler
SET    ad = 'Ahmet Y. (guncellendi)'
WHERE  ad = 'Ahmet Yilmaz';
