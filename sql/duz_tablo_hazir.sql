-- ============================================================
-- Duz (denormalize) kayitlar tablosu
-- Uretildi : ogrenci no 240541612
-- FiratFit Spor Merkezi - eski Excel sistemi aktarimi
-- ============================================================

DROP TABLE IF EXISTS duz_kayitlar;

CREATE TABLE duz_kayitlar (
    kayit_id       INTEGER,
    uye_id         INTEGER,
    uye_ad         VARCHAR(100),
    uye_telefonlar VARCHAR(200),   -- 1NF ihlali: noktali virgul ile ayrilmis liste
    ders_id        INTEGER,
    ders_ad        VARCHAR(100),
    ucret          NUMERIC(8,2),   -- Guncelleme anomalisi: ayni ders farkli ucret
    egitmen_id     INTEGER,
    egitmen_ad     VARCHAR(100),   -- Guncelleme anomalisi: yuzlerce satirda tekrar
    egitmen_brans  VARCHAR(50),
    salon_id       INTEGER,
    salon_ad       VARCHAR(100),
    salon_kapasite INTEGER,        -- 3NF ihlali: salon_ad'a bagimli
    tarih          DATE
);

INSERT INTO duz_kayitlar VALUES
--  id    uye_id  uye_ad           telefonlar                                     ders_id  ders_ad                ucret   egit_id  egitmen_ad       brans       sal_id  salon_ad       kap  tarih
(1,  1001, 'Ali Sahin',    '0532 111 2233;0212 333 4455',             1, 'Sabah Yogasi',       160.00, 1, 'Ahmet Yilmaz', 'Yoga',     1, 'Ana Salon',   30, '2024-01-15'),
(2,  1001, 'Ali Sahin',    '0532 111 2233;0212 333 4455',             2, 'Pilates Baslangic', 200.00, 2, 'Fatma Demir',  'Pilates',  2, 'Kucuk Salon', 15, '2024-01-16'),
(3,  1001, 'Ali Sahin',    '0532 111 2233;0212 333 4455',             3, 'CrossFit Pro',       250.00, 3, 'Mehmet Kaya',  'CrossFit', 3, 'Acik Alan',   50, '2024-01-17'),
(4,  1002, 'Ayse Koca',    '0533 222 3344',                           1, 'Sabah Yogasi',       150.00, 1, 'Ahmet Yilmaz', 'Yoga',     1, 'Ana Salon',   30, '2024-01-20'),
(5,  1002, 'Ayse Koca',    '0533 222 3344',                           4, 'Spinning Dersi',     180.00, 4, 'Zeynep Arslan','Spinning', 1, 'Ana Salon',   30, '2024-01-21'),
(6,  1003, 'Burak Celik',  '0535 333 4455;0216 444 5566;0850 222 3333', 2, 'Pilates Baslangic', 200.00, 2, 'Fatma Demir', 'Pilates', 2, 'Kucuk Salon', 15, '2024-01-22'),
(7,  1003, 'Burak Celik',  '0535 333 4455;0216 444 5566;0850 222 3333', 3, 'CrossFit Pro',    240.00, 3, 'Mehmet Kaya',  'CrossFit', 3, 'Acik Alan',   50, '2024-01-23'),
(8,  1003, 'Burak Celik',  '0535 333 4455;0216 444 5566;0850 222 3333', 4, 'Spinning Dersi',  180.00, 4, 'Zeynep Arslan','Spinning', 1, 'Ana Salon',   30, '2024-01-24'),
(9,  1004, 'Canan Oz',     '0536 444 5566',                           1, 'Sabah Yogasi',       150.00, 1, 'Ahmet Yilmaz', 'Yoga',     1, 'Ana Salon',   30, '2024-01-25'),
(10, 1004, 'Canan Oz',     '0536 444 5566',                           2, 'Pilates Baslangic', 200.00, 2, 'Fatma Demir',  'Pilates',  2, 'Kucuk Salon', 15, '2024-01-26'),
(11, 1005, 'Deniz Yurt',   '0537 555 6677;0312 555 6677',             1, 'Sabah Yogasi',       150.00, 1, 'Ahmet Yilmaz', 'Yoga',     1, 'Ana Salon',   30, '2024-02-01'),
(12, 1005, 'Deniz Yurt',   '0537 555 6677;0312 555 6677',             3, 'CrossFit Pro',       240.00, 3, 'Mehmet Kaya',  'CrossFit', 3, 'Acik Alan',   50, '2024-02-02'),
(13, 1005, 'Deniz Yurt',   '0537 555 6677;0312 555 6677',             4, 'Spinning Dersi',     180.00, 4, 'Zeynep Arslan','Spinning', 1, 'Ana Salon',   30, '2024-02-03'),
(14, 1006, 'Emre Dogan',   '0538 666 7788',                           1, 'Sabah Yogasi',       160.00, 1, 'Ahmet Yilmaz', 'Yoga',     1, 'Ana Salon',   30, '2024-02-10'),
(15, 1006, 'Emre Dogan',   '0538 666 7788',                           2, 'Pilates Baslangic', 200.00, 2, 'Fatma Demir',  'Pilates',  2, 'Kucuk Salon', 15, '2024-02-11'),
(16, 1006, 'Emre Dogan',   '0538 666 7788',                           3, 'CrossFit Pro',       250.00, 3, 'Mehmet Kaya',  'CrossFit', 3, 'Acik Alan',   50, '2024-02-12'),
(17, 1006, 'Emre Dogan',   '0538 666 7788',                           4, 'Spinning Dersi',     180.00, 4, 'Zeynep Arslan','Spinning', 1, 'Ana Salon',   30, '2024-02-13'),
(18, 1007, 'Fatma Guler',  '0539 777 8899;0232 777 8899',             1, 'Sabah Yogasi',       150.00, 1, 'Ahmet Yilmaz', 'Yoga',     1, 'Ana Salon',   30, '2024-02-15'),
(19, 1007, 'Fatma Guler',  '0539 777 8899;0232 777 8899',             4, 'Spinning Dersi',     180.00, 4, 'Zeynep Arslan','Spinning', 1, 'Ana Salon',   30, '2024-02-16'),
(20, 1008, 'Gokhan Tan',   '0531 888 9900',                           3, 'CrossFit Pro',       250.00, 3, 'Mehmet Kaya',  'CrossFit', 3, 'Acik Alan',   50, '2024-02-20'),
(21, 1008, 'Gokhan Tan',   '0531 888 9900',                           4, 'Spinning Dersi',     180.00, 4, 'Zeynep Arslan','Spinning', 1, 'Ana Salon',   30, '2024-02-21'),
(22, 1009, 'Hande Acar',   '0534 999 0011;0224 999 0011',             1, 'Sabah Yogasi',       150.00, 1, 'Ahmet Yilmaz', 'Yoga',     1, 'Ana Salon',   30, '2024-02-25'),
(23, 1009, 'Hande Acar',   '0534 999 0011;0224 999 0011',             2, 'Pilates Baslangic', 200.00, 2, 'Fatma Demir',  'Pilates',  2, 'Kucuk Salon', 15, '2024-02-26'),
(24, 1010, 'Ibrahim Kurt', '0540 000 1122',                           1, 'Sabah Yogasi',       150.00, 1, 'Ahmet Yilmaz', 'Yoga',     1, 'Ana Salon',   30, '2024-03-01'),
(25, 1010, 'Ibrahim Kurt', '0540 000 1122',                           3, 'CrossFit Pro',       250.00, 3, 'Mehmet Kaya',  'CrossFit', 3, 'Acik Alan',   50, '2024-03-02');
