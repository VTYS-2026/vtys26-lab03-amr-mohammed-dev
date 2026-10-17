-- ============================================================
-- sql/g1_anomali.sql  |  Gorev 1 - Anomalileri Kanitla
-- Ogrenci: 240541612
-- ============================================================

-- ------------------------------------------------------------
-- 1.1  Her egitmenin kac satirda tekrar ettigi (guncelleme anomalisi boyutu)
-- ------------------------------------------------------------
SELECT
    egitmen_ad,
    COUNT(*) AS satir_sayisi
FROM duz_kayitlar
GROUP BY egitmen_ad
ORDER BY satir_sayisi DESC;

-- Beklenen sonuc:
--  Ahmet Yilmaz  | 8
--  Mehmet Kaya   | 6
--  Zeynep Arslan | 6
--  Fatma Demir   | 5

-- ------------------------------------------------------------
-- 1.2  Birden fazla farkli ucreti olan dersler (tutarsizlik basladi!)
-- ------------------------------------------------------------
SELECT
    ders_id,
    ders_ad,
    COUNT(DISTINCT ucret) AS farkli_ucret_sayisi,
    MIN(ucret)            AS en_dusuk_ucret,
    MAX(ucret)            AS en_yuksek_ucret
FROM duz_kayitlar
GROUP BY ders_id, ders_ad
HAVING COUNT(DISTINCT ucret) > 1
ORDER BY ders_id;

-- Beklenen sonuc:
--  ders_id=1  Sabah Yogasi  2  150.00  160.00
--  ders_id=3  CrossFit Pro  2  240.00  250.00
