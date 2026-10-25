-- 1.1 Her egitmenin tekrar sayisi
SELECT egitmen_ad, COUNT(*) AS satir_sayisi
FROM duz_kayitlar
GROUP BY egitmen_ad
ORDER BY satir_sayisi DESC;

-- 1.2 Farkli ucreti olan dersler
SELECT ders_id, ders_ad, COUNT(DISTINCT ucret) AS farkli_ucret_sayisi, MIN(ucret) AS en_dusuk, MAX(ucret) AS en_yuksek
FROM duz_kayitlar
GROUP BY ders_id, ders_ad
HAVING COUNT(DISTINCT ucret) > 1
ORDER BY ders_id;
