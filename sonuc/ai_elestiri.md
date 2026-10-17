# Yapay Zeka Köşesi — AI Eleştirisi
**Öğrenci:** 240541612

---

## 1. Kullanılan Araç ve İstem

**Araç:** ChatGPT-4o  
**İstem:**
> "Aşağıdaki tablo yapısını ve 5 örnek satırı inceleyerek tabloyu 3NF'e ayrıştır.
> Tablo adı: duz_kayitlar
> Sütunlar: kayit_id, uye_id, uye_ad, uye_telefonlar, ders_id, ders_ad, ucret,
> egitmen_id, egitmen_ad, egitmen_brans, salon_id, salon_ad, salon_kapasite, tarih"

---

## 2. AI'ın Önerdiği Şema

```sql
-- ChatGPT-4o çıktısı (kısaltılmış)

CREATE TABLE uyeler (
    uye_id   INTEGER PRIMARY KEY,
    ad       VARCHAR(100),
    telefon  VARCHAR(200)   -- tek sütun olarak bıraktı!
);

CREATE TABLE egitmenler (
    egitmen_id SERIAL PRIMARY KEY,
    ad         VARCHAR(100),
    brans      VARCHAR(50)
);

CREATE TABLE dersler (
    ders_id        INTEGER PRIMARY KEY,
    ad             VARCHAR(100),
    egitmen_id     INTEGER REFERENCES egitmenler(egitmen_id),
    salon_ad       VARCHAR(100),   -- salon_id değil, doğrudan ad!
    salon_kapasite INTEGER,        -- dersler içinde kaldı!
    ucret          NUMERIC(8,2)
);

CREATE TABLE kayitlar (
    kayit_id SERIAL PRIMARY KEY,
    uye_id   INTEGER REFERENCES uyeler(uye_id),
    ders_id  INTEGER REFERENCES dersler(ders_id),
    tarih    DATE
);
```

---

## 3. Eleştiri

### Eleştiri 1 — 1NF İhlali Devam Ediyor: telefon Sütunu Atomik Değil

AI, `uye_telefonlar` sütununu `telefon VARCHAR(200)` olarak
`uyeler` tablosunun içinde bırakmış. Bu 1NF'i hâlâ ihlal ediyor;
çünkü bir üyenin birden fazla telefonu olduğunda yine noktalı virgülle
ayrılmış liste (`0532 111 2233;0212 333 4455`) tek hücreye sıkıştırılmış
olacak. Doğru yaklaşım, `telefonlar` adında ayrı bir tablo oluşturmak
ve her numarayı bağımsız bir satırda tutmaktır.

**Düzeltilmiş hali:**

```sql
-- uyeler tablosundan telefon sütunu tamamen çıkarılır
CREATE TABLE uyeler (
    uye_id INTEGER PRIMARY KEY,
    ad     VARCHAR(100) NOT NULL
);

-- Her numara kendi satırında, ayrı tabloda
CREATE TABLE telefonlar (
    telefon_id SERIAL  PRIMARY KEY,
    uye_id     INTEGER NOT NULL REFERENCES uyeler(uye_id),
    numara     VARCHAR(30) NOT NULL
);
```

---

### Eleştiri 2 — 3NF İhlali Devam Ediyor: salon_kapasite Dersler İçinde

AI, `salon_ad` ve `salon_kapasite` sütunlarını `dersler` tablosunda
bırakmış. Bu açık bir 3NF ihlalidir: `salon_kapasite` değeri
`salon_ad`'a (birincil anahtar dışı bir sütuna) bağımlıdır,
doğrudan `ders_id`'ye değil. Yani geçişli bağımlılık
(`ders_id → salon_ad → salon_kapasite`) hâlâ mevcut.
Bunun sonucu olarak aynı salonun kapasitesi birden fazla
ders satırında tekrar eder ve güncelleme anomalisi ortadan kalkmaz.
Doğru çözüm, `salonlar` adında bağımsız bir tablo oluşturmak
ve `dersler` tablosunda yalnızca `salon_id` yabancı anahtarını
tutmaktır.

**Düzeltilmiş hali:**

```sql
-- Salonlar kendi tablosuna tasinir
CREATE TABLE salonlar (
    salon_id SERIAL      PRIMARY KEY,
    ad       VARCHAR(100) NOT NULL,
    kapasite INTEGER
);

-- dersler tablosunda yalnizca salon_id FK olarak kalir
CREATE TABLE dersler (
    ders_id    INTEGER      PRIMARY KEY,
    ad         VARCHAR(100) NOT NULL,
    egitmen_id INTEGER      NOT NULL REFERENCES egitmenler(egitmen_id),
    salon_id   INTEGER      NOT NULL REFERENCES salonlar(salon_id),
    ucret      NUMERIC(8,2) NOT NULL
);
```

---

### Eleştiri 3 (Ek) — Ücret Tutarsızlığını Fark Etmedi

AI, `ucret` sütununda aynı ders için farklı değerler bulunduğunu
hiç belirtmedi ve bir kural önermedi. Oysa `duz_kayitlar` tablosunda
`Sabah Yogasi` için hem 150 hem 160, `CrossFit Pro` için hem 240
hem 250 TL değerleri mevcuttur. Gerçek bir normalizasyon sürecinde
bu çelişkiye dikkat çekilmeli ve hangi değerin esas alınacağı
(bizim durumumuzda yönetim kararıyla `MIN(ucret)`) açıkça
belirtilmeliydi. AI bu noktayı tamamen atlamıştır.
