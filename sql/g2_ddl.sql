DROP TABLE IF EXISTS kayitlar CASCADE;
DROP TABLE IF EXISTS telefonlar CASCADE;
DROP TABLE IF EXISTS dersler CASCADE;
DROP TABLE IF EXISTS egitmenler CASCADE;
DROP TABLE IF EXISTS salonlar CASCADE;
DROP TABLE IF EXISTS uyeler CASCADE;

CREATE TABLE uyeler (
    uye_id INTEGER PRIMARY KEY,
    ad VARCHAR(100) NOT NULL
);

CREATE TABLE telefonlar (
    telefon_id SERIAL PRIMARY KEY,
    uye_id INTEGER NOT NULL REFERENCES uyeler(uye_id),
    numara VARCHAR(30) NOT NULL
);

CREATE TABLE egitmenler (
    egitmen_id SERIAL PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    brans VARCHAR(50)
);

CREATE TABLE salonlar (
    salon_id SERIAL PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    kapasite INTEGER
);

CREATE TABLE dersler (
    ders_id INTEGER PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    egitmen_id INTEGER NOT NULL REFERENCES egitmenler(egitmen_id),
    salon_id INTEGER NOT NULL REFERENCES salonlar(salon_id),
    ucret NUMERIC(8,2) NOT NULL
);

CREATE TABLE kayitlar (
    kayit_id SERIAL PRIMARY KEY,
    uye_id INTEGER NOT NULL REFERENCES uyeler(uye_id),
    ders_id INTEGER NOT NULL REFERENCES dersler(ders_id),
    tarih DATE NOT NULL
);
