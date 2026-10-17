-- ============================================================
-- sql/g2_ddl.sql  |  Gorev 2 - 3NF Sema (DDL)
-- Ogrenci: 240541612
-- Olusturma sirasi FK bagimliliklarini izler.
-- ============================================================

-- Onceki calistirimadan kalan tablolari temizle (siralama onemli!)
DROP TABLE IF EXISTS kayitlar;
DROP TABLE IF EXISTS telefonlar;
DROP TABLE IF EXISTS dersler;
DROP TABLE IF EXISTS egitmenler;
DROP TABLE IF EXISTS salonlar;
DROP TABLE IF EXISTS uyeler;

-- ------------------------------------------------------------
-- 1. uyeler  (bagimsiz, FK yok)
-- ------------------------------------------------------------
CREATE TABLE uyeler (
    uye_id INTEGER      PRIMARY KEY,
    ad     VARCHAR(100) NOT NULL
);

-- ------------------------------------------------------------
-- 2. telefonlar  (uye_id -> uyeler)
-- ------------------------------------------------------------
CREATE TABLE telefonlar (
    telefon_id SERIAL       PRIMARY KEY,
    uye_id     INTEGER      NOT NULL REFERENCES uyeler(uye_id),
    numara     VARCHAR(30)  NOT NULL
);

-- ------------------------------------------------------------
-- 3. egitmenler  (bagimsiz, FK yok)
-- ------------------------------------------------------------
CREATE TABLE egitmenler (
    egitmen_id SERIAL       PRIMARY KEY,
    ad         VARCHAR(100) NOT NULL,
    brans      VARCHAR(50)
);

-- ------------------------------------------------------------
-- 4. salonlar  (bagimsiz, FK yok)
-- ------------------------------------------------------------
CREATE TABLE salonlar (
    salon_id SERIAL       PRIMARY KEY,
    ad       VARCHAR(100) NOT NULL,
    kapasite INTEGER
);

-- ------------------------------------------------------------
-- 5. dersler  (egitmen_id -> egitmenler,  salon_id -> salonlar)
-- ------------------------------------------------------------
CREATE TABLE dersler (
    ders_id    INTEGER       PRIMARY KEY,
    ad         VARCHAR(100)  NOT NULL,
    egitmen_id INTEGER       NOT NULL REFERENCES egitmenler(egitmen_id),
    salon_id   INTEGER       NOT NULL REFERENCES salonlar(salon_id),
    ucret      NUMERIC(8,2)  NOT NULL
);

-- ------------------------------------------------------------
-- 6. kayitlar  (uye_id -> uyeler,  ders_id -> dersler)
-- ------------------------------------------------------------
CREATE TABLE kayitlar (
    kayit_id SERIAL  PRIMARY KEY,
    uye_id   INTEGER NOT NULL REFERENCES uyeler(uye_id),
    ders_id  INTEGER NOT NULL REFERENCES dersler(ders_id),
    tarih    DATE    NOT NULL
);
