-- Creamos la base de datos de la Gomeria

DROP SCHEMA IF EXISTS tienda_jt;

CREATE SCHEMA IF NOT EXISTS tienda_jt;

-- Seleccionamos el esquema tienda_jt

USE tienda_jt

-- Creamos las tablas

-- -----------------------------------------------------
-- Tabla `pais`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `autor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autor` ;

CREATE TABLE IF NOT EXISTS `autor` (
  `id_autor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NULL DEFAULT NULL,
  `id_pais` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_autor`),
  INDEX `fk_autor_pais` (`id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_autor_pais`
    FOREIGN KEY (`id_pais`)
    REFERENCES `pais` (`id_pais`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 51
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `membresia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `membresia` ;

CREATE TABLE IF NOT EXISTS `membresia` (
  `id_membresia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descuento` DECIMAL(4,2) NULL DEFAULT '0.00',
  `costo_mensual` DECIMAL(10,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`id_membresia`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cliente` ;

CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `genero` VARCHAR(20) NULL DEFAULT NULL,
  `id_membresia` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_membresia` (`id_membresia` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_membresia`
    FOREIGN KEY (`id_membresia`)
    REFERENCES `membresia` (`id_membresia`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 102
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `editorial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `editorial` ;

CREATE TABLE IF NOT EXISTS `editorial` (
  `id_editorial` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `cuit` VARCHAR(20) NULL DEFAULT NULL,
  `contacto_email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_editorial`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `genero_libros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `genero_libros` ;

CREATE TABLE IF NOT EXISTS `genero_libros` (
  `id_genero` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_genero`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libro` ;

CREATE TABLE IF NOT EXISTS `libro` (
  `id_libro` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  `stock` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_autor` INT NOT NULL,
  `id_genero` INT NULL DEFAULT NULL,
  `id_editorial` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_libro`),
  INDEX `fk_libro_genero` (`id_genero` ASC) VISIBLE,
  INDEX `fk_libro_editorial` (`id_editorial` ASC) VISIBLE,
  INDEX `fk_libro_autor` (`id_autor` ASC) VISIBLE,
  CONSTRAINT `fk_libro_autor`
    FOREIGN KEY (`id_autor`)
    REFERENCES `autor` (`id_autor`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_libro_editorial`
    FOREIGN KEY (`id_editorial`)
    REFERENCES `editorial` (`id_editorial`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_libro_genero`
    FOREIGN KEY (`id_genero`)
    REFERENCES `genero_libros` (`id_genero`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1001
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `empleado` ;

CREATE TABLE IF NOT EXISTS `empleado` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `legajo` VARCHAR(10) NOT NULL,
  `fecha_ingreso` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `metodo_pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `metodo_pago` ;

CREATE TABLE IF NOT EXISTS `metodo_pago` (
  `id_pago` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_pago`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pedido` ;

CREATE TABLE IF NOT EXISTS `pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_empleado` INT NULL DEFAULT NULL,
  `id_pago` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `pedido_ibfk_1` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_pedido_empleado` (`id_empleado` ASC) VISIBLE,
  INDEX `fk_pedido_pago` (`id_pago` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_empleado`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_pago`
    FOREIGN KEY (`id_pago`)
    REFERENCES `metodo_pago` (`id_pago`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `pedido_ibfk_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `cliente` (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 501
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `detallepedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detallepedido` ;

CREATE TABLE IF NOT EXISTS `detallepedido` (
  `id_pedido` INT NOT NULL,
  `id_libro` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_pedido`, `id_libro`),
  INDEX `detallepedido_ibfk_1` (`id_libro` ASC) VISIBLE,
  CONSTRAINT `detallepedido_ibfk_1`
    FOREIGN KEY (`id_libro`)
    REFERENCES `libro` (`id_libro`),
  CONSTRAINT `detallepedido_ibfk_2`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `pedido` (`id_pedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `envio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `envio` ;

CREATE TABLE IF NOT EXISTS `envio` (
  `id_envio` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `direccion_destino` VARCHAR(150) NOT NULL,
  `empresa_transporte` VARCHAR(50) NULL DEFAULT 'Correo Propio',
  `costo_envio` DECIMAL(10,2) NULL DEFAULT '0.00',
  `estado` VARCHAR(30) NOT NULL,
  `fecha_salida` DATE NULL DEFAULT NULL,
  `fecha_entrega` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_envio`),
  INDEX `fk_envio_pedido` (`id_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_envio_pedido`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `pedido` (`id_pedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 411
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `log_clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `log_clientes` ;

CREATE TABLE IF NOT EXISTS `log_clientes` (
  `id_log` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NULL DEFAULT NULL,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `fecha_alta` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_log`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `resena`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `resena` ;

CREATE TABLE IF NOT EXISTS `resena` (
  `id_resena` INT NOT NULL AUTO_INCREMENT,
  `id_libro` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `calificacion` INT NOT NULL,
  `comentario` TEXT NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT curdate(),
  PRIMARY KEY (`id_resena`),
  INDEX `fk_resena_libro` (`id_libro` ASC) VISIBLE,
  INDEX `fk_resena_cliente` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_resena_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `fk_resena_libro`
    FOREIGN KEY (`id_libro`)
    REFERENCES `libro` (`id_libro`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- CREACION DE VISTAS 
--------------------------------------------------------
-- VISTA DE ALERTAS REPOSICION 
--------------------------------------------------------
DROP TABLE IF EXISTS `vw_alertas_reposicion`;
DROP VIEW IF EXISTS `vw_alertas_reposicion` ;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_alertas_reposicion` AS select `l`.`titulo` AS `titulo`,`l`.`stock` AS `stock`,concat(`a`.`nombre`,' ',`a`.`apellido`) AS `autor` from (`libro` `l` join `autor` `a` on((`l`.`id_autor` = `a`.`id_autor`))) where (`l`.`stock` < 3);
-- -----------------------------------------------------
-- VISTA DE CATALOGO DISPONIBLE
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vw_catalogo_disponible`;
DROP VIEW IF EXISTS `vw_catalogo_disponible` ;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_catalogo_disponible` AS select `l`.`id_libro` AS `id_libro`,`l`.`titulo` AS `titulo`,`l`.`precio` AS `precio`,`l`.`stock` AS `stock`,concat(`a`.`nombre`,' ',`a`.`apellido`) AS `autor` from (`libro` `l` join `autor` `a` on((`l`.`id_autor` = `a`.`id_autor`))) where (`l`.`stock` > 0);
-- -----------------------------------------------------
-- VISTA DETALLE PEDIDOS COMPLETOS
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vw_detalle_pedidos_completos`;
DROP VIEW IF EXISTS `vw_detalle_pedidos_completos` ;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_detalle_pedidos_completos` AS select `p`.`id_pedido` AS `id_pedido`,`p`.`fecha` AS `fecha`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente`,`l`.`titulo` AS `libro`,`dp`.`cantidad` AS `cantidad`,`dp`.`precio` AS `precio`,(`dp`.`cantidad` * `dp`.`precio`) AS `subtotal` from (((`pedido` `p` join `cliente` `c` on((`p`.`id_cliente` = `c`.`id_cliente`))) join `detallepedido` `dp` on((`p`.`id_pedido` = `dp`.`id_pedido`))) join `libro` `l` on((`dp`.`id_libro` = `l`.`id_libro`)));
-- -----------------------------------------------------
-- VISTA LIBROS POR AUTOR
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vw_libros_por_autor`;
DROP VIEW IF EXISTS `vw_libros_por_autor` ;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_libros_por_autor` AS select concat(`a`.`nombre`,' ',`a`.`apellido`) AS `autor`,count(`l`.`id_libro`) AS `cantidad_titulos` from (`autor` `a` left join `libro` `l` on((`a`.`id_autor` = `l`.`id_autor`))) group by `a`.`id_autor`,`a`.`nombre`,`a`.`apellido`;
-- -----------------------------------------------------
-- VISTA RANKIG DE VENTAS CLIENTE
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vw_ranking_ventas_cliente`;
DROP VIEW IF EXISTS `vw_ranking_ventas_cliente` ;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_ranking_ventas_cliente` AS select `c`.`id_cliente` AS `id_cliente`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente`,count(`p`.`id_pedido`) AS `cantidad_pedidos` from (`cliente` `c` left join `pedido` `p` on((`c`.`id_cliente` = `p`.`id_cliente`))) group by `c`.`id_cliente`,`c`.`nombre`,`c`.`apellido`;

DELIMITER $$

-- CREACION DE FUNCIONES 
-- -----------------------------------------------------
-- FUNCION OBTENER EMAIL DE CLIENTE
-- -----------------------------------------------------
DROP function IF EXISTS `fn_obtener_email_cliente`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_obtener_email_cliente`(
    p_id_cliente INT
) RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    DETERMINISTIC
BEGIN
    DECLARE v_email VARCHAR(100);

    SELECT email
    INTO v_email
    FROM cliente
    WHERE id_cliente = p_id_cliente;

    RETURN v_email;
END$$

DELIMITER ;
-- -----------------------------------------------------
-- FUNCION VALOR INVENTARIO TOTAL
-- -----------------------------------------------------
DROP function IF EXISTS `fn_valor_inventario_total`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_valor_inventario_total`() RETURNS decimal(12,2)
    DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(12,2);

    SELECT SUM(precio * stock)
    INTO total
    FROM libro;

    RETURN IFNULL(total, 0);
END$$

DELIMITER ;
-- -----------------------------------------------------
-- STORED PROCEDURES ACTUALIZAR STOCK LIBRO
-- -----------------------------------------------------
DROP procedure IF EXISTS `sp_actualizar_stock_libro`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_stock_libro`(
    IN p_id_libro INT,
    IN p_nuevo_stock INT
)
BEGIN
    UPDATE libro
    SET stock = p_nuevo_stock
    WHERE id_libro = p_id_libro;
END$$

DELIMITER ;
-- -----------------------------------------------------
-- STORED PROCEDURES ELIMINAR PEDIDO CASCADA
-- -----------------------------------------------------
DROP procedure IF EXISTS `sp_eliminar_pedido_cascada`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_pedido_cascada`(
    IN p_id_pedido INT
)
BEGIN
    -- Primero se eliminan los registros hijos
    DELETE FROM detallepedido
    WHERE id_pedido = p_id_pedido;

    -- Luego se elimina la cabecera del pedido
    DELETE FROM pedido
    WHERE id_pedido = p_id_pedido;
END$$

DELIMITER ;
-- -----------------------------------------------------
-- CREACION DE TRIGGER LOG NUEVOS CLIENTES
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `tr_log_nuevos_clientes` $$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `tienda_jt`.`tr_log_nuevos_clientes`
AFTER INSERT ON `tienda_jt`.`cliente`
FOR EACH ROW
BEGIN
    INSERT INTO log_clientes (
        id_cliente,
        nombre,
        apellido,
        email,
        fecha_alta
    )
    VALUES (
        NEW.id_cliente,
        NEW.nombre,
        NEW.apellido,
        NEW.email,
        NOW()
    );
END$$

DELIMITER ;
-- -----------------------------------------------------
-- CREACION DE TRIGGER CHEQUEO PRECIO POSITIVO
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `tr_check_precio_positivo` $$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `tienda_jt`.`tr_check_precio_positivo`
BEFORE INSERT ON `tienda_jt`.`libro`
FOR EACH ROW
BEGIN
    IF NEW.precio <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio del libro debe ser mayor a cero';
    END IF;
END$$


DELIMITER ;
