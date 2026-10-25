-- 4.1 Satir sayisi karsilastirmasi
SELECT
    (SELECT COUNT(*) FROM duz_kayitlar) AS duz_tablo_satir_sayisi,
    (SELECT COUNT(*) FROM kayitlar)     AS temiz_tablo_satir_sayisi;

-- 4.2 Egitmen adi guncelleme
UPDATE duz_kayitlar
SET egitmen_ad = 'Ahmet Y. (guncellendi)'
WHERE egitmen_ad = 'Ahmet Yilmaz';

UPDATE egitmenler
SET ad = 'Ahmet Y. (guncellendi)'
WHERE ad = 'Ahmet Yilmaz';
