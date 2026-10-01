-- =====================================================
-- CRM / Membership DB  (PostgreSQL - Neon)
-- PT Nusantara Retail Mandiri
-- =====================================================
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS membership_tiers CASCADE;

-- 1. Master level keanggotaan
CREATE TABLE membership_tiers (
    tier_name       VARCHAR(20) PRIMARY KEY,
    min_spending    NUMERIC(14,2) NOT NULL DEFAULT 0,
    point_multiplier NUMERIC(3,1) NOT NULL DEFAULT 1.0,
    description     TEXT
);

-- 2. Data pelanggan
-- is_active memakai SMALLINT (0/1) agar kueri WHERE is_active = 1 dari tugas
-- berjalan di PostgreSQL (tipe BOOLEAN tidak bisa dibandingkan dengan angka 1).
CREATE TABLE customers (
    customer_id     VARCHAR(10) PRIMARY KEY,
    customer_name   VARCHAR(100) NOT NULL,
    email           VARCHAR(120) UNIQUE,
    gender          CHAR(1) CHECK (gender IN ('L','P')),
    birth_date      DATE,
    city            VARCHAR(50),
    membership_tier VARCHAR(20) NOT NULL REFERENCES membership_tiers(tier_name),
    join_date       DATE NOT NULL,
    is_active       SMALLINT NOT NULL DEFAULT 1 CHECK (is_active IN (0,1))
);
CREATE INDEX idx_customers_active ON customers(is_active);
CREATE INDEX idx_customers_tier   ON customers(membership_tier);

INSERT INTO membership_tiers (tier_name, min_spending, point_multiplier, description) VALUES
('Bronze',0,1.0,'Member baru'),
('Silver',5000000,1.5,'Belanja kumulatif >= 5 juta'),
('Gold',15000000,2.0,'Belanja kumulatif >= 15 juta'),
('Platinum',40000000,3.0,'Belanja kumulatif >= 40 juta');

INSERT INTO customers (customer_id, customer_name, email, gender, birth_date, city, membership_tier, join_date, is_active) VALUES
('C0001','Dewi Santoso','user001@example.com','P','1980-12-26','Semarang','Bronze','2021-07-29',1),
('C0002','Maya Wijaya','user002@example.com','P','1971-06-05','Jakarta','Bronze','2022-04-22',1),
('C0003','Rudi Setiawan','user003@example.com','L','1995-03-06','Semarang','Gold','2024-12-07',1),
('C0004','Maya Nugroho','user004@example.com','L','1990-02-24','Tegal','Bronze','2021-01-14',1),
('C0005','Joko Utami','user005@example.com','P','1985-04-06','Yogyakarta','Bronze','2022-11-21',1),
('C0006','Dewi Wijaya','user006@example.com','P','1974-05-04','Medan','Gold','2024-05-21',1),
('C0007','Sri Santoso','user007@example.com','P','1994-01-20','Bandung','Platinum','2023-02-15',1),
('C0008','Agus Rahayu','user008@example.com','P','1998-03-14','Tegal','Gold','2023-01-11',1),
('C0009','Andi Hidayat','user009@example.com','L','1972-01-21','Semarang','Gold','2021-06-13',1),
('C0010','Eko Wijaya','user010@example.com','P','1982-06-21','Denpasar','Silver','2023-01-18',0),
('C0011','Joko Kusuma','user011@example.com','P','1979-05-26','Yogyakarta','Gold','2024-10-31',1),
('C0012','Agus Setiawan','user012@example.com','L','1993-12-17','Semarang','Bronze','2023-02-17',1),
('C0013','Sri Firmansyah','user013@example.com','L','2000-09-16','Medan','Gold','2021-04-25',1),
('C0014','Eko Santoso','user014@example.com','P','1987-12-30','Yogyakarta','Bronze','2024-03-07',1),
('C0015','Bayu Hidayat','user015@example.com','P','1987-10-01','Denpasar','Bronze','2021-10-13',1),
('C0016','Eko Utami','user016@example.com','P','1996-03-22','Makassar','Gold','2023-03-29',1),
('C0017','Wati Hidayat','user017@example.com','L','1992-11-09','Denpasar','Bronze','2021-04-07',1),
('C0018','Dewi Pratama','user018@example.com','L','2000-07-11','Makassar','Silver','2023-02-28',1),
('C0019','Hadi Setiawan','user019@example.com','P','1993-09-26','Yogyakarta','Platinum','2021-01-24',1),
('C0020','Dewi Firmansyah','user020@example.com','P','1998-10-02','Medan','Bronze','2023-06-10',0),
('C0021','Joko Lestari','user021@example.com','L','2002-05-23','Yogyakarta','Platinum','2022-01-01',1),
('C0022','Rudi Wijaya','user022@example.com','P','1998-08-30','Pemalang','Silver','2021-11-10',1),
('C0023','Wati Pratama','user023@example.com','L','1996-11-13','Medan','Silver','2021-08-18',1),
('C0024','Wati Saputra','user024@example.com','L','1972-08-07','Semarang','Gold','2021-06-11',1),
('C0025','Agus Utami','user025@example.com','P','1973-02-07','Pemalang','Gold','2021-09-20',1),
('C0026','Putri Rahayu','user026@example.com','L','1981-11-21','Pemalang','Gold','2023-05-17',1),
('C0027','Ani Rahayu','user027@example.com','L','2001-12-24','Yogyakarta','Bronze','2024-10-07',1),
('C0028','Wati Lestari','user028@example.com','P','1975-06-06','Semarang','Bronze','2022-11-24',1),
('C0029','Budi Setiawan','user029@example.com','L','1996-05-25','Semarang','Bronze','2024-12-20',1),
('C0030','Siti Hidayat','user030@example.com','L','1971-05-30','Medan','Bronze','2022-05-03',0),
('C0031','Sri Firmansyah','user031@example.com','P','1979-08-12','Pemalang','Bronze','2024-03-15',1),
('C0032','Andi Lestari','user032@example.com','L','1991-03-21','Makassar','Bronze','2021-07-18',1),
('C0033','Lestari Kusuma','user033@example.com','P','1988-06-10','Denpasar','Gold','2021-04-21',1),
('C0034','Dewi Santoso','user034@example.com','P','2002-09-01','Medan','Gold','2021-08-12',1),
('C0035','Eko Hidayat','user035@example.com','L','1994-01-21','Denpasar','Bronze','2022-01-11',1),
('C0036','Sri Lestari','user036@example.com','L','1973-05-20','Denpasar','Gold','2024-02-02',1),
('C0037','Dewi Santoso','user037@example.com','L','1974-03-09','Semarang','Bronze','2023-09-22',1),
('C0038','Putri Hidayat','user038@example.com','P','1972-08-18','Surabaya','Bronze','2023-03-11',1),
('C0039','Sri Lestari','user039@example.com','P','1988-12-22','Pemalang','Silver','2023-09-24',1),
('C0040','Rina Hidayat','user040@example.com','P','1979-10-07','Jakarta','Silver','2024-01-16',0),
('C0041','Siti Utami','user041@example.com','P','1972-07-25','Jakarta','Silver','2023-10-27',1),
('C0042','Rudi Pratama','user042@example.com','L','1992-10-12','Bandung','Gold','2021-05-21',1),
('C0043','Nina Wijaya','user043@example.com','L','1988-02-11','Bandung','Platinum','2024-03-12',1),
('C0044','Eko Setiawan','user044@example.com','L','1997-10-13','Bandung','Silver','2024-04-10',1),
('C0045','Andi Rahayu','user045@example.com','P','1981-09-12','Semarang','Silver','2022-10-06',1),
('C0046','Eko Saputra','user046@example.com','P','1975-11-15','Yogyakarta','Silver','2021-05-29',1),
('C0047','Budi Lestari','user047@example.com','L','1973-04-15','Pemalang','Bronze','2022-06-28',1),
('C0048','Rina Kusuma','user048@example.com','L','1980-12-16','Medan','Bronze','2023-06-17',1),
('C0049','Maya Utami','user049@example.com','P','1997-06-09','Pemalang','Bronze','2024-02-10',1),
('C0050','Dian Firmansyah','user050@example.com','L','1976-01-10','Yogyakarta','Bronze','2021-08-08',0),
('C0051','Maya Pratama','user051@example.com','P','1982-08-22','Tegal','Bronze','2022-12-04',1),
('C0052','Ani Firmansyah','user052@example.com','P','1992-09-02','Denpasar','Bronze','2021-04-15',1),
('C0053','Agus Firmansyah','user053@example.com','P','1982-05-31','Jakarta','Bronze','2021-09-25',1),
('C0054','Sri Pratama','user054@example.com','P','1994-09-30','Makassar','Silver','2021-08-18',1),
('C0055','Agus Utami','user055@example.com','L','1994-06-22','Jakarta','Gold','2024-04-07',1),
('C0056','Maya Pratama','user056@example.com','P','1975-09-20','Jakarta','Bronze','2021-03-23',1),
('C0057','Wati Hidayat','user057@example.com','L','1999-12-02','Bandung','Bronze','2024-02-21',1),
('C0058','Lestari Setiawan','user058@example.com','L','1980-08-14','Surabaya','Platinum','2021-12-29',1),
('C0059','Lestari Santoso','user059@example.com','L','1984-11-25','Makassar','Gold','2022-05-24',1),
('C0060','Sri Pratama','user060@example.com','L','1987-02-28','Jakarta','Gold','2022-04-01',0);

-- Cek hasil
SELECT membership_tier, is_active, COUNT(*) FROM customers GROUP BY 1,2 ORDER BY 1,2;
