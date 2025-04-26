
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE TABLE `alertas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `nivel` enum('Bajo','Medio','Alto') NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `alertas` (`id`, `usuario_id`, `mensaje`, `nivel`, `fecha`) VALUES
(2, 2, 'El dispositivo 2 tiene un aumento de consumo', 'Medio', '2025-03-18 22:32:34'),
(3, 3, 'El dispositivo 3 tiene un fallo de corriente', 'Alto', '2025-03-18 22:32:34'),
(4, 4, 'El dispositivo 4 está en modo ahorro', 'Bajo', '2025-03-18 22:32:34'),
(5, 5, 'El dispositivo 5 se encuentra en mantenimiento', 'Medio', '2025-03-18 22:32:34');

CREATE TABLE `configuracion_ahorro` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `limite_consumo` decimal(6,2) NOT NULL,
  `modo_ahorro` enum('Bajo','Medio','Alto') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `configuracion_ahorro` (`id`, `usuario_id`, `limite_consumo`, `modo_ahorro`) VALUES
(2, 2, 400.00, 'Medio'),
(3, 3, 350.00, 'Bajo'),
(4, 4, 450.00, 'Alto'),
(5, 5, 300.00, 'Medio');

CREATE TABLE `dispositivos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `id_grupo` int(11) DEFAULT NULL,
  `id_sensor` int(11) DEFAULT NULL,
  `id_tipo_dispositivo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dispositivos_agrupados` (
  `id` int(11) NOT NULL,
  `grupo_id` int(11) NOT NULL,
  `dispositivo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `grupos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `mediciones` (
  `id` int(11) NOT NULL,
  `sensor_id` int(11) NOT NULL,
  `voltaje` decimal(5,2) DEFAULT NULL,
  `corriente` decimal(5,2) DEFAULT NULL,
  `potencia` decimal(6,2) DEFAULT NULL,
  `factor_potencia` decimal(4,2) DEFAULT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp(),
  `frecuencia` decimal(8,2) DEFAULT NULL,
  `energia` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tarifas` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `proveedores` (`id`, `nombre`, `tarifas`) VALUES
(1, 'CFE', 3.50);

CREATE TABLE `recuperacion_passwords` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `fecha_expiracion` datetime NOT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `reportes` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo_reporte` enum('Diario','Semanal','Mensual') DEFAULT NULL,
  `fecha_generacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `datos` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `reportes` (`id`, `usuario_id`, `tipo_reporte`, `fecha_generacion`, `datos`) VALUES
(2, 2, 'Semanal', '2025-03-18 22:32:42', 0x5265706f72746520646520636f6e73756d6f2073656d616e616c),
(3, 3, 'Mensual', '2025-03-18 22:32:42', 0x5265706f72746520646520636f6e73756d6f206d656e7375616c),
(4, 4, 'Diario', '2025-03-18 22:32:42', 0x5265706f72746520646520636f6e73756d6f2064656c2064c3ad61),
(5, 5, 'Semanal', '2025-03-18 22:32:42', 0x5265706f72746520646520636f6e73756d6f2073656d616e616c);

CREATE TABLE `sensores` (
  `id` int(11) NOT NULL,
  `dispositivo_id` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `mac_address` varchar(50) NOT NULL,
  `fecha_instalacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `contraseña`, `id_proveedor`, `fecha_registro`) VALUES
(1, 'julio', 'admin@uv.mx', '$2b$08$R9b7P530IzB1vaL38xH04u6txDBNfGSMDMYwIHt.ooESXN1/nJy.y', NULL, '2025-03-27 05:21:15'),
(2, 'Ana López', 'ana.lopez@email.com', 'contraseña123', 1, '2025-03-18 22:26:18'),
(3, 'Carlos Sánchez', 'carlos.sanchez@email.com', 'contraseña123', 1, '2025-03-18 22:26:18'),
(4, 'Laura Gómez', 'laura.gomez@email.com', 'contraseña123', 1, '2025-03-18 22:26:18'),
(5, 'Pedro Martínez', 'pedro.martinez@email.com', 'contraseña123', 1, '2025-03-18 22:26:18'),
(9, 'rolero', 'rolero@uv.mx', '$2b$08$E3rP370R6J2ukMqpcN08L.5wOypkCVpyzI0VWurcus/uZn9JoLVY.', 1, '2025-04-06 05:39:02'),
(10, 'Rolo admin12', 'prueba@admin', '$2b$08$Kfb0SPr7o/SoAasCdqdJ8.KNSPEWLKH6R10GVbLmr1Qn/3r3AuFnK', 1, '2025-04-13 00:00:10'),
(11, 'Rolerito', 'Rolerito@missher', '$2b$08$25CfcmSbc6npC.yx2vejnOXpbNFuAcedHW9Mu9dy/nK5q.LnYjMSK', 1, '2025-04-16 04:23:48'),
(13, 'Julio aldair', 'prueba@owo', '$2b$08$pwa4TzS99sw8.ZZYvl.rSOOzRBobSMScwCQy.lBkxnSaicIHeP3RK', 1, '2025-04-16 22:25:45');


CREATE TABLE `vista_ahorro_alertas` (
`usuario_id` int(11)
,`limite_consumo` decimal(6,2)
,`modo_ahorro` enum('Bajo','Medio','Alto')
,`mensaje` varchar(255)
,`nivel` enum('Bajo','Medio','Alto')
,`fecha` timestamp
);

DROP TABLE IF EXISTS `vista_ahorro_alertas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_ahorro_alertas`  AS SELECT `ca`.`usuario_id` AS `usuario_id`, `ca`.`limite_consumo` AS `limite_consumo`, `ca`.`modo_ahorro` AS `modo_ahorro`, `a`.`mensaje` AS `mensaje`, `a`.`nivel` AS `nivel`, `a`.`fecha` AS `fecha` FROM (`configuracion_ahorro` `ca` join `alertas` `a` on(`ca`.`usuario_id` = `a`.`usuario_id`)) ;


ALTER TABLE `alertas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `configuracion_ahorro`
--
ALTER TABLE `configuracion_ahorro`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `id_grupo` (`id_grupo`);

--
-- Indices de la tabla `dispositivos_agrupados`
--
ALTER TABLE `dispositivos_agrupados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `grupo_id` (`grupo_id`),
  ADD KEY `dispositivo_id` (`dispositivo_id`);

--
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_grupos_usuario` (`usuario_id`);

--
-- Indices de la tabla `mediciones`
--
ALTER TABLE `mediciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sensor_id` (`sensor_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recuperacion_passwords`
--
ALTER TABLE `recuperacion_passwords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_unique` (`token`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `sensores`
--
ALTER TABLE `sensores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mac_address` (`mac_address`),
  ADD KEY `dispositivo_id` (`dispositivo_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alertas`
--
ALTER TABLE `alertas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `configuracion_ahorro`
--
ALTER TABLE `configuracion_ahorro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `dispositivos_agrupados`
--
ALTER TABLE `dispositivos_agrupados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `mediciones`
--
ALTER TABLE `mediciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `recuperacion_passwords`
--
ALTER TABLE `recuperacion_passwords`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `sensores`
--
ALTER TABLE `sensores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alertas`
--
ALTER TABLE `alertas`
  ADD CONSTRAINT `alertas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `configuracion_ahorro`
--
ALTER TABLE `configuracion_ahorro`
  ADD CONSTRAINT `configuracion_ahorro_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD CONSTRAINT `dispositivos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `dispositivos_ibfk_2` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `dispositivos_agrupados`
--
ALTER TABLE `dispositivos_agrupados`
  ADD CONSTRAINT `dispositivos_agrupados_ibfk_1` FOREIGN KEY (`grupo_id`) REFERENCES `grupos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `dispositivos_agrupados_ibfk_2` FOREIGN KEY (`dispositivo_id`) REFERENCES `dispositivos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD CONSTRAINT `fk_grupos_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mediciones`
--
ALTER TABLE `mediciones`
  ADD CONSTRAINT `mediciones_ibfk_1` FOREIGN KEY (`sensor_id`) REFERENCES `sensores` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `recuperacion_passwords`
--
ALTER TABLE `recuperacion_passwords`
  ADD CONSTRAINT `recuperacion_passwords_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `sensores`
--
ALTER TABLE `sensores`
  ADD CONSTRAINT `sensores_ibfk_1` FOREIGN KEY (`dispositivo_id`) REFERENCES `dispositivos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
