USE [master]
GO
/****** Object:  Database [QuanLyThuVien_HKP2T]    Script Date: 01/06/2021 8:46:43 PM ******/
CREATE DATABASE [QuanLyThuVien_HKP2T]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyThuVien_HKP2T].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QuanLyThuVien_HKP2T]
GO
/****** Object:  UserDefinedFunction [dbo].[func_nextID]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Tự động tăng mã sách
create function [dbo].[func_nextID](@lastID varchar(5), @prefix varchar(2), @size int)
	returns varchar(5)
as
	BEGIN
		if(@lastID = '')
			set @lastID = @prefix + REPLICATE(0, @size - LEN(@prefix))
		declare @num_nextID int, @nextID varchar(5)
		set @lastID = LTRIM(RTRIM(@lastID))
		set @num_nextID = REPLACE(@lastID, @prefix, '') + 1
		set @size = @size - LEN(@prefix)
		set @nextID = @prefix + RIGHT(REPLICATE(0, @size) + CONVERT(VARCHAR(MAX), @num_nextID), @size)
		return  @nextID
	END
GO
/****** Object:  UserDefinedFunction [dbo].[tinhSoNgayTre]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[tinhSoNgayTre](@ngayMuon date, @ngayTra date, @songayMuon int)
	returns int
as
	BEGIN
		declare @num int = (DAY(@ngayTra) - DAY(@ngayMuon)) - @songayMuon
		return @num
	END
GO
/****** Object:  Table [dbo].[CanBo]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CanBo](
	[maCanBo] [char](10) NOT NULL,
	[matKhau] [varchar](20) NULL,
	[tenCanBo] [nvarchar](100) NULL,
	[ngaySinh] [date] NULL,
	[gioiTinh] [int] NULL,
	[diaChi] [nvarchar](100) NULL,
	[sdt] [varchar](11) NULL,
	[email] [varchar](100) NULL,
	[status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[maCanBo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietPhieuMuon]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhieuMuon](
	[maPhieuMuon] [varchar](5) NOT NULL,
	[maSach] [varchar](5) NOT NULL,
	[ngayThucTra] [date] NULL,
	[tienPhat] [money] NULL,
	[tinhTrangSach] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[maPhieuMuon] ASC,
	[maSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhMucSach]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMucSach](
	[maDMSach] [char](10) NOT NULL,
	[tenDMSach] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[maDMSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuMuon]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuMuon](
	[maPhieuMuon] [varchar](5) NOT NULL,
	[ngayMuon] [date] NULL,
	[soNgayMuon] [int] NULL,
	[maTaiKhoan] [char](13) NULL,
	[maCanBo] [char](10) NULL,
	[ghiChu] [text] NULL,
	[trangThai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[maPhieuMuon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sach]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sach](
	[maSach] [varchar](5) NOT NULL,
	[tenSach] [nvarchar](100) NULL,
	[maDMSach] [char](10) NULL,
	[maTheLoai] [char](10) NULL,
	[TacGia] [nvarchar](100) NULL,
	[NXB] [nvarchar](100) NULL,
	[namXuatBan] [int] NULL,
	[soLuongCon] [int] NULL,
	[tomTatND] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[maSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[maTaiKhoan] [char](13) NOT NULL,
	[matKhau] [varchar](20) NULL,
	[tenNguoiDung] [nvarchar](100) NULL,
	[ngaySinh] [date] NULL,
	[gioiTinh] [int] NULL,
	[email] [varchar](100) NULL,
	[sdt] [varchar](11) NULL,
	[status] [int] NULL,
	[soLuongMuon] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[maTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheLoai]    Script Date: 01/06/2021 8:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheLoai](
	[maTheLoai] [char](10) NOT NULL,
	[tenTheLoai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[maTheLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
create trigger tr_nextSach on dbo.Sach
for insert
as
	begin
		declare @lastSach varchar(5)
		set @lastSach = (Select top 1 maSach from Sach order by maSach desc)
		UPDATE Sach set maSach = dbo.func_nextID(@lastSach, 'S', 5) where maSach = ''
	end
GO
create trigger tr_nextMaPM on dbo.PhieuMuon
for insert
as
	begin
		declare @lastIdMaPM varchar(5)
		set @lastIdMaPM = (Select top 1 maPhieuMuon from PhieuMuon order by maPhieuMuon desc)
		UPDATE PhieuMuon set maPhieuMuon = dbo.func_nextID(@lastIdMaPM, 'PM', 5) where maPhieuMuon = ''
	end
go
--Trigger cập nhật Số lượng mượn
create trigger tr_soLuongMuon on ChiTietPhieuMuon 
for insert 
as
	BEGIN
		update TaiKhoan
		set	soluongMuon = soluongMuon + 1
		from TaiKhoan, PhieuMuon, inserted
		where inserted.maPhieuMuon = PhieuMuon.maPhieuMuon and TaiKhoan.maTaiKhoan = PhieuMuon.maTaiKhoan
	END
go

create trigger tr_soLuongMuon_delete on ChiTietPhieuMuon 
for delete 
as
	BEGIN
		update TaiKhoan
		set	soluongMuon = soluongMuon - 1
		from TaiKhoan, PhieuMuon, inserted
		where inserted.maPhieuMuon = PhieuMuon.maPhieuMuon and TaiKhoan.maTaiKhoan = PhieuMuon.maTaiKhoan
	END
go

--Trigger tính tiền phạt
create trigger tr_tienPhat on ChiTietPhieuMuon
for update
as
	begin 
		declare @ngayThucTra date = (select ngayThucTra from inserted)
		declare @ngayMuon date = (select ngayMuon from inserted, PhieuMuon where inserted.maPhieuMuon = PhieuMuon.maPhieuMuon)
		declare @soNgayMuon int = (select soNgayMuon from inserted, PhieuMuon where inserted.maPhieuMuon = PhieuMuon.maPhieuMuon)
		declare @tinhTrang nvarchar(100) = (select inserted.tinhTrangSach from inserted)
		
		if @tinhTrang = N'Bình thường'
			if (datediff(day, @ngayMuon, @ngayThucTra) > @soNgayMuon)
				update ChiTietPhieuMuon
				set tienPhat = (datediff(Day, PhieuMuon.ngayMuon, inserted.ngayThucTra)) * 10000
				from inserted, PhieuMuon, ChiTietPhieuMuon
				where inserted.maPhieuMuon = PhieuMuon.maPhieuMuon and ChiTietPhieuMuon.maPhieuMuon = inserted.maPhieuMuon
				and ChiTietPhieuMuon.maSach = inserted.maSach and PhieuMuon.maPhieuMuon = ChiTietPhieuMuon.maPhieuMuon
			else 
				update ChiTietPhieuMuon
				set tienPhat = 0
				from ChiTietPhieuMuon, inserted
				where ChiTietPhieuMuon.maPhieuMuon = inserted.maPhieuMuon
				and ChiTietPhieuMuon.maSach = inserted.maSach
		else if @tinhTrang = N'Mất sách'
			update ChiTietPhieuMuon
			set tienPhat = 50000
			from ChiTietPhieuMuon, inserted
			where ChiTietPhieuMuon.maPhieuMuon = inserted.maPhieuMuon
				and ChiTietPhieuMuon.maSach = inserted.maSach
		else if @tinhTrang = N'Hư hỏng'
			if ((datediff(day, @ngayMuon, @ngayThucTra)) > @soNgayMuon)
				update ChiTietPhieuMuon
				set tienPhat = (datediff(Day, PhieuMuon.ngayMuon, inserted.ngayThucTra)) * 10000 + 20000
				from inserted, PhieuMuon, ChiTietPhieuMuon
				where inserted.maPhieuMuon = PhieuMuon.maPhieuMuon and ChiTietPhieuMuon.maPhieuMuon = inserted.maPhieuMuon
				and ChiTietPhieuMuon.maSach = inserted.maSach and PhieuMuon.maPhieuMuon = ChiTietPhieuMuon.maPhieuMuon
			else
				update ChiTietPhieuMuon
				set tienPhat = 20000
				from ChiTietPhieuMuon, inserted
				where ChiTietPhieuMuon.maPhieuMuon = inserted.maPhieuMuon
				and ChiTietPhieuMuon.maSach = inserted.maSach
		--Cập nhật số lượng mượn
		if (@ngayThucTra is not null)
			update TaiKhoan
			set	soluongMuon = soluongMuon - 1
			from TaiKhoan, PhieuMuon, inserted
			where inserted.maPhieuMuon = PhieuMuon.maPhieuMuon and TaiKhoan.maTaiKhoan = PhieuMuon.maTaiKhoan
		else 
			return
	end
go
GO
INSERT [dbo].[CanBo] ([maCanBo], [matKhau], [tenCanBo], [ngaySinh], [gioiTinh], [diaChi], [sdt], [email], [status]) VALUES (N'101010    ', N'abc123', N'Trần Thị A', CAST(N'1990-07-02' AS Date), 1, N'02/Thanh Sơn', N'0773123889', N'tranthia@gmail.com', 1)
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM001', N'S0001', CAST(N'2021-05-27' AS Date), 50000.0000, N'Mất sách')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM001', N'S0002', CAST(N'2021-06-20' AS Date), 430000.0000, N'Hư hỏng')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM002', N'S0003', CAST(N'2021-06-20' AS Date), 0.0000, N'Bình thường')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM002', N'S0004', NULL, 0.0000, N'')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM002', N'S0005', NULL, 0.0000, N'')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM003', N'S0006', NULL, 0.0000, N'')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM004', N'S0006', CAST(N'2021-05-27' AS Date), 0.0000, N'Bình thường')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM004', N'S0008', CAST(N'2021-05-27' AS Date), 0.0000, N'Bình thường')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM004', N'S0009', CAST(N'2021-05-27' AS Date), 0.0000, N'Bình thường')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM005', N'S0006', CAST(N'2021-05-27' AS Date), 0.0000, N'Bình thường')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM005', N'S0008', NULL, 0.0000, N'')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM006', N'S0002', CAST(N'2021-05-26' AS Date), 0.0000, N'Bình thường')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM006', N'S0003', CAST(N'2021-05-26' AS Date), 0.0000, N'Bình thường')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM006', N'S0007', CAST(N'2021-05-26' AS Date), 0.0000, N'Bình thường')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM007', N'S0003', NULL, 0.0000, N'')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM007', N'S0005', NULL, 0.0000, N'')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM008', N'S0007', CAST(N'2021-05-31' AS Date), 10000.0000, N'Trễ hạn')
INSERT [dbo].[ChiTietPhieuMuon] ([maPhieuMuon], [maSach], [ngayThucTra], [tienPhat], [tinhTrangSach]) VALUES (N'PM008', N'S0010', CAST(N'2021-05-31' AS Date), 10000.0000, N'Trễ hạn')
INSERT [dbo].[DanhMucSach] ([maDMSach], [tenDMSach]) VALUES (N'DM001     ', N'Chuyên ngành Điện-Điện tử')
INSERT [dbo].[DanhMucSach] ([maDMSach], [tenDMSach]) VALUES (N'DM002     ', N'Chuyên ngành Cơ khí')
INSERT [dbo].[DanhMucSach] ([maDMSach], [tenDMSach]) VALUES (N'DM003     ', N'Chuyên ngành Công nghệ thông tin')
INSERT [dbo].[DanhMucSach] ([maDMSach], [tenDMSach]) VALUES (N'DM004     ', N'Chuyên ngành Xây dựng')
INSERT [dbo].[DanhMucSach] ([maDMSach], [tenDMSach]) VALUES (N'DM005     ', N'Sách Tiếng Anh')
INSERT [dbo].[DanhMucSach] ([maDMSach], [tenDMSach]) VALUES (N'DM006     ', N'Kỹ năng sống')
INSERT [dbo].[DanhMucSach] ([maDMSach], [tenDMSach]) VALUES (N'DM007     ', N'Sách nước ngoài')
INSERT [dbo].[PhieuMuon] ([maPhieuMuon], [ngayMuon], [soNgayMuon], [maTaiKhoan], [maCanBo], [ghiChu], [trangThai]) VALUES (N'PM001', CAST(N'2021-05-10' AS Date), 7, N'1911505310132', N'101010    ', N'', N'Chưa trả')
INSERT [dbo].[PhieuMuon] ([maPhieuMuon], [ngayMuon], [soNgayMuon], [maTaiKhoan], [maCanBo], [ghiChu], [trangThai]) VALUES (N'PM002', CAST(N'2021-05-11' AS Date), 7, N'1911505310118', N'101010    ', N'', N'Chưa trả')
INSERT [dbo].[PhieuMuon] ([maPhieuMuon], [ngayMuon], [soNgayMuon], [maTaiKhoan], [maCanBo], [ghiChu], [trangThai]) VALUES (N'PM003', CAST(N'2021-05-12' AS Date), 14, N'1911505310123', N'101010    ', N'', N'Chưa trả')
INSERT [dbo].[PhieuMuon] ([maPhieuMuon], [ngayMuon], [soNgayMuon], [maTaiKhoan], [maCanBo], [ghiChu], [trangThai]) VALUES (N'PM004', CAST(N'2021-05-24' AS Date), 7, N'1911505310132', N'101010    ', N'', N'Đã trả')
INSERT [dbo].[PhieuMuon] ([maPhieuMuon], [ngayMuon], [soNgayMuon], [maTaiKhoan], [maCanBo], [ghiChu], [trangThai]) VALUES (N'PM005', CAST(N'2021-05-24' AS Date), 7, N'1911505310132', N'101010    ', N'', N'Chưa trả')
INSERT [dbo].[PhieuMuon] ([maPhieuMuon], [ngayMuon], [soNgayMuon], [maTaiKhoan], [maCanBo], [ghiChu], [trangThai]) VALUES (N'PM006', CAST(N'2021-05-24' AS Date), 7, N'1911505310123', N'101010    ', N'', N'Đã trả')
INSERT [dbo].[PhieuMuon] ([maPhieuMuon], [ngayMuon], [soNgayMuon], [maTaiKhoan], [maCanBo], [ghiChu], [trangThai]) VALUES (N'PM007', CAST(N'2021-05-25' AS Date), 7, N'1911505310132', N'101010    ', N'khong', N'Chưa trả')
INSERT [dbo].[PhieuMuon] ([maPhieuMuon], [ngayMuon], [soNgayMuon], [maTaiKhoan], [maCanBo], [ghiChu], [trangThai]) VALUES (N'PM008', CAST(N'2021-05-23' AS Date), 7, N'1911505310123', N'101010    ', N'', N'Chưa trả')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0001', N'Lập trình cơ bản với C', N'DM003     ', N'TL001     ', N'Hoàng Thị Mỹ Lệ', N'NXB Công nghệ thông tin', 2016, 5, N'Với mong muốn chia sẻ kinh nghiệm học lập trình và các kỹ năng mà anh đã trải qua trong suốt quá trình học và làm việc với tư cách là người đi trước cũng như là một Developer Full Stack, nên anh đã quyết định xuất bản sách')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0002', N'Giáo trình kỹ thuật xung số và ứng dụng', N'DM003     ', N'TL001     ', N'Nguyễn Linh Nam', N'NXB Công nghệ thông tin', 2016, 3, N'Với mong muốn chia sẻ kinh nghiệm học lập trình và các kỹ năng mà anh đã trải qua trong suốt quá trình học và làm việc với tư cách là người đi trước cũng như là một Developer Full Stack, nên anh đã quyết định xuất bản sách')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0003', N'Trường điện từ - Lý thuyết và bài tập', N'DM003     ', N'TL001     ', N'Lê Văn Sung', N'NXB Công nghệ thông tin', 2016, 3, N'Với mong muốn chia sẻ kinh nghiệm học lập trình và các kỹ năng mà anh đã trải qua trong suốt quá trình học và làm việc với tư cách là người đi trước cũng như là một Developer Full Stack, nên anh đã quyết định xuất bản sách')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0004', N'Cơ sở dữ liệu', N'DM003     ', N'TL001     ', N'Hoàng Thị Mỹ Lệ', N'NXB Công nghệ thông tin', 2016, 3, N'Với mong muốn chia sẻ kinh nghiệm học lập trình và các kỹ năng mà anh đã trải qua trong suốt quá trình học và làm việc với tư cách là người đi trước cũng như là một Developer Full Stack, nên anh đã quyết định xuất bản sách')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0005', N'Tin học văn phòng', N'DM003     ', N'TL001     ', N'Hoàng Thị Mỹ Lệ', N'NXB Công nghệ thông tin', 2016, 3, N'Với mong muốn chia sẻ kinh nghiệm học lập trình và các kỹ năng mà anh đã trải qua trong suốt quá trình học và làm việc với tư cách là người đi trước cũng như là một Developer Full Stack, nên anh đã quyết định xuất bản sách')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0006', N'Bơm nhiệt', N'DM002     ', N'TL001     ', N'Nguyễn Đức Lợi', N'NXB Cơ Khí', 2018, 3, N'Giáo trình gồm có 10 chương, trình bày các vấn đề về cơ cấu máy, phân tích động lực học cơ cấu máy, các vấn đề cơ bản trong thiết kế truyền động cơ khí, thiết kế các bộ truyền cơ khí và bộ phận đỡ nổi các bộ truyền. ')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0007', N'Cơ sở thiết kế máy', N'DM002     ', N'TL001     ', N'Nguyễn Đức Lợi', N'NXB Cơ Khí', 2018, 3, N'Giáo trình gồm có 10 chương, trình bày các vấn đề về cơ cấu máy, phân tích động lực học cơ cấu máy, các vấn đề cơ bản trong thiết kế truyền động cơ khí, thiết kế các bộ truyền cơ khí và bộ phận đỡ nổi các bộ truyền. ')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0008', N'Đo lường nhiệt', N'DM002     ', N'TL001     ', N'Võ Huy Hoàng', N'NXB Cơ Khí', 2018, 3, N'Giáo trình gồm có 10 chương, trình bày các vấn đề về cơ cấu máy, phân tích động lực học cơ cấu máy, các vấn đề cơ bản trong thiết kế truyền động cơ khí, thiết kế các bộ truyền cơ khí và bộ phận đỡ nổi các bộ truyền. ')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0009', N'Nhiên liệu sạch', N'DM002     ', N'TL001     ', N'Nguyễn Đức Lợi', N'NXB Cơ Khí', 2018, 3, N'Giáo trình gồm có 10 chương, trình bày các vấn đề về cơ cấu máy, phân tích động lực học cơ cấu máy, các vấn đề cơ bản trong thiết kế truyền động cơ khí, thiết kế các bộ truyền cơ khí và bộ phận đỡ nổi các bộ truyền. ')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0010', N'Giáo trình kỹ thuật nhiệt', N'DM002     ', N'TL001     ', N'Nguyễn Đức Lợi', N'NXB Cơ Khí', 2018, 3, N'Giáo trình gồm có 10 chương, trình bày các vấn đề về cơ cấu máy, phân tích động lực học cơ cấu máy, các vấn đề cơ bản trong thiết kế truyền động cơ khí, thiết kế các bộ truyền cơ khí và bộ phận đỡ nổi các bộ truyền. ')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0011', N'Ngoại ngữ 1', N'DM005     ', N'TL002     ', N'Nguyễn Như Hiền', N'NXB Ngoại ngữ', 2010, 1, N'Nội dung chính của sách, gồm từ mới, mẫu câu được giới thiệu bằng hình ảnh trực quan kết hợp với việc nghe đĩa,
								kế đến là những bài tập đọc hiểu. Các chủ điểm ngữ pháp được đưa vào sách một cách nhẹ nhàng và tự nhiên thông qua 
								các tình huống thực tế.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0012', N'Grammar in use', N'DM005     ', N'TL002     ', N'Nguyễn Đức Trí', N'NXB Ngoại ngữ', 2018, 4, N'Nội dung chính của sách, gồm từ mới, mẫu câu được giới thiệu bằng hình ảnh trực quan kết hợp với việc nghe đĩa,
								kế đến là những bài tập đọc hiểu. Các chủ điểm ngữ pháp được đưa vào sách một cách nhẹ nhàng và tự nhiên thông qua 
								các tình huống thực tế.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0013', N'Listen carefully', N'DM005     ', N'TL002     ', N'Nguyễn Như Hiền', N'NXB Ngoại ngữ', 2018, 2, N'Nội dung chính của sách, gồm từ mới, mẫu câu được giới thiệu bằng hình ảnh trực quan kết hợp với việc nghe đĩa,
								kế đến là những bài tập đọc hiểu. Các chủ điểm ngữ pháp được đưa vào sách một cách nhẹ nhàng và tự nhiên thông qua 
								các tình huống thực tế.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0014', N'Ngoại ngữ cơ bản', N'DM005     ', N'TL002     ', N'Nguyễn Như Hiền', N'NXB Ngoại ngữ', 2018, 2, N'Nội dung chính của sách, gồm từ mới, mẫu câu được giới thiệu bằng hình ảnh trực quan kết hợp với việc nghe đĩa,
								kế đến là những bài tập đọc hiểu. Các chủ điểm ngữ pháp được đưa vào sách một cách nhẹ nhàng và tự nhiên thông qua 
								các tình huống thực tế.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0015', N'Ngoại ngữ 2', N'DM005     ', N'TL002     ', N'Nguyễn Như Hiền', N'NXB Ngoại ngữ', 2018, 1, N'Nội dung chính của sách, gồm từ mới, mẫu câu được giới thiệu bằng hình ảnh trực quan kết hợp với việc nghe đĩa,
								kế đến là những bài tập đọc hiểu. Các chủ điểm ngữ pháp được đưa vào sách một cách nhẹ nhàng và tự nhiên thông qua 
								các tình huống thực tế.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0016', N'Kỹ thuật xử lý tín hiệu điều khiển', N'DM001     ', N'TL001     ', N'	Phạm Ngọc Thắng', N'NXB Điện-Điện Tử', 2014, 1, N'Giáo trình này được sử dụng làm tài liệu học tập cho sinh viên các khối ngành kỹ thuật và các ngành có liên quan đến kỹ thuật.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0017', N'Bài tập vi điều khiển và PLC', N'DM001     ', N'TL001     ', N'Đặng Văn Tuệ', N'NXB Điện-Điện Tử', 2014, 4, N'')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0018', N'Khí cụ điện - kết cấu, sử dụng và sửa chữa', N'DM001     ', N'TL001     ', N'Nguyễn Xuân Phú', N'NXB Điện-Điện Tử', 2014, 2, N'Giáo trình này được sử dụng làm tài liệu học tập cho sinh viên các khối ngành kỹ thuật và các ngành có liên quan đến kỹ thuật.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0019', N'Sổ tay chuyên ngành điện', N'DM001     ', N'TL002     ', N'Tăng Văn Mùi - Trần Duy Nam', N'NXB Điện-Điện Tử', 2013, 2, N'Giáo trình này được sử dụng làm tài liệu học tập cho sinh viên các khối ngành kỹ thuật và các ngành có liên quan đến kỹ thuật.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0020', N'Bài tập điều khiển tự động', N'DM001     ', N'TL001     ', N'	Nguyễn Công Phương', N'NXB Điện-Điện Tử', 2013, 1, N'Giáo trình này được sử dụng làm tài liệu học tập cho sinh viên các khối ngành kỹ thuật và các ngành có liên quan đến kỹ thuật.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0021', N'Sổ tay máy làm đất và làm đường', N'DM004     ', N'TL002     ', N'Lưu Bá Thuận', N'NXB Xây dựng', 2015, 10, N'Cuốn sách này nhằm hệ thống hóa và trang bị các khái niệm, thông tin cơ bản về các hệ thống kỹ thuật trong công trình cho các sinh viên trong trường Đại học Xây dựng nói riêng cũng như các trường đại học có đạo tạo ngành kỹ thuật xây dựng.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0022', N'Móng cọc phân tích và thiết kế', N'DM004     ', N'TL001     ', N'Nguyễn Thái', N'NXB Xây dựng', 2014, 4, N'Cuốn sách này nhằm hệ thống hóa và trang bị các khái niệm, thông tin cơ bản về các hệ thống kỹ thuật trong công trình cho các sinh viên trong trường Đại học Xây dựng nói riêng cũng như các trường đại học có đạo tạo ngành kỹ thuật xây dựng.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0023', N'Cấu tạo bê tông cốt thép', N'DM004     ', N'TL001     ', N'Bộ Xây dựng', N'NXB Xây dựng', 2014, 2, N'Cuốn sách này nhằm hệ thống hóa và trang bị các khái niệm, thông tin cơ bản về các hệ thống kỹ thuật trong công trình cho các sinh viên trong trường Đại học Xây dựng nói riêng cũng như các trường đại học có đạo tạo ngành kỹ thuật xây dựng.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0024', N'Kết cấu thép - Công trình đặc biệt', N'DM004     ', N'TL001     ', N'GS.TS.Phạm Văn Hội ', N'NXB Xây dựng', 2013, 2, N'Cuốn sách này nhằm hệ thống hóa và trang bị các khái niệm, thông tin cơ bản về các hệ thống kỹ thuật trong công trình cho các sinh viên trong trường Đại học Xây dựng nói riêng cũng như các trường đại học có đạo tạo ngành kỹ thuật xây dựng.')
INSERT [dbo].[Sach] ([maSach], [tenSach], [maDMSach], [maTheLoai], [TacGia], [NXB], [namXuatBan], [soLuongCon], [tomTatND]) VALUES (N'S0025', N'Kết cấu bê tông cốt thép - Phần cấu kiện cơ bản', N'DM004     ', N'TL001     ', N'Phan Quang Minh', N'NXB Xây dựng', 2013, 1, N'Cuốn sách này nhằm hệ thống hóa và trang bị các khái niệm, thông tin cơ bản về các hệ thống kỹ thuật trong công trình cho các sinh viên trong trường Đại học Xây dựng nói riêng cũng như các trường đại học có đạo tạo ngành kỹ thuật xây dựng.')
INSERT [dbo].[TaiKhoan] ([maTaiKhoan], [matKhau], [tenNguoiDung], [ngaySinh], [gioiTinh], [email], [sdt], [status], [soLuongMuon]) VALUES (N'1911505310118', N'abc123', N'Cao Thị Thúy Hằng', CAST(N'2001-09-02' AS Date), 2, N'thuyhangfr01@gmail.com', N'0776155064', 1, 3)
INSERT [dbo].[TaiKhoan] ([maTaiKhoan], [matKhau], [tenNguoiDung], [ngaySinh], [gioiTinh], [email], [sdt], [status], [soLuongMuon]) VALUES (N'1911505310123', N'abc123', N'Lê Quốc Tuấn', CAST(N'2001-07-09' AS Date), 1, N'lequoctuan@gmail.com', N'0777443873', 1, 1)
INSERT [dbo].[TaiKhoan] ([maTaiKhoan], [matKhau], [tenNguoiDung], [ngaySinh], [gioiTinh], [email], [sdt], [status], [soLuongMuon]) VALUES (N'1911505310124', N'abc123', N'Võ Xuân Phúc', CAST(N'2001-07-09' AS Date), 1, N'voxuanphuc@gmail.com', N'0777443873', 1, 0)
INSERT [dbo].[TaiKhoan] ([maTaiKhoan], [matKhau], [tenNguoiDung], [ngaySinh], [gioiTinh], [email], [sdt], [status], [soLuongMuon]) VALUES (N'1911505310125', N'abc123', N'Nguyễn Thị Thu Thủy', CAST(N'2001-07-09' AS Date), 2, N'thuthuy@gmail.com', N'0777443873', 1, 0)
INSERT [dbo].[TaiKhoan] ([maTaiKhoan], [matKhau], [tenNguoiDung], [ngaySinh], [gioiTinh], [email], [sdt], [status], [soLuongMuon]) VALUES (N'1911505310132', N'abc123', N'Nguyễn Đình Khoa', CAST(N'2001-07-09' AS Date), 1, N'nguyendinhkhoa19t1@gmail.com', N'0777443873', 1, 3)
INSERT [dbo].[TheLoai] ([maTheLoai], [tenTheLoai]) VALUES (N'TL001     ', N'Giáo trình học')
INSERT [dbo].[TheLoai] ([maTheLoai], [tenTheLoai]) VALUES (N'TL002     ', N'Sách tham khảo')
INSERT [dbo].[TheLoai] ([maTheLoai], [tenTheLoai]) VALUES (N'TL003     ', N'Văn hóa lịch sử')
INSERT [dbo].[TheLoai] ([maTheLoai], [tenTheLoai]) VALUES (N'TL004     ', N'Chính trị, Pháp luật')
INSERT [dbo].[TheLoai] ([maTheLoai], [tenTheLoai]) VALUES (N'TL005     ', N'Tạp chí')
ALTER TABLE [dbo].[CanBo] ADD  DEFAULT ('1') FOR [status]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ('1') FOR [status]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ((0)) FOR [soLuongMuon]
GO
ALTER TABLE [dbo].[ChiTietPhieuMuon]  WITH CHECK ADD FOREIGN KEY([maPhieuMuon])
REFERENCES [dbo].[PhieuMuon] ([maPhieuMuon])
GO
ALTER TABLE [dbo].[ChiTietPhieuMuon]  WITH CHECK ADD FOREIGN KEY([maSach])
REFERENCES [dbo].[Sach] ([maSach])
GO
ALTER TABLE [dbo].[PhieuMuon]  WITH CHECK ADD FOREIGN KEY([maCanBo])
REFERENCES [dbo].[CanBo] ([maCanBo])
GO
ALTER TABLE [dbo].[PhieuMuon]  WITH CHECK ADD FOREIGN KEY([maTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([maTaiKhoan])
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD FOREIGN KEY([maDMSach])
REFERENCES [dbo].[DanhMucSach] ([maDMSach])
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD FOREIGN KEY([maTheLoai])
REFERENCES [dbo].[TheLoai] ([maTheLoai])
GO
ALTER TABLE [dbo].[CanBo]  WITH CHECK ADD CHECK  (([Email] like '[a-z]%@%'))
GO
ALTER TABLE [dbo].[CanBo]  WITH CHECK ADD CHECK  (([SDT] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR [SDT] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD CHECK  (([Email] like '[a-z]%@%'))
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD CHECK  (([SDT] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR [SDT] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
USE [master]
GO
ALTER DATABASE [QuanLyThuVien_HKP2T] SET  READ_WRITE 
GO
