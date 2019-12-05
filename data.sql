-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 05, 2019 lúc 04:34 PM
-- Phiên bản máy phục vụ: 10.4.6-MariaDB
-- Phiên bản PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `data`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `exam`
--

CREATE TABLE `exam` (
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `exam_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exam_describe` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exam_kind` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_time` int(11) DEFAULT NULL,
  `exam_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `exam`
--

INSERT INTO `exam` (`exam_id`, `exam_name`, `exam_describe`, `exam_kind`, `id`, `created_at`, `updated_at`, `exam_time`, `exam_password`) VALUES
(10, 'Trắc nghiệm Lịch Sử 12', 'Phần 1: Lịch sử thế giới hiện đại (1945-2000)\r\nChương 1: Bối cảnh quốc tế từ sau chiến tranh thế giới thứ hai', 'History', 2, '2019-12-05 07:11:44', NULL, 10, 'd41d8cd98f00b204e9800998ecf8427e');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `quest`
--

CREATE TABLE `quest` (
  `quest_id` bigint(20) UNSIGNED NOT NULL,
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rightAnswer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `quest`
--

INSERT INTO `quest` (`quest_id`, `exam_id`, `question`, `answer`, `rightAnswer`) VALUES
(17, 10, 'Những nước nào tham gia Hội nghị Ianta ?', 'Anh - Pháp - Mĩ.***Anh - Mĩ - Liên Xô.***Anh - Pháp - Đức.***Mĩ - Liên Xô - Trung Quốc.', 'B'),
(18, 10, 'Một trong những nội dung quan trọng của Hội nghị Ianta là:', 'Đàm phán, kí kết các hiệp ước với các nước phát xít bại trận.***Các nước thắng trận thoả thuận viêc phân chia Đức thành haỉ nước Đông Đức và Tây Đức.***Ba nước phe Đồng minh bàn bạc, thoả thuận khu vực đóng quân tại các nước nhằm giải giáp quân đội phát xít; phân chia phạm vi ảnh hưởng ở châu Âu và châu Á.***Các nước phát xít Đức, Italia kí văn kiện đầu hàng phe Đồng minh vô điều kiện.', 'C'),
(19, 10, 'Hội nghị Ianta diễn ra từ:', 'Ngày 4 đến 11/2/1945.***Ngày 2 đến 14/2/1945.***Ngày 2 đến 12/4/1945.***Ngày 12 đến 22/4/ 1945.', 'A'),
(20, 10, 'Hội nghị Ianta đã họp ở đâu?', 'Nước Anh***Nước Pháp***Thụy Sĩ***Liên Xô', 'D');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `scores`
--

CREATE TABLE `scores` (
  `scores_id` bigint(20) UNSIGNED NOT NULL,
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `scores` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `scores`
--

INSERT INTO `scores` (`scores_id`, `exam_id`, `id`, `scores`, `created_at`, `updated_at`) VALUES
(6, 10, 2, 10, '2019-12-05 07:36:10', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'asimo', 'asimo@gmail.com', NULL, '$2y$10$pPL/kQ5dxZxOpSIARwM4reUiDMcxIwG17u8pJCFdQy8BikDQd6dV6', 'ZT9Opp7kOhydk0YBuhbzykOOjQ7eSkvLgZolFX6xzGLeXIfMmfQyzoZg52As', '2019-11-12 19:42:49', '2019-11-12 19:42:49'),
(3, 'user', 'user@gmail.com', NULL, '$2y$10$gLmxHi7qUXrvrlwoglWmE.Bqv9QnvwmVY3fV9jIMwube3oahV6Juy', NULL, '2019-11-14 09:00:31', '2019-11-14 09:00:31'),
(4, 'test', 'test@gmail.com', NULL, '$2y$10$DFUmUV4p2nHgmewMqyQ2iuPSVIuktA9sBXuWMetuboCZNYQPp.Jvq', NULL, '2019-11-21 06:01:20', '2019-11-21 06:01:20');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `exam`
--
ALTER TABLE `exam`
  ADD PRIMARY KEY (`exam_id`);

--
-- Chỉ mục cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Chỉ mục cho bảng `quest`
--
ALTER TABLE `quest`
  ADD PRIMARY KEY (`quest_id`);

--
-- Chỉ mục cho bảng `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`scores_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `exam`
--
ALTER TABLE `exam`
  MODIFY `exam_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `quest`
--
ALTER TABLE `quest`
  MODIFY `quest_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `scores`
--
ALTER TABLE `scores`
  MODIFY `scores_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
