# Yapay Zeka Elestirisi (Foy 03)

Ogrenci: 240541612

## 1. Kullanilan Arac ve Istek

Arac: ChatGPT
Istek:
"duz_kayitlar tablosundaki sutunlari (kayit_id, uye_id, uye_ad, uye_telefonlar, ders_id, ders_ad, ucret, egitmen_id, egitmen_ad, egitmen_brans, salon_id, salon_ad, salon_kapasite, tarih) ve ornek satirlari inceleyerek 3NF semasina ayristir."

## 2. Onerilen Sema

```sql
CREATE TABLE uyeler (
    uye_id INT PRIMARY KEY,
    ad VARCHAR(100),
    telefonlar VARCHAR(200)
);

CREATE TABLE egitmenler (
    egitmen_id INT PRIMARY KEY,
    ad VARCHAR(100),
    brans VARCHAR(50)
);

CREATE TABLE dersler (
    ders_id INT PRIMARY KEY,
    ad VARCHAR(100),
    egitmen_id INT REFERENCES egitmenler(egitmen_id),
    salon_ad VARCHAR(100),
    salon_kapasite INT,
    ucret NUMERIC(8,2)
);

CREATE TABLE kayitlar (
    kayit_id INT PRIMARY KEY,
    uye_id INT REFERENCES uyeler(uye_id),
    ders_id INT REFERENCES dersler(ders_id),
    tarih DATE
);
```

## 3. Elestiri ve Degerlendirme

Yapay zekanin olusturdugu semayi inceledigimde onemli eksiklikler ve normalizasyon hatalari tespit ettim:

1. 1NF kurali ihlal edilmistir. Yapay zeka uye_telefonlar sutununu uyeler tablosunda tek bir sutun (telefonlar) olarak birakmis. Oysa bir uyenin birden fazla numarasi olabilecegi icin bu hucreler atomik degildir. Her telefon numarasinin ayri bir satira acilmasi ve telefonlar adinda ayri bir tablo olusturulmasi gerekiyordu.

2. 3NF kurali ihlal edilmeye devam etmektedir. Model, salon_ad ve salon_kapasite sutunlarini dersler tablosunda birakmis. Salon kapasitesi dogrudan ders_id'ye degil, salon_ad sutununa bagimlidir. Dolayisiyla burada gecisli bagimlilik (transitive dependency) surmektedir. Salon bilgileri ayri bir salonlar tablosunda tutulmali ve dersler tablosunda sadece salon_id yabanci anahtar olarak yer almalidir.

3. Ayrica model, verideki ucret tutarsizligini fark etmemistir. Ayni ders icin farkli ucretler varken veriyi tasirken hangi kuralin (ornegin en dusuk ucret) secilmesi gerektigine dair bir cozum sunmamistir.

## 4. Duzeltilmis Tablolar

```sql
CREATE TABLE telefonlar (
    telefon_id SERIAL PRIMARY KEY,
    uye_id INT REFERENCES uyeler(uye_id),
    numara VARCHAR(30) NOT NULL
);

CREATE TABLE salonlar (
    salon_id SERIAL PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    kapasite INT
);

CREATE TABLE dersler (
    ders_id INT PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    egitmen_id INT REFERENCES egitmenler(egitmen_id),
    salon_id INT REFERENCES salonlar(salon_id),
    ucret NUMERIC(8,2) NOT NULL
);
```
