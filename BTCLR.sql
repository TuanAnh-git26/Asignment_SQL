USE RDBMS;

CREATE TABLE DocGia (
    MaDG VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Tuoi INT CHECK (Tuoi BETWEEN 10 AND 80)
);

CREATE TABLE Sach (
    MaSach VARCHAR(10) PRIMARY KEY,
    TenSach NVARCHAR(200) NOT NULL,
    TheLoai NVARCHAR(50),
    SoLuongTon INT DEFAULT 0 CHECK (SoLuongTon >= 0)
);

CREATE TABLE PhieuMuon (
    MaPhieu INT IDENTITY(1,1) PRIMARY KEY,
    MaDG VARCHAR(10),
    MaSach VARCHAR(10),
    NgayMuon DATE DEFAULT GETDATE(),
    FOREIGN KEY (MaDG) REFERENCES DocGia(MaDG),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);


INSERT INTO DocGia (MaDG, HoTen, Email, Tuoi) VALUES 
(1, N'Lê Tuấn Anh', 'tanklee@gmail.com', 35),
(2, N'Trịnh Tuấn Anh', 'tuananhtrinh@ygmail.com', 20),
(3, N'Hoàng Nguyễn Gia Khang', 'giakhanghoang@gmail.com', 16);

INSERT INTO Sach (MaSach, TenSach, TheLoai, SoLuongTon) VALUES 
(1, N'Lập trình Python cơ bản', N'Tin học', 15),
(2, N'Cấu trúc dữ liệu và Giải thuật', N'Tin học', 10),
(3, N'Lịch sử văn học Việt Nam', N'Văn học', 5),
(4, N'Vật lý đại cương', N'Khoa học', 8),
(5, N'Tiếng Anh chuyên ngành IT', N'Ngoại ngữ', 12);

INSERT INTO PhieuMuon (MaDG, MaSach) VALUES 
('1', '1'), 
('2', '2'), 
('3', '1');


SELECT * 
FROM Sach 
WHERE TheLoai = N'Tin học' AND SoLuongTon > 0;

SELECT DISTINCT 
    dg.HoTen, 
    s.TenSach
FROM DocGia dg
JOIN PhieuMuon pm ON dg.MaDG = pm.MaDG
JOIN Sach s ON pm.MaSach = s.MaSach;

CREATE TRIGGER trg_GiamTonKho_KhiMuon
ON PhieuMuon
AFTER INSERT
AS
BEGIN
    UPDATE Sach 
    SET SoLuongTon = SoLuongTon - 1
    FROM Sach s
    INNER JOIN inserted i ON s.MaSach = i.MaSach;
END;

SELECT MaSach, TenSach, SoLuongTon FROM Sach WHERE MaSach = '4';

INSERT INTO PhieuMuon (MaDG, MaSach) VALUES ('1', '4');

SELECT MaSach, TenSach, SoLuongTon FROM Sach WHERE MaSach = '4';


