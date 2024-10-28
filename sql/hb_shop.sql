-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 05, 2024 lúc 04:32 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `hb_shop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `productPrice` decimal(10,0) NOT NULL,
  `productImage` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cart`
--

INSERT INTO `cart` (`id`, `userId`, `productId`, `qty`, `productName`, `productPrice`, `productImage`) VALUES
(130, 1, 19, 1, 'Áo sơ mi tay cánh tiên', 600000, 'a1.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `status`) VALUES
(6, 'Áo Nữ', 1),
(7, 'Đầm Nữ', 1),
(8, 'Áo Khoác Dạ/Măng Tô Nữ', 1),
(9, 'Set Bộ CO-ORDS', 1),
(10, 'Đầm Dạ Hội - SENORA', 1),
(11, 'Quần và Jumpsuit', 1),
(12, 'Phụ kiện', 1),
(13, 'Chân váy', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chatbot`
--

CREATE TABLE `chatbot` (
  `id` int(11) NOT NULL,
  `queries` varchar(255) NOT NULL,
  `replies` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `createdDate` date NOT NULL,
  `receivedDate` date DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `phoneNumber` varchar(100) NOT NULL,
  `address` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `userId`, `createdDate`, `receivedDate`, `status`, `fullname`, `phoneNumber`, `address`) VALUES
(19, 3, '2024-05-24', '2024-05-24', 'Complete', 'Nguyễn Thị B', '0987533117', ' Liên Hiêp- Phúc Thọ - HÀ Nội'),
(20, 2, '2024-06-05', '2024-06-08', 'Delivered', 'Đỗ Kim Hoàn', '0987533117', ' hanoi');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `productPrice` decimal(10,0) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `productImage` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_details`
--

INSERT INTO `order_details` (`id`, `orderId`, `productId`, `qty`, `productPrice`, `productName`, `productImage`) VALUES
(22, 19, 20, 1, 1000000, 'Dark Beige Set(Áo sơ mi lụa và chân váy xếp ly)', 'a2.jpg'),
(23, 20, 21, 1, 1200000, 'Áo sơ mi họa tiết CROPTOP', 'a3.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `originalPrice` decimal(10,0) NOT NULL,
  `promotionPrice` decimal(10,0) NOT NULL,
  `image` varchar(50) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdDate` date NOT NULL,
  `cateId` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `des` varchar(1000) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `soldCount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `originalPrice`, `promotionPrice`, `image`, `createdBy`, `createdDate`, `cateId`, `qty`, `des`, `status`, `soldCount`) VALUES
(19, 'Áo sơ mi tay cánh tiên', 850000, 600000, 'a1.jpg', 1, '2024-05-19', 6, 9, '<b>Giới Thiệu: </b>\n<br> - Áo sơ mi cổ tròn dáng xuông. Tay liền tạo kiểu cánh tiên mềm mại kết hợp các đường xếp ly nhỏ, tinh tế thể hiện vẻ đẹp dịu dàng\n<br> - Cổ áo: Cổ tròn\n<br> - Tay áo: cánh tiên\n<br> - Kiểu dáng: xuông\n<br> - Họa tiết: trơn\n<br> - Chất liệu: lụa\n<br>', 1, 0),
(20, 'Dark Beige Set(Áo sơ mi lụa và chân váy xếp ly)', 1500000, 1000000, 'a2.jpg', 1, '2024-05-19', 6, 14, '<b>Giới Thiệu: </b>\r\n<br> - Áo sơ mi cổ đức, ngắn tay gập gấu cách điệu, thân trước cố đính qua hàng khuy kim loại sang trọng. Chân váy xếp ly độ dài qua gối, tạo độ bồng nhẹ, đặc biệt che khuyết điểm cực tốt\r\n<br> - Cổ áo: cổ đức\r\n<br> - Tay áo: tay ngắn\r\n<br> -	Kiểu dáng: xuông\r\n<br> - Họa tiết: trơn\r\n<br> -	Chất liệu: lụa\r\n<br>', 1, 1),
(21, 'Áo sơ mi họa tiết CROPTOP', 1500000, 1200000, 'a3.jpg', 1, '2024-05-19', 6, 15, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế cổ 2 ve, tay ngắn, kiểu dáng croptop năng động, trẻ trung. Với nền họa tiết bắt mắt, cùng kiểu dáng trẻ trung, thích hợp để nàng diện trong nhiều dịp khác nhau\r\n<br> - Cổ áo: Cổ 2 ve\r\n<br> - Tay áo: tay ngắn\r\n<br> - Kiểu dáng: Ôm\r\n<br> -	Họa tiết: trơn\r\n<br> - Chất liệu: Batiste\r\n<br>', 1, 1),
(22, 'Áo sơ mi họa tiết CROPTOP', 1600000, 1450000, 'a4.jpg', 1, '2024-05-19', 6, 1, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế cổ 2 ve, tay ngắn, kiểu dáng croptop năng động, trẻ trung. Với nền họa tiết bắt mắt, cùng kiểu dáng trẻ trung, thích hợp để nàng diện trong nhiều dịp khác nhau\r\n<br> - Cổ áo: Cổ 2 ve\r\n<br> - Tay áo: tay ngắn\r\n<br> - Kiểu dáng: Ôm\r\n<br> -	Họa tiết: trơn\r\n<br> - Chất liệu: Batiste\r\n<br>', 1, 0),
(23, 'Áo sơ mi peplum vai kiểu', 1500000, 1100000, 'a5.jpg', 1, '2024-05-19', 6, 8, '<b>Giới Thiệu: </b>\r\n<br> - Cổ áo được may nếp ly, mang đến vẻ nền nã và nữ tính cho thiết kế. Điểm nhấn đặc biệt là chi tiết xếp vai lệch cùng phần Peplum tinh tế, giúp tôn lên vòng eo thon gọn và làm nổi bật cho vẻ đẹp của sản phẩm\r\n<br> - Cổ áo: Cổ 2 ve\r\n<br> - Tay áo: Tay liền\r\n<br> - Kiểu dáng: Peplum\r\n<br> - Họa tiết: trơn\r\n<br> -	Chất liệu: Lụa\r\n<br>', 1, 0),
(24, 'White Woven - Set áo kiểu kèm chân váy', 800000, 600000, 'a6.jpg', 1, '2024-05-19', 6, 20, '<b>Giới Thiệu: </b>\r\n<br> -	Áo của Woven set với thiết kế cổ đức cùng điểm nhấn nổi bật là phần xếp ly vai tạo sự quyến rũ và thu hút\r\n<br> -	Cổ áo: Cổ 2 ve\r\n<br> - Tay áo: Tay liền\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: trơn \r\n<br> - Chất liệu: Tencel\r\n<br>', 1, 0),
(25, 'Áo Tencel dập nổi nhấn bèo', 700000, 550000, 'a7.jpg', 1, '2024-05-19', 6, 22, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế áo suông, không tay. Cổ V cách điệu cùng dây buộc phần cổ. Phần vai và tay áo cánh tiên được viền nhấn bèo chun. Chất liệu lụa phù hợp cho thời tiết ngày hè\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Cánh tiên\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: trơn\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(26, 'Áo Tencel dập nổi nhấn bèo', 600000, 400000, 'a8.jpg', 1, '2024-05-19', 6, 10, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế áo suông, không tay. Cổ V cách điệu cùng dây buộc phần cổ. Phần vai và tay áo cánh tiên được viền nhấn bèo chun. Chất liệu lụa phù hợp cho thời tiết ngày hè\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Cánh tiên\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: trơn\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(27, 'Set đầm họa tiết Viscose', 850000, 600000, 'a9.jpg', 1, '2024-05-19', 7, 100, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế được dệt may từ 2 dòng chất liệu Viscose, Poly cao cấp. Sử dụng kỹ thuật dệt burn out để tạo nên nền họa tiết vẽ tay độc quyền. Sản phẩm có độ mịn màng cao, khi mặc vô cùng  thoải mái và không hề cảm nhận sự bí bách. Lựa chọn dễ chịu trong thời tiết Xuân – Hè\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: xuông\r\n<br> - Họa tiết: trơn\r\n<br> - Chất liệu: Lụa,Voan\r\n<br>', 1, 0),
(28, 'Đầm hoa xếp ly', 800000, 600000, 'a10.jpg', 1, '2024-05-19', 7, 0, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế đầm nhẹ nhàng  và tinh tế này sẽ là sự lựa chọn hoàn hảo cho buổi gặp mặt đầu xuân của nàng. Họa tiết trên đầm được lên màu sáng và rõ nét trên chất liệu cao cấp\r\n<br> - Cổ áo: Cổ khác\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Đầm xòe\r\n<br> - Họa tiết: trơn\r\n<br> - Chất liệu: Voan\r\n<br>', 1, 0),
(29, 'Đầm hoa xếp ly', 950000, 650000, 'a11.jpg', 1, '2024-05-19', 7, 97, '<b>Giới Thiệu: </b>\r\n<br> - Họa tiết trên đầm được lên màu sáng và rõ nét trên chất liệu cao cấp. Chi tiết tay cánh tiên khéo léo che đi khuyết điểm nơi bắt tay. Dáng đầm thướt tha tôn lên nét đẹp duyên dáng của nàng\r\n<br> - Cổ áo: Cổ khác\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Đầm xòe\r\n<br> - Họa tiết: trơn\r\n<br> - Chất liệu: Voan\r\n<br>', 1, 0),
(30, 'Peony set - Bộ áo khoác kiểu và đầm xòe', 850000, 600000, 'a12.jpg', 1, '2024-05-19', 7, 99, '<b>Giới Thiệu: </b>\r\n<br> - Họa tiết trên đầm được lên màu sáng và rõ nét trên chất liệu cao cấp. Chi tiết tay cánh tiên khéo léo che đi khuyết điểm nơi bắt tay. Dáng đầm thướt tha tôn lên nét đẹp duyên dáng của nàng\r\n<br> - Cổ áo: Cổ khác\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Đầm xòe\r\n<br> - Họa tiết: trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(31, 'Đầm họa tiết thắt nơ', 1150000, 800000, 'a13.jpg', 1, '2024-05-19', 7, 19, '<b>Giới Thiệu: </b>\r\n<br> - Họa tiết trên đầm được lên màu sáng, rõ nét trên nền chất liệu lụa cao cấp. Dáng đầm tôn lên nét đẹp duyên dáng của nàng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay ngắn\r\n<br> -	Kiểu dáng: Đầm xếp\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(32, 'Áo khoác dạ khuy ẩn', 9500000, 700000, 'a14.jpg', 1, '2024-05-19', 8, 15, '<b>Giới Thiệu: </b>\r\n<br> - Họa tiết trên đầm được lên màu sáng, rõ nét trên nền chất liệu lụa cao cấp. Dáng đầm tôn lên nét đẹp duyên dáng của nàng\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay dài\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Dạ\r\n<br>', 1, 0),
(33, 'Áo khoác dạ khuy ẩn', 850000, 600000, 'a15.jpg', 1, '2024-05-19', 8, 14, '<b>Giới Thiệu: </b>\r\n<br> - Hàng cúc dọc trải dài mặt trước đem lại sự cách điệu, thu hút. Chất liệu dạ cao cấp dày dặn, mềm mại và có khả năng giữ nhiệt tốt\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay dài\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Dạ\r\n<br>', 1, 0),
(34, 'Áo khoác dạ khuy ẩn', 950000, 600000, 'a15.jpg', 1, '2024-05-19', 8, 25, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế cổ tròn, dài tay, dáng suông phù hợp với móc vóc dáng giúp che đi khuyết điểm cơ thể 1 cách tuyệt đối\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay dài\r\n<br> -	Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Dạ\r\n<br>', 1, 0),
(35, 'Áo khoác dạ khuy ẩn', 750000, 600000, 'a16.jpg', 1, '2024-05-19', 8, 30, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế cổ tròn, dài tay, dáng suông phù hợp với móc vóc dáng giúp che đi khuyết điểm cơ thể 1 cách tuyệt đối\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay dài\r\n<br> -	Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Dạ\r\n<br>', 1, 0),
(36, 'Áo khoác dạ khuy ẩn', 850000, 600000, 'a17.jpg', 1, '2024-05-19', 8, 50, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế cổ tròn, dài tay, dáng suông phù hợp với móc vóc dáng giúp che đi khuyết điểm cơ thể 1 cách tuyệt đối\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay dài\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Dạ\r\n<br>', 1, 0),
(37, 'Áo khoác dạ cổ vạt', 650000, 600000, 'a18.jpg', 1, '2024-05-19', 8, 100, '<b>Giới Thiệu: </b>\r\n<br> - Chi tiết 2 túi tiện lợi mặt trước kèm đai eo phần ống tay giúp chiếc áo khoác thêm phần thu hút, tinh tế\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay dài\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Dạ\r\n<br>', 1, 0),
(38, 'Áo khoác dạ khuy ẩn', 850000, 700000, 'a19.jpg', 1, '2024-05-19', 8, 100, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế cổ tròn, dài tay, dáng suông phù hợp với móc vóc dáng giúp che đi khuyết điểm cơ thể 1 cách tuyệt đối\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay dài\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Dạ\r\n<br>', 1, 0),
(39, 'Áo khoác dạ cổ vạt', 850000, 600000, 'a20.jpg', 1, '2024-05-19', 8, 100, '<b>Giới Thiệu: </b>\r\n<br> - Chi tiết 2 túi tiện lợi mặt trước kèm đai eo phần ống tay giúp chiếc áo khoác thêm phần thu hút, tinh tế\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay dài\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Dạ\r\n<br>', 1, 0),
(40, 'Ombre Set - Áo vest dáng ngắn và quần short', 1150000, 800000, 'a21.jpg', 1, '2024-05-19', 8, 98, '<b>Giới Thiệu: </b>\r\n<br> - Áo khoác dáng vest, tay ngắn. Phía trước có 2 khuy cài kim loại và túi hộp. Chất liệu voan mềm có độ xuyên thấu nhẹ. Phối màu Ombré độc quyền từ IVY moda\r\n<br> - Cổ áo: Cổ hai ve\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Họa tiết khác\r\n<br> - Chất liệu: Voan\r\n<br>', 1, 0),
(41, 'Set bộ áo kiểu và chân zuýp a', 850000, 600000, 'a22.jpg', 1, '2024-05-19', 8, 100, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế set bộ gồm áo blazer croptop trẻ trung và chân zuýp A ngắn hiện đại đã đáp ứng đủ tình thần tươi mới, năng động nhưng vẫn thật thanh lịch và tinh tế\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(42, 'Set bộ áo kiểu và chân zuýp a', 900000, 600000, 'a23.jpg', 1, '2024-05-19', 8, 100, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế set bộ gồm áo blazer croptop trẻ trung và chân zuýp A ngắn hiện đại đã đáp ứng đủ tình thần tươi mới, năng động nhưng vẫn thật thanh lịch và tinh tế\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(43, 'Áo gile dạ tweed ', 850000, 600000, 'a24.jpg', 1, '2024-05-19', 8, 100, '<b>Giới Thiệu: </b>\r\n<br> - Áo gile croptop là một phiên bản ngắn gọn của áo gile, thường để mix tạo điểm nhấn với áo, chân váy hay nhiều thiết kế khác\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Sát nách\r\n<br> - Kiểu dáng: Ôm\r\n<br> - Họa tiết: Trơn \r\n<br> - Chất liệu: Tweed\r\n<br>', 1, 0),
(44, 'Jumpsuit hai dây phối bèo', 850000, 600000, 'a25.jpg', 1, '2024-05-19', 9, 50, '<b>Giới Thiệu: </b>\r\n<br> - Được chế tác từ chất liệu vải thô tinh tế, sản phẩm đem lại cảm giác thoải mái và thoáng mát mỗi khi diện\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: Không tay\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ,Trơn\r\n<br> - Chất liệu: Thô\r\n<br>', 1, 0),
(45, 'Set 2 dây kiểu phối viền vạt', 850000, 600000, 'a26.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Set đồ áo 2 dây cùng quần suông dài với hoạ tiết kẻ ngang là một sản phẩm thời trang nổi bật trong những ngày hè\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: 2dây\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ,Trơn\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(46, 'Áo thun thêu hoa và chân váy', 850000, 600000, 'a27.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Ensoleille Set, thiết kế set bộ với áo thun mix cùng chân váy voan hoa tiết, đơn giản nhưng da dụng, thích hợp cả đi làm hay đi chơi\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ,Trơn \r\n<br> - Chất liệu: Thun\r\n<br>', 1, 0),
(47, 'Áo thun thêu hoa và chân váy', 850000, 600000, 'a28.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Áo thun cổ tròn, dáng suông và tay lỡ. Thân trước của áo tạo điểm nhấn qua các chi tiết thêu chữ và hoa nổi bật\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ,Trơn\r\n<br> - Chất liệu: Thun\r\n<br>', 1, 0),
(48, 'Áo thun thêu hoa và chân váy', 850000, 600000, 'a29.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Áo thun cổ tròn, dáng suông và tay lỡ. Thân trước của áo tạo điểm nhấn qua các chi tiết thêu chữ và hoa nổi bật\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ,Trơn\r\n<br> - Chất liệu: Thun\r\n<br>', 1, 0),
(49, 'Jumpsuit hai dây phối bèo', 850000, 600000, 'a30.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Được chế tác từ chất liệu vải thô tinh tế, sản phẩm đem lại cảm giác thoải mái và thoáng mát mỗi khi diện\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: Không tay\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ,Trơn\r\n<br> - Chất liệu: Thô\r\n<br>', 1, 0),
(50, 'Set 2 dây kiểu phối viền vạt', 850000, 600000, 'a31.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Set đồ áo 2 dây cùng quần suông dài với hoạ tiết kẻ ngang là một sản phẩm thời trang nổi bật trong những ngày hè\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: 2dây\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ,Trơn\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(51, 'Set 2 dây kiểu phối viền vạt', 850000, 600000, 'a32.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Quần suông dài kết hợp với áo, tạo nên một bộ đồ hoàn hảo. Quần suông với form dáng rộng rãi và thoải mái giúp người mặc dễ dàng di chuyển\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: 2dây\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ,Trơn\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(52, 'Set áo croptop trể vai và chân váy', 850000, 600000, 'a33.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Áo croptop 1 lớp, dây trễ vai, ngực phối nắp túi giả, phần dưới bo chun co giãn (áo không có khóa kéo)\r\n<br> - Cổ áo: Cổ khác\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Bo gấu\r\n<br> - Họa tiết:Trơn\r\n<br> - Chất liệu: Thô\r\n<br>', 1, 0),
(53, 'Set áo croptop trể vai và chân váy', 850000, 600000, 'a34.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Áo croptop 1 lớp, dây trễ vai, ngực phối nắp túi giả, phần dưới bo chun co giãn (áo không có khóa kéo)\r\n<br> - Cổ áo: Cổ khác\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Bo gấu\r\n<br> - Họa tiết:Trơn\r\n<br> - Chất liệu: Thô\r\n<br>', 1, 0),
(54, 'Set áo croptop và chân váy bí ngô', 850000, 600000, 'a35.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Áo crop top may 2 lớp kín đáo, phần ngực may nhún vải kiểu, cổ vuông có phối 2 dây. Tay lỡ phồng\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Ôm\r\n<br> - Họa tiết:Trơn\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(55, 'Set áo croptop và chân váy bí ngô', 850000, 600000, 'a36.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Áo crop top may 2 lớp kín đáo, phần ngực may nhún vải kiểu, cổ vuông có phối 2 dây. Tay lỡ phồng\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Ôm\r\n<br> -  Họa tiết:Trơn\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(56, 'Áo hai dây phối bèo và quần short', 850000, 600000, 'a37.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế bộ đồ mang đến sự nữ tính, nhẹ nhàng, dễ thương và lôi cuốn. IVY moda đã chọn Nora Set với sự kết hợp từ áo hai dây bên cạnh quần short để khởi động mùa hè này\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: 2dây\r\n<br> - Kiểu dáng: Ôm\r\n<br> - Họa tiết:Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(57, 'Áo kiểu cùng chân váy MIDI', 850000, 600000, 'a38.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Set áo Twill và chân váy Midi là bản phối hướng đến sự trẻ trung, hiện đại nhưng vẫn thật thời thượng và yêu kiều của quý cô thành thị\r\n<br> - Cổ áo: Cổ vuông\r\n<br> - Tay áo: 2dây\r\n<br> - Kiểu dáng: Ôm\r\n<br> - Họa tiết: Kẻ\r\n<br> - Chất liệu: Tweed\r\n<br>', 1, 0),
(58, 'Set bộ họa tiết chấm bi', 850000, 600000, 'a39.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Thêm điểm chạm hiện đại, trẻ trung, năng động trong thiết kế Set bộ dành tặng nàng. Bản phối được kết  hợp từ áo croptop bên cạnh dáng chân váy dài, qua gối cực kì tôn dáng\r\n<br> - Cổ áo: Cổ thuyền\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Bo gấu\r\n<br> - Họa tiết: Chấm bi\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(59, 'Set bộ áo kiểu và chân zuýp a', 850000, 600000, 'a40.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế set bộ gồm áo blazer croptop trẻ trung và chân zuýp A ngắn hiện đại đã đáp ứng đủ tình thần tươi mới, năng động nhưng vẫn thật thanh lịch và tinh tế\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(60, 'Set Ren Fuchsia - Áo kiểu cùng chân váy', 850000, 600000, 'a41.jpg', 1, '2024-05-19', 9, 200, '<b>Giới Thiệu: </b>\r\n<br> - Nàng nổi bật xuống phố với Set ren Fuchsia xinh đẹp và sành điệu. Thiết kế mang điểm chung phối ren độc đáo cùng sự kết hợp giữa 2 item áo sơ mi croptop cùng chân váy A hiện đại\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ\r\n<br> - Chất liệu: Ren\r\n<br>', 1, 0),
(61, 'Set Ren Fuchsia - Áo kiểu cùng chân váy', 850000, 600000, 'a42.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Áo cổ đức, tay ngắn, tạo điểm nhấn đường viền trơn kèm khuy đính kim loại sang trọng. Chân váy A ren đồng bộ vừa mang đến sự thanh lịch, vừa giúp cô nàng tôn lên diện mạo trẻ trung và thời thượng\r\n<br> - Cổ áo: Cổ tròn\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Kẻ\r\n<br> - Chất liệu: Ren\r\n<br>', 1, 0),
(62, 'Set Ren Fuchsia - Áo kiểu cùng chân váy', 850000, 600000, 'a43.jpg', 1, '2024-05-19', 9, 100, '<b>Giới Thiệu: </b>\r\n<br> - Set bộ thời trang IVY You cá tính, hiện đại gồm: Áo sơ mi cổ đức cách điệu cùng chân váy chữ A bắt mắt\r\n<br> - Cổ áo: Cổ đức\r\n<br> - Tay áo: Tay ngắn\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Thô\r\n<br>', 1, 0),
(63, 'Set bộ hoa tiết chấm bi', 850000, 600000, 'a44.jpg', 1, '2024-05-19', 9, 99, '<b>Giới Thiệu: </b>\r\n<br> - Thêm điểm chạm hiện đại, trẻ trung, năng động trong thiết kế Set bộ dành tặng nàng. Bản phối được kết  hợp từ áo croptop bên cạnh dáng chân váy dài, qua gối cực kì tôn dáng\r\n<br> - Cổ áo: Cổ thuyền\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Chấm bi\r\n<br> - Chất liệu: Lụa\r\n<br>', 1, 0),
(64, 'Đầm kim sa diên vĩ', 850000, 600000, 'a45.jpg', 1, '2024-05-19', 10, 500, '<b>Giới Thiệu: </b>\r\n<br> - Nằm trong BST ARTISANAL DELICATE nơi những kiệt tác được tạo nên bởi bàn tay nghệ nhân, Irises Dress mang trọn nét ngọc ngà trong gam màu trắng yêu kiều, giúp nàng tỏa sáng như viên ngọc quý\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(65, 'Đầm dạ hội cánh bướm', 850000, 600000, 'a46.jpg', 1, '2024-05-19', 10, 500, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế sử dụng chất liệu Tapta xước, với độ bóng nhẹ cùng sự đảm bảo giữ form dáng tuyệt đối. Nàng chỉ cần thêm các phụ kiện đi kèm mang tông màu sáng là sẽ hoàn thiện ngay một Outfit giúp mình nổ bật trong buổi tiệc tới đây\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(66, 'Đầm dạ hội tay cánh tiên', 850000, 600000, 'a47.jpg', 1, '2024-05-19', 10, 500, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế sử dụng chất liệu Tapta xước, với độ bóng nhẹ cùng sự đảm bảo giữ form dáng tuyệt đối. Nàng chỉ cần thêm các phụ kiện đi kèm mang tông màu sáng là sẽ hoàn thiện ngay một Outfit giúp mình nổ bật trong buổi tiệc tới đây\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(67, 'Đầm dạ hội tay cánh tiên', 850000, 600000, 'a48.jpg', 1, '2024-05-19', 10, 500, '<b>Giới Thiệu: </b>\r\n<br> - Thiết kế sử dụng chất liệu Tapta xước, với độ bóng nhẹ cùng sự đảm bảo giữ form dáng tuyệt đối. Nàng chỉ cần thêm các phụ kiện đi kèm mang tông màu sáng là sẽ hoàn thiện ngay một Outfit giúp mình nổ bật trong buổi tiệc tới đây\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(68, 'Đầm dạ hội khắc hoa', 850000, 600000, 'a49.jpg', 1, '2024-05-19', 10, 500, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(69, 'Đầm dạ hội đuôi cá', 850000, 600000, 'a50.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(70, 'Đầm dạ hội đính cườm', 850000, 600000, 'a51.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(71, 'Đầm dạ hội khắc hoa', 850000, 600000, 'a52.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(72, 'Đầm dạ hội phối ren', 850000, 600000, 'a53.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(73, 'Đầm dạ hội phối ren', 850000, 600000, 'a54.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(74, 'Đầm dạ hội đính cườm', 850000, 600000, 'a55.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(75, 'Đầm dạ hội thêu hoa', 850000, 600000, 'a56.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(76, 'Đầm Senora cổ yếm', 850000, 600000, 'a57.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(77, 'Đầm Senora cổ yếm', 850000, 600000, 'a58.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm lựa chọn dáng A xòe nhẹ, thích hợp để nàng diện trọng những dịp quan trọng khi cần sự sang trọng và thời thượng\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(78, 'Đầm ren Senora', 850000, 600000, 'a59.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(79, 'Đầm ren Senora', 850000, 600000, 'a60.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(80, 'Đầm ren Senora', 850000, 600000, 'a61.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(81, 'Đầm tiệc Tuysi', 850000, 600000, 'a62.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(82, 'Đầm dạ hội', 850000, 600000, 'a63.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(83, 'Đầm dạ hội', 850000, 600000, 'a64.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(84, 'Đầm dạ hội', 850000, 600000, 'a65.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(85, 'Đầm dạ hội tay phồng', 850000, 600000, 'a66.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(86, 'Đầm dạ hội tay phồng', 850000, 600000, 'a67.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(87, 'Đầm dạ hội vai lưới ren', 850000, 600000, 'a68.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(88, 'Đầm Tapta tay Cape', 850000, 600000, 'a69.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(89, 'Đầm dạ hội xếp hoa', 850000, 600000, 'a70.jpg', 1, '2024-05-19', 10, 100, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(90, 'Đầm dạ hội xếp hoa', 850000, 600000, 'a71.jpg', 1, '2024-05-19', 10, 99, '<b>Giới Thiệu: </b>\r\n<br> - Đầm dáng A ôm trọn cơ thể, tạo nên vẻ đẹp mềm mại, quyến rũ. Thiết kế hở vai trẻ trung bên cạnh tạo kiểu bồng ngang ngực đã khéo léo che đi phần bắp tay và giúp tổng thể đầm thêm phần thanh thoát\r\n<br> - Cổ áo: Cổ chữ V\r\n<br> - Tay áo: Tay lỡ\r\n<br> - Kiểu dáng: Xuông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Organza\r\n<br>', 1, 0),
(91, 'Quần short phối ly nổi', 950000, 70000, 'a72.jpg', 1, '2024-05-23', 11, 100, '<b>Giới Thiệu: </b>\r\n<br> - Quần vải Tuysi mềm mại, dễ mặc, độ thấm hút tốt. Các sợi vải rất nhẹ và mềm mịn mang lại cảm thoải mái tuyệt đối khi diện\r\n<br> - Độ dài: Ngang đùi\r\n<br> - Kiểu dáng: Ống suông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(92, 'Quần short Tuysi gập gấu', 950000, 70000, 'a73.jpg', 1, '2024-05-23', 11, 121, '<b>Giới Thiệu: </b>\r\n<br> - Quần thiết kế trên nền vải Tuysi mềm mại, dễ mặc, độ thấm hút tốt. Các sợi vải rất nhẹ và mềm mịn mang lại cảm thoải mái tuyệt đối khi diện\r\n<br> - Độ dài: Ngang đùi\r\n<br> - Kiểu dáng: Ống suông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(93, 'Quần short basic ống suông', 950000, 70000, 'a74.jpg', 1, '2024-05-23', 11, 123, '<b>Giới Thiệu: </b>\r\n<br> - Quần short cạp cao, dáng suông, ống đứng, thiết kế có 2 túi sườn\r\n<br> - Độ dài: Ngang đùi\r\n<br> - Kiểu dáng: Ống suông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(94, 'Quần short cạp cao Rayon', 950000, 70000, 'a75.jpg', 1, '2024-05-23', 11, 123, '<b>Giới Thiệu: </b>\r\n<br> - Quần short trẻ trung, tôn dáng người mặc. Mix cùng MS 61M8698 để tạo set bộ thời\r\n<br> - Độ dài: Ngang đùi\r\n<br> - Kiểu dáng: Ống suông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(95, 'Quần short cạp cao Rayon', 950000, 70000, 'a76.jpg', 1, '2024-05-23', 11, 123, '<b>Giới Thiệu: </b>\r\n<br> - Quần short trẻ trung, tôn dáng người mặc. Mix cùng MS 61M8698 để tạo set bộ thời\r\n<br> - Độ dài: Ngang đùi\r\n<br> - Kiểu dáng: Ống suông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(96, 'Quần short cạp cao Rayon', 950000, 70000, 'a77.jpg', 1, '2024-05-23', 11, 123, '<b>Giới Thiệu: </b>\r\n<br> - Quần short trẻ trung, tôn dáng người mặc. Mix cùng MS 61M8698 để tạo set bộ thời\r\n<br> - Độ dài: Ngang đùi\r\n<br> - Kiểu dáng: Ống suông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(97, 'Quần short Dahlia set', 950000, 70000, 'a78.jpg', 1, '2024-05-23', 11, 123, '<b>Giới Thiệu: </b>\r\n<br> - Quần short cạp cao, độ dài ngang đùi thoải mái và năng động. Có thể mix cùng áo sơ mi, áo phông kèm vest hay blazer khoác ngoài\r\n<br> - Độ dài: Ngang đùi\r\n<br> - Kiểu dáng: Ống suông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(98, 'Quần short basic ống suông', 950000, 70000, 'a79.jpg', 1, '2024-05-23', 11, 122, '<b>Giới Thiệu: </b>\r\n<br> - Quần short cạp cao, dáng suông, ống đứng, thiết kế có 2 túi sườn\r\n<br> - Độ dài: Ngang đùi\r\n<br> - Kiểu dáng: Ống suông\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(99, 'Túi đeo vai dáng Hobo', 950000, 70000, 'a80.jpg', 1, '2024-05-23', 12, 99, '<b>Giới Thiệu: </b>\r\n<br> - Túi da PU trơn, đứng phom. Form túi rộng tiện lợi giúp nàng đựng được nhiều đồ cơ bản, phù hợp sử dụng đi chơi hay đi làm\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(100, 'Túi đeo vai dáng Hobo', 950000, 70000, 'a81.jpg', 1, '2024-05-23', 12, 93, '<b>Giới Thiệu: </b>\r\n<br> - Túi da PU trơn, đứng phom. Form túi rộng tiện lợi giúp nàng đựng được nhiều đồ cơ bản, phù hợp sử dụng đi chơi hay đi làm\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(101, 'Túi đeo vai dáng Hobo', 950000, 70000, 'a82.jpg', 1, '2024-05-23', 12, 99, '<b>Giới Thiệu: </b>\r\n<br> - Túi da PU trơn, đứng phom. Form túi rộng tiện lợi giúp nàng đựng được nhiều đồ cơ bản, phù hợp sử dụng đi chơi hay đi làm\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(102, 'Túi xách Hobo', 950000, 70000, 'a83.jpg', 1, '2024-05-23', 12, 100, '<b>Giới Thiệu: </b>\r\n<br> - Túi da PU trơn, đứng phom. Form túi rộng tiện lợi giúp nàng đựng được nhiều đồ cơ bản, phù hợp sử dụng đi chơi hay đi làm\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(103, 'Túi xách chần bông', 950000, 70000, 'a84.jpg', 1, '2024-05-23', 12, 100, '<b>Giới Thiệu: </b>\r\n<br> - Túi xách size medium, quai xách cố định, túi kèm quai da đeo chéo tháo rời. Bên trong 1 ngắn lớn, ngăn ẩn có khóa kéo. Nắp mặt trước có nút cài kim loại, mặt sau in logo IVY moda\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(104, 'Túi đeo vai Baguette', 950000, 70000, 'a85.jpg', 1, '2024-05-23', 12, 98, '<b>Giới Thiệu: </b>\r\n<br> - Túi xách size medium, quai xách cố định, túi kèm quai da đeo chéo tháo rời. Bên trong 1 ngắn lớn, ngăn ẩn có khóa kéo. Nắp mặt trước có nút cài kim loại, mặt sau in logo IVY moda\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(105, 'Túi đeo vai Baguette', 950000, 70000, 'a86.jpg', 1, '2024-05-23', 12, 100, '<b>Giới Thiệu: </b>\r\n<br> - Túi xách size medium, quai xách cố định, túi kèm quai da đeo chéo tháo rời. Bên trong 1 ngắn lớn, ngăn ẩn có khóa kéo. Nắp mặt trước có nút cài kim loại, mặt sau in logo IVY moda\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(106, 'Túi đeo vai Baguette', 950000, 70000, 'a87.jpg', 1, '2024-05-23', 12, 100, '<b>Giới Thiệu: </b>\r\n<br> - Túi xách size medium, quai xách cố định, túi kèm quai da đeo chéo tháo rời. Bên trong 1 ngắn lớn, ngăn ẩn có khóa kéo. Nắp mặt trước có nút cài kim loại, mặt sau in logo IVY moda\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(107, 'Túi đeo chéo mini', 950000, 70000, 'a88.jpg', 1, '2024-05-23', 12, 100, '<b>Giới Thiệu: </b>\r\n<br> - Túi xách size medium, quai xách cố định, túi kèm quai da đeo chéo tháo rời. Bên trong 1 ngắn lớn, ngăn ẩn có khóa kéo. Nắp mặt trước có nút cài kim loại, mặt sau in logo IVY moda\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(108, 'Túi xách chần bông', 950000, 70000, 'a89.jpg', 1, '2024-05-23', 12, 100, '<b>Giới Thiệu: </b>\r\n<br> - Túi xách size medium, quai xách cố định, túi kèm quai da đeo chéo tháo rời. Bên trong 1 ngắn lớn, ngăn ẩn có khóa kéo. Nắp mặt trước có nút cài kim loại, mặt sau in logo IVY moda\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(109, 'Túi hộp mini phối xích', 950000, 70000, 'a90.jpg', 1, '2024-05-23', 12, 90, '<b>Giới Thiệu: </b>\r\n<br> - Túi hộp size mini có dây da đeo chéo đi kèm. Trang trí họa tiết da động vật cùng xích kim loại cá tính. Bên trong lót vải, cài khóa nam châm\r\n<br> - Dòng sản phẩm: Accessories\r\n<br> - Kiểu dáng: Medium\r\n<br>', 1, 0),
(110, 'Chân váy bút chì xẻ lệch', 950000, 70000, 'a91.jpg', 1, '2024-05-23', 13, 100, '<b>Giới Thiệu: </b>\r\n<br> - Thân trước xẻ lệch 1 bên, độ dài qua đầu gối và cài bằng khóa kéo. Chân váy kiểu dáng bút chì cơ bản dễ dàng mix&match với nhiều kiểu áo khác nhau\r\n<br> - Độ dài: Qua gối\r\n<br> - Kiểu dáng: Bút chì\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0),
(111, 'Chân váy bút chì phối túi', 950000, 70000, 'a92.jpg', 1, '2024-05-23', 13, 100, '<b>Giới Thiệu: </b>\r\n<br> - Chân váy mang gam màu trung tính, dễ dàng phối hợp với nhiều loại trang phục khác nhau\r\n<br> - Độ dài: Qua gối\r\n<br> - Kiểu dáng: Bút chì\r\n<br> - Họa tiết: Trơn\r\n<br> - Chất liệu: Tuysi\r\n<br>', 1, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'Admin'),
(2, 'Normal'),
(3, 'Staff');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `statistical`
--

CREATE TABLE `statistical` (
  `id` int(11) NOT NULL,
  `order_date` varchar(100) NOT NULL,
  `sales` varchar(200) NOT NULL,
  `profit` varchar(200) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `statistical`
--

INSERT INTO `statistical` (`id`, `order_date`, `sales`, `profit`, `quantity`, `total_order`) VALUES
(84, '2024-05-27', '1000000', '1000000', 1, 1),
(85, '2024-06-08', '1200000', '1200000', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `address` varchar(500) NOT NULL,
  `isConfirmed` tinyint(4) NOT NULL DEFAULT 0,
  `captcha` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `email`, `fullname`, `dob`, `password`, `role_id`, `status`, `address`, `isConfirmed`, `captcha`) VALUES
(1, 'admin@gmail.com', 'Admin', '0000-00-00', '0cc175b9c0f1b6a831c399e269772661', 1, 1, '', 1, ''),
(2, 'dokima@gmail.com', 'Đỗ Kim A', '2003-07-19', '0cc175b9c0f1b6a831c399e269772661', 2, 1, 'Hà Nội', 1, '56666'),
(3, 'dokimb@gmail.com', 'Đỗ Kim B', '2003-07-20', '0cc175b9c0f1b6a831c399e269772661', 2, 1, 'Hồ CHí Minh', 1, '87909'),
(4, 'dokimc@gmail.com', 'Đỗ Kim C', '2003-07-21', '0cc175b9c0f1b6a831c399e269772661', 3, 1, 'Đà Nẵng', 1, '59682');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`userId`),
  ADD KEY `product_id` (`productId`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `chatbot`
--
ALTER TABLE `chatbot`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`userId`);

--
-- Chỉ mục cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`orderId`),
  ADD KEY `product_id` (`productId`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cate_id` (`cateId`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `statistical`
--
ALTER TABLE `statistical`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `chatbot`
--
ALTER TABLE `chatbot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT cho bảng `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `statistical`
--
ALTER TABLE `statistical`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`cateId`) REFERENCES `categories` (`id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
