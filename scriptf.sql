USE [master]
GO
/****** Object:  Database [CC_Models]    Script Date: 17-04-2023 11:08:59 ******/
CREATE DATABASE [CC_Models]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CC_Models', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CC_Models.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CC_Models_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CC_Models_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CC_Models] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CC_Models].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CC_Models] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CC_Models] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CC_Models] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CC_Models] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CC_Models] SET ARITHABORT OFF 
GO
ALTER DATABASE [CC_Models] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CC_Models] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CC_Models] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CC_Models] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CC_Models] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CC_Models] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CC_Models] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CC_Models] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CC_Models] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CC_Models] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CC_Models] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CC_Models] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CC_Models] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CC_Models] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CC_Models] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CC_Models] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CC_Models] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CC_Models] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CC_Models] SET  MULTI_USER 
GO
ALTER DATABASE [CC_Models] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CC_Models] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CC_Models] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CC_Models] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CC_Models] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CC_Models] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CC_Models', N'ON'
GO
ALTER DATABASE [CC_Models] SET QUERY_STORE = ON
GO
ALTER DATABASE [CC_Models] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CC_Models]
GO
/****** Object:  Table [dbo].[advertisement]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[advertisement](
	[ad_id] [int] IDENTITY(1,1) NOT NULL,
	[date_created] [date] NOT NULL,
	[expiry_date] [date] NOT NULL,
	[type_of_ad] [date] NOT NULL,
	[container_type_id] [int] NOT NULL,
	[price] [decimal](18, 2) NULL,
	[status] [nvarchar](50) NULL,
	[quantity] [int] NOT NULL,
	[port_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[posted_by] [int] NOT NULL,
	[updated_by] [int] NOT NULL,
	[update_date_time] [datetime] NOT NULL,
	[port_of_departure] [nvarchar](50) NOT NULL,
	[port_of_arrival] [nvarchar](50) NOT NULL,
	[slot_details] [nvarchar](50) NULL,
	[free_days] [int] NULL,
	[per_diem] [int] NULL,
	[pickup_charges] [decimal](18, 4) NULL,
PRIMARY KEY CLUSTERED 
(
	[ad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company](
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[licence_id] [int] NOT NULL,
	[domain_address] [nvarchar](50) NOT NULL,
	[company_logo] [image] NULL,
	[company_location] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[rating] [decimal](4, 2) NULL,
	[address] [nvarchar](50) NULL,
 CONSTRAINT [PK_company] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[container]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[container](
	[container_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[capacity] [decimal](5, 2) NOT NULL,
	[availability] [nvarchar](50) NOT NULL,
	[price] [decimal](8, 3) NOT NULL,
	[mfg] [date] NOT NULL,
	[serial_no] [nvarchar](50) NOT NULL,
	[container_type_id] [int] NOT NULL,
	[port_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[container_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[container_type]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[container_type](
	[container_type_id] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[capacity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[container_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[contracts]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contracts](
	[contract_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[content] [nvarchar](50) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[upload_file] [varbinary](max) NOT NULL,
	[updated_by] [int] NOT NULL,
	[updated_date_time] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[contract_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inventory]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventory](
	[inventory_id] [int] IDENTITY(1,1) NOT NULL,
	[date_created] [date] NOT NULL,
	[last_modified] [date] NOT NULL,
	[company_id] [int] NOT NULL,
	[container_type] [nvarchar](50) NOT NULL,
	[available] [int] NOT NULL,
	[maximum] [int] NOT NULL,
	[minimum] [int] NOT NULL,
	[port_id] [int] NOT NULL,
	[updated_by] [int] NOT NULL,
	[container_size] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[inventory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[message]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[message](
	[message_id] [int] IDENTITY(1,1) NOT NULL,
	[negotiation_id] [int] NOT NULL,
	[sender_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[message_body] [nvarchar](50) NULL,
	[created_time] [date] NOT NULL,
	[status] [nvarchar](50) NULL,
	[container_image] [image] NULL,
	[recipent_company_id] [int] NOT NULL,
	[updated_date_time] [date] NOT NULL,
	[updated_by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[message_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[negotiation]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[negotiation](
	[negotiation_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[ad_id] [int] NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[negotiation_type] [nvarchar](50) NULL,
	[container_type] [nvarchar](50) NULL,
	[quantity] [int] NOT NULL,
	[status] [nvarchar](50) NULL,
	[company_id] [int] NOT NULL,
	[contract_id] [int] NOT NULL,
	[date_created] [date] NOT NULL,
	[expiry_date] [date] NOT NULL,
	[updated_by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[negotiation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[permission]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permission](
	[permission_id] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](max) NOT NULL,
	[actions] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_permission] PRIMARY KEY CLUSTERED 
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ports]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ports](
	[port_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[port_name] [nvarchar](50) NOT NULL,
	[latitude] [decimal](5, 2) NOT NULL,
	[longitude] [decimal](5, 2) NOT NULL,
	[state] [nvarchar](50) NULL,
	[country] [nvarchar](50) NOT NULL,
	[city] [nvarchar](50) NOT NULL,
	[region] [nvarchar](50) NULL,
	[sub_region] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[port_code] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[port_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transaction]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transaction](
	[transaction_id] [int] IDENTITY(1,1) NOT NULL,
	[contract_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[date_time] [date] NOT NULL,
	[amount] [decimal](8, 3) NULL,
	[status] [nvarchar](50) NULL,
	[updated_by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[up_mapping]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[up_mapping](
	[up_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[up_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 17-04-2023 11:08:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[fname] [nvarchar](50) NOT NULL,
	[lname] [nvarchar](50) NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[phone_no] [nvarchar](20) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[is_verified] [int] NOT NULL,
	[is_approved] [int] NOT NULL,
	[is_active] [int] NOT NULL,
	[last_login] [datetime] NOT NULL,
	[designation] [nvarchar](50) NOT NULL,
	[otp] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[company] ON 

INSERT [dbo].[company] ([company_id], [name], [licence_id], [domain_address], [company_logo], [company_location], [country], [rating], [address]) VALUES (1, N'TCS', 0, N'vfgc', 0x89504E470D0A1A0A0000000D494844520000008C000000230806000000468AE205000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400000E2E49444154785EED5C097454D5197E01A42EC5BA5112C44CA8B458F4682D1E259399442B5AAB1EADB5E8D1D6A5D6D69E2AB4EE928521862420A6A8A77AA08228347B4242820149609248C5051511AD5257ACD29A05085464BBB7DFF7DE7D9377DF4C2633444F439AEF9CFFDCFBDFFBBFF7326FBEF9B7371343BC32F254F176D22B727392146F24CD150DE3BE613821CACE3244E55B8628DF6F88E24C432E3842ED448628BE15B65D908F0D597ABE5A8D087FA3B8DAD72ADA7C2DA22D7DB5B8462D0FA23F03247941BE3F5A9230F2BD93419AC49BD49661C80D4718A2F44543D6494356406A21C53F55BBE13009550D9B4ACB56947E6A88A5496A5783BF49DEEC6F11FBD29F97327D9D94694D624F6A509CA1B607D15F01C2EC929B4016CA3F468330A372D51608539168BEE926094A21CB499807D4AE0E519CD54D96124815085302AF54164682B455E296F456B19744F13549E96FB64833A9515CA24C06D15F215E4FEC946F2AC26C01613625E6A82D45981284169B30352041F1BD6AB71BA264BA4E16DAAEA06D892183C3949589B4D5E20E7FABD84FCF42B2F8D64879C12BF0306B44EBC446F92D653688FE0AB131B1233EC294DEA3762D686188642983D4C3AE7C158ED708609105DEC44196F35FC618142FA535CA64653688FE8CF809E3F03061618864A167295F83D07592B23291D6286EF13FAF7B1692C5DF2C5ECC088A31CA6C10FD1DF113A6EC8FE69E28CE8B4C96D295865834D2B451F0358ADF230CED758721DF5AF1C2B90D836439AC101F619671BC1964B9C3AA984816AE531886CA56A0ECD6C2906F8D989ADE43183A6795384599F515972624245462BCC85207F1B5213EC2C08B88925721BBBAC912CA59561862E10875A4096FA3980ACF7250230B3D4BF3574A16A21A84918A3483E83B4EC7BD6CC2986AA90EC447180ACA65B327E34C704B91E0EA9E25F539310D39CB017A172759FC41D1EA5F2922F666FA00DBC35C68A983E823AEE20710E36F2CD581F809638B4D1686A19AE3D4112690B34C8BE859D68AD6F3968B51CACCC479F76F4B49CDEAF4287510FD035728C2FCCA521D3834C2D8092EC350AD168698B3F85B5C398B1586D6670465A23233E1CD6EBF336DE6EE368A37BB23BCBF3388FF15E8B149981B2CD581F80913CA596A22E42C77867916AB745E97E1AA8652B33BEEF705764BDF837BA43F6FAF04610EF872DA26AAED78C112FE6790134CCD3086402E839C666ABD2301C26759DF37351D0C9F5740A6E326CEC6781FE462C8F19048F0427E624D6302CF956E4D35F0C375F9902143321DD76527BCA7EB12EED77D2CE4129C230BE728E2B9A0735FF3F20E1C05616A718D22CC6D9063208C205614893BE9B54AE765200C4F1E82AF4964B2BDEFCC59EC0E2EF2996F2B3313A9591D33FD0FEE9569812E10A55DA6CDD8297D815DD29BD3768132891753D40BB41F2D0C87BE1512547A6FB880C7E3866A8F3DA0DF81F50EEE41BA20FF84EC56FA0730B9D1B2D450461B8CDA6BEE0189CAB6CA5243B813EB6DEA3A3B21DA75F177FD42D9B9C1F3EDC3387DD8B0613ECCDF55C71C807C09114AFF0CE7707B8F63B1BE12F21184D7A3DDBF21EF403E846C85CDE43808639305398B584AE68680DC649A593ABBC8E20FCAE6C864F91224B1C8E2CDE994190552C2E3546504E491CA2C5E5CCB1788F1524B85CB4848C8576BE199BE0BB0AB857C81E9386BC5180E59CAE3212D43870EE50357F696E851F9C9BF01EB6FA8FD42E84E5CC4758C56BF2A3A1E50B6932DD5380AFA1275DE75D0AF869C0831AF8B37F93AACBFAE8EA1D771E314EC75625C8FB11DB201C7300FE1EBA257190FFD77587F5B9D632AC4C69158CB852C8234701F12843C0E7912F2346CCE889130ECBF300C55D4BAC3505A93F8833B0C994DB966D1925127B56EAF37F3F3804916E559BC39DB657AFE41CCB7D779EF6DD3CE1B276C17EA0C0527638D9FCADE4AEDB3792CE409A59340BC715C9B07956E3E128EC1BE492ACC9DC92196125A21F4409A177681C7F393DC82394322310BBA7D5DED199C034763BF987698BB93D23158A757E0DE5288FE55956E1C0F1B9281DEE86C6B4983E971314EB154076220CC5643AE66182A37C412C6B310BC0C43204A58E9DC2C82BE06A1757B5333DB7275CF02B2E41D9093B23B4BCEBC7B9B76DE434024C2F09D9BABD623DD1413D8E79BBE1FD3F1D68AF103E8FB202B941E0D0C7D2F43B661EE7CBD57628D21EE16A587017BBFA40DA6F6DFFC3DE87C036B2D352AE80D5E83ECC47CB4B5648284D9057907F3686425CE84DD41C8934A77228E2A69A38330A264346437F2953A432ED6C20572962CE62C7C981822CB068EE1A5B3198672F530946E86A1CEAA090149F7DF5744240C908275C6EEC54A77633CF6488E254A270A782EE4004C5E7B05C315ED31BDCE5A3141EFF1016413E6915EDF30EC6D80BC86B9BD9FADCEF3434BED15F66BBED5524D90305F401E577A54C08E64DF82E9506B25843808F35A62406D6173E978789645208BDE676912F76909EE5A3B67116BC33C8B2B674933C39090DE193BFA1A869CE88930C47CECEDC578AAA56AF8933A2E549D41A7ABFE04D39EDCB91B49B067E2FA98A55A8007B94B9D3BD217CECCB21536D72B9D60DEF021C658AFCB7C851F86454A274CC2608C94DF8401B67F857461CA3CC989D80923DF1835536D6113959028D25C1BAA9EE9E9CC59C2C350FD64EDFB2C32615266DB232C99B53034EB007396928BFA1E869C8846187A11869C872D3584E3B0CE4AC4190286406755B09E736BA957D05BB0B22857BA8D13B1B64D9DCBF909C69299E37C84F9D1D692B9C64F3B6D6305FF7EE640CF2A9DB00933D752A303B64F43487677997D88847121AD51648795CE0843696B64B34E1636E53A0AD3671D0459763AC87250C2E3148F9BBA25D64F51AC88461882794A3B46BB4F430F70BB3AC667AD98C092192ADEC2DCEDA67BC208D8B3F47E4AE921E01A33B0CE6B381F8A66700D7BCE129E496F33D619C26225EA49B0EF84D4299D889730CF407661EA6E01D884B9D9521DD008C3AF686E4C9AA5B634D8394BACA5B32F774F882C66180259BC59DB8B9D394BC0080C29485E7639A5C2A888F50D8A84DE08730EF7192694CEA4710B84158AF60661ED29084358AC5FE83A97E7C678B7A56AB02BB59017C0BC06B21D53F79BF404D6FF8331D687B2E67521CE1ECE5745183369C718DE670A1186F2F1C94C7AED9B1A826FB5C8CB6082DBA2C8829C457570EBCFAA918EFC4626A466B617994D392D0C99A573C9C4DFCAD02F0E0249754717265795CC4DA997947CCC177BF4C43A0EF44618DE9CE510369F4810DBFE2AEEB97019F720F94A8F0AD8B16FC290D75357B9485DEBBB14358F74EE1FA9BD072D353A60BB98F6106728FCAA087321CF8D318C0B1661F88B018B2CCBE5A664ADF58C309493F1379D2CAA835BEFAD155AD28A30F4287314B7676118CAB8E9C31019EE1EB5E49802CFB2AA47C63E27677B6AE4432975A6142697D90DAC78D12B6180C9CA865DE14608FB24760EE1047312EED3F64A6B2932E0B16EA41DE451B51409E3B04F8F3503528839738648DE8BF91313DF83A8BC7AFB5ECF6DB0E375BF2EC2B063BC03420FACC324CC27FC79C9E81AB979E437D5B28950E94CB22004996479156350AC3AB74168DD5E90659E7FD67E90658722CB0EB32947B238C3D09C13178EC8F75457CD1BBB4A167AAA6581A7D2224B0AE62995E729B378110B61D8336105F4B9B2BDDD5A8E88EFC0E63DDA8114EC86BA1374E60F33B90FD948DD5A8E0CD830B964B9BB17A255532E9C8AFD4F20FBD575B5F70360C32D0FC2EB322F7B1FE2CE61F6608C9530F48E111F63E0FA66FE05614B829D623612130CF9F72429362795C9A0470B07F02CB90C43CED2D90C4341D130699508258F6618CA6A7FC8AA866CCFB243FAF3F6211CED5838658A0CE52685C92B8E0741EA9C649993522B1F1EBB82F33C897329D378713D5F1CC6CB2DB54798DFF380B04289F6108FE09B57A7ECF9262EC31A5BE4F510B6DDED9BD9D3833C27CE82AD4918CCED06614F380D762BD4F93F855E0DB1AFCBAA8ECF83F8388255D8A790353C4881A536EF4334528600DB5288C034D26BA0A7655EC5BF83E5FB67907586D894B44434E8B53F3C4B61C67A57CEC20477ADA8CBA8904ED627A466B73DE67784A1EE9CA5E3292759E68C5F38A23079D9B30C43DD64A99145204BBEA722A6B81D0513F062F8AC2352AFC509DE84F9187B7A7817097C3EC544F85508136596BF8F602DA6C69E023D123D9BB341D81B7E0C7B12851D5D3E447C196B2442C80B63AD109EC0D9B8A3176578ECF9C7863AAE85F03144B45FB35E8C73FE19F21CE6BC773A909BE466BCE0CA59CCD259D48787A1EDC859BAC39017239B720C43973C2A4224B472163D0CCDF1C0B3A4D0B39477FF706E80026FEA3DB8E1FCE49F63AD0C10C0B304F86CC8268B9F9EE5258C6B44A533C19D10D83C1C1EE4717F1EC9A2C210C8C230949AB363B1563A8F293FA120B9BA263C0C3D2BF3C794472CE10718F8B501BAF306A50F0C781986DC9E0561C8B7562C9FB8A0BB1C66CEE2CDFA7C01BF92C05CC50A43F02C208F37AB7D81110884FA1AF33C35C7210CADD4C3502DC210C8D2F73074B8C06E100E9C9F01FB1AE5EC9EC2905E3A832C289D4DCFA2C842CFC2523A35BB7D7E4640861EC917C1B3802CABDC9EA5C80C4395033E0C29D80D423E648CFE5F2F0E17C083DCA59125685543204B8D3B6749CDEEC8B5FA2C3A5940A2A79D64094CA8189E9F5C5D46CF82DCC51186EAE159CA7B7CF430D080DCE5D7CABB381F321EDE0031769A64517D16F347662DE2193D0C8158F95D231172B6FB73F75864B1C35076E77C6718220A3D9567172457ED7F2865B9832C663514F93F3F0C508030EC0F2DC4F4503BD8FD0F694DE2F5F35142DBA53312DFF20915E1DF519954B4F5286F56DB9B66096DF75990B3384B671B859E9A9482E4CA7F9124ECE45A64A9FCBFF12C031AF030A7A7B78ACD240CC8F3978C60CFDFAB4DCB6C9FE49DD1F5AE3767FB81D4ACB6A815CEECB1D53F9FE3A9692FF42CEB2A48A99CA696077158C330FE0B70FE066E939F5C3D0000000049454E44AE426082, N'vgfc', N'cgc', CAST(6.00 AS Decimal(4, 2)), N'gcg')
INSERT [dbo].[company] ([company_id], [name], [licence_id], [domain_address], [company_logo], [company_location], [country], [rating], [address]) VALUES (2, N'IVO Consultant', 84, N'www.IVOYANTConsultant.com', 0x433A5C55736572735C54617261204720505C50696374757265735C53637265656E73686F74735C6C696C6C792E6A7067, N'Kerala', N'India', CAST(4.10 AS Decimal(4, 2)), N'31th cross')
INSERT [dbo].[company] ([company_id], [name], [licence_id], [domain_address], [company_logo], [company_location], [country], [rating], [address]) VALUES (3, N'DEF Consultant', 897, N'www.DEFConsultant.com', 0x433A5C55736572735C54617261204720505C50696374757265735C53637265656E73686F74735C706F707065792E6A7067, N'Kolatta', N'India', CAST(4.20 AS Decimal(4, 2)), N'2th cross')
INSERT [dbo].[company] ([company_id], [name], [licence_id], [domain_address], [company_logo], [company_location], [country], [rating], [address]) VALUES (4, N'GHI Consultant', 897, N'www.GHIConsultant.com', 0x433A5C55736572735C54617261204720505C50696374757265735C53637265656E73686F74735C7265645F726F73652E6A7067, N'Mumbai', N'India', CAST(4.30 AS Decimal(4, 2)), N'3th cross')
INSERT [dbo].[company] ([company_id], [name], [licence_id], [domain_address], [company_logo], [company_location], [country], [rating], [address]) VALUES (5, N'JKL Consultant', 897, N'www.JKLConsultant.com', 0x433A5C55736572735C54617261204720505C50696374757265735C53637265656E73686F74735C74756C69702E6A7067, N'Bangalore', N'India', CAST(4.40 AS Decimal(4, 2)), N'4th cross')
INSERT [dbo].[company] ([company_id], [name], [licence_id], [domain_address], [company_logo], [company_location], [country], [rating], [address]) VALUES (6, N'KLM Consultant', 897, N'www.KLMConsultant.com', 0x433A5C55736572735C54617261204720505C50696374757265735C53637265656E73686F74735C6461686C69612E6A7067, N'Jaipur', N'India', CAST(4.50 AS Decimal(4, 2)), N'5th cross')
INSERT [dbo].[company] ([company_id], [name], [licence_id], [domain_address], [company_logo], [company_location], [country], [rating], [address]) VALUES (7, N'marine', 6989, N'www.asgg.com', 0x433A5C55736572735C5468656A655C446F776E6C6F6164735C494D4732303233303231333135313233372E6A7067, N'blr', N'india', CAST(8.70 AS Decimal(4, 2)), N'jp nagar')
SET IDENTITY_INSERT [dbo].[company] OFF
GO
SET IDENTITY_INSERT [dbo].[inventory] ON 

INSERT [dbo].[inventory] ([inventory_id], [date_created], [last_modified], [company_id], [container_type], [available], [maximum], [minimum], [port_id], [updated_by], [container_size]) VALUES (105, CAST(N'2023-07-28' AS Date), CAST(N'2023-04-13' AS Date), 3, N'refrigerated', 96544, 89, 987, 3, 23, 4)
INSERT [dbo].[inventory] ([inventory_id], [date_created], [last_modified], [company_id], [container_type], [available], [maximum], [minimum], [port_id], [updated_by], [container_size]) VALUES (108, CAST(N'2023-07-28' AS Date), CAST(N'2023-04-14' AS Date), 1, N'non_refrigerated', 6877, 6777, 1, 1, 8, 1)
INSERT [dbo].[inventory] ([inventory_id], [date_created], [last_modified], [company_id], [container_type], [available], [maximum], [minimum], [port_id], [updated_by], [container_size]) VALUES (109, CAST(N'2023-07-28' AS Date), CAST(N'2023-04-12' AS Date), 1, N'refrigerated', 6666666, 987, 987, 3, 8, 4)
INSERT [dbo].[inventory] ([inventory_id], [date_created], [last_modified], [company_id], [container_type], [available], [maximum], [minimum], [port_id], [updated_by], [container_size]) VALUES (115, CAST(N'2023-07-28' AS Date), CAST(N'2023-04-13' AS Date), 3, N'non_refrigerated', 6877, 6777, 6677, 1, 23, 1)
INSERT [dbo].[inventory] ([inventory_id], [date_created], [last_modified], [company_id], [container_type], [available], [maximum], [minimum], [port_id], [updated_by], [container_size]) VALUES (117, CAST(N'2023-07-28' AS Date), CAST(N'2023-04-13' AS Date), 1, N'non_refrigerated', 6877, 6777, 6677, 1, 8, 1)
INSERT [dbo].[inventory] ([inventory_id], [date_created], [last_modified], [company_id], [container_type], [available], [maximum], [minimum], [port_id], [updated_by], [container_size]) VALUES (119, CAST(N'2023-07-28' AS Date), CAST(N'2023-04-15' AS Date), 3, N'non_refrigerated', 6877, 6777, 6677, 1, 23, 1)
SET IDENTITY_INSERT [dbo].[inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[permission] ON 

INSERT [dbo].[permission] ([permission_id], [type], [actions]) VALUES (1, N'advertisement', N'read')
INSERT [dbo].[permission] ([permission_id], [type], [actions]) VALUES (2, N'advertisement', N'write')
INSERT [dbo].[permission] ([permission_id], [type], [actions]) VALUES (3, N'negotiation', N'read')
INSERT [dbo].[permission] ([permission_id], [type], [actions]) VALUES (4, N'negotiation', N'write')
INSERT [dbo].[permission] ([permission_id], [type], [actions]) VALUES (5, N'ARNR', N'R')
INSERT [dbo].[permission] ([permission_id], [type], [actions]) VALUES (6, N'AWNW', N'W')
INSERT [dbo].[permission] ([permission_id], [type], [actions]) VALUES (7, N'ARNW', N'RW')
INSERT [dbo].[permission] ([permission_id], [type], [actions]) VALUES (8, N'AWNR', N'WR')
SET IDENTITY_INSERT [dbo].[permission] OFF
GO
SET IDENTITY_INSERT [dbo].[ports] ON 

INSERT [dbo].[ports] ([port_id], [company_id], [port_name], [latitude], [longitude], [state], [country], [city], [region], [sub_region], [status], [port_code]) VALUES (1, 2, N'UT&TU', CAST(40.32 AS Decimal(5, 2)), CAST(78.09 AS Decimal(5, 2)), N'kar', N'india', N'blr', N'north', N'dhtg', N'surplus', N'IND56,1')
INSERT [dbo].[ports] ([port_id], [company_id], [port_name], [latitude], [longitude], [state], [country], [city], [region], [sub_region], [status], [port_code]) VALUES (2, 2, N'Vlore', CAST(40.27 AS Decimal(5, 2)), CAST(19.28 AS Decimal(5, 2)), N'', N'Albania', N'Albania', N'', N'', N'Available', N'ALVAL')
INSERT [dbo].[ports] ([port_id], [company_id], [port_name], [latitude], [longitude], [state], [country], [city], [region], [sub_region], [status], [port_code]) VALUES (3, 3, N'Valona', CAST(40.27 AS Decimal(5, 2)), CAST(19.28 AS Decimal(5, 2)), N'', N'Albania', N'Albania', N'', N'', N'Available', N'ALVAL')
INSERT [dbo].[ports] ([port_id], [company_id], [port_name], [latitude], [longitude], [state], [country], [city], [region], [sub_region], [status], [port_code]) VALUES (4, 5, N'Oran', CAST(35.43 AS Decimal(5, 2)), CAST(0.39 AS Decimal(5, 2)), N'', N'Algeria', N'Algeria', N'', N'', N'Busy', N'DZORN')
INSERT [dbo].[ports] ([port_id], [company_id], [port_name], [latitude], [longitude], [state], [country], [city], [region], [sub_region], [status], [port_code]) VALUES (5, 4, N'Sorrel', CAST(46.01 AS Decimal(5, 2)), CAST(73.01 AS Decimal(5, 2)), N'', N'Canada', N'Ontoria', N'', N'', N'Partially Available', N'CASOR')
INSERT [dbo].[ports] ([port_id], [company_id], [port_name], [latitude], [longitude], [state], [country], [city], [region], [sub_region], [status], [port_code]) VALUES (6, 6, N'Madras', CAST(13.06 AS Decimal(5, 2)), CAST(80.17 AS Decimal(5, 2)), N'', N'India', N'Southern India', N'', N'Chennai', N'Busy', N'INMAA')
SET IDENTITY_INSERT [dbo].[ports] OFF
GO
SET IDENTITY_INSERT [dbo].[up_mapping] ON 

INSERT [dbo].[up_mapping] ([up_id], [user_id], [permission_id]) VALUES (2, 2, 7)
INSERT [dbo].[up_mapping] ([up_id], [user_id], [permission_id]) VALUES (3, 2, 5)
INSERT [dbo].[up_mapping] ([up_id], [user_id], [permission_id]) VALUES (4, 2, 1)
INSERT [dbo].[up_mapping] ([up_id], [user_id], [permission_id]) VALUES (5, 2, 1)
SET IDENTITY_INSERT [dbo].[up_mapping] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (2, 2, N'Vishrutha', N'vignesh', N'india', N'v@gmail.com', N'9875446788', N'123', 1, 0, 1, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (3, 4, N'Avi', N'oo', N'fgc', N'ffgdgd', N'9875446788', N'tfhgff', 1, 0, 1, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (5, 1, N'jack', N'b', N'india', N'y@gmail.com', N'9875446788', N'123', 1, 0, 1, CAST(N'2024-07-15T00:00:00.000' AS DateTime), N'user', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (8, 1, N'amal', N'sghggh', N'gfhgsh', N'a@gmail.com', N'9875446788', N'123', 1, 1, 1, CAST(N'2024-07-15T00:00:00.000' AS DateTime), N'user', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (10, 2, N'Harish', N'oo', N'fgc', N'h@gmail.com', N'9875446788', N'123', 1, 0, 1, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (11, 1, N'ravi', N'sghggh', N'gfhgsh', N'r@gmail.com', N'9875446788', N'123', 1, 1, 1, CAST(N'2024-07-15T00:00:00.000' AS DateTime), N'user', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (15, 3, N'b', N'oo', N'fgc', N'b@gmail.com', N'9875446788', N'123', 0, 0, 1, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (17, 2, N'd', N'oo', N'fgc', N'd@gmail.com', N'9875446788', N'123', 0, 1, 0, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (18, 4, N'e', N'oo', N'fgc', N'e@gmail.com', N'9875446788', N'123', 0, 1, 1, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (19, 2, N'f', N'oo', N'fgc', N'f@gmail.com', N'9875446788', N'123', 1, 0, 0, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (20, 7, N'j', N'oo', N'fgc', N'j@gmail.com', N'9875446788', N'123', 1, 1, 0, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (21, 6, N'm', N'oo', N'fgc', N'm@gmail.com', N'9875446788', N'123', 0, 0, 0, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (22, 3, N'o', N'oo', N'fgc', N'o@gmail.com', N'9875446788', N'123', 1, 0, 1, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (23, 3, N'x', N'oo', N'fgc', N'x@gmail.com', N'9875446788', N'123', 1, 1, 1, CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (24, 4, N'tttttt', N'oo', N'fgc', N't', N'9875446788', N'123', 1, 1, 1, CAST(N'2023-04-10T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (25, 1, N'fanbns', N'oo', N'fgc', N'freds', N'9875446788', N'tfhgff', 1, 1, 1, CAST(N'2023-04-10T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (26, 3, N'fanbns', N'oo', N'fgc', N'hareiiiyyy', N'9875446788', N'tfhgff', 1, 1, 1, CAST(N'2023-04-10T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (27, 3, N'ramesh', N'oo', N'fgc', N'acchu@gmail.com', N'9875446788', N'123', 1, 1, 1, CAST(N'2023-04-11T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (28, 4, N'fanbns', N'oo', N'fgc', N'hh', N'9875446788', N'123', 1, 0, 1, CAST(N'2023-04-11T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (29, 1, N'ashitha', N'tfft', N'yt', N'ashi@gmail.com', N'9875446788', N'tfhgff', 1, 1, 1, CAST(N'2024-07-15T00:00:00.000' AS DateTime), N'user', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (30, 1, N'bavi', N'string', N'string', N'string', N'string', N'string', 1, 1, 1, CAST(N'2023-04-12T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (31, 4, N'THEJESH', N'UPPALA', N'fgc', N'ThejeshM@ivoyant.com', N'9875446788', N'1243', 1, 1, 1, CAST(N'2023-04-13T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (32, 1, N'string', N'string', N'string', N'string', N'string', N'string', 0, 0, 0, CAST(N'2023-04-14T05:17:09.350' AS DateTime), N'string', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (33, 3, N'THEJESH', N'UPPALA', N'fgc', N'ThejeshMshgggggggssssssss', N'9875446788', N'tfhgff', 1, 1, 1, CAST(N'2023-04-14T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (34, 1, N'fanbns', N'oo', N'fgc', N'ffgdgd', N'9875446788', N'tfhgff', 1, 1, 1, CAST(N'2023-04-14T00:00:00.000' AS DateTime), N'admin', 0)
INSERT [dbo].[users] ([user_id], [company_id], [fname], [lname], [address], [email], [phone_no], [password], [is_verified], [is_approved], [is_active], [last_login], [designation], [otp]) VALUES (35, 1, N'otptest', N'UPPALA', N'fgc', N'uppalathejesh@gmail.com', N'9875446788', N'123', 1, 1, 1, CAST(N'2023-04-16T00:00:00.000' AS DateTime), N'admin', 985953)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[inventory] ADD  DEFAULT ((0)) FOR [container_size]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [otp]
GO
ALTER TABLE [dbo].[advertisement]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[advertisement]  WITH CHECK ADD FOREIGN KEY([container_type_id])
REFERENCES [dbo].[container_type] ([container_type_id])
GO
ALTER TABLE [dbo].[advertisement]  WITH CHECK ADD FOREIGN KEY([port_id])
REFERENCES [dbo].[ports] ([port_id])
GO
ALTER TABLE [dbo].[advertisement]  WITH CHECK ADD FOREIGN KEY([posted_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[advertisement]  WITH CHECK ADD FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[container]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[container]  WITH CHECK ADD FOREIGN KEY([container_type_id])
REFERENCES [dbo].[container_type] ([container_type_id])
GO
ALTER TABLE [dbo].[container]  WITH CHECK ADD FOREIGN KEY([port_id])
REFERENCES [dbo].[ports] ([port_id])
GO
ALTER TABLE [dbo].[contracts]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[contracts]  WITH CHECK ADD FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[contracts]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD FOREIGN KEY([port_id])
REFERENCES [dbo].[ports] ([port_id])
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[message]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[message]  WITH CHECK ADD FOREIGN KEY([negotiation_id])
REFERENCES [dbo].[negotiation] ([negotiation_id])
GO
ALTER TABLE [dbo].[message]  WITH CHECK ADD FOREIGN KEY([recipent_company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[message]  WITH CHECK ADD FOREIGN KEY([sender_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[message]  WITH CHECK ADD FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[negotiation]  WITH CHECK ADD FOREIGN KEY([ad_id])
REFERENCES [dbo].[advertisement] ([ad_id])
GO
ALTER TABLE [dbo].[negotiation]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[negotiation]  WITH CHECK ADD FOREIGN KEY([contract_id])
REFERENCES [dbo].[contracts] ([contract_id])
GO
ALTER TABLE [dbo].[negotiation]  WITH CHECK ADD FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[negotiation]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[ports]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[transaction]  WITH CHECK ADD FOREIGN KEY([contract_id])
REFERENCES [dbo].[contracts] ([contract_id])
GO
ALTER TABLE [dbo].[transaction]  WITH CHECK ADD FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[transaction]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[up_mapping]  WITH CHECK ADD FOREIGN KEY([permission_id])
REFERENCES [dbo].[permission] ([permission_id])
GO
ALTER TABLE [dbo].[up_mapping]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
USE [master]
GO
ALTER DATABASE [CC_Models] SET  READ_WRITE 
GO
