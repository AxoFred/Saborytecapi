-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 18-05-2026 a las 02:34:00
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `saborytecapi`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `ID_calificacion` int NOT NULL,
  `ID_pedido` int NOT NULL,
  `ID_tienda` int NOT NULL,
  `ID_usuario` int NOT NULL,
  `puntuacion` int DEFAULT NULL,
  `comentario` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Volcado de datos para la tabla `calificaciones`
--

INSERT INTO `calificaciones` (`ID_calificacion`, `ID_pedido`, `ID_tienda`, `ID_usuario`, `puntuacion`, `comentario`, `created_at`) VALUES
(1, 6, 1, 15, 5, 'xd', '2026-05-09 18:33:07'),
(4, 2, 1, 15, 5, 'GOOD', '2026-05-09 18:37:04'),
(5, 7, 1, 15, 4, 'Me gusto demasiado', '2026-05-13 06:31:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `ID_carrito` int NOT NULL,
  `ID_usuario` int NOT NULL,
  `ID_producto` int NOT NULL,
  `ID_tienda` int NOT NULL,
  `cantidad` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`ID_carrito`, `ID_usuario`, `ID_producto`, `ID_tienda`, `cantidad`, `created_at`, `updated_at`) VALUES
(3, 3, 7, 1, 1, '2026-05-04 11:57:30', '2026-05-06 09:13:44'),
(5, 3, 2, 1, 2, '2026-05-04 11:57:35', '2026-05-08 12:09:47'),
(10, 3, 4, 1, 1, '2026-05-04 22:24:19', '2026-05-04 22:24:19'),
(11, 3, 3, 1, 1, '2026-05-04 22:24:28', '2026-05-04 22:24:28'),
(41, 15, 6, 2, 1, '2026-05-13 11:52:15', '2026-05-13 11:52:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `ID_categoria` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`ID_categoria`, `nombre`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 'Bebidas', 'Incluye todo tipo de bebidas, tanto frías como calientes, preparadas o embotelladas.', '2026-05-01 22:58:51', 'activo'),
(2, 'Comidas', 'Platillos en general que pueden incluir comidas completas o preparaciones rápidas.', '2026-05-01 23:05:31', 'activo'),
(3, 'Snacks', 'Productos ligeros y de consumo rápido como botanas y aperitivos.', '2026-05-01 23:07:30', 'activo'),
(4, 'Postres', 'Productos dulces como pasteles, gelatinas, flanes y repostería en general.', '2026-05-01 23:08:17', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedidos`
--

CREATE TABLE `detalle_pedidos` (
  `ID_detalle` int NOT NULL,
  `ID_pedido` int NOT NULL,
  `ID_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_pedidos`
--

INSERT INTO `detalle_pedidos` (`ID_detalle`, `ID_pedido`, `ID_producto`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(1, 2, 1, 1, 35.00, 35.00),
(2, 2, 3, 1, 15.00, 15.00),
(3, 2, 4, 1, 35.00, 35.00),
(4, 2, 5, 1, 19.00, 19.00),
(5, 3, 6, 1, 25.00, 25.00),
(6, 4, 6, 3, 25.00, 75.00),
(7, 5, 2, 1, 25.00, 25.00),
(8, 6, 7, 1, 35.00, 35.00),
(9, 6, 5, 1, 19.00, 19.00),
(10, 7, 2, 1, 25.00, 25.00),
(11, 7, 5, 1, 19.00, 19.00),
(12, 8, 7, 1, 35.00, 35.00),
(13, 8, 2, 1, 25.00, 25.00),
(14, 8, 1, 1, 35.00, 35.00),
(15, 9, 6, 2, 25.00, 50.00),
(16, 10, 2, 2, 25.00, 50.00),
(17, 10, 1, 3, 35.00, 105.00),
(18, 10, 7, 4, 35.00, 140.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `ID_horario` int NOT NULL,
  `ID_tienda` int NOT NULL,
  `dia_semana` enum('lunes','martes','miercoles','jueves','viernes','sabado','domingo') NOT NULL,
  `hora_apertura` time NOT NULL,
  `hora_cierre` time NOT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`ID_horario`, `ID_tienda`, `dia_semana`, `hora_apertura`, `hora_cierre`, `estado`) VALUES
(3, 1, 'lunes', '07:00:00', '18:00:00', 'activo'),
(7, 1, 'martes', '10:00:00', '18:00:00', 'activo'),
(8, 1, 'miercoles', '08:00:00', '18:00:00', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_pedido`
--

CREATE TABLE `mensajes_pedido` (
  `ID_mensaje` bigint UNSIGNED NOT NULL,
  `ID_pedido` int NOT NULL,
  `ID_usuario` int NOT NULL,
  `mensaje` text COLLATE utf8mb4_unicode_ci,
  `archivo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` enum('texto','imagen','sistema') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'texto',
  `es_de_tienda` tinyint(1) NOT NULL DEFAULT '0',
  `leido` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mensajes_pedido`
--

INSERT INTO `mensajes_pedido` (`ID_mensaje`, `ID_pedido`, `ID_usuario`, `mensaje`, `archivo_path`, `tipo`, `es_de_tienda`, `leido`, `created_at`, `updated_at`) VALUES
(22, 2, 15, 'Buenas tardes', NULL, 'texto', 0, 0, '2026-05-08 11:55:32', '2026-05-08 11:55:32'),
(23, 2, 15, 'procedere a pagar', NULL, 'texto', 0, 0, '2026-05-08 11:55:40', '2026-05-08 11:55:40'),
(24, 2, 15, NULL, 'comprobantes/PdbUohRdz1P8KnqSpXrob7jFX2ppsoueTvvd1N3W.png', 'imagen', 0, 0, '2026-05-08 12:01:15', '2026-05-08 12:01:15'),
(25, 2, 2, 'hola si reviso', NULL, 'texto', 1, 0, '2026-05-08 12:01:48', '2026-05-08 12:01:48'),
(26, 2, 15, 'vale', NULL, 'texto', 0, 0, '2026-05-08 12:02:25', '2026-05-08 12:02:25'),
(27, 3, 15, 'hola soy nuevo pagare', NULL, 'texto', 0, 0, '2026-05-08 12:02:48', '2026-05-08 12:02:48'),
(28, 3, 15, NULL, 'comprobantes/XQlfiRjtHrML0z5DOrNZ4lV3n7xMNtALNldEceeA.jpg', 'imagen', 0, 0, '2026-05-08 12:02:55', '2026-05-08 12:02:55'),
(29, 3, 4, 'vale', NULL, 'texto', 1, 0, '2026-05-08 12:04:43', '2026-05-08 12:04:43'),
(30, 2, 2, 'ya esta en un momento confirmo el pago', NULL, 'texto', 1, 0, '2026-05-08 12:06:56', '2026-05-08 12:06:56'),
(31, 2, 2, 'esta listo', NULL, 'texto', 1, 0, '2026-05-08 12:08:43', '2026-05-08 12:08:43'),
(32, 5, 15, 'hola?', NULL, 'texto', 0, 0, '2026-05-09 04:00:44', '2026-05-09 04:00:44'),
(33, 5, 2, 'hola', NULL, 'texto', 1, 0, '2026-05-09 04:01:21', '2026-05-09 04:01:21'),
(34, 5, 15, NULL, 'comprobantes/fT8ZG5ssIoH6nLZuotkji9XfUKVQ3anZKy6Q4oAK.png', 'imagen', 0, 0, '2026-05-09 04:11:01', '2026-05-09 04:11:01'),
(35, 2, 15, 'gracias', NULL, 'texto', 0, 0, '2026-05-09 04:16:13', '2026-05-09 04:16:13'),
(36, 5, 2, 'hola de nuevo', NULL, 'texto', 1, 0, '2026-05-09 04:31:23', '2026-05-09 04:31:23'),
(37, 5, 15, 'hola esta vez si', NULL, 'texto', 0, 0, '2026-05-09 04:31:32', '2026-05-09 04:31:32'),
(38, 5, 2, 'gracias', NULL, 'texto', 1, 0, '2026-05-09 04:31:42', '2026-05-09 04:31:42'),
(39, 5, 15, 'muy bien', NULL, 'texto', 0, 0, '2026-05-09 04:31:51', '2026-05-09 04:31:51'),
(40, 5, 15, NULL, 'comprobantes/SdF1w1bYWPDZ9gFjGGzrm1z0ZmEJVEl9Fz2ZOO3y.jpg', 'imagen', 0, 0, '2026-05-09 04:32:08', '2026-05-09 04:32:08'),
(41, 5, 15, 'ya listo', NULL, 'texto', 0, 0, '2026-05-09 04:39:44', '2026-05-09 04:39:44'),
(42, 5, 15, 'va?', NULL, 'texto', 0, 0, '2026-05-09 04:39:57', '2026-05-09 04:39:57'),
(43, 5, 15, 'aver', NULL, 'texto', 0, 0, '2026-05-09 04:40:12', '2026-05-09 04:40:12'),
(44, 5, 2, 'tardas', NULL, 'texto', 1, 0, '2026-05-09 04:40:26', '2026-05-09 04:40:26'),
(45, 5, 15, 'ya estas', NULL, 'texto', 0, 0, '2026-05-09 04:41:11', '2026-05-09 04:41:11'),
(46, 5, 15, 'minecraft?', NULL, 'texto', 0, 0, '2026-05-09 04:44:20', '2026-05-09 04:44:20'),
(47, 5, 2, 'ora', NULL, 'texto', 1, 0, '2026-05-09 04:44:31', '2026-05-09 04:44:31'),
(48, 5, 15, NULL, 'comprobantes/yuv0fU3px2dHs18z8ICaL3pYGHujs1Rgag1aqlZx.jpg', 'imagen', 0, 0, '2026-05-09 04:44:56', '2026-05-09 04:44:56'),
(49, 5, 15, 'este', 'comprobantes/MpykkgmLgMfxjEB2FcUvYbFXHfPcVywiGhMQX3Uh.jpg', 'imagen', 0, 0, '2026-05-09 04:56:51', '2026-05-09 04:56:51'),
(50, 5, 15, 'gola', NULL, 'texto', 0, 0, '2026-05-09 04:57:39', '2026-05-09 04:57:39'),
(51, 6, 15, 'hola', NULL, 'texto', 0, 0, '2026-05-09 10:34:38', '2026-05-09 10:34:38'),
(52, 6, 15, NULL, 'comprobantes/evn36y1xuMECpcRTwZdAhdijxBOirfeM8oKLUMLy.png', 'imagen', 0, 0, '2026-05-09 10:35:31', '2026-05-09 10:35:31'),
(53, 6, 2, 'checo', NULL, 'texto', 1, 0, '2026-05-09 10:35:44', '2026-05-09 10:35:44'),
(54, 6, 2, 'listo confirmo el pago', NULL, 'texto', 1, 0, '2026-05-09 10:36:02', '2026-05-09 10:36:02'),
(55, 6, 15, 'vale', NULL, 'texto', 0, 0, '2026-05-09 10:36:10', '2026-05-09 10:36:10'),
(56, 6, 2, 'realizare tu pedido', NULL, 'texto', 1, 0, '2026-05-09 10:36:42', '2026-05-09 10:36:42'),
(57, 6, 15, 'va', NULL, 'texto', 0, 0, '2026-05-09 10:36:59', '2026-05-09 10:36:59'),
(58, 6, 2, 'listo ven a recojerlo', NULL, 'texto', 1, 0, '2026-05-09 10:37:18', '2026-05-09 10:37:18'),
(59, 6, 15, 'voy', NULL, 'texto', 0, 0, '2026-05-09 10:37:24', '2026-05-09 10:37:24'),
(60, 6, 2, 'enregado', NULL, 'texto', 1, 0, '2026-05-09 10:37:31', '2026-05-09 10:37:31'),
(61, 6, 15, 'si', NULL, 'texto', 0, 0, '2026-05-09 10:37:40', '2026-05-09 10:37:40'),
(62, 3, 15, 'ok', NULL, 'texto', 0, 0, '2026-05-09 10:48:52', '2026-05-09 10:48:52'),
(63, 3, 4, 'paga', NULL, 'texto', 1, 0, '2026-05-09 10:49:06', '2026-05-09 10:49:06'),
(64, 3, 15, 'pago', NULL, 'texto', 0, 0, '2026-05-09 11:02:42', '2026-05-09 11:02:42'),
(65, 3, 4, 'pero ya', NULL, 'texto', 1, 0, '2026-05-09 11:03:20', '2026-05-09 11:03:20'),
(66, 3, 15, 'listo', NULL, 'texto', 0, 0, '2026-05-09 11:03:26', '2026-05-09 11:03:26'),
(67, 3, 4, 'ok', NULL, 'texto', 1, 0, '2026-05-09 11:03:36', '2026-05-09 11:03:36'),
(68, 3, 15, 'vale', NULL, 'texto', 0, 0, '2026-05-09 11:04:09', '2026-05-09 11:04:09'),
(69, 3, 4, 'entregado', NULL, 'texto', 1, 0, '2026-05-09 11:04:19', '2026-05-09 11:04:19'),
(70, 3, 15, 'si', NULL, 'texto', 0, 0, '2026-05-09 11:04:26', '2026-05-09 11:04:26'),
(71, 7, 15, 'hola', NULL, 'texto', 0, 0, '2026-05-10 00:01:56', '2026-05-10 00:01:56'),
(72, 7, 15, NULL, 'comprobantes/LQJoTBeQ5XyPeJHJsaBFGVV1XJKvinQpgdKKLxo6.jpg', 'imagen', 0, 0, '2026-05-10 00:02:05', '2026-05-10 00:02:05'),
(73, 7, 2, 'hola', NULL, 'texto', 1, 0, '2026-05-10 00:02:52', '2026-05-10 00:02:52'),
(74, 7, 15, 'hola', NULL, 'texto', 0, 0, '2026-05-10 00:09:56', '2026-05-10 00:09:56'),
(75, 7, 2, 'si si me llego tu mensaje alas 12:09', NULL, 'texto', 1, 0, '2026-05-10 00:10:41', '2026-05-10 00:10:41'),
(76, 7, 15, 'ok', NULL, 'texto', 0, 0, '2026-05-10 00:11:07', '2026-05-10 00:11:07'),
(77, 7, 15, NULL, 'comprobantes/BP02LKYVIecpi5y4kKUy4B9QHO4xp3iAuIPCgit4.jpg', 'imagen', 0, 0, '2026-05-10 00:11:19', '2026-05-10 00:11:19'),
(78, 7, 15, 'aver de nuevo', NULL, 'texto', 0, 0, '2026-05-10 00:33:34', '2026-05-10 00:33:34'),
(79, 7, 15, NULL, 'comprobantes/0WGdhToLLughlbQWHeXOHXPn8Yv0Hx7n2VgT1P8q.jpg', 'imagen', 0, 0, '2026-05-10 00:33:42', '2026-05-10 00:33:42'),
(80, 7, 2, 'yes me llego alas 12:33', NULL, 'texto', 1, 0, '2026-05-10 00:34:28', '2026-05-10 00:34:28'),
(81, 7, 15, 'ok', NULL, 'texto', 0, 0, '2026-05-10 00:37:48', '2026-05-10 00:37:48'),
(82, 7, 15, 'ok', NULL, 'texto', 0, 0, '2026-05-10 00:49:58', '2026-05-10 00:49:58'),
(83, 7, 2, 'va', NULL, 'texto', 1, 0, '2026-05-10 01:09:12', '2026-05-10 01:09:12'),
(84, 7, 15, NULL, 'comprobantes/Rxc8VdSzKaGassTGqaTBir14WMxVhuUp537OmAD2.png', 'imagen', 0, 0, '2026-05-12 13:11:27', '2026-05-12 13:11:27'),
(85, 7, 15, 'Llego?', NULL, 'texto', 0, 0, '2026-05-12 13:13:02', '2026-05-12 13:13:02'),
(86, 7, 2, 'si', NULL, 'texto', 1, 0, '2026-05-12 13:13:12', '2026-05-12 13:13:12'),
(87, 7, 15, 'Muy bien', NULL, 'texto', 0, 0, '2026-05-12 13:13:25', '2026-05-12 13:13:25'),
(88, 7, 2, 'asies', NULL, 'texto', 1, 0, '2026-05-12 13:13:38', '2026-05-12 13:13:38'),
(89, 7, 15, 'Ok', NULL, 'texto', 0, 0, '2026-05-12 13:24:25', '2026-05-12 13:24:25'),
(90, 7, 2, 'si aver', NULL, 'texto', 1, 0, '2026-05-12 13:24:39', '2026-05-12 13:24:39'),
(91, 7, 2, 'esta listo', NULL, 'texto', 1, 0, '2026-05-12 13:41:24', '2026-05-12 13:41:24'),
(92, 7, 15, 'Si', NULL, 'texto', 0, 0, '2026-05-12 13:41:34', '2026-05-12 13:41:34'),
(93, 7, 2, 'hola si reviso', NULL, 'texto', 1, 0, '2026-05-12 13:41:47', '2026-05-12 13:41:47'),
(94, 7, 2, 'pero si?', NULL, 'texto', 1, 0, '2026-05-12 13:47:31', '2026-05-12 13:47:31'),
(95, 7, 15, 'Si', NULL, 'texto', 0, 0, '2026-05-12 13:47:38', '2026-05-12 13:47:38'),
(96, 7, 2, 'ya esta en preparacion', NULL, 'texto', 1, 0, '2026-05-12 13:48:26', '2026-05-12 13:48:26'),
(97, 8, 15, 'Hola hice un pedido y enviare mi comprobante', NULL, 'texto', 0, 0, '2026-05-13 11:22:58', '2026-05-13 11:22:58'),
(98, 8, 15, NULL, 'comprobantes/Njtf8hqVjrp3BxUFNVjEKKg5tKHjpvcVRwXNSl4R.png', 'imagen', 0, 0, '2026-05-13 11:26:23', '2026-05-13 11:26:23'),
(99, 8, 2, 'perfecto', NULL, 'texto', 1, 0, '2026-05-13 11:26:43', '2026-05-13 11:26:43'),
(100, 8, 15, 'Vale', NULL, 'texto', 0, 0, '2026-05-13 11:26:53', '2026-05-13 11:26:53'),
(101, 10, 15, 'Hola hice un pedido y realizare mi pago', NULL, 'texto', 0, 0, '2026-05-13 11:53:09', '2026-05-13 11:53:09'),
(102, 10, 15, NULL, 'comprobantes/DDkMbJ5pFZ7rKY8TA5DjKLBVkgN5Mq67EP7HiamD.png', 'imagen', 0, 0, '2026-05-13 11:53:27', '2026-05-13 11:53:27'),
(103, 10, 15, 'Listo revise por favor', NULL, 'texto', 0, 0, '2026-05-13 11:53:36', '2026-05-13 11:53:36'),
(104, 10, 2, 'reviso', NULL, 'texto', 1, 0, '2026-05-13 11:53:54', '2026-05-13 11:53:54'),
(105, 10, 2, 'en un momento', NULL, 'texto', 1, 0, '2026-05-13 11:54:08', '2026-05-13 11:54:08'),
(106, 10, 15, 'Gracias', NULL, 'texto', 0, 0, '2026-05-13 11:54:13', '2026-05-13 11:54:13'),
(107, 10, 2, 'si comfirmado', NULL, 'texto', 1, 0, '2026-05-13 11:54:28', '2026-05-13 11:54:28'),
(108, 7, 15, 'Ya te vi', NULL, 'texto', 0, 0, '2026-05-13 12:27:57', '2026-05-13 12:27:57'),
(109, 10, 15, 'Pero si', NULL, 'texto', 0, 0, '2026-05-13 13:03:35', '2026-05-13 13:03:35'),
(110, 10, 2, 'si', NULL, 'texto', 1, 0, '2026-05-13 13:03:46', '2026-05-13 13:03:46'),
(111, 10, 15, 'Ok', NULL, 'texto', 0, 0, '2026-05-13 13:03:51', '2026-05-13 13:03:51'),
(112, 10, 15, NULL, 'comprobantes/mzIi72igVb2Od9zwK8VEGHbyyf6j0OyDAelWpOle.png', 'imagen', 0, 0, '2026-05-13 13:03:58', '2026-05-13 13:03:58'),
(113, 10, 2, 'ok', NULL, 'texto', 1, 0, '2026-05-13 13:04:09', '2026-05-13 13:04:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2026_05_01_232829_create_sessions_table', 1),
(5, '2026_05_01_235152_create_personal_access_tokens_table', 2),
(6, '2026_05_07_081723_create_mensajes_pedido_table', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `ID_pedido` int NOT NULL,
  `ID_usuario` int NOT NULL,
  `ID_tienda` int NOT NULL,
  `nombre_cliente` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `metodo_pago` enum('efectivo','transferencia') COLLATE utf8mb4_general_ci NOT NULL,
  `notas_pedido` text COLLATE utf8mb4_general_ci,
  `estado` enum('pendiente','validando','preparacion','listo','entregado','finalizado','cancelado') COLLATE utf8mb4_general_ci DEFAULT 'pendiente',
  `motivo_cancelacion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `comprobante` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`ID_pedido`, `ID_usuario`, `ID_tienda`, `nombre_cliente`, `total`, `metodo_pago`, `notas_pedido`, `estado`, `motivo_cancelacion`, `comprobante`, `created_at`, `updated_at`) VALUES
(2, 15, 1, 'Miguel', 104.00, 'transferencia', NULL, 'entregado', NULL, 'comprobantes/PdbUohRdz1P8KnqSpXrob7jFX2ppsoueTvvd1N3W.png', '2026-05-07 13:53:54', '2026-05-09 04:12:21'),
(3, 15, 2, 'Miguel', 25.00, 'transferencia', NULL, 'entregado', NULL, 'comprobantes/XQlfiRjtHrML0z5DOrNZ4lV3n7xMNtALNldEceeA.jpg', '2026-05-08 03:04:00', '2026-05-09 05:04:31'),
(4, 3, 2, 'Itzel', 75.00, 'efectivo', NULL, 'pendiente', NULL, NULL, '2026-05-08 12:09:54', '2026-05-08 12:09:54'),
(5, 15, 1, 'Miguel', 25.00, 'transferencia', NULL, 'entregado', NULL, 'comprobantes/MpykkgmLgMfxjEB2FcUvYbFXHfPcVywiGhMQX3Uh.jpg', '2026-05-09 03:55:34', '2026-05-09 05:02:53'),
(6, 15, 1, 'Miguel', 54.00, 'transferencia', NULL, 'entregado', NULL, 'comprobantes/evn36y1xuMECpcRTwZdAhdijxBOirfeM8oKLUMLy.png', '2026-05-09 04:34:19', '2026-05-09 04:37:51'),
(7, 15, 1, 'Miguel', 44.00, 'transferencia', NULL, 'entregado', NULL, 'comprobantes/Rxc8VdSzKaGassTGqaTBir14WMxVhuUp537OmAD2.png', '2026-05-09 18:01:45', '2026-05-13 06:31:34'),
(8, 15, 1, 'Miguel', 95.00, 'transferencia', NULL, 'validando', NULL, 'comprobantes/Njtf8hqVjrp3BxUFNVjEKKg5tKHjpvcVRwXNSl4R.png', '2026-05-12 06:13:46', '2026-05-13 05:26:23'),
(9, 15, 2, 'Miguel', 50.00, 'transferencia', NULL, 'pendiente', NULL, NULL, '2026-05-13 05:49:46', '2026-05-13 05:49:46'),
(10, 15, 1, 'Miguel', 295.00, 'transferencia', NULL, 'validando', NULL, 'comprobantes/mzIi72igVb2Od9zwK8VEGHbyyf6j0OyDAelWpOle.png', '2026-05-13 05:52:47', '2026-05-13 07:03:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Usuario', 15, 'auth_token', 'e5c9ad5ade44865d8aa381068b37dad9d9807c184e7dda0459387b2dd6f0809f', '[\"*\"]', '2026-05-07 14:52:55', NULL, '2026-05-07 14:49:44', '2026-05-07 14:52:55'),
(2, 'App\\Models\\Usuario', 15, 'auth_token', '4a3f088fa69324662e53726981e1c8a7bdc206280e662236ce0d124cb11e2bb9', '[\"*\"]', '2026-05-07 15:01:01', NULL, '2026-05-07 14:53:07', '2026-05-07 15:01:01'),
(3, 'App\\Models\\Usuario', 15, 'auth_token', 'c5124a6b8b4083b9a8b16d5f68b764cd2b3df49ed970fde4109ece541c275ca9', '[\"*\"]', '2026-05-07 15:02:03', NULL, '2026-05-07 15:01:15', '2026-05-07 15:02:03'),
(4, 'App\\Models\\Usuario', 15, 'auth_token', '2a63e177063ab69cbf1545ca87ea5a0ad6cf439c908f113ec2e84061950b9d43', '[\"*\"]', '2026-05-07 15:04:26', NULL, '2026-05-07 15:02:17', '2026-05-07 15:04:26'),
(5, 'App\\Models\\Usuario', 15, 'auth_token', '3e5ba67c6c30f0c7ab5636af9547d4a592b74dc372e05e329c216b1982e5b239', '[\"*\"]', '2026-05-07 15:11:55', NULL, '2026-05-07 15:04:42', '2026-05-07 15:11:55'),
(6, 'App\\Models\\Usuario', 15, 'auth_token', 'df260fb76069d8a2f814ccf894e9bbed4cc65c01f16cad756cc8f09139878c0f', '[\"*\"]', '2026-05-07 15:12:46', NULL, '2026-05-07 15:12:12', '2026-05-07 15:12:46'),
(7, 'App\\Models\\Usuario', 15, 'auth_token', 'b00c8efeb0e95c7afca54c41b78d47b4f43bc01a17f5262ec67c9e13fb37a338', '[\"*\"]', '2026-05-08 02:05:52', NULL, '2026-05-08 02:02:25', '2026-05-08 02:05:52'),
(8, 'App\\Models\\Usuario', 15, 'auth_token', '2a9067ff000c4af743dd1c7c6a75c7de10b5ca9190c0fd5eb1595da9f6e6f888', '[\"*\"]', '2026-05-08 03:08:26', NULL, '2026-05-08 03:02:46', '2026-05-08 03:08:26'),
(9, 'App\\Models\\Usuario', 2, 'auth_token', 'fd1a26f6464f1a097dacea30a026cd6dceee42af75e0c69c9ce0f29cacf12a75', '[\"*\"]', '2026-05-08 05:31:08', NULL, '2026-05-08 04:54:15', '2026-05-08 05:31:08'),
(10, 'App\\Models\\Usuario', 2, 'auth_token', 'a4d2c20eedfd62dee137a9a12db34b05377948975d098c6b388d71dc2e104348', '[\"*\"]', '2026-05-08 05:34:33', NULL, '2026-05-08 05:31:31', '2026-05-08 05:34:33'),
(11, 'App\\Models\\Usuario', 2, 'auth_token', '2f57faf2cd9825f558a91ec0d1c1bcc13f5c2026a5f0fcc41b511a96cb49ace9', '[\"*\"]', '2026-05-08 06:00:12', NULL, '2026-05-08 05:35:52', '2026-05-08 06:00:12'),
(12, 'App\\Models\\Usuario', 2, 'auth_token', '8465d68c96a1a88dc1f0929d2962867900f003bc7fc8122bd069c8764232969e', '[\"*\"]', '2026-05-08 06:09:10', NULL, '2026-05-08 06:00:28', '2026-05-08 06:09:10'),
(13, 'App\\Models\\Usuario', 15, 'auth_token', '43d80feab69e4eedbab437e3ad0a182b6e5acc92d491af8343cad6d63b893538', '[\"*\"]', '2026-05-08 06:13:06', NULL, '2026-05-08 06:09:52', '2026-05-08 06:13:06'),
(14, 'App\\Models\\Usuario', 2, 'auth_token', '410e63912236c71255694e8ae1c47e404993b48c1f2b9410301b4fe032333a44', '[\"*\"]', '2026-05-08 06:13:34', NULL, '2026-05-08 06:13:25', '2026-05-08 06:13:34'),
(15, 'App\\Models\\Usuario', 15, 'auth_token', '91c942c0138623fa3872a1579c955f8fb1053aae7d7fa841572d2c29bb7d2884', '[\"*\"]', '2026-05-08 06:15:44', NULL, '2026-05-08 06:13:58', '2026-05-08 06:15:44'),
(16, 'App\\Models\\Usuario', 2, 'auth_token', 'c2953eeee276efd3b92967c568dd048bcf51ab0990405f100fdd2c81a6874e56', '[\"*\"]', '2026-05-08 06:22:15', NULL, '2026-05-08 06:16:22', '2026-05-08 06:22:15'),
(17, 'App\\Models\\Usuario', 15, 'auth_token', '955cbccab0ddd0505aa22c88ac4a6a416b4c627ab234f0b4053466803a8139b4', '[\"*\"]', '2026-05-08 06:35:13', NULL, '2026-05-08 06:23:05', '2026-05-08 06:35:13'),
(18, 'App\\Models\\Usuario', 2, 'auth_token', '3d4a5d65e1b9eaf58793cfde2952431db4331bafce494a594a2b4894b768bab0', '[\"*\"]', NULL, NULL, '2026-05-08 06:23:43', '2026-05-08 06:23:43'),
(19, 'App\\Models\\Usuario', 2, 'auth_token', 'd4a57f2b7fbb7a5e8453b460330783501ab040907149c218dd4796b633b05255', '[\"*\"]', '2026-05-08 06:43:44', NULL, '2026-05-08 06:24:02', '2026-05-08 06:43:44'),
(20, 'App\\Models\\Usuario', 15, 'auth_token', 'e7b28a72fbcf3d1b37305b86f8fe2a7fd6c40d440b3451d9274a31705cdf1a83', '[\"*\"]', '2026-05-08 06:43:57', NULL, '2026-05-08 06:35:32', '2026-05-08 06:43:57'),
(21, 'App\\Models\\Usuario', 15, 'auth_token', '5b6c626d839e06963197491adf622962be246cf212e3f333022140011d71eb64', '[\"*\"]', '2026-05-08 06:47:11', NULL, '2026-05-08 06:44:17', '2026-05-08 06:47:11'),
(22, 'App\\Models\\Usuario', 2, 'auth_token', 'ee4e5352283afb2727ae1825de72352a61006e05cb167ec7a2ee867762f30685', '[\"*\"]', '2026-05-08 06:45:44', NULL, '2026-05-08 06:44:57', '2026-05-08 06:45:44'),
(23, 'App\\Models\\Usuario', 2, 'auth_token', '5137ced2dd7179e0c67c7721f9223071dabf6bb0f7af5c4061d8b14a8111ca04', '[\"*\"]', '2026-05-08 10:54:15', NULL, '2026-05-08 10:31:19', '2026-05-08 10:54:15'),
(24, 'App\\Models\\Usuario', 15, 'auth_token', 'adc425d7a3bbb4e292f3fb17f178774ba75d00f0a81112409fa77beb4f1ff79c', '[\"*\"]', '2026-05-08 11:13:34', NULL, '2026-05-08 10:36:06', '2026-05-08 11:13:34'),
(25, 'App\\Models\\Usuario', 2, 'auth_token', '0cfb7ccf61500d6e39899613a62a6c35d3a7a9b69f43819ac8a088b0ea4abbee', '[\"*\"]', '2026-05-08 10:57:50', NULL, '2026-05-08 10:55:47', '2026-05-08 10:57:50'),
(26, 'App\\Models\\Usuario', 15, 'auth_token', 'f01bb1ee9efd9180869ecb27e3733fb159e7638e3e2942d98ae2716752a0b109', '[\"*\"]', '2026-05-08 11:02:37', NULL, '2026-05-08 11:02:35', '2026-05-08 11:02:37'),
(27, 'App\\Models\\Usuario', 2, 'auth_token', '14436371702aed4ef370de4fe78edcba631820c015b98bd68d350e66a3091747', '[\"*\"]', '2026-05-08 11:13:38', NULL, '2026-05-08 11:02:48', '2026-05-08 11:13:38'),
(28, 'App\\Models\\Usuario', 2, 'auth_token', '28976ffdd61b5dbeac9571e52c0d27f54feeab9fe0e9b10207280a1983591ceb', '[\"*\"]', '2026-05-08 11:57:01', NULL, '2026-05-08 11:16:02', '2026-05-08 11:57:01'),
(29, 'App\\Models\\Usuario', 15, 'auth_token', '1aacc904a9d37479c0a912fdfd804bf7a4471e16b7511e544571fdc2b4e5ce6a', '[\"*\"]', '2026-05-08 11:57:18', NULL, '2026-05-08 11:16:35', '2026-05-08 11:57:18'),
(30, 'App\\Models\\Usuario', 15, 'auth_token', 'c1d5751e7474068e925fe0c621fe1aaede1a20342fe6fde2a772658d87797349', '[\"*\"]', '2026-05-08 12:01:25', NULL, '2026-05-08 12:00:58', '2026-05-08 12:01:25'),
(31, 'App\\Models\\Usuario', 2, 'auth_token', '75bcef3c93f1888158545910e2a1896d0b70c8b589764e326040032cf30269d6', '[\"*\"]', '2026-05-08 12:02:00', NULL, '2026-05-08 12:01:33', '2026-05-08 12:02:00'),
(32, 'App\\Models\\Usuario', 15, 'auth_token', 'd05f9aaa7ee99609fca6124aa34f280e1607782a02fd518c35383ac23041d141', '[\"*\"]', '2026-05-08 12:03:00', NULL, '2026-05-08 12:02:14', '2026-05-08 12:03:00'),
(33, 'App\\Models\\Usuario', 2, 'auth_token', '41cc28b7db4b5d12c25598be95f50e567715066c1f161afb6de97deee4901447', '[\"*\"]', '2026-05-08 12:03:12', NULL, '2026-05-08 12:03:08', '2026-05-08 12:03:12'),
(34, 'App\\Models\\Usuario', 2, 'auth_token', '99e64237a68f669d90eb8c05b01f8f9bd037b755028fec0b3b1a64ef1d99ef50', '[\"*\"]', '2026-05-08 12:03:38', NULL, '2026-05-08 12:03:35', '2026-05-08 12:03:38'),
(35, 'App\\Models\\Usuario', 4, 'auth_token', '22bc37fd0b8ba315539b9312d93e06b74b7958927149dae69df586c550dff661', '[\"*\"]', '2026-05-08 12:04:45', NULL, '2026-05-08 12:04:14', '2026-05-08 12:04:45'),
(36, 'App\\Models\\Usuario', 2, 'auth_token', 'bbe91beb47ea5dc7e0baee85c92b45c22d16173ce0746c4791e1c93cf9b92a0c', '[\"*\"]', NULL, NULL, '2026-05-08 12:04:57', '2026-05-08 12:04:57'),
(37, 'App\\Models\\Usuario', 15, 'auth_token', 'e18c26a0297da397d0766bd2e1f64ababc6d5c62c0aab74b961146de9a2f4b56', '[\"*\"]', '2026-05-08 12:06:24', NULL, '2026-05-08 12:05:06', '2026-05-08 12:06:24'),
(38, 'App\\Models\\Usuario', 2, 'auth_token', '8a88b2866e29b419fc087948578ee80c84d26360c783995d448a5f4833d714be', '[\"*\"]', '2026-05-08 12:07:21', NULL, '2026-05-08 12:06:31', '2026-05-08 12:07:21'),
(39, 'App\\Models\\Usuario', 2, 'auth_token', '43ba4d1184584badc59151e46b6dc7ff1765c750e3db5811aebc12f1d0da8478', '[\"*\"]', '2026-05-08 12:07:41', NULL, '2026-05-08 12:07:39', '2026-05-08 12:07:41'),
(40, 'App\\Models\\Usuario', 15, 'auth_token', 'f562b1afd0b44f3b2ea96f46b91426cdedd2145834dcddddbf775ba250540274', '[\"*\"]', '2026-05-08 12:08:15', NULL, '2026-05-08 12:07:50', '2026-05-08 12:08:15'),
(41, 'App\\Models\\Usuario', 2, 'auth_token', '041445d49727c73667365005575117c5f8cc427bcb04bf5cd359e4c8bcaecb7c', '[\"*\"]', '2026-05-08 12:08:44', NULL, '2026-05-08 12:08:24', '2026-05-08 12:08:44'),
(42, 'App\\Models\\Usuario', 3, 'auth_token', '1dc3636d2363ed1ab175460fd939c32c5cc72eca75fa988610427cc5223709da', '[\"*\"]', '2026-05-08 12:10:00', NULL, '2026-05-08 12:09:23', '2026-05-08 12:10:00'),
(43, 'App\\Models\\Usuario', 2, 'auth_token', '646f004068698b2e7a17eb038bdf6124eb1c5e88efd5ab483efb7b24ebbe4d49', '[\"*\"]', '2026-05-09 03:54:30', NULL, '2026-05-09 03:53:54', '2026-05-09 03:54:30'),
(44, 'App\\Models\\Usuario', 15, 'auth_token', '33ec5c9def85a250b13695d1bf69ba8adcebec3ef5ff8eeb5a274238f9de0047', '[\"*\"]', '2026-05-09 03:55:45', NULL, '2026-05-09 03:54:45', '2026-05-09 03:55:45'),
(45, 'App\\Models\\Usuario', 2, 'auth_token', '98513d907a576d25a2bd0bc6dd6118c1a90e266a47691c7c83b9e728726f3ac4', '[\"*\"]', '2026-05-09 03:59:53', NULL, '2026-05-09 03:55:56', '2026-05-09 03:59:53'),
(46, 'App\\Models\\Usuario', 2, 'auth_token', 'dd6091639024c73249baf3b1e7a1d35ef7f725e6163e50b0eba61ec16b2e809c', '[\"*\"]', '2026-05-09 04:00:17', NULL, '2026-05-09 04:00:14', '2026-05-09 04:00:17'),
(47, 'App\\Models\\Usuario', 15, 'auth_token', '65ad99db1c1d520967d6d73f828d6e9ded0002125b854321b1c89d17af464bcc', '[\"*\"]', '2026-05-09 04:00:50', NULL, '2026-05-09 04:00:29', '2026-05-09 04:00:50'),
(48, 'App\\Models\\Usuario', 2, 'auth_token', '157e18490b9e7ad0486ec2b8ad58a6232c0983dd597e9482a54154af607ffec1', '[\"*\"]', '2026-05-09 04:01:24', NULL, '2026-05-09 04:00:59', '2026-05-09 04:01:24'),
(49, 'App\\Models\\Usuario', 2, 'auth_token', '2d753b5927c110e44a348cd3e097baff8402a22c50f72d7e2f9fffe456bebc24', '[\"*\"]', '2026-05-09 04:09:38', NULL, '2026-05-09 04:01:54', '2026-05-09 04:09:38'),
(50, 'App\\Models\\Usuario', 2, 'auth_token', 'ebf64d368036654e3a8a673009a183262ebd3e3ce3fe1d630245b9880573fb87', '[\"*\"]', '2026-05-09 04:10:29', NULL, '2026-05-09 04:09:58', '2026-05-09 04:10:29'),
(51, 'App\\Models\\Usuario', 15, 'auth_token', '036fed0da26d647c24c158af02863b9e7229cd782f2ef11b5161962109cf3f8c', '[\"*\"]', '2026-05-09 04:11:06', NULL, '2026-05-09 04:10:48', '2026-05-09 04:11:06'),
(52, 'App\\Models\\Usuario', 2, 'auth_token', 'a84a9df75e187483e5b519a3c813efaefa80137de8f952ab1190dd39dbebadf2', '[\"*\"]', '2026-05-09 04:12:25', NULL, '2026-05-09 04:11:12', '2026-05-09 04:12:25'),
(53, 'App\\Models\\Usuario', 15, 'auth_token', '42dd8d1f04b80a7da7c1fcab622e04dfb34a3aa658a715871c232be8a2b30485', '[\"*\"]', '2026-05-09 04:15:40', NULL, '2026-05-09 04:12:43', '2026-05-09 04:15:40'),
(54, 'App\\Models\\Usuario', 15, 'auth_token', '3d81b60821dd10687b652a03669115732c19e1e79ca98c16228748ee06d03d45', '[\"*\"]', '2026-05-09 04:17:40', NULL, '2026-05-09 04:15:52', '2026-05-09 04:17:40'),
(55, 'App\\Models\\Usuario', 15, 'auth_token', '2102e8cb1361d1d15641ee4a3102ded8f4f002106e09be94e008f6a6601271db', '[\"*\"]', '2026-05-09 04:26:18', NULL, '2026-05-09 04:17:53', '2026-05-09 04:26:18'),
(56, 'App\\Models\\Usuario', 15, 'auth_token', 'cf84775996db6db3d299fb0e0ac499d074db72503f480618ad08ed426102f196', '[\"*\"]', '2026-05-09 04:27:04', NULL, '2026-05-09 04:26:31', '2026-05-09 04:27:04'),
(57, 'App\\Models\\Usuario', 15, 'auth_token', '8146ee4d95c530f3f49fe64285be2d544efd00d4c41c10699859fcbf16b0c5df', '[\"*\"]', '2026-05-09 04:29:28', NULL, '2026-05-09 04:27:16', '2026-05-09 04:29:28'),
(58, 'App\\Models\\Usuario', 15, 'auth_token', '1328c9f05572a8e4ae7845cab08477b547233d74bebb65ec571e856634da9643', '[\"*\"]', '2026-05-09 04:30:10', NULL, '2026-05-09 04:29:46', '2026-05-09 04:30:10'),
(59, 'App\\Models\\Usuario', 15, 'auth_token', '3aa38ccd8b6e2e2a84428680b700ec2945232f2197b41ef597663a803f1d09f7', '[\"*\"]', '2026-05-09 04:33:27', NULL, '2026-05-09 04:30:41', '2026-05-09 04:33:27'),
(60, 'App\\Models\\Usuario', 15, 'auth_token', '76a801c15f255fe01b3e87b63395e9c2be9a93d7bcf858cc0056b29ffde9618b', '[\"*\"]', NULL, NULL, '2026-05-09 04:30:41', '2026-05-09 04:30:41'),
(61, 'App\\Models\\Usuario', 2, 'auth_token', '30747515975994132e4d8ecc2c23f7fd43ae996599a23c49b41f227eac39d6fb', '[\"*\"]', '2026-05-09 04:59:55', NULL, '2026-05-09 04:30:59', '2026-05-09 04:59:55'),
(62, 'App\\Models\\Usuario', 15, 'auth_token', 'b5a4df323137787b3380bf9a5f28b0f87302aa2260033de0635c713b467f4b9c', '[\"*\"]', '2026-05-09 04:39:09', NULL, '2026-05-09 04:33:50', '2026-05-09 04:39:09'),
(63, 'App\\Models\\Usuario', 15, 'auth_token', 'a854f7fb810da20aa948a79b0cfc8f238686e8e59b236691af1be320c94d9fe9', '[\"*\"]', '2026-05-09 04:56:00', NULL, '2026-05-09 04:39:24', '2026-05-09 04:56:00'),
(64, 'App\\Models\\Usuario', 15, 'auth_token', 'e338d6c4d77e81f283b19c5595d5dee51838db6fc04cfe025008f3279ac91c08', '[\"*\"]', '2026-05-09 05:07:53', NULL, '2026-05-09 04:56:14', '2026-05-09 05:07:53'),
(65, 'App\\Models\\Usuario', 2, 'auth_token', '944d7d93dc862202d71a85a5efca2de312b6f8409d7a413c749e731556e5fd2d', '[\"*\"]', '2026-05-09 05:09:26', NULL, '2026-05-09 05:00:11', '2026-05-09 05:09:26'),
(66, 'App\\Models\\Usuario', 15, 'auth_token', '6ed8a3daa8f7681d335ab2faf1c70d98ac2fc22672be9a1d678cca16f130020d', '[\"*\"]', '2026-05-09 05:08:11', NULL, '2026-05-09 05:08:05', '2026-05-09 05:08:11'),
(67, 'App\\Models\\Usuario', 15, 'auth_token', '90bde364bf92d8357496e15a1c726f69c2c00f6bfd149b47e4fbc09f396135f4', '[\"*\"]', '2026-05-09 05:09:45', NULL, '2026-05-09 05:09:41', '2026-05-09 05:09:45'),
(68, 'App\\Models\\Usuario', 2, 'auth_token', '772a900af3149177131df5d0e8ce8424dd405a8c932078b3757398df1203825c', '[\"*\"]', '2026-05-09 05:14:11', NULL, '2026-05-09 05:11:16', '2026-05-09 05:14:11'),
(69, 'App\\Models\\Usuario', 2, 'auth_token', '132eeb0a3faaee085dffa231602d0fed718b328db3387e32825c8e5d7cc379b6', '[\"*\"]', '2026-05-09 05:38:49', NULL, '2026-05-09 05:14:42', '2026-05-09 05:38:49'),
(70, 'App\\Models\\Usuario', 2, 'auth_token', '0cbbbaba7707c506480dd3099d1ec35e11473c2d50e5ef6181f60f9006af2c99', '[\"*\"]', '2026-05-09 05:43:04', NULL, '2026-05-09 05:39:30', '2026-05-09 05:43:04'),
(71, 'App\\Models\\Usuario', 2, 'auth_token', '52bb9dc89cde695d253a3cfaf0b88eff62ce575051082abcbb1d03ca7f6b884e', '[\"*\"]', '2026-05-09 05:53:09', NULL, '2026-05-09 05:43:33', '2026-05-09 05:53:09'),
(72, 'App\\Models\\Usuario', 2, 'auth_token', 'f010cfa5ad06a45c9d1901acbf9d7c5843cd507de611744ff7fa84a8af5a18fc', '[\"*\"]', '2026-05-09 05:58:31', NULL, '2026-05-09 05:53:27', '2026-05-09 05:58:31'),
(73, 'App\\Models\\Usuario', 2, 'auth_token', '4d8f46e1bcd4594052b44722d08f07254aabaf95a5dda80f1f5bcf25360bf532', '[\"*\"]', '2026-05-09 06:04:04', NULL, '2026-05-09 05:59:00', '2026-05-09 06:04:04'),
(74, 'App\\Models\\Usuario', 2, 'auth_token', 'c33d63bc93c50377dbe61de0ea7ebe902b91728c40b410bd83f54164c2c01f37', '[\"*\"]', '2026-05-09 06:09:58', NULL, '2026-05-09 06:04:48', '2026-05-09 06:09:58'),
(75, 'App\\Models\\Usuario', 2, 'auth_token', 'b3b8e251e61033e4897f977967c711395cb34e02637dd8d7d9ffbb788b99e075', '[\"*\"]', NULL, NULL, '2026-05-09 06:04:49', '2026-05-09 06:04:49'),
(76, 'App\\Models\\Usuario', 2, 'auth_token', '7a750821e1dd09a2dae2e1764eaf0f4e6232dace35b04e78f8d4dd753b3953ff', '[\"*\"]', '2026-05-09 06:13:46', NULL, '2026-05-09 06:10:15', '2026-05-09 06:13:46'),
(77, 'App\\Models\\Usuario', 2, 'auth_token', '0e77d9ba268659c75996c254655e6b34c0a802ae5fd4194c25a9fa0311af98e7', '[\"*\"]', '2026-05-09 06:14:49', NULL, '2026-05-09 06:14:03', '2026-05-09 06:14:49'),
(78, 'App\\Models\\Usuario', 2, 'auth_token', '6c99398f4e43bdee70de4bcb3eac2b5fef369bf1d529b879ffa53a8a0d1934f5', '[\"*\"]', '2026-05-09 06:40:07', NULL, '2026-05-09 06:19:01', '2026-05-09 06:40:07'),
(79, 'App\\Models\\Usuario', 2, 'auth_token', '6a0f6b40ebb5871b6786fb341a48c4eb3f8faaa028bcf45c3a214b29c4e8ca4b', '[\"*\"]', '2026-05-09 07:34:41', NULL, '2026-05-09 07:11:22', '2026-05-09 07:34:41'),
(80, 'App\\Models\\Usuario', 2, 'auth_token', '8b20c40c367038ea8248e2557ae4b408e5a9dde83f1601c0705fd57ee63ceca2', '[\"*\"]', '2026-05-09 07:39:27', NULL, '2026-05-09 07:35:00', '2026-05-09 07:39:27'),
(81, 'App\\Models\\Usuario', 2, 'auth_token', '6156ddca101ef6568c7381a7a978f6cc0b522cd8047601cb772dc10449246463', '[\"*\"]', '2026-05-09 07:41:14', NULL, '2026-05-09 07:39:44', '2026-05-09 07:41:14'),
(82, 'App\\Models\\Usuario', 2, 'auth_token', 'b8cea97de67b6455bca5417ed0fc467e55f3b3aac06bb7ce3a4fbfc4045b3c2d', '[\"*\"]', '2026-05-09 07:43:07', NULL, '2026-05-09 07:41:30', '2026-05-09 07:43:07'),
(83, 'App\\Models\\Usuario', 2, 'auth_token', '0bcaf9e4b2d0b41b672d5aec9b6629caa7c410a06f0d09015cb53bcc84efb803', '[\"*\"]', '2026-05-09 07:45:07', NULL, '2026-05-09 07:43:30', '2026-05-09 07:45:07'),
(84, 'App\\Models\\Usuario', 2, 'auth_token', '8b98a2ae5ff5677f94512b4316cef461cf3ab1736f87241e507d94a1e5ff42de', '[\"*\"]', '2026-05-09 07:48:21', NULL, '2026-05-09 07:45:31', '2026-05-09 07:48:21'),
(85, 'App\\Models\\Usuario', 2, 'auth_token', 'fd652874435e95391811d6f7d1eac012d94a3bc649211f95319f7c2a8a64766d', '[\"*\"]', '2026-05-09 08:48:24', NULL, '2026-05-09 07:48:35', '2026-05-09 08:48:24'),
(86, 'App\\Models\\Usuario', 2, 'auth_token', '2343c6475f18ccf992afb057e4bbc7f0ff336c3ffc72c318083503313800fef3', '[\"*\"]', '2026-05-09 09:01:02', NULL, '2026-05-09 08:50:38', '2026-05-09 09:01:02'),
(87, 'App\\Models\\Usuario', 2, 'auth_token', '71d809b2ab90d4c061f172bfa31010044d5a214d684427d9cfb582131e9df4bc', '[\"*\"]', '2026-05-09 09:02:38', NULL, '2026-05-09 09:02:34', '2026-05-09 09:02:38'),
(88, 'App\\Models\\Usuario', 2, 'auth_token', 'b321f5263f55a018504d8393b50f27841e85c5a7453bb816213903cfba81230e', '[\"*\"]', '2026-05-09 09:07:17', NULL, '2026-05-09 09:05:29', '2026-05-09 09:07:17'),
(89, 'App\\Models\\Usuario', 2, 'auth_token', '20296c48d412f87bc437b63e3c4c8c7b55470e9643cb449834551b3e5897a16a', '[\"*\"]', '2026-05-09 09:07:53', NULL, '2026-05-09 09:07:40', '2026-05-09 09:07:53'),
(90, 'App\\Models\\Usuario', 1, 'auth_token', 'a10f0068ba8c5ccc9e613e8a7671e2ed7a8e873af9a5663bd2b13afb55f9fb1a', '[\"*\"]', '2026-05-09 09:08:12', NULL, '2026-05-09 09:08:08', '2026-05-09 09:08:12'),
(91, 'App\\Models\\Usuario', 2, 'auth_token', 'e6a701f9fbb6cfbbf715cfb47e826b66559bc9a72d6af4436a7a8e612fcef89b', '[\"*\"]', '2026-05-09 09:09:05', NULL, '2026-05-09 09:09:01', '2026-05-09 09:09:05'),
(92, 'App\\Models\\Usuario', 2, 'auth_token', 'c0be567f822533f78833c91b7c73b6d85ca55f74e52c11c337ef773942b38f2a', '[\"*\"]', '2026-05-09 09:09:36', NULL, '2026-05-09 09:09:22', '2026-05-09 09:09:36'),
(93, 'App\\Models\\Usuario', 2, 'auth_token', '25588b6f5f2dbb1b3dec46843e3527fc0dde69397edb91c9e45b91efbe0bcb36', '[\"*\"]', '2026-05-09 09:10:08', NULL, '2026-05-09 09:09:56', '2026-05-09 09:10:08'),
(94, 'App\\Models\\Usuario', 2, 'auth_token', 'f19f15df7226d85b78bdfeaa11a328ed9013e93bf18a7c0a7b5479c67e0c4638', '[\"*\"]', '2026-05-09 09:10:55', NULL, '2026-05-09 09:10:52', '2026-05-09 09:10:55'),
(95, 'App\\Models\\Usuario', 1, 'auth_token', '47bcb539c74cb51cc552af7cdd9d6583abcc5639d97cf3b46f9568cdc5f60d88', '[\"*\"]', NULL, NULL, '2026-05-09 09:11:05', '2026-05-09 09:11:05'),
(96, 'App\\Models\\Usuario', 1, 'auth_token', '044cb305119a91ec89b36ca514a2f4e6319191aacd17daccbb42fb184391843b', '[\"*\"]', '2026-05-09 09:39:20', NULL, '2026-05-09 09:17:38', '2026-05-09 09:39:20'),
(97, 'App\\Models\\Usuario', 1, 'auth_token', '98523aa194547998a3e9b97406f26ec6671682595076d132c1b5c1d8320c5e5e', '[\"*\"]', '2026-05-09 09:49:27', NULL, '2026-05-09 09:39:39', '2026-05-09 09:49:27'),
(98, 'App\\Models\\Usuario', 1, 'auth_token', 'ac3c9555607586b78d5c462bdd6aec7a74d68871e5597c89fcd9b9c1e49cde43', '[\"*\"]', '2026-05-09 09:53:32', NULL, '2026-05-09 09:51:18', '2026-05-09 09:53:32'),
(99, 'App\\Models\\Usuario', 15, 'auth_token', '898bce561059e39b2ed3edb4dc1a065e1ca306daca0ae82bf4eeb82412aa4b24', '[\"*\"]', '2026-05-09 09:58:20', NULL, '2026-05-09 09:58:15', '2026-05-09 09:58:20'),
(100, 'App\\Models\\Usuario', 15, 'auth_token', '5e1f4ef31cc724b8fc8613feef543e959b26d8cd29b9aaafd9726728add37df8', '[\"*\"]', '2026-05-09 10:02:00', NULL, '2026-05-09 09:58:50', '2026-05-09 10:02:00'),
(101, 'App\\Models\\Usuario', 15, 'auth_token', 'bea308e1cbf8f86f16cdd70570e14e66fe9cda700e001fb80fdbefde16f95fe8', '[\"*\"]', '2026-05-09 10:02:22', NULL, '2026-05-09 10:02:18', '2026-05-09 10:02:22'),
(102, 'App\\Models\\Usuario', 15, 'auth_token', '18fe1b684953b4b2030b445453161d214b3d982b0c4654dd2dc31c824515acfd', '[\"*\"]', '2026-05-09 10:14:30', NULL, '2026-05-09 10:03:41', '2026-05-09 10:14:30'),
(103, 'App\\Models\\Usuario', 15, 'auth_token', '010f898a96b57ef8fc62e0de1f3614cef6530fdf2b311e785c7311130a3ba5f3', '[\"*\"]', '2026-05-09 10:15:31', NULL, '2026-05-09 10:14:51', '2026-05-09 10:15:31'),
(104, 'App\\Models\\Usuario', 15, 'auth_token', 'cc9137ee4cf2e042fead930beae89311d5498cd5e714271104d6ec0152b13e3c', '[\"*\"]', '2026-05-09 10:32:38', NULL, '2026-05-09 10:21:33', '2026-05-09 10:32:38'),
(105, 'App\\Models\\Usuario', 2, 'auth_token', '5f62b66fa916463da993a90b4e7916b749180d549ecc37b7c7e3baa38ab1e73c', '[\"*\"]', '2026-05-09 10:33:19', NULL, '2026-05-09 10:32:55', '2026-05-09 10:33:19'),
(106, 'App\\Models\\Usuario', 15, 'auth_token', '418d8c2b1c6376075659d62ebcca486ba3e3d3530a162e8860167c9a760f9bc3', '[\"*\"]', '2026-05-09 10:38:13', NULL, '2026-05-09 10:33:45', '2026-05-09 10:38:13'),
(107, 'App\\Models\\Usuario', 2, 'auth_token', 'b031e72c9e922e083b405d96349462e819f29b0e43972fccaea6e3b73fccdc47', '[\"*\"]', '2026-05-09 10:37:54', NULL, '2026-05-09 10:35:07', '2026-05-09 10:37:54'),
(108, 'App\\Models\\Usuario', 3, 'auth_token', 'cbf8f43ae452d550fe08a23a38fbeffa48a31d48aeb210a93ea3a8f5f1078c56', '[\"*\"]', '2026-05-09 10:38:44', NULL, '2026-05-09 10:38:34', '2026-05-09 10:38:44'),
(109, 'App\\Models\\Usuario', 4, 'auth_token', '86a32316b086509ed54f50b1cc23551126348eb9f4c6a1d3e1bc96f55aa8a422', '[\"*\"]', '2026-05-09 10:50:44', NULL, '2026-05-09 10:39:01', '2026-05-09 10:50:44'),
(110, 'App\\Models\\Usuario', 15, 'auth_token', '4a0d6e4998894c064d15feed6e8cd428375f9ccfad4b6cb26a657fc1516711e4', '[\"*\"]', '2026-05-09 10:42:17', NULL, '2026-05-09 10:40:12', '2026-05-09 10:42:17'),
(111, 'App\\Models\\Usuario', 15, 'auth_token', 'd7c32e17725e7bc2c785f9517973ea2a93e703bd341d660db85e59e9783d1ea1', '[\"*\"]', '2026-05-09 10:47:09', NULL, '2026-05-09 10:42:36', '2026-05-09 10:47:09'),
(112, 'App\\Models\\Usuario', 15, 'auth_token', 'e623a1dc159bcb0925609fce26139e41e3849f6bb646ebb0270d5b2dcae797d6', '[\"*\"]', '2026-05-09 10:50:45', NULL, '2026-05-09 10:47:29', '2026-05-09 10:50:45'),
(113, 'App\\Models\\Usuario', 2, 'auth_token', '71bd6fa7da225c67a7a22448f55afbf68b70ccce6b0ca685f72341ee495c30f2', '[\"*\"]', '2026-05-09 11:02:47', NULL, '2026-05-09 10:55:40', '2026-05-09 11:02:47'),
(114, 'App\\Models\\Usuario', 15, 'auth_token', '5a121872ac4d3202540c7a45b35791a47389b4b9ba28feb18fc7fb89690b75d2', '[\"*\"]', '2026-05-09 10:58:34', NULL, '2026-05-09 10:56:00', '2026-05-09 10:58:34'),
(115, 'App\\Models\\Usuario', 15, 'auth_token', '0276d497e801302ec0fd2932bc87b21cc611ab2a2f84af33d53f75571bdb663a', '[\"*\"]', '2026-05-09 11:09:34', NULL, '2026-05-09 10:59:00', '2026-05-09 11:09:34'),
(116, 'App\\Models\\Usuario', 4, 'auth_token', '064529c380f9bf0d318fa3f72fd657aecea3f1349dd166dca6d327b652c50e9b', '[\"*\"]', '2026-05-09 11:10:13', NULL, '2026-05-09 11:03:06', '2026-05-09 11:10:13'),
(117, 'App\\Models\\Usuario', 2, 'auth_token', '3985e8b1f171e07fda85b7862ed71deebe688fd34fc4328b138e593e23fab97b', '[\"*\"]', '2026-05-09 23:10:22', NULL, '2026-05-09 23:09:30', '2026-05-09 23:10:22'),
(118, 'App\\Models\\Usuario', 1, 'auth_token', 'cddba535ab67ff97e2159a621af3ec07ce84db2b02b4ff1fcfd2279abfab95cf', '[\"*\"]', '2026-05-09 23:11:33', NULL, '2026-05-09 23:10:59', '2026-05-09 23:11:33'),
(119, 'App\\Models\\Usuario', 15, 'auth_token', 'a3f3a02a680edd0f1ea2350ff5e59aebbf430239f57e60db5cb3e59ec91aa813', '[\"*\"]', '2026-05-09 23:12:47', NULL, '2026-05-09 23:11:55', '2026-05-09 23:12:47'),
(120, 'App\\Models\\Usuario', 15, 'auth_token', '50be45eca522ba490d9b651491749440c1d666393440d607336891f02a907664', '[\"*\"]', '2026-05-09 23:56:43', NULL, '2026-05-09 23:40:56', '2026-05-09 23:56:43'),
(121, 'App\\Models\\Usuario', 15, 'auth_token', 'f5cf0e4d5eaf88b43e63ed2d22bb85ed1f7a8cfb37b602c9310dd189923265ca', '[\"*\"]', '2026-05-10 00:00:23', NULL, '2026-05-09 23:56:59', '2026-05-10 00:00:23'),
(122, 'App\\Models\\Usuario', 15, 'auth_token', 'f07f664e981cb27020361f421e8c913d4672c76dde595555ad693cfb9e5bd054', '[\"*\"]', '2026-05-10 00:02:14', NULL, '2026-05-10 00:00:35', '2026-05-10 00:02:14'),
(123, 'App\\Models\\Usuario', 2, 'auth_token', '6e0aee68ff1d788056290eb4636b4d0d861fd64c124035911ee5ad31bdb2e209', '[\"*\"]', '2026-05-10 00:02:58', NULL, '2026-05-10 00:02:38', '2026-05-10 00:02:58'),
(124, 'App\\Models\\Usuario', 15, 'auth_token', 'e0c53210333e238f729a5f4ae58218f2dbac41ab9ebb49f7cda384d9098143d7', '[\"*\"]', '2026-05-10 00:09:57', NULL, '2026-05-10 00:03:08', '2026-05-10 00:09:57'),
(125, 'App\\Models\\Usuario', 2, 'auth_token', 'e9805f699f8d2a56895e1d09d6ecebea5085258f66dda4db17b53fba9007d72e', '[\"*\"]', '2026-05-10 00:10:42', NULL, '2026-05-10 00:10:13', '2026-05-10 00:10:42'),
(126, 'App\\Models\\Usuario', 15, 'auth_token', '059a654563f57212ba88f7dc04acb7bb54e360cd5b78dcca82740c02eb526a69', '[\"*\"]', '2026-05-10 00:15:48', NULL, '2026-05-10 00:10:56', '2026-05-10 00:15:48'),
(127, 'App\\Models\\Usuario', 2, 'auth_token', 'e2e540b7e65dc68522deae1916942184e9a619267a4a56b78977bfb2432d96a3', '[\"*\"]', '2026-05-10 00:23:32', NULL, '2026-05-10 00:23:26', '2026-05-10 00:23:32'),
(128, 'App\\Models\\Usuario', 15, 'auth_token', 'fa0ebfaa30a1cfdf62c0c3ac2b4bc13df0c2798c89cd241c2648cd1d68acafd4', '[\"*\"]', '2026-05-10 00:33:43', NULL, '2026-05-10 00:23:50', '2026-05-10 00:33:43'),
(129, 'App\\Models\\Usuario', 2, 'auth_token', '4a8bddc744563ff996d00d7e9699d801c6d49ef5af2a5ed80b00f38f54203b7d', '[\"*\"]', '2026-05-10 00:34:33', NULL, '2026-05-10 00:34:04', '2026-05-10 00:34:33'),
(130, 'App\\Models\\Usuario', 15, 'auth_token', 'bab46e717f1f56d1a22480a416bbb9362ffc416d31e2b9b41d382cbc232da281', '[\"*\"]', '2026-05-10 00:45:45', NULL, '2026-05-10 00:34:51', '2026-05-10 00:45:45'),
(131, 'App\\Models\\Usuario', 15, 'auth_token', 'a6a237862e5f9fbf95671b87a2b4641cca07d9e4e8471a1f54f534b50f0f899e', '[\"*\"]', '2026-05-10 00:52:59', NULL, '2026-05-10 00:46:12', '2026-05-10 00:52:59'),
(132, 'App\\Models\\Usuario', 2, 'auth_token', '3260e8eeb87f54f5a75a715c9d29c62d46974b6392b79cc470adfa5ef01196b2', '[\"*\"]', '2026-05-10 00:54:05', NULL, '2026-05-10 00:53:17', '2026-05-10 00:54:05'),
(133, 'App\\Models\\Usuario', 15, 'auth_token', '061fbf431babd0108f196b8af0df90b43b9c3a4bec9f74e115266e9c098911ca', '[\"*\"]', '2026-05-10 01:05:36', NULL, '2026-05-10 00:54:27', '2026-05-10 01:05:36'),
(134, 'App\\Models\\Usuario', 2, 'auth_token', '366a387ece465c066506e2ce240f1f39e97263fd459a6fe7af59e9aad25b8695', '[\"*\"]', '2026-05-10 01:08:25', NULL, '2026-05-10 01:05:48', '2026-05-10 01:08:25'),
(135, 'App\\Models\\Usuario', 2, 'auth_token', 'a95ae0b662b6e3a002e4ae6ac85c1ff48fd97e6e49a7ccd679ba4ad5bcf61227', '[\"*\"]', '2026-05-10 01:10:50', NULL, '2026-05-10 01:08:37', '2026-05-10 01:10:50'),
(136, 'App\\Models\\Usuario', 2, 'auth_token', 'a2bb1d8bd49768c36ccb94388eaaed3c459e624b49bcd756a527cd8129143ac3', '[\"*\"]', '2026-05-10 01:22:47', NULL, '2026-05-10 01:12:27', '2026-05-10 01:22:47'),
(137, 'App\\Models\\Usuario', 15, 'auth_token', '9af195628b7c625c912fc0f70e8179afab2cbdd9b7dd30d63e5ee649669156d4', '[\"*\"]', '2026-05-10 05:41:00', NULL, '2026-05-10 05:40:42', '2026-05-10 05:41:00'),
(138, 'App\\Models\\Usuario', 15, 'auth_token', 'a6f14e0c759cb668e34415920e00a7191a9fe6e19b1dcab956c77d91c8bc09a1', '[\"*\"]', '2026-05-10 07:05:24', NULL, '2026-05-10 07:05:22', '2026-05-10 07:05:24'),
(139, 'App\\Models\\Usuario', 15, 'auth_token', '1694491957d086795e6b846fb92306cc8c10cc02a9f01f03a40c7281ccab9688', '[\"*\"]', '2026-05-10 07:12:22', NULL, '2026-05-10 07:06:30', '2026-05-10 07:12:22'),
(140, 'App\\Models\\Usuario', 15, 'auth_token', 'b0576a6d31e348f6437b796541c5bd6feb47ab4afdc6ed722aac7964ffa9640b', '[\"*\"]', '2026-05-10 07:23:40', NULL, '2026-05-10 07:10:54', '2026-05-10 07:23:40'),
(141, 'App\\Models\\Usuario', 15, 'auth_token', 'a0c3d9c109e67b13258102bd3e1d31bd1d6bc573429b9b7120c47edbca2efdda', '[\"*\"]', '2026-05-10 07:18:26', NULL, '2026-05-10 07:12:43', '2026-05-10 07:18:26'),
(142, 'App\\Models\\Usuario', 15, 'auth_token', '83638e2ffaf576b92b08baaf11f3997dd5fd8db1926e7b883898d2dff1803030', '[\"*\"]', '2026-05-10 07:29:32', NULL, '2026-05-10 07:22:07', '2026-05-10 07:29:32'),
(143, 'App\\Models\\Usuario', 15, 'auth_token', 'aa0bc97af81d48d93a26f4381cfada2d379f618762e2de538b646b03258456e7', '[\"*\"]', '2026-05-10 07:30:16', NULL, '2026-05-10 07:29:45', '2026-05-10 07:30:16'),
(144, 'App\\Models\\Usuario', 15, 'auth_token', '387deb34727d11f7fba5dc3636eae5cf6f278a121fd5840bf6bf21713fa562af', '[\"*\"]', '2026-05-10 07:37:58', NULL, '2026-05-10 07:31:23', '2026-05-10 07:37:58'),
(145, 'App\\Models\\Usuario', 2, 'auth_token', '7ec218981bb04aa471faef546666410cc04c1e5312d2872185a7121692754398', '[\"*\"]', '2026-05-10 07:37:54', NULL, '2026-05-10 07:37:39', '2026-05-10 07:37:54'),
(146, 'App\\Models\\Usuario', 15, 'auth_token', 'b16584a43bfcaca528423a1e21ed77233a420a0210c2e66c7b2e5562dcfc33a8', '[\"*\"]', '2026-05-10 07:38:11', NULL, '2026-05-10 07:38:09', '2026-05-10 07:38:11'),
(147, 'App\\Models\\Usuario', 1, 'auth_token', '33a2014b5b405e557cf7a0ba752ed089d0ac554c52a3edb5e8f1186c26fd4574', '[\"*\"]', '2026-05-10 07:38:31', NULL, '2026-05-10 07:38:20', '2026-05-10 07:38:31'),
(148, 'App\\Models\\Usuario', 15, 'auth_token', '925141f395df9b90571e588e0d32caabb7ac3899057fdc48cc0b3098e55e9fa2', '[\"*\"]', '2026-05-10 07:53:47', NULL, '2026-05-10 07:39:20', '2026-05-10 07:53:47'),
(149, 'App\\Models\\Usuario', 3, 'auth_token', 'f4ad18cc65dbfdb017f68561a727f6d823fe7b64f6cd170e41d93ae19340e5d2', '[\"*\"]', '2026-05-10 08:58:57', NULL, '2026-05-10 07:43:49', '2026-05-10 08:58:57'),
(150, 'App\\Models\\Usuario', 15, 'auth_token', 'ea33032cb1841a9dc886b0232b8cc17e16282c8136ba21188eb2c14d15ce6b7a', '[\"*\"]', '2026-05-10 08:04:32', NULL, '2026-05-10 07:54:02', '2026-05-10 08:04:32'),
(151, 'App\\Models\\Usuario', 15, 'auth_token', 'e6d6f032f45c980e4b8e3912c877fe52e466ce1c374d69acd8dd8ab9e6f768b7', '[\"*\"]', '2026-05-10 08:13:20', NULL, '2026-05-10 08:06:37', '2026-05-10 08:13:20'),
(152, 'App\\Models\\Usuario', 15, 'auth_token', '98aa92ecd53badf03fc156db2bb087945a4047d3b627fce6904ebf7555266c6f', '[\"*\"]', '2026-05-10 08:13:46', NULL, '2026-05-10 08:13:44', '2026-05-10 08:13:46'),
(153, 'App\\Models\\Usuario', 15, 'auth_token', '17f35dbc66deaab4af5f849d2db278eda9c8571815d28cafb738e0d9b2834b70', '[\"*\"]', '2026-05-10 08:37:22', NULL, '2026-05-10 08:17:32', '2026-05-10 08:37:22'),
(154, 'App\\Models\\Usuario', 15, 'auth_token', '7594a37c8bb67e6060c2da507ca8a21a59859fe1f2fb46bb53011473fe15ca1e', '[\"*\"]', '2026-05-10 09:02:24', NULL, '2026-05-10 08:43:52', '2026-05-10 09:02:24'),
(155, 'App\\Models\\Usuario', 15, 'auth_token', '13fdf9a0b86a32a9b31617107f2ece7ab823e61f6536bf63e4f89b9f06052d80', '[\"*\"]', '2026-05-10 08:59:34', NULL, '2026-05-10 08:59:10', '2026-05-10 08:59:34'),
(156, 'App\\Models\\Usuario', 15, 'auth_token', 'b3c879e5ac5e19e4041428cd2c0f0743de3ec865d8e507735fe9fc6ce278667b', '[\"*\"]', '2026-05-10 09:01:01', NULL, '2026-05-10 09:00:56', '2026-05-10 09:01:01'),
(157, 'App\\Models\\Usuario', 15, 'auth_token', 'b0917bcf8e62478c25cc479d7c2858b2a742642a9508bf8df14bcb2457b4b3ff', '[\"*\"]', '2026-05-10 09:02:40', NULL, '2026-05-10 09:02:38', '2026-05-10 09:02:40'),
(158, 'App\\Models\\Usuario', 15, 'auth_token', '0e1e4d0f109b2ac1d2a5af487ae78c161235269ca9fbaa4c880fe6cc2732de79', '[\"*\"]', '2026-05-12 11:02:00', NULL, '2026-05-12 10:46:42', '2026-05-12 11:02:00'),
(159, 'App\\Models\\Usuario', 15, 'auth_token', '9995349a15faaac5ff47dccb35bf8757d3cff8449799d853c083877977020114', '[\"*\"]', '2026-05-12 11:12:29', NULL, '2026-05-12 10:49:01', '2026-05-12 11:12:29'),
(160, 'App\\Models\\Usuario', 15, 'auth_token', '85cdc85c6d1994eb19e413437aad86ec805ece0b9d28c7ce5d754f3882828c04', '[\"*\"]', '2026-05-12 11:25:47', NULL, '2026-05-12 11:03:26', '2026-05-12 11:25:47'),
(161, 'App\\Models\\Usuario', 15, 'auth_token', 'c329d06407f382b45fde471e00ca4298444d3aa65cbb1e2cae0e99cd94c2576b', '[\"*\"]', '2026-05-12 12:00:21', NULL, '2026-05-12 11:26:43', '2026-05-12 12:00:21'),
(162, 'App\\Models\\Usuario', 2, 'auth_token', 'f00b36f081068cf45a536a46c347ac8673ca53f70ee1db8a09d419e9326c0769', '[\"*\"]', '2026-05-12 12:03:07', NULL, '2026-05-12 11:43:11', '2026-05-12 12:03:07'),
(163, 'App\\Models\\Usuario', 15, 'auth_token', '804eb227b9c3a168a1dcdea1a839f46a8504108e8676a95992c3432ba795428a', '[\"*\"]', '2026-05-12 12:16:53', NULL, '2026-05-12 12:01:47', '2026-05-12 12:16:53'),
(164, 'App\\Models\\Usuario', 15, 'auth_token', '03f72fed827eaa0f27d4aa8365847e93f1ccf34559a5ce582f435b4eb59f9fd1', '[\"*\"]', '2026-05-12 12:13:01', NULL, '2026-05-12 12:04:07', '2026-05-12 12:13:01'),
(165, 'App\\Models\\Usuario', 15, 'auth_token', 'a1965d48f172b0384e5f10a248e7919ff9ccaf4e78f39dfaa768b0043ad79c8c', '[\"*\"]', '2026-05-12 12:52:54', NULL, '2026-05-12 12:13:20', '2026-05-12 12:52:54'),
(166, 'App\\Models\\Usuario', 15, 'auth_token', '64e61566a156c329c5776f83c179b1af13a1c6905932d254f342dccc3c1ac179', '[\"*\"]', '2026-05-12 12:23:48', NULL, '2026-05-12 12:17:08', '2026-05-12 12:23:48'),
(167, 'App\\Models\\Usuario', 15, 'auth_token', 'dd5768009521fc9b32a0bc3b27e1f9d6895d4ca94c00a6eda2b60c58461471ee', '[\"*\"]', '2026-05-12 13:03:40', NULL, '2026-05-12 12:30:29', '2026-05-12 13:03:40'),
(168, 'App\\Models\\Usuario', 15, 'auth_token', 'f0e77d83217b6362104741acd2d3d81a923bf8714bdb94f6ac37cccfe0e128c6', '[\"*\"]', '2026-05-12 13:12:03', NULL, '2026-05-12 12:53:10', '2026-05-12 13:12:03'),
(169, 'App\\Models\\Usuario', 15, 'auth_token', '6e85c86cbe593a1dacd29cfee15ea707bac86e7010373d91ac199dbf77c5fead', '[\"*\"]', '2026-05-12 13:28:54', NULL, '2026-05-12 13:09:16', '2026-05-12 13:28:54'),
(170, 'App\\Models\\Usuario', 2, 'auth_token', 'f605c55504e8b47cab7cbe9e74c38262dcbf015d9f7acc61c0dd1f3b01b4aea4', '[\"*\"]', '2026-05-12 13:49:14', NULL, '2026-05-12 13:12:17', '2026-05-12 13:49:14'),
(171, 'App\\Models\\Usuario', 15, 'auth_token', '62c6d7f27779504bd3a1c91bed8bb77df702d5f4f19e8cdc00b3e7d62fb289d0', '[\"*\"]', '2026-05-12 13:29:39', NULL, '2026-05-12 13:29:20', '2026-05-12 13:29:39'),
(172, 'App\\Models\\Usuario', 15, 'auth_token', 'eb71615b21a9b13e0c0f773e6e7f17f26f91e6c23dae42265a5b819ee9f23663', '[\"*\"]', '2026-05-12 13:31:43', NULL, '2026-05-12 13:29:45', '2026-05-12 13:31:43'),
(173, 'App\\Models\\Usuario', 15, 'auth_token', '2d8d81d1c8957ffbad708e01ce6d5d8972eb0fc29633d432af1cf8e429af8634', '[\"*\"]', '2026-05-12 13:35:23', NULL, '2026-05-12 13:31:57', '2026-05-12 13:35:23'),
(174, 'App\\Models\\Usuario', 15, 'auth_token', '374f8b8c6f02c90dcfd9b6566d3647a980a7672dc05a3d3b455c8b2c803edcac', '[\"*\"]', '2026-05-12 13:36:54', NULL, '2026-05-12 13:35:40', '2026-05-12 13:36:54'),
(175, 'App\\Models\\Usuario', 15, 'auth_token', '338eab9b1bacce74a4b3082aefc8e394ebc3e1dd41aa99ca478976c4e5e0b551', '[\"*\"]', '2026-05-12 13:43:11', NULL, '2026-05-12 13:37:04', '2026-05-12 13:43:11'),
(176, 'App\\Models\\Usuario', 15, 'auth_token', 'e67738f06f5a658a7b391bf56dbadf9829478768dd0f610e1ae179ec3ed1062e', '[\"*\"]', '2026-05-12 13:49:07', NULL, '2026-05-12 13:43:43', '2026-05-12 13:49:07'),
(177, 'App\\Models\\Usuario', 15, 'auth_token', '0e4d779810ade00a18b39dbd5208d4e580e1b9553986f423f6217b775f510a7d', '[\"*\"]', '2026-05-12 13:56:02', NULL, '2026-05-12 13:51:29', '2026-05-12 13:56:02'),
(178, 'App\\Models\\Usuario', 15, 'auth_token', 'b0bf21c3759a8469b59ad0c6f9311efd48587665690f8ad770ddb6b5096b65b6', '[\"*\"]', '2026-05-12 14:07:05', NULL, '2026-05-12 13:56:12', '2026-05-12 14:07:05'),
(179, 'App\\Models\\Usuario', 15, 'auth_token', '340249123eeac677424e5ebb2464d2027076afffb457b29412958f7d42cd1480', '[\"*\"]', '2026-05-13 11:06:03', NULL, '2026-05-13 11:04:56', '2026-05-13 11:06:03'),
(180, 'App\\Models\\Usuario', 15, 'auth_token', 'bcdbfe0b7530a5d69af18ec9c5e9e746e25c633373807d96a82afee0a3238ef1', '[\"*\"]', '2026-05-13 11:20:00', NULL, '2026-05-13 11:14:58', '2026-05-13 11:20:00'),
(181, 'App\\Models\\Usuario', 15, 'auth_token', '5e2a989cb521f9d1407a741eb124fb90625af05fb8d11e1dacfc73dae375e69e', '[\"*\"]', '2026-05-13 11:23:06', NULL, '2026-05-13 11:20:26', '2026-05-13 11:23:06'),
(182, 'App\\Models\\Usuario', 2, 'auth_token', '827dba5400c33c75baa0205e91ea6b1b99dfc084b769822559b3727833d2c245', '[\"*\"]', '2026-05-13 13:05:33', NULL, '2026-05-13 11:23:19', '2026-05-13 13:05:33'),
(183, 'App\\Models\\Usuario', 15, 'auth_token', '3f7ef74f7c80fa85b0a863c1009c5b058702971dc7bdeb87a0b539c29a1ca12b', '[\"*\"]', '2026-05-13 11:39:33', NULL, '2026-05-13 11:24:35', '2026-05-13 11:39:33'),
(184, 'App\\Models\\Usuario', 15, 'auth_token', '44d9ac49c5543e89f3d2dfb49513108321a6ed8798ce987738c85bdd1a78f04e', '[\"*\"]', '2026-05-13 11:44:04', NULL, '2026-05-13 11:39:38', '2026-05-13 11:44:04'),
(185, 'App\\Models\\Usuario', 15, 'auth_token', '432dfcba6dbcfbcdbc79407be4bfaaf47f03facf87732b06ade9e6477c4b649a', '[\"*\"]', '2026-05-13 11:46:37', NULL, '2026-05-13 11:44:54', '2026-05-13 11:46:37'),
(186, 'App\\Models\\Usuario', 15, 'auth_token', '83888479455fc0e4c3a45502be0ff4c1b77eee903a3f7f6f87b327aacc85f848', '[\"*\"]', '2026-05-13 11:50:26', NULL, '2026-05-13 11:47:46', '2026-05-13 11:50:26'),
(187, 'App\\Models\\Usuario', 15, 'auth_token', '6e13d1227bc0fd54d1f7f01ef587082569222765711f28b9762b7a8a5d473034', '[\"*\"]', '2026-05-13 11:55:42', NULL, '2026-05-13 11:51:25', '2026-05-13 11:55:42'),
(188, 'App\\Models\\Usuario', 15, 'auth_token', 'ca5bf0e8e675bf75a5fc839cc01ea75cd816c207474dda7e9c0bdcda96fdbdac', '[\"*\"]', '2026-05-13 12:24:06', NULL, '2026-05-13 12:23:23', '2026-05-13 12:24:06'),
(189, 'App\\Models\\Usuario', 15, 'auth_token', '131ce13762c7a9c620ccf475053a0112aa35579887bedbd277ce9c8cc60bf7bb', '[\"*\"]', '2026-05-13 12:34:02', NULL, '2026-05-13 12:27:29', '2026-05-13 12:34:02'),
(190, 'App\\Models\\Usuario', 15, 'auth_token', 'a70277c24b9ae01bc4cb21b1d620b26dd6d485d07435b2522e7bf149c5c51d6d', '[\"*\"]', '2026-05-13 12:52:29', NULL, '2026-05-13 12:34:09', '2026-05-13 12:52:29'),
(191, 'App\\Models\\Usuario', 15, 'auth_token', '3599d2aa9527561f66aae0ddab62eecdea40178d02824046bf31dddeff450b48', '[\"*\"]', '2026-05-13 13:04:30', NULL, '2026-05-13 12:52:51', '2026-05-13 13:04:30'),
(192, 'App\\Models\\Usuario', 15, 'auth_token', 'c95980772b14d3218ab5e68f4d12cdd740bd4b568a3f7879120690f7007a6d55', '[\"*\"]', '2026-05-14 02:30:21', NULL, '2026-05-14 02:29:33', '2026-05-14 02:30:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID_producto` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'pendiente',
  `ID_categoria` int DEFAULT NULL,
  `ID_tienda` int NOT NULL,
  `visible` tinyint(1) DEFAULT '1',
  `disponible` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`ID_producto`, `nombre`, `marca`, `descripcion`, `precio`, `imagen`, `estado`, `ID_categoria`, `ID_tienda`, `visible`, `disponible`) VALUES
(1, 'Hamburgueza', NULL, 'Disfruta de unas ricas hamburguezas...', 35.00, '1777761386_hamburgueza1.jpg', 'aprobado', 2, 1, 1, 1),
(2, 'Coca', 'Coca-cola', 'rica bebida', 25.00, '1777761282_coca.jpg', 'aprobado', 1, 1, 1, 1),
(3, 'Aguas de sabor', NULL, 'ricas aguas de sabor', 15.00, '1777765959_aguas.png', 'aprobado', 1, 1, 1, 1),
(4, 'frutas', NULL, 'deli frutas', 35.00, '1777768061_coctel de frutas.jpg', 'aprobado', 4, 1, 1, 1),
(5, 'coffee', 'make', 'para tus mañanas', 19.00, '1777768772.jpeg', 'aprobado', 1, 1, 1, 1),
(6, 'Tamal', NULL, 'un tamal para tu mejor desayuno', 25.00, '1777774783.jpg', 'aprobado', 2, 2, 1, 1),
(7, 'tortas', NULL, 'mas tortas y mas', 35.00, '1777856883.jpg', 'aprobado', 2, 1, 1, 1),
(8, 'Tacos al Pastor', NULL, 'Disfrut de unos ricos tacos al pastor', 35.00, '1777877982.jpg', 'pendiente', 2, 2, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `ID_rol` int NOT NULL,
  `rol` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`ID_rol`, `rol`, `descripcion`) VALUES
(1, 'Administrador', 'Control total del sistema'),
(2, 'Vendedor', 'Gestiona productos, precios y pedidos'),
(3, 'Cliente', 'Puede realizar pedidos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('GCa3a95MtUwVBEkMar8vLpgKpVaIuIjgD7bNvMQG', NULL, '192.168.0.5', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', 'eyJfdG9rZW4iOiJwWHp1RlRNS28wOG5VNzBRckFXVmFWT2FQaTlQeVd0ZlRrN0FMWGNOIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzE5Mi4xNjguMC44OjgwMDAiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1778021378),
('gFwHXVN3IFNZ0x56bPWYoF236ymvpcOMn9tCGS5H', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJtd2lzaDVPa05PN3lQdHZhbFIzNDZtT3VmYnlkdm8xZHZOVGVFVUxmIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL3NhYm9yeXRlY2FwaS50ZXN0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777706917),
('hbKLp151HBrvfFKNYao2k1v3aXQhvCXaAZrEt2Eb', NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) EdgiOS/147.0.3912.87 Version/26.0 Mobile/15E148 Safari/604.1', 'eyJfdG9rZW4iOiJIVXh1bkFiaU9KWTZPNHBPY2R6NEVXZU1IdkJBeFN5c1VPdkhLUmN2IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2VsZXZhdGlvbi1jYXJuaXZvcmUtcGFub3JhbWljLm5ncm9rLWZyZWUuZGV2Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778022581),
('hEpQrPo54Ec8gAigWOYDvNTd8h6v90BPnM5D1zOU', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI4a1RWdDc1bVJ1aEthbGNpdmdtNXowWG9TRHlYVjczTHBNMFFDd1piIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778022284),
('huRyYqAjaWowNCxOLePA6H1eAxnJ0cjyxTeMDl55', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJuUk54cHhDdmFuTTVtenJPY092VTU0bW9HN0dFc204RVIxVnBPenNoIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL3NhYm9yeXRlY2FwaS50ZXN0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777760319),
('jhyMGn1ypOhbi9OcJHPpJ4rjDCsrtJrNA8Q230Xy', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ4Z0VxaTgyWFl1MmFUUkd0Q3pKcEpuV0pmYTlzNW15U0FVRGNsbmtLIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL3NhYm9yeXRlY2FwaS50ZXN0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777850073),
('NOTY9iTt3IjZb8W3gzAcfdDOHGhnD3dPQp86Y0Ue', NULL, '127.0.0.1', 'Thunder Client (https://www.thunderclient.com)', 'eyJfdG9rZW4iOiIxUm93aHVaUHBSSmlaY3RvWkhqclUzU3BSOUxhRll4dWdsd2ZTUnhnIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL3NhYm9yeXRlY2FwaS50ZXN0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777678792),
('OikiuoD5HDCCaLCHrVJthwcQzkCuzXmcpbfGJRK0', NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) EdgiOS/147.0.3912.87 Version/26.0 Mobile/15E148 Safari/604.1', 'eyJfdG9rZW4iOiJYd0dEemFRcTJxdjRqRGQzOFpwcDYxTlVQOXNOOEJZSXl2VlBtUVNwIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2VsZXZhdGlvbi1jYXJuaXZvcmUtcGFub3JhbWljLm5ncm9rLWZyZWUuZGV2Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778022581),
('PbMzuDp5pE3LjuIRobLPbIsX4QZVqE0xlWN0pds7', NULL, '192.168.0.5', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1', 'eyJfdG9rZW4iOiJWNGpHc2o1bU10VFlhTVpZcjZjbzZwc1NkUlVac0pZMVBFREU2NFBxIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzE5Mi4xNjguMC44OjgwMDAiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777967319),
('pIYZRxdHjDz6tIwL5yfk57ZOgly3qr0AlhVCS8Fb', NULL, '192.168.0.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJjYUx2T3BPT0FnTWFka21WeHpiblNTbVFUYlVQQlcySGx4TWs3djRXIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzE5Mi4xNjguMC44OjgwMDAiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1777956107),
('RCir6QpCZvnSpx0ww1leaikHyb0Saw4jf48i8a3m', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI5RWZkVmo5bTVSaDJROVljYzhBT1RaVWZGNFFsOUVmbjRwOGFqSG9OIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL3NhYm9yeXRlY2FwaS50ZXN0Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1777678771),
('WisqV9f2HcQzoklPqXzKQ0B58GEgtvyZoc6G7Kvj', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJjSUV1cmxPQlJxY3dEd3U2RFl5N08ydzNqdHQzUnI3WHZpbThWRzlmIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2VsZXZhdGlvbi1jYXJuaXZvcmUtcGFub3JhbWljLm5ncm9rLWZyZWUuZGV2Iiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1778022321);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiendas`
--

CREATE TABLE `tiendas` (
  `ID_tienda` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(600) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `ID_usuario_vendedor` int DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '1',
  `facebook` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(20) DEFAULT NULL,
  `tiktok` varchar(255) DEFAULT NULL,
  `portada` varchar(255) DEFAULT NULL,
  `clabe` varchar(18) DEFAULT NULL,
  `banco` varchar(100) DEFAULT NULL,
  `titular_cuenta` varchar(100) DEFAULT NULL,
  `aprobacion` enum('pendiente','aprobada','rechazada') NOT NULL DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tiendas`
--

INSERT INTO `tiendas` (`ID_tienda`, `nombre`, `descripcion`, `logo`, `estado`, `ID_usuario_vendedor`, `visible`, `facebook`, `instagram`, `whatsapp`, `tiktok`, `portada`, `clabe`, `banco`, `titular_cuenta`, `aprobacion`) VALUES
(1, 'Cafeteria_ITSSMT', 'Los mejores productos dentro del campus universitario..', 'logos/nzzjeal9XxrSEO1kmofHpZ3MaPuAaG8i2erNPD91.jpg', 'activo', 2, 1, 'https://www.facebook.com/AxoFredRP', 'https://www.instagram.com/axofred/', '2345677899', 'https://www.tiktok.com/@axofredgg', 'portadas/vXw8AbxPsrIKcaQ89eu0MonZ93YHkRLpxhPnOvWk.jpg', '123456789012345678', 'BBVA', 'Yadira Flores Perez', 'aprobada'),
(2, 'Desayunos_tec', 'los mejores desayunos dentro del campus...', 'logos/WCSk9RSqIvQCU2XHg6rEZPVrn3k7uAGEkTGYuu3V.jpg', 'activo', 4, 1, '@vianney/fb', '@vianney/insta', '55 2719 8453', '@vianney/tt', 'portadas/0zcPrnMngJavkt36OPY9ppETR2ZlviFDwPWuLDct.jpg', '014785236901457823', 'Banorte', 'vianney', 'aprobada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID_usuario` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `Apaterno` varchar(100) NOT NULL,
  `Amaterno` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_rol` int NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID_usuario`, `nombre`, `Apaterno`, `Amaterno`, `correo`, `password`, `telefono`, `estado`, `fecha_registro`, `ID_rol`, `visible`) VALUES
(1, 'Damián', 'Huerta', 'García', 'administrador@smartin.tecnm.mx', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2462449030', 'activo', '2026-05-01 23:11:21', 1, 1),
(2, 'Yadira', 'Flores', 'Perez', 'yadira@gmail.com', '$2y$12$tXKqkWslkL2onsklpnuQHOPM0I7UkYbKkogvUgm14NfeBeXTe7x.e', '2481701307', 'activo', '2026-05-02 00:44:04', 2, 1),
(3, 'Itzel', 'Mendez', 'Perez', 'itzel@smartin.tecnm.mx', '$2y$12$c8YBcFU8sDf.L2Gw6iJay.jrsF74LSb6F3vSQIwOV4zXJy3UwXuMe', '5512345672', 'activo', '2026-05-02 02:20:17', 3, 1),
(4, 'Vianney', 'Morales', 'Zamora', 'vianney@smartin.tecnm.mx', '$2y$12$LJ3KWmLCmqREq3g57YCoOe0WU.F.K3/qpsjwo11JnqR1hJ.W/qOja', '2481701304', 'activo', '2026-05-02 02:21:30', 2, 1),
(14, 'Fredy', 'Cano', 'Lopez', 'axofred@gmail.com', '$2y$12$aHfhRYl.6nKnMEbLxK6eSODxX0QNE8CKiNTlf..MxF5ArR/fuvsYi', '2481701307', 'activo', '2026-05-02 02:44:48', 1, 1),
(15, 'Miguel', 'Mendez', 'Reyes', 'miguel@smartin.tecnm.mx', '$2y$12$OjpXCKh6qJdNkOyy7ChlDuFV62Fhv7ITAm10qabCsxnc/B/GxpXIG', '5512345672', 'activo', '2026-05-04 00:38:40', 3, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`ID_calificacion`),
  ADD KEY `ID_pedido` (`ID_pedido`),
  ADD KEY `ID_tienda` (`ID_tienda`),
  ADD KEY `ID_usuario` (`ID_usuario`);

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`ID_carrito`),
  ADD KEY `ID_usuario` (`ID_usuario`),
  ADD KEY `ID_producto` (`ID_producto`),
  ADD KEY `ID_tienda` (`ID_tienda`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`ID_categoria`);

--
-- Indices de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD PRIMARY KEY (`ID_detalle`),
  ADD KEY `fk_pedido_detalle` (`ID_pedido`),
  ADD KEY `fk_producto_detalle` (`ID_producto`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`ID_horario`),
  ADD UNIQUE KEY `uniq_tienda_dia_semana` (`ID_tienda`,`dia_semana`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mensajes_pedido`
--
ALTER TABLE `mensajes_pedido`
  ADD PRIMARY KEY (`ID_mensaje`),
  ADD KEY `mensajes_pedido_id_pedido_foreign` (`ID_pedido`),
  ADD KEY `mensajes_pedido_id_usuario_foreign` (`ID_usuario`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`ID_pedido`),
  ADD KEY `fk_usuario_pedido` (`ID_usuario`),
  ADD KEY `fk_tienda_pedido` (`ID_tienda`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`ID_producto`),
  ADD KEY `ID_categoria` (`ID_categoria`),
  ADD KEY `ID_tienda` (`ID_tienda`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`ID_rol`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `tiendas`
--
ALTER TABLE `tiendas`
  ADD PRIMARY KEY (`ID_tienda`),
  ADD KEY `ID_usuario_vendedor` (`ID_usuario_vendedor`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `ID_rol` (`ID_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `ID_calificacion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `ID_carrito` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `ID_categoria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `ID_detalle` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `ID_horario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes_pedido`
--
ALTER TABLE `mensajes_pedido`
  MODIFY `ID_mensaje` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `ID_pedido` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `ID_producto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `ID_rol` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tiendas`
--
ALTER TABLE `tiendas`
  MODIFY `ID_tienda` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID_usuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`ID_pedido`) REFERENCES `pedidos` (`ID_pedido`),
  ADD CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`ID_tienda`) REFERENCES `tiendas` (`ID_tienda`),
  ADD CONSTRAINT `calificaciones_ibfk_3` FOREIGN KEY (`ID_usuario`) REFERENCES `usuarios` (`ID_usuario`);

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`ID_usuario`) REFERENCES `usuarios` (`ID_usuario`),
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`),
  ADD CONSTRAINT `carrito_ibfk_3` FOREIGN KEY (`ID_tienda`) REFERENCES `tiendas` (`ID_tienda`);

--
-- Filtros para la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD CONSTRAINT `fk_pedido_detalle` FOREIGN KEY (`ID_pedido`) REFERENCES `pedidos` (`ID_pedido`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_producto_detalle` FOREIGN KEY (`ID_producto`) REFERENCES `productos` (`ID_producto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `fk_horarios_tienda` FOREIGN KEY (`ID_tienda`) REFERENCES `tiendas` (`ID_tienda`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensajes_pedido`
--
ALTER TABLE `mensajes_pedido`
  ADD CONSTRAINT `mensajes_pedido_id_pedido_foreign` FOREIGN KEY (`ID_pedido`) REFERENCES `pedidos` (`ID_pedido`) ON DELETE CASCADE,
  ADD CONSTRAINT `mensajes_pedido_id_usuario_foreign` FOREIGN KEY (`ID_usuario`) REFERENCES `usuarios` (`ID_usuario`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `fk_tienda_pedido` FOREIGN KEY (`ID_tienda`) REFERENCES `tiendas` (`ID_tienda`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_usuario_pedido` FOREIGN KEY (`ID_usuario`) REFERENCES `usuarios` (`ID_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`ID_categoria`) REFERENCES `categorias` (`ID_categoria`),
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`ID_tienda`) REFERENCES `tiendas` (`ID_tienda`);

--
-- Filtros para la tabla `tiendas`
--
ALTER TABLE `tiendas`
  ADD CONSTRAINT `tiendas_ibfk_3` FOREIGN KEY (`ID_usuario_vendedor`) REFERENCES `usuarios` (`ID_usuario`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`ID_rol`) REFERENCES `roles` (`ID_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
