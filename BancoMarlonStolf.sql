-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: marlon
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `CodCli` int NOT NULL AUTO_INCREMENT,
  `DesCli` varchar(100) NOT NULL,
  `CodCid` varchar(100) DEFAULT NULL,
  `DsUf` char(2) DEFAULT NULL,
  PRIMARY KEY (`CodCli`),
  KEY `idx_DesCli` (`DesCli`),
  KEY `idx_CodCid` (`CodCid`),
  KEY `idx_DsUf` (`DsUf`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Maria Silva','São Paulo','SP'),(2,'João Pereira','Rio de Janeiro','RJ'),(3,'Ana Souza','Belo Horizonte','MG'),(4,'Carlos Oliveira','Porto Alegre','RS'),(5,'Fernanda Costa','Curitiba','PR'),(6,'Lucas Lima','Salvador','BA'),(7,'Bruno Santos','Fortaleza','CE'),(8,'Juliana Ferreira','Recife','PE'),(9,'Paulo Alves','Brasília','DF'),(10,'Amanda Rocha','Goiânia','GO'),(11,'Gabriel Martins','Florianópolis','SC'),(12,'Rafaela Nascimento','Manaus','AM'),(13,'Marcos Teixeira','Belém','PA'),(14,'Camila Ribeiro','Vitória','ES'),(15,'Rodrigo Batista','São Luís','MA'),(16,'Isabela Melo','Maceió','AL'),(17,'Pedro Araújo','Natal','RN'),(18,'Larissa Dias','Aracaju','SE'),(19,'Felipe Barbosa','Campo Grande','MS'),(20,'Julio Castro','Cuiabá','MT');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itempedido`
--

DROP TABLE IF EXISTS `itempedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itempedido` (
  `CdItem` int NOT NULL,
  `CodPed` int NOT NULL,
  `CodPro` int NOT NULL,
  `VlrPro` decimal(10,2) NOT NULL,
  `VlrUni` decimal(10,2) NOT NULL,
  `QtdPed` decimal(10,2) NOT NULL,
  PRIMARY KEY (`CodPed`,`CdItem`),
  KEY `idx_CodPro` (`CodPro`),
  CONSTRAINT `itempedido_ibfk_1` FOREIGN KEY (`CodPed`) REFERENCES `pedidos` (`CodPed`),
  CONSTRAINT `itempedido_ibfk_2` FOREIGN KEY (`CodPro`) REFERENCES `produtos` (`CodPro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itempedido`
--

LOCK TABLES `itempedido` WRITE;
/*!40000 ALTER TABLE `itempedido` DISABLE KEYS */;
INSERT INTO `itempedido` VALUES (1,1,10,155.00,155.00,1.00),(2,1,14,49.90,4.99,10.00);
/*!40000 ALTER TABLE `itempedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_itempedido_insert` BEFORE INSERT ON `itempedido` FOR EACH ROW BEGIN
  DECLARE maxCdItem INT;

  SELECT IFNULL(MAX(CdItem), 0) INTO maxCdItem
  FROM ItemPedido
  WHERE CodPed = NEW.CodPed;

  SET NEW.CdItem = maxCdItem + 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `CodPed` int NOT NULL AUTO_INCREMENT,
  `CodCli` int NOT NULL,
  `VlrTot` decimal(10,2) NOT NULL,
  `DtEmi` date NOT NULL,
  PRIMARY KEY (`CodPed`),
  KEY `idx_CodCli` (`CodCli`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`CodCli`) REFERENCES `clientes` (`CodCli`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,204.90,'2025-01-30');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `CodPro` int NOT NULL AUTO_INCREMENT,
  `DesPro` varchar(255) NOT NULL,
  `PreVen` decimal(10,2) NOT NULL,
  PRIMARY KEY (`CodPro`),
  KEY `idx_DesPro` (`DesPro`),
  KEY `idx_PreVen` (`PreVen`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Apple iPhone 14 Pro Max',1099.00),(2,'Samsung Galaxy S23 Ultra',999.00),(3,'Notebook Dell XPS 13',1299.00),(4,'Smart TV LG OLED 55\"',1399.00),(5,'Câmera GoPro HERO10',499.99),(6,'PlayStation 5',499.00),(7,'Xbox Series X',499.00),(8,'Fone de Ouvido Bluetooth Sony WH-1000XM5',349.00),(9,'Monitor Gamer Samsung Odyssey G7',699.00),(10,'Notebook Lenovo ThinkPad X1 Carbon',1799.00),(11,'Detergente Líquido OMO Lavagem Perfeita 3L',7.99),(12,'Sabonete Líquido Dove 250ml',3.50),(13,'Shampoo Pantene 400ml',5.50),(14,'Café em Pó Pilão Tradicional 500g',4.99),(15,'Água Mineral Bonafont 1,5L',1.00),(16,'Arroz Tio João Tipo 1 5kg',12.50),(17,'Leite Longa Vida Parmalat Integral 1L',1.99),(18,'Refrigerante Coca-Cola 2L',2.99),(19,'Creme Dental Colgate Total 90g',2.50),(20,'Chocolate Nestlé KitKat 45g',1.25);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'marlon'
--

--
-- Dumping routines for database 'marlon'
--
/*!50003 DROP PROCEDURE IF EXISTS `SPExcluiPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPExcluiPedido`(IN p_CodPed INT)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;
	
  START TRANSACTION;
  
    DELETE FROM ItemPedido
	WHERE CodPed = p_CodPed;
    
	DELETE FROM Pedidos
	WHERE CodPed = p_CodPed;
    
  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPInsertOrUpdateItemPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPInsertOrUpdateItemPedido`(
    IN p_CodPed INT,
    IN p_CdItem INT,
    IN p_CodPro INT,
    IN p_QtdPed INT,
    IN p_VlrUni INT,
    IN p_VlrPro DECIMAL(10, 2))
BEGIN
  -- Verifica se o registro já existe
  IF EXISTS (SELECT 1 
              FROM ItemPedido 
              WHERE CodPed = p_CodPed 
                AND CdItem = p_CdItem) THEN
        -- Se existir, atualiza o registro
        UPDATE ItemPedido
        SET QtdPed = p_QtdPed, 
            VlrUni = p_VlrUni,
            VlrPro = p_VlrPro
        WHERE CdItem = p_CdItem
          AND CodPed = p_CodPed; 
    ELSE
        -- Se não existir, insere um novo registro
        INSERT INTO ItemPedido (CodPed, 
                                CodPro,
                                QtdPed,
                                VlrUni,
                                VlrPro)
        VALUES (p_CodPed, 
                p_CodPro, 
                p_QtdPed,
                p_VlrUni,
                p_VlrPro);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPTotalizaEAtualizaPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPTotalizaEAtualizaPedido`(
    IN p_CodPed INT  -- Código do pedido a ser atualizado
)
BEGIN
    DECLARE p_VlrTot DECIMAL(10, 2); 

    -- Calcula o total do pedido
    SELECT SUM(VlrUni * QtdPed) INTO p_VlrTot
    FROM ItemPedido
    WHERE CodPed = p_CodPed;

    -- Atualiza o campo VlrTot na tabela Pedidos
    UPDATE Pedidos
    SET VlrTot = p_VlrTot
    WHERE CodPed = p_CodPed;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-30  6:43:25
