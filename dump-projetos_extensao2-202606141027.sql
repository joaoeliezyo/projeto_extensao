-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: projetos_extensao2
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anexo_projeto`
--

DROP TABLE IF EXISTS `anexo_projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anexo_projeto` (
  `id_anexo` int NOT NULL AUTO_INCREMENT,
  `id_projeto` int NOT NULL,
  `nome_original` varchar(255) NOT NULL,
  `nome_arquivo` varchar(255) NOT NULL,
  `caminho_arquivo` varchar(500) NOT NULL,
  `tipo_arquivo` varchar(120) DEFAULT NULL,
  `tamanho_bytes` bigint DEFAULT NULL,
  `data_upload` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_anexo`),
  KEY `idx_anexo_projeto_id_projeto` (`id_projeto`),
  CONSTRAINT `fk_anexo_projeto` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anexo_projeto`
--

LOCK TABLES `anexo_projeto` WRITE;
/*!40000 ALTER TABLE `anexo_projeto` DISABLE KEYS */;
INSERT INTO `anexo_projeto` VALUES (5,4,'test_file.png','1780626133423-785406319.png','/uploads/anexos/1780626133423-785406319.png','image/png',22,'2026-06-04 23:22:13'),(6,4,'test_file.png','1780626423992-807644508.png','/uploads/anexos/1780626423992-807644508.png','image/png',22,'2026-06-04 23:27:04'),(7,4,'apresentacao Design - design GrÃ¡fico.pdf','1780627085903-6628020.pdf','/uploads/anexos/1780627085903-6628020.pdf','application/pdf',NULL,'2026-06-04 23:38:05');
/*!40000 ALTER TABLE `anexo_projeto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacao_institucional`
--

DROP TABLE IF EXISTS `avaliacao_institucional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacao_institucional` (
  `id_avaliacao` int NOT NULL AUTO_INCREMENT,
  `id_projeto` int NOT NULL,
  `criterios_avaliacao` text,
  `metodologia_avaliacao` text,
  `forma_apresentacao_relatorio` text,
  PRIMARY KEY (`id_avaliacao`),
  KEY `id_projeto` (`id_projeto`),
  CONSTRAINT `avaliacao_institucional_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacao_institucional`
--

LOCK TABLES `avaliacao_institucional` WRITE;
/*!40000 ALTER TABLE `avaliacao_institucional` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacao_institucional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacao_participante`
--

DROP TABLE IF EXISTS `avaliacao_participante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacao_participante` (
  `id_avaliacao_participante` int NOT NULL AUTO_INCREMENT,
  `id_projeto` int NOT NULL,
  `data_resposta` date DEFAULT NULL,
  `id_faixa` int DEFAULT NULL,
  `id_escolaridade` int DEFAULT NULL,
  `reside_na_comunidade` tinyint(1) DEFAULT NULL,
  `avaliacao_conteudo` varchar(20) DEFAULT NULL,
  `atendeu_expectativas` varchar(20) DEFAULT NULL,
  `facilitadores_acessiveis` varchar(20) DEFAULT NULL,
  `escuta_comunidade` varchar(20) DEFAULT NULL,
  `estrutura_adequada` varchar(20) DEFAULT NULL,
  `sente_mais_capacitado` varchar(20) DEFAULT NULL,
  `contribuicao_pessoal` varchar(20) DEFAULT NULL,
  `descricao_contribuicao` text,
  `pretende_aplicar` varchar(20) DEFAULT NULL,
  `motivo_nao_aplicar` text,
  `recomendaria` varchar(20) DEFAULT NULL,
  `comentario_positivo` text,
  `sugestao_melhoria` text,
  `sugestoes_futuras` text,
  `consentimento` tinyint(1) DEFAULT NULL,
  `assentimento` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_avaliacao_participante`),
  KEY `id_projeto` (`id_projeto`),
  KEY `id_faixa` (`id_faixa`),
  KEY `id_escolaridade` (`id_escolaridade`),
  CONSTRAINT `avaliacao_participante_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`),
  CONSTRAINT `avaliacao_participante_ibfk_2` FOREIGN KEY (`id_faixa`) REFERENCES `faixa_etaria` (`id_faixa`),
  CONSTRAINT `avaliacao_participante_ibfk_3` FOREIGN KEY (`id_escolaridade`) REFERENCES `escolaridade` (`id_escolaridade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacao_participante`
--

LOCK TABLES `avaliacao_participante` WRITE;
/*!40000 ALTER TABLE `avaliacao_participante` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacao_participante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cronograma_atividades`
--

DROP TABLE IF EXISTS `cronograma_atividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cronograma_atividades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_projeto` int DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `etapa` text NOT NULL,
  `data` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `local` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cronograma_atividades`
--

LOCK TABLES `cronograma_atividades` WRITE;
/*!40000 ALTER TABLE `cronograma_atividades` DISABLE KEYS */;
INSERT INTO `cronograma_atividades` VALUES (3,4,1,'Envio do Projeto de Extensão para a Coordenação do Curso','2025-03-16','14:00:00',''),(4,4,2,'Selecionar textos','2026-03-16','14:00:00',''),(5,4,3,'Editar textos','2026-04-13','14:00:00',''),(6,4,4,'Formatar livro','2026-04-13','15:00:00',''),(7,4,5,'Revisar livro','2026-05-11','14:00:00',''),(8,4,6,'Emitir ISBN e ficha catalográfica','2026-05-15','15:00:00',''),(9,4,7,'Imprimir livro','2026-05-30','15:00:00',''),(10,4,8,'Envio dos Relatório de Extensão para a Coordenação do Curso','2026-06-30','15:00:00',''),(11,4,9,'Apresentação Evento','2026-06-30','20:00:00','Pátio UNICET');
/*!40000 ALTER TABLE `cronograma_atividades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nome_curso` varchar(255) DEFAULT NULL,
  `coordenador_id` int DEFAULT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (2,'SISTEMAS PARA INTERNET',269),(10,'ENFERMAGEM',86),(12,'FARMÁCIA',89),(16,'DIREITO',80),(25,'BACHARELADO EM ADMINISTRAÇÃO',169),(26,'BACHARELADO EM CIÊNCIAS CONTÁBEIS',169),(30,'MEDICINA',195),(38,'DESIGN GRÁFICO',269),(52,'ODONTOLOGIA',244),(56,'ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL',117);
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_pessoa`
--

DROP TABLE IF EXISTS `curso_pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_pessoa` (
  `id_curso` int NOT NULL,
  `id_pessoa` int NOT NULL,
  `ativo` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_curso`,`id_pessoa`),
  KEY `id_pessoa` (`id_pessoa`),
  CONSTRAINT `curso_pessoa_ibfk_2` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_pessoa`
--

LOCK TABLES `curso_pessoa` WRITE;
/*!40000 ALTER TABLE `curso_pessoa` DISABLE KEYS */;
INSERT INTO `curso_pessoa` VALUES (2,78,1),(2,82,1),(2,155,1),(2,176,1),(2,177,1),(2,254,1),(2,269,1),(9,69,1),(9,76,1),(9,91,1),(9,97,1),(9,110,1),(9,131,1),(9,167,1),(9,170,1),(9,171,1),(9,172,1),(9,173,1),(10,67,1),(10,69,1),(10,71,1),(10,73,1),(10,74,1),(10,76,1),(10,86,1),(10,91,1),(10,96,1),(10,97,1),(10,105,1),(10,108,1),(10,110,1),(10,167,1),(10,170,1),(10,171,1),(10,172,1),(10,173,1),(10,181,1),(12,67,1),(12,69,1),(12,73,1),(12,74,1),(12,76,1),(12,84,1),(12,88,1),(12,89,1),(12,91,1),(12,97,1),(12,110,1),(12,111,1),(12,131,1),(12,146,1),(12,167,1),(12,168,1),(12,170,1),(12,171,1),(12,172,1),(12,173,1),(16,72,1),(16,78,1),(16,80,1),(16,81,1),(16,82,1),(16,90,1),(16,95,1),(16,97,1),(16,100,1),(16,103,1),(16,104,1),(16,109,1),(16,112,1),(16,113,1),(16,150,1),(16,178,1),(16,179,1),(16,180,1),(16,257,1),(25,100,1),(25,168,1),(25,169,1),(25,255,1),(25,256,1),(26,82,1),(26,100,1),(26,168,1),(26,169,1),(26,255,1),(30,73,1),(30,76,1),(30,78,1),(30,91,1),(30,105,1),(30,106,1),(30,116,1),(30,117,1),(30,118,1),(30,131,1),(30,133,1),(30,136,1),(30,139,1),(30,140,1),(30,141,1),(30,143,1),(30,145,1),(30,146,1),(30,168,1),(30,171,1),(30,181,1),(30,183,1),(30,184,1),(30,185,1),(30,186,1),(30,187,1),(30,188,1),(30,189,1),(30,190,1),(30,191,1),(30,192,1),(30,193,1),(30,194,1),(30,195,1),(30,196,1),(30,197,1),(30,198,1),(30,199,1),(30,200,1),(30,201,1),(30,202,1),(30,203,1),(30,204,1),(30,205,1),(30,206,1),(30,207,1),(30,208,1),(30,209,1),(30,210,1),(30,211,1),(30,212,1),(30,213,1),(30,214,1),(30,215,1),(30,216,1),(30,217,1),(30,218,1),(30,219,1),(30,220,1),(30,221,1),(30,222,1),(30,223,1),(30,224,1),(30,225,1),(30,226,1),(30,227,1),(30,228,1),(30,229,1),(30,230,1),(30,231,1),(30,232,1),(30,233,1),(30,234,1),(30,235,1),(30,236,1),(30,237,1),(30,238,1),(30,257,1),(30,258,1),(30,259,1),(30,260,1),(30,261,1),(30,262,1),(30,263,1),(30,264,1),(30,265,1),(38,82,1),(38,174,1),(38,175,1),(38,176,1),(38,177,1),(38,269,1),(52,78,1),(52,170,1),(52,192,1),(52,239,1),(52,240,1),(52,241,1),(52,242,1),(52,243,1),(52,244,1),(52,245,1),(52,246,1),(52,247,1),(52,248,1),(52,249,1),(52,250,1),(52,251,1),(52,252,1),(52,253,1),(52,257,1),(52,266,1),(52,267,1),(52,268,1),(56,105,1),(56,155,1),(56,161,1),(56,164,1),(56,165,1),(56,170,1),(56,177,1),(56,182,1);
/*!40000 ALTER TABLE `curso_pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escolaridade`
--

DROP TABLE IF EXISTS `escolaridade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `escolaridade` (
  `id_escolaridade` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_escolaridade`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escolaridade`
--

LOCK TABLES `escolaridade` WRITE;
/*!40000 ALTER TABLE `escolaridade` DISABLE KEYS */;
INSERT INTO `escolaridade` VALUES (1,'Não alfabetizado'),(2,'Ensino Fundamental'),(3,'Ensino Médio'),(4,'Superior'),(5,'Pós-graduação');
/*!40000 ALTER TABLE `escolaridade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faixa_etaria`
--

DROP TABLE IF EXISTS `faixa_etaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faixa_etaria` (
  `id_faixa` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_faixa`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faixa_etaria`
--

LOCK TABLES `faixa_etaria` WRITE;
/*!40000 ALTER TABLE `faixa_etaria` DISABLE KEYS */;
INSERT INTO `faixa_etaria` VALUES (1,'Menos de 18'),(2,'18 a 24'),(3,'25 a 34'),(4,'35 a 44'),(5,'45 a 59'),(6,'60 ou mais');
/*!40000 ALTER TABLE `faixa_etaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instituicao`
--

DROP TABLE IF EXISTS `instituicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instituicao` (
  `id_instituicao` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  `id_tipo_instituicao` int DEFAULT NULL,
  PRIMARY KEY (`id_instituicao`),
  KEY `id_tipo_instituicao` (`id_tipo_instituicao`),
  CONSTRAINT `instituicao_ibfk_1` FOREIGN KEY (`id_tipo_instituicao`) REFERENCES `tipo_instituicao` (`id_tipo_instituicao`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instituicao`
--

LOCK TABLES `instituicao` WRITE;
/*!40000 ALTER TABLE `instituicao` DISABLE KEYS */;
INSERT INTO `instituicao` VALUES (1,'Universidade Federal do Piauí','UFPI',1),(2,'Univesidade Estadual do Piaui','UESPI',1);
/*!40000 ALTER TABLE `instituicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linha_programatica`
--

DROP TABLE IF EXISTS `linha_programatica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linha_programatica` (
  `id_linha` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id_linha`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linha_programatica`
--

LOCK TABLES `linha_programatica` WRITE;
/*!40000 ALTER TABLE `linha_programatica` DISABLE KEYS */;
INSERT INTO `linha_programatica` VALUES (1,'Comunicação'),(2,'Cultura'),(3,'Direitos Humanos e Justiça'),(4,'Educação'),(5,'Meio Ambiente'),(6,'Saúde'),(7,'Tecnologia e Produção'),(8,'Trabalho');
/*!40000 ALTER TABLE `linha_programatica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_execucao`
--

DROP TABLE IF EXISTS `local_execucao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_execucao` (
  `id_local` int NOT NULL AUTO_INCREMENT,
  `endereco` text,
  `cep` varchar(10) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_local`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_execucao`
--

LOCK TABLES `local_execucao` WRITE;
/*!40000 ALTER TABLE `local_execucao` DISABLE KEYS */;
INSERT INTO `local_execucao` VALUES (1,'Avenida Marechal Castelo Branco','64001921','Frei Serafim','Teresina');
/*!40000 ALTER TABLE `local_execucao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `papel_projeto`
--

DROP TABLE IF EXISTS `papel_projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `papel_projeto` (
  `id_papel` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_papel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `papel_projeto`
--

LOCK TABLES `papel_projeto` WRITE;
/*!40000 ALTER TABLE `papel_projeto` DISABLE KEYS */;
INSERT INTO `papel_projeto` VALUES (1,'Professor'),(2,'Técnico');
/*!40000 ALTER TABLE `papel_projeto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `id_pessoa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `cpf` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `id_tipo_pessoa` int DEFAULT NULL,
  PRIMARY KEY (`id_pessoa`),
  KEY `id_tipo_pessoa` (`id_tipo_pessoa`),
  CONSTRAINT `pessoa_ibfk_1` FOREIGN KEY (`id_tipo_pessoa`) REFERENCES `tipo_pessoa` (`id_tipo_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (64,'Administrador','',NULL,NULL,3),(66,'RENATO  DA COSTA E SILVA REBELO SAMPAIO ','2','RENATOSAMP@IG.COM.BR ','0',1),(67,'KATIA CILENE DE OLIVEIRA PEREIRA','84442528594','KATIA.PEREIRA@CET.EDU.BR ','0',2),(69,'MARIA DAS GRAÇAS PRIANTI','27583796:27','MGPRIANTI@HOTMAIL.COM ','0',2),(71,'MARIA NAUSIDE PESSOA DA SILVA','462:2:::58:','NAUSIDE@YAHOO.COM.BR ','0',2),(72,'GISELLE KAROLINA GOMES FREITAS IBIAPINA',':7;265;4542','GISELLE-KAROLINA@BOL.COM.BR ','0',2),(73,'KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','VIEIRA.BEATRIZ.KELLY@HOTMAIL.COM ','0',2),(74,'KEYLLA DA CONCEIÇÃO MACHADO','24::4594567','KEYLLAMACHADO06@HOTMAIL.COM ','0',2),(76,'AKEMI SUZUKI CRUZIO','249252275:7','AKEMISCRUZIO@GMAIL.COM ','0',2),(78,'JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','KARLA.SANTTOS@HOTMAIL.COM ','0',2),(80,'DANIEL CARVALHO SAMPAIO','22537645588','DANIELCSAMPAIO@HOTMAIL.COM ','0',1),(81,'JUSTINA ALZIRA SOARES DO NASCIMENTO','8377375:556','JSADVOGAR@HOTMAIL.COM ','0',2),(82,'JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','JOELMAMEIRELES@HOTMAIL.COM ','0',2),(84,'THALYTA PEREIRA OLIVEIRA','248;79:;573','THALYTA.QUI@HOTMAIL.COM ','0',2),(86,'MÁRCIA LAÍS FORTES RODRIGUES MATTOS','8878749:556','MARCIALAISMATTOS@GMAIL.COM ','0',1),(88,'ANNA ERIKA PINHEIRO DA SILVA','24799223593','ANNAERIKA_PINHEIRO@HOTMAIL.COM ','0',2),(89,'THIARA LORENNA BEZERRA DA SILVA OLIVEIRA','2294;895538','THIARALORENNA@GMAIL.COM ','0',1),(90,'VANESSA NUNES DE BARROS MENDES','2353:475528','VANESSANBM@HOTMAIL.COM ','0',2),(91,'FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','MAIRANASSOUSA@HOTMAIL.COM ','0',2),(95,'EULANE COELHO BATISTA','246;3323522','DRAEULANECOELHO@GMAIL.COM ','0',2),(96,'EVERTON MORAES LOPES','24935327596','EVERTONLOPESUFPI@GMAIL.COM ','0',2),(97,'LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','COLIVEIRA.LUIZ@GMAIL.COM ','0',2),(98,'DEBORA  FONSECA LEITE ','2','DEBORAFONSECALEITE_3@HOTMAIL.COM ','0',2),(99,'ANA  KAROLINNE DA SILVA BRITO ','2','ANAKAROLINNESB@HOTMAIL.COM ','0',2),(100,'DEILLANY MARTINS MENDES',';;48:;;2522','deillanymm@gmail.com','0',2),(102,'NELSON  JORGE CARVALHO BATISTA ','2','PROFESSORNELSONJORGE@GMAIL.COM ','0',1),(103,'THALITA FURTADO MASCARENHAS LUSTOSA','2482:45857;','FURTADOTHALITA@GMAIL.COM ','0',2),(104,'ELSON JOSÉ DO RÊGO','882792655;3','ELSONREGO@GMAIL.COM ','0',2),(105,'NELSON AGAPITO BRANDÃO RIOS',':;23:274575','NELSON17.RIOS@GMAIL.COM','0',2),(106,'NAYLA ANDRADE BARBOZA','2226;:95522','NAYLABARB30@GMAIL.COM ','0',2),(107,'JOSÉ  MIGUEL LUZ PARENTE ','2','JSMIGPARENTE@GMAIL.COM ','0',2),(108,'LORENA ROCHA BATISTA CARVALHO','2262279;554','LORENAROCHABC@GMAIL.COM ','0',2),(109,'ANA CAROLINNA BARROS SILVA','25;57225529','PROFCAROLINNABARROS@GMAIL.COM ','0',2),(110,'VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','BARBOSA.A.VICTOR@GMAIL.COM ','0',2),(111,'ANA CRISTINA SOUSA GRAMOZA VILARINHO SANTANA','259499;7523','PROFESSOR27@FACULDADECET.EDU.BR ','0',2),(112,'MAÍRA MELO CAVALCANTE','22939456267','MCMAIRA@GMAIL.COM ','0',2),(113,'TATIANA VELOSO MAGALHAES','239439:852;','taatianavelosom@gmail.com','0',2),(114,'MARINA  UCHOA WALL BARBOSA DE CARVALHO ','2','MARINAUWBC@GMAIL.COM ','0',2),(115,'MOISES  ALVES FERREIRA FILHO ','2','MOISESFH@HOTMAIL.COM ','0',2),(116,'ISABEL CRISTINA DE PAULA OLIVEIRA','33628439:7;','PROFESSOR62@FACULDADECET.EDU.BR ','0',2),(117,'FRANCISCO HONEIDY CARVALHO AZEVEDO',':74299:25:9','HONEIDY@GMAIL.COM ','0',1),(118,'ADÉLIA DALVA DA SILVA OLIVEIRA','6682;354542','PROFESSOR64@FACULDADECET.EDU.BR ','0',2),(119,'MARIA  DO AMPARO VELOSO MAGALHÃES ','2','VELOSOCIRURGIA@YAHOO.COM.BR ','0',2),(121,'Admin Faculdade CET','2','suporte@faculdadecet.edu.br','0',1),(122,'LUCIANA MENESES COSTA','2','LUCIANA.MENESES.COSTA@GMAIL.COM','0',3),(123,'VANEIDE CARVALHO BARBOSA','2','ANATEKA.2013@GMAIL.COM','0',3),(124,'Lucelena','2','lab.saude@cet.edu.br','0',3),(125,'Meire','2','','0',3),(126,'Francisca Antonia','2','','0',3),(127,'Rene Oliveira de Andrade','2','rene.oliveira@cet.edu.br','0',1),(128,'Aluísio De Sousa Martins Jr','2','aluisio.martins@cet.edu.br','0',2),(131,'DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','DANIELLEFURTTADO@GMAIL.COM','0',2),(132,'ANDERSON WILBUR LOPES ANDRADE','>><B=<','professor75@faculdadecet.edu.br','0',2),(133,'ANTONIO MOREIRA MENDES FILHO','537675;6556','professor68@faculdadecet.edu.br','0',2),(134,'CAMILA TAPETY E SILVA DO RÊGO MONTEIRO','2','professor78@faculdadecet.edu.br','0',2),(135,'CHARLLYTON LUIS SENA DA COSTA','2','CHARLLYTON@GMAIL.COM','0',2),(136,'EDISON DE ARAÚJO VALE','465776;858:','professor69@faculdadecet.edu.br','0',2),(137,'EDIWYRTON DE FREITAS MORAIS BARROS','2','EDIWYRTON@GMAIL.COM','0',2),(138,'EDUARDO CAIRO OLIVEIRA CORDEIRO','2','professor72@faculdadecet.edu.br','0',2),(139,'GIULIANO DA PAZ OLIVEIRA','2573633:583','GIULIANOPOLIVEIRA@GMAIL.COM','0',2),(140,'LUIZ BEZERRA NETO',':622853758:','professor71@faculdadecet.edu.br','0',2),(141,'MAGDA ROGERIA PEREIRA VIANA','73972962542','professor73@faculdadecet.edu.br','0',2),(142,'MAURICIO BATISTA PAES LANDIM','2','MAURICIOLANDIM@GMAIL.COM','0',2),(143,'MAURO GUIMARÃES ALBUQUERQUE',':62387;2575','mgalbuquerque9@hotmail.COM','0',2),(144,'MONICA TAPETY DO REGO MONTEIRO','2','MONICATAPETY@HOTMAIL.COM','0',2),(145,'NAYLA ANDRADE BARBOZA','2226;:95522','NAYLABARB30@GMAIL.COM','0',2),(146,'PEDRO SIMÃO DA SILVA AZEVEDO','2754;3425;2','pss.azevedo@hotmail.COM','0',2),(148,'SANMANTH DO NASCIMENTO ARAÚJO ','>><B<B','professor74@faculdadecet.edu.br','0',1),(150,'ENEDINA GIZELI ALBANO MOURA','26344266589','endinaalbanoadv@hotmail.com','0',2),(151,'Magno Alves','2','assessoria.planejamento@cet.edu.br','0',3),(152,'MEC ','2','mec@faculdadecom.br','0',3),(153,'Ednilza Maria da Costa Silva ','2','ednilzamariacosta@gmail.com','0',3),(154,'EDUARDO LIRA','4<;5<656745','franciso.lira@cet.edu.br','0',2),(155,'DANILO BARBOSA','=8=4=;;:764','danilo.barbosa@cet.edu.br','0',2),(157,'Carlos Daniel Aragão Sousa','2','carlos.aragao@faculdadecet.edu.br','0',2),(159,'FERNANDA DENISE BARBOSA DE OLIVEIRA','2','fernanda.barbosa@faculdadecet.edu.br','0',3),(160,'Fernanda Pereira Santana','4744<8;;78<','fernanda.santana@faculdadecet.edu.br','0',2),(161,'Romullo Randell ','47=865;9799','romullo.carvalho@faculdadecet.edu.br','0',2),(163,'ARTUR FELIPE DA SILVA VELOSO','4965659678<','artur.veloso@unicet.edu.br','0',2),(164,'TARCÍSIO FRANCO JAIME','84595375522','','0',2),(165,'ANTONIO ALBERTO IBIABINA','47;454=874:','','0',2),(166,'MARIA OLIVIA ALVES DA SILVA','=<7:;<647:7','','0',2),(167,'RUSBENE BRUNO FONSECA DE CARVALHO','252773::587','rusbene.carvalho@unicet.edu.br','0',2),(168,'ANA KAROLINE DA SILVA BRITO','26:533425:5','ana.karolinne@unicet.edu.br','0',2),(169,'MARCIO LUCIANO PEREIRA BATISTA','9458544556;','professor79@faculdadecet.edu.br','0',1),(170,'MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','mara.silva@unicet.edu.br','0',2),(171,'LUCAS MATOS OLIVEIRA','283749455;8','lucas.oliveira@faculdadecet.edu.br','0',2),(172,'EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','eugeniobmj@gmail.com','0',2),(173,'MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','maria.brito@faculdadecet.edu.br','0',2),(174,'ACACIO SALVADOR VERAS E SILVA JUNIOR','22:3449;523','acacio.voxer@gmail.com','0',2),(175,'BERNARDO AURÉLIO DE ANDRADE OLIVEIRA','2265538;525','bernardohq@hotmail.com','0',2),(176,'CARLOS ALBERTO SOUSA SILVEIRA','99854;4556;','ca25te@hotmail.com','0',2),(177,'VINICIUS SILVA GONÇALVES','29226396574','vinisgon2@gmail.com','0',2),(178,'DHANIEL LUCKAS TERTO MADEIRA FERREIRA','8224328;582','dhaniel.terto@unicet.edu.br','0',2),(179,'LUIZA LOURDES PINHEIRO LEAL NUNES FERREIRA','32845:725;9','luiza.ferreira@faculdadecet.edu.br','0',2),(180,'ELIANA FREIRE DO NASCIMENTO','72685463526','elianafreirenascimento@gmail.com','0',2),(181,'LAYANNE CAVALCANTE DE MOURA','2234;9:85;2','layannecavalcante @hotmail.com','0',2),(182,'LUCAS MATEUS DE LIMA NERIS','29877639564','lucas.neris@faculdadecet.edu.br','0',2),(183,'DAVES PRADO PONTES MOURA E SILVA',':3;22262566','daves.pontes@faculdadecet.edu.br','0',2),(184,'FABIOLA FERREIRA HORTENCIO VERAS','66665499537','fabiola.hortencio@unicet.edu.br','0',2),(185,'MIGUEL ANTONIO TEIXEIRA FERREIRA','24:;594;55;','miguel.ferreira@faculdadecet.edu.br','0',2),(186,'ALDA CASSIA ALVES DA SILVA','284688:;54;','alda.alves@unicet.edu.br','0',2),(187,'ANTONIO CARLOS LEAL CORTEZ','8837;:6;5:9','antonio.cortez@unicet.edu.br','0',2),(188,'SERGIO HENRIQUE MOURÃO GUIMARÃES DE MORAIS MENESES','843899;258:','dr.sergiomgm@outlook.com','0',2),(189,'THIAGO PEREIRA DINIZ','263:6357553','thiagopereiradiniz@yahoo.com.br','0',2),(190,'FREDERICO MAIA PRADO','23256397549','fredprado21@hotmail.com','0',2),(191,'GEORGIA MARIA IZIDORIO AGOSTINHO',':;253785537','geoagostinho@hotmail.com','0',2),(192,'THIAGO HENRIQUE GONÇALVES MOREIRA','34643857952','thiago.goncalves@unicet.edu.br','0',2),(193,'EURIPEDES FERREIRA ARAUJO MENDES',';395364;526','euripedes_fam@hotmail.com','0',2),(194,'FABRIZIO FREITAS NUNES','2469936853;','fabrizio.freitas1043@gmail.com','0',2),(195,'LARA BASILIO MEDEIROS VERAS','86;3;;;6542','lara.veras@faculdadecet.edu.br','0',1),(196,'MAURÍLIO BATISTA LIMA','267875::589','maurilio.lima@faculdadecet.edu.br','0',2),(197,'SILVIA AMÉLIA PRADO BURGOS MADEIRA CAMPOS',':38237955;3','silvia.campos@faculdadecet.edu.br','0',2),(198,'EDUARDO SALMITO SOARES PINTO','24386:68568','eduardo.soares@unicet.edu.br','0',2),(199,'JULIO CESAR AYRES FERREIRA FILHO','8;57;947537','julio.filho@unicet.edu.br','0',2),(200,'LUIZ CARLOS NOGUEIRA FALCÃO','22696:75595','luiz.falcao@faculdadecet.edu.br','0',2),(201,'MOISÉS DA SILVA OLIVEIRA','57326474575','moises.oliveira@unicet.edu.br','0',2),(202,'ANA VALERIA SANTOS PEREIRA DE ALMEIDA',':4:7;4;;522','ana.almeida@unicet.edu.br','0',2),(203,'DAYRTON RAULINO MOREIRA','24533;65538','dayrton.moreira@gmail.com','0',2),(204,'EUCÁRIO LEITE MONTEIRO ALVES','4398;:99526','eucmonteiro@yahoo.com.br','0',2),(205,'JYSELDA DE JESUS LEMOS DUARTE','564425;;594','jyselda.duarte@faculdadecet.edu.br','0',2),(206,'LILIAM MENDES DE ARAÚJO','52;6443956;','liliam.mendes@faculdadecet.edu.br','0',2),(207,'LORENA MARIA BARROS BRITO BATISTA',':277975:522','lorena.batista@faculdadecet.edu.br','0',2),(208,'LUCAS DA SILVEIRA TERTO','234627:5592','lucas.terto@faculdadecet.edu.br','0',2),(209,'NAGELE DE SOUSA LIMA',';895;364522','nagele.lima@faculdadecet.edu.br','0',2),(210,'PATRICIA MOREIRA MELO',';3:69223522','patricia.melo@unicet.edu.br','0',2),(211,'THADEU DO LAGO BARATTA MONTEIRO','9927:8:4594','thadeu.monteiro@faculdadecet.edu.br','0',2),(212,'THIAGO SOARES GONDIM MEDEIROS',':2::26;75;3','thiago.medeiros@faculdadecet.edu.br','0',2),(213,'VIRGINIA PORTELA CARDOSO','246429495;:','vii.portela@gmail.com','0',2),(214,'WELLIGTON RIBEIRO FIGUEIREDO','8723568:575','welligton.figueiredo@faculdadecet.edu.br','0',2),(215,'ALESSE RIBEIRO DOS SANTOS',':2737682542','alesse.santos@unicet.edu.br','0',2),(216,'ANA MARIA PEARCE DE AREA LEÃO PINHEIRO',':6::3756522','ana.pinheiro@unicet.edu.br','0',2),(217,'LAURO LOURIVAL LOPES FILHO','2884528;594','lauro.filho@faculdadecet.edu.br','0',2),(218,'LEANDRO PONCE LEAL','3899:8;;:63','leandro.leal@faculdadecet.edu.br','0',2),(219,'MARCELO OLIVEIRA DA COSTA','92585872522','marcelo.costa@faculdadecet.edu.br','0',2),(220,'THAIS RODRIGUES CARVALHO','2722;353596','thais-rod@hotmail.com','0',2),(221,'AURUS DOURADO MENESES',';29:7283526','aurus.meneses@unicet.edu.br','0',2),(222,'BRUNO MACEDO GONÇALVES','23599:845;;','brunomg.bruno@hotmail.com','0',2),(223,'DANILO GONÇALVES DANTAS','246:62:357;','danilodantasmed@gmail.com','0',2),(224,'FLÁVIO CARVALHO SANTOS FILHO','265974:8564','flavio0209@gmail.com','0',2),(225,'GERMANO DA PAZ OLIVEIRA',';348:86:575','germano.oliveira@faculdadecet.edu.br','0',2),(226,'LAÍS MOREIRA DE GALIZA','2428;6:;524','lais.galiza@faculdadecet.edu.br','0',2),(227,'LEONARDO DE MOURA SOUSA JUNIOR',';84886445:9','leonardo.junior@faculdadecet.edu.br','0',2),(228,'MARIANA DE NOVAES SANTOS MAGALHÃES PINHEIRO','22:7:7;4526','mariana.pinheiro@faculdadecet.edu.br','0',2),(229,'ANTONIO NUNES NUNES PEREIRA','528:24;:526','antonio.pereira@unicet.edu.br','0',2),(230,'ATÊNCIO PEREIRA DE QUEIROGA FILHO','774624895;3','atenciofilho@hotmail.com','0',2),(231,'DENISE DELMONDE MEDEIROS','822624465:6','denisedelmonde@hotmail.com','0',2),(232,'ELNA JOELANE LOPES DA SILVA DO AMARAL','983;69:958:','elna.amaral@faculdadecet.edu.br','0',2),(233,'FLAVIA CARVALHAL FRAZÃO CORREA ARRAIS',':62:;8:956;','flaviafrazao@hotmail.com','0',2),(234,'FLÁVIA VERÍSSIMO MELO E SILVA','8225:298587','fverissima@gmail.com','0',2),(235,'LUIZA IVETE VIEIRA BATISTA','5644999858:','luiza.batista@faculdadecet.edu.br','0',2),(236,'RAIMUNDO FELIX DOS SANTOS JUNIOR','74899::75:9','raimundo.junior@faculdadecet.edu.br','0',2),(237,'WILLIAMS CARDEC DA SILVA',';;5624:558:','williams.silva@faculdadecet.edu.br','0',2),(238,'GERARDO VIANA DO MONTE NETO','86945;3956;','dr.gerardoviana@hotmail.com','0',2),(239,'EGIDIA MARIA MOURA DE PAULO MARTINS VIEIRA','7758:329537','egidia.moura@unicet.edu.br','0',2),(240,'FRANCISCO BRUNO NUNES NASCIMENTO SILVA','26;65427543','bruno.nunes@unicet.edu.br','0',2),(241,'GISELLE TORRES FEITOSA',';6597;635;3','giselle.feitosa@faculdadecet.edu.br','0',2),(242,'JOSÉ CARLOS DE OLIVEIRA GOMES FILHO',';798726458:','jose.oliveira@unicet.edu.br','0',2),(243,'KARINA OLIVEIRA LUSTOSA','2795;882582','karina.lustosa@unicet.edu.br','0',2),(244,'LUANA KELLE BATISTA MOURA','23739354577','luana.moura@unicet.edu.br','0',1),(245,'LUCAS FERNANDES FALCÃO','255:3443559','lucas.falcao@unicet.edu.br','0',2),(246,'MARCELYA CHRYSTIAN MOURA ROCHA','249689295;2','marcelya.chrystian@hotmail.com','0',2),(247,'VICTOR WILLIAN FERREIRA DOURADO','2835767657:','victor.dourado@unicet.edu.br','0',2),(248,'LUCIANA REINALDO LIMA','88::9462522','luciana.lima@unicet.edu.br','0',2),(249,'THIAGO LIMA MONTE',':5398978594','thiago.monte@unicet.edu.br','0',2),(250,'WILANA DA SILVA MOURA','22952292523','wilana.moura@unicet.edu.br','0',2),(251,'CARINE SOARES BORGES',':5:6467658:','carine.borges@unicet.edu.br','0',2),(252,'PATRÍCIA JOST','267:6387557','patricia.jost@unicet.edu.br','0',2),(253,'SERGIO ANTONIO PEREIRA FREITAS','6;948;65575','sergio.freitas@unicet.edu.br','0',2),(254,'MISAEL COSTA JÚNIOR','275;6:;:546','misael.junior@faculdadecet.edu.br','0',2),(255,'GUILHERMINA CASTRO SILVA','6853;6:656;','guilherminacastro50@gmail.com','0',2),(256,'JOÉLCIO BRAGA DE SOUSA','228;486;59;','joelciobs@gmail.com','0',2),(257,'ISMAEL MENDES DA SILVA','2724754:536','ismael.mendes@unicet.edu.br','0',2),(258,'ISABEL CHRISTYNA DE OLIVEIRA BATISTA','84;6:99858:','isabel.batista@faculdadecet.edu.br','0',2),(259,'JOCERLANO SANTOS DE SOUSA',':745679756;','jocerlanosousa@hotmail.com','0',2),(260,'JOÃO LUIZ VIEIRA RIBEIRO','44993;6:542','joao.ribeiro@faculdadecet.edu.br','0',2),(261,'IONE MARIA RIBEIRO SOARES LOPES','2885;:8258:','ione.lopes@faculdadecet.edu.br','0',2),(262,'ISANIO VASCONCELOS MESQUITA','564;3;5:56;','isanio.mesquita@faculdadecet.edu.br','0',2),(263,'JOSÉ ARIMATÉA DOS SANTOS JUNIOR','6:4256545:9','jose.santos@faculdadecet.edu.br','0',2),(264,'JOSÉ JAMES LIMA DA SILVA SEGUNDO','2266595;596','jose.segundo@faculdadecet.edu.br','0',2),(265,'GUSTAVO SOUSA NOLETO','22887394525','gustavo.noleto@faculdadecet.edu.br','0',2),(266,'ISABEL CRISTINA QUARESMA RÊGO','4238;3:5522','isabel.quaresma@unicet.edu.br','0',2),(267,'ISABELA FLORIANO NUNES','22956;2955:','isabela.floriano@unicet.edu.br','0',2),(268,'JAIRON DESIDÉRIO CARDOSO','2949864554:','jairon.cardoso@faculdadecet.edu.br','0',2),(269,'MÁRIO RODRIGUES GOMES MEIRELES FILHO','675;;7;2566','mario.meireles@unicet.edu.br','0',1),(321,'Coordenador Geral','',NULL,NULL,1);
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pla_coordenador_curso`
--

DROP TABLE IF EXISTS `pla_coordenador_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pla_coordenador_curso` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `codcurso` int NOT NULL,
  UNIQUE KEY `pla_coordenador_curso_usernamecurso_IDX` (`username`,`codcurso`) USING BTREE,
  KEY `pla_coordenador_curso_codcurso_IDX` (`codcurso`) USING BTREE,
  KEY `pla_coordenador_curso_username_IDX` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pla_coordenador_curso`
--

LOCK TABLES `pla_coordenador_curso` WRITE;
/*!40000 ALTER TABLE `pla_coordenador_curso` DISABLE KEYS */;
INSERT INTO `pla_coordenador_curso` VALUES ('675;;7;2566',2),('8878749:556',10),('2294;895538',12),('22537645588',16),('9458544556;',25),('9458544556;',26),('86;3;;;6542',30),('675;;7;2566',38),('23739354577',52),(':74299:25:9',56);
/*!40000 ALTER TABLE `pla_coordenador_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pla_curso_disciplina`
--

DROP TABLE IF EXISTS `pla_curso_disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pla_curso_disciplina` (
  `PERIODO_LETIVO` varchar(255) DEFAULT NULL,
  `CODCURSO` varchar(3) DEFAULT NULL,
  `NOME_CURSO` varchar(255) DEFAULT NULL,
  `CODTURMA` varchar(255) DEFAULT NULL,
  `IDTURMADISC` decimal(10,0) DEFAULT NULL,
  `NOMEDISCIPLINA` varchar(255) DEFAULT NULL,
  `CH` double DEFAULT NULL,
  `CODPROF` varchar(255) DEFAULT NULL,
  `NOMEPROFESSOR` varchar(255) DEFAULT NULL,
  `CPF` varchar(255) DEFAULT NULL,
  `TITULACAO` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `ID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `pla_curso_disciplina_CODCURSO_IDX` (`CODCURSO`) USING BTREE,
  KEY `pla_curso_disciplina_CPF_IDX` (`CPF`) USING BTREE,
  KEY `pla_curso_disciplina_NOMEPROFESSOR_IDX` (`NOMEPROFESSOR`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pla_curso_disciplina`
--

LOCK TABLES `pla_curso_disciplina` WRITE;
/*!40000 ALTER TABLE `pla_curso_disciplina` DISABLE KEYS */;
INSERT INTO `pla_curso_disciplina` VALUES ('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','BA-1',9930,'TRABALHO DE CONCLUSÃO DE CURSO',80,'559','ANA KAROLINE DA SILVA BRITO','26:533425:5','Doutor','ana.karolinne@unicet.edu.br',1),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','BA-1',9988,'METODOLOGIA DA PESQUISA',80,'559','ANA KAROLINE DA SILVA BRITO','26:533425:5','Doutor','ana.karolinne@unicet.edu.br',2),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','BA-1',9931,'OPTATIVA II',40,'560','DEILLANY MARTINS MENDES',';;48:;;2522','Especialista','deillany.mendes@hotmail.com',3),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','BA-1',9687,'CULTURA AFRO-BRASILEIRA E INDÍGENA',41,'781','GUILHERMINA CASTRO SILVA','6853;6:656;','Doutor','guilherminacastro50@gmail.com',4),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','BA-1',9929,'GESTÃO HOSPITALAR',40,'781','GUILHERMINA CASTRO SILVA','6853;6:656;','Doutor','guilherminacastro50@gmail.com',5),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','BA-1',9689,'GESTÃO DE TURISMO',40,'782','JOÉLCIO BRAGA DE SOUSA','228;486;59;','Mestre','joelciobs@gmail.com',6),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','BA-1',9690,'SEMINÁRIOS AVANÇADOS',40,'782','JOÉLCIO BRAGA DE SOUSA','228;486;59;','Mestre','joelciobs@gmail.com',7),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','BA-1',9688,'ESTÁGIO CURRICULAR SUPERVISIONADO I',160,'624','MARCIO LUCIANO PEREIRA BATISTA','9458544556;','Doutor','professor79@faculdadecet.edu.br',8),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','GER-2026.1',9987,'METODOLOGIA DA PESQUISA',80,'559','ANA KAROLINE DA SILVA BRITO','26:533425:5','Doutor','ana.karolinne@unicet.edu.br',9),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','GER-2026.1',9933,'OPTATIVA II',40,'560','DEILLANY MARTINS MENDES',';;48:;;2522','Especialista','deillany.mendes@hotmail.com',10),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','GER-2026.1',9685,'CULTURA AFRO-BRASILEIRA E INDÍGENA',41,'781','GUILHERMINA CASTRO SILVA','6853;6:656;','Doutor','guilherminacastro50@gmail.com',11),('2026.1','25','BACHARELADO EM ADMINISTRAÇÃO','GER-2026.1',9686,'ESTÁGIO CURRICULAR SUPERVISIONADO I',160,'624','MARCIO LUCIANO PEREIRA BATISTA','9458544556;','Doutor','professor79@faculdadecet.edu.br',12),('2026.1','26','BACHARELADO EM CIÊNCIAS CONTÁBEIS','BCC-1',9691,'METODOLOGIA DA PESQUISA',80,'559','ANA KAROLINE DA SILVA BRITO','26:533425:5','Doutor','ana.karolinne@unicet.edu.br',13),('2026.1','26','BACHARELADO EM CIÊNCIAS CONTÁBEIS','BCC-1',9932,'OPTATIVA II',40,'560','DEILLANY MARTINS MENDES',';;48:;;2522','Especialista','deillany.mendes@hotmail.com',14),('2026.1','26','BACHARELADO EM CIÊNCIAS CONTÁBEIS','BCC-1',9692,'CULTURA AFRO-BRASILEIRA E INDÍGENA',41,'781','GUILHERMINA CASTRO SILVA','6853;6:656;','Doutor','guilherminacastro50@gmail.com',15),('2026.1','26','BACHARELADO EM CIÊNCIAS CONTÁBEIS','BCC-1',9934,'CONTROLADORIA',40,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',16),('2026.1','26','BACHARELADO EM CIÊNCIAS CONTÁBEIS','BCC-1',9693,'ESTÁGIO SUPERVISIONADO I',160,'624','MARCIO LUCIANO PEREIRA BATISTA','9458544556;','Doutor','professor79@faculdadecet.edu.br',17),('2026.1','9','BIOMEDICINA','M2-B1',9914,'ECOLOGIA',60,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',18),('2026.1','9','BIOMEDICINA','M2-B1',9916,'MICROBIOLOGIA CLÍNICA',45,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',19),('2026.1','9','BIOMEDICINA','M2-B1',9915,'LÍQUIDOS CORPORAIS E URINÁLISE',60,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',20),('2026.1','9','BIOMEDICINA','M2-B1',9918,'ESTAGIO SUPERVISIONADO II',360,'216','MARIA DAS GRAÇAS PRIANTI','27583796:27','Doutor','mgprianti@gmail.com',21),('2026.1','9','BIOMEDICINA','M2-B1',9917,'TRABALHO DE CONCLUSÃO DE CURSO I',75,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',22),('2026.1','9','BIOMEDICINA','M2-B2',9913,'ANÁLISE AMBIENTAL',45,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',23),('2026.1','9','BIOMEDICINA','M2-B2',9971,'ANATOMIA HUMANA',90,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',24),('2026.1','9','BIOMEDICINA','M2-B2',9911,'PATOLOGIA GERAL',90,'216','MARIA DAS GRAÇAS PRIANTI','27583796:27','Doutor','mgprianti@gmail.com',25),('2026.1','9','BIOMEDICINA','M2-B2',9910,'SOROLOGIA',30,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',26),('2026.1','9','BIOMEDICINA','S-B1',9922,'GENÉTICA BÁSICA',75,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',27),('2026.1','9','BIOMEDICINA','S-B1',9924,'INFORMÁTICA APLICADA À SAÚDE',45,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',28),('2026.1','9','BIOMEDICINA','S-B1',9921,'ANÁLISE AMBIENTAL',45,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',29),('2026.1','9','BIOMEDICINA','S-B1',10027,'ÉTICA PROFISSIONAL E BIOÉTICA',45,'762','LUCAS MATOS OLIVEIRA','283749455;8','Doutor','lucas.oliveira@faculdadecet.edu.br',30),('2026.1','9','BIOMEDICINA','S-B1',10028,'VIROLOGIA',45,'762','LUCAS MATOS OLIVEIRA','283749455;8','Doutor','lucas.oliveira@faculdadecet.edu.br',31),('2026.1','9','BIOMEDICINA','S-B1',9920,'EPIDEMIOLOGIA E SAÚDE PÚBLICA',45,'216','MARIA DAS GRAÇAS PRIANTI','27583796:27','Doutor','mgprianti@gmail.com',32),('2026.1','9','BIOMEDICINA','S-B1',9923,'MICROBIOLOGIA BÁSICA',60,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',33),('2026.1','9','BIOMEDICINA','S-B2',10098,'HISTOLOGIA',60,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',34),('2026.1','9','BIOMEDICINA','S-B2',10100,'BIOFÍSICA',60,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',35),('2026.1','9','BIOMEDICINA','S-B2',10097,'BIOLOGIA CELULAR',60,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',36),('2026.1','9','BIOMEDICINA','S-B2',10101,'CIÊNCIAS SOCIAIS APLICADA À SAÚDE',30,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',37),('2026.1','9','BIOMEDICINA','S-B2',10099,'ANATOMIA HUMANA',90,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',38),('2026.1','9','BIOMEDICINA','S-B2',10096,'METODOLOGIA CIENTÍFICA',30,'769','RUSBENE BRUNO FONSECA DE CARVALHO','252773::587','Doutor','rusbene.carvalho@unicet.edu.br',39),('2026.1','38','DESIGN GRÁFICO','M2-DG-01',10135,'PROJETO INTEGRADOR II',45,'792','ACACIO SALVADOR VERAS E SILVA JUNIOR','22:3449;523','Mestre','acacio.voxer@gmail.com',40),('2026.1','38','DESIGN GRÁFICO','M2-DG-01',9797,'FUNDAMENTOS DO DESIGN PARA PRODUÇÃO GRÁFICA EDITORIA',60,'308','BERNARDO AURÉLIO DE ANDRADE OLIVEIRA','2265538;525','Mestre','bernardohq@hotmail.com',41),('2026.1','38','DESIGN GRÁFICO','M2-DG-01',10025,'GESTÃO DE PROJETOS E MODELAGEM DE NEGÓCIOS DESIGN THINKING',60,'697','CARLOS ALBERTO SOUSA SILVEIRA','99854;4556;','Mestre','ca25te@hotmail.com',42),('2026.1','38','DESIGN GRÁFICO','M2-DG-01',9795,'FERRAMENTAS DE DESIGN',60,'758','VINICIUS SILVA GONÇALVES','29226396574','Especialista','vinisgon2@gmail.com',43),('2026.1','16','DIREITO','M1-D12',10015,'ESTÁGIO  SUPERVISIONADO II',150,'449','DANIEL CARVALHO SAMPAIO','22537645588','Mestre','professor04@faculdadecet.edu.br',44),('2026.1','16','DIREITO','M1-D12',10143,'PRÁTICA DE DIREITO DO TRABALHO',54,'775','DHANIEL LUCKAS TERTO MADEIRA FERREIRA','8224328;582','Mestre','dhaniel.terto@unicet.edu.br',45),('2026.1','16','DIREITO','M1-D12',10054,'PRÁTICA DO DIREITO PENAL',54,'565','ELSON JOSÉ DO RÊGO','882792655;3','Mestre','elsonrego@gmail.com',46),('2026.1','16','DIREITO','M1-D12',10002,'DIREITO PROCESSUAL CONSTITUCIONAL',36,'366','GISELLE KAROLINA GOMES FREITAS IBIAPINA',':7;265;4542','Mestre','giselle.freitas@faculdadecet.edu.br',47),('2026.1','16','DIREITO','M1-D12',10003,'DIREITO PROCESSUAL ADMINISTRATIVO E TRIBUTÁRIO',54,'705','LUIZA LOURDES PINHEIRO LEAL NUNES FERREIRA','32845:725;9','Mestre','luiza.ferreira@faculdadecet.edu.br',48),('2026.1','16','DIREITO','M1-D12',9813,'DIREITO CIVIL VII',54,'513','VANESSA NUNES DE BARROS MENDES','2353:475528','Mestre','professor45@faculdadecet.edu.br',49),('2026.1','16','DIREITO','M1-D13',10004,'PRÁTICA DE DIREITO CIVIL I',36,'578','ANA CAROLINNA BARROS SILVA','25;57225529','Mestre','ana.barros@unicet.edu.br',50),('2026.1','16','DIREITO','M1-D13',10017,'ESTÁGIO SUPERVISIONADO I',150,'449','DANIEL CARVALHO SAMPAIO','22537645588','Mestre','professor04@faculdadecet.edu.br',51),('2026.1','16','DIREITO','M1-D13',10124,'DIREITO DO TRABALHO II',54,'775','DHANIEL LUCKAS TERTO MADEIRA FERREIRA','8224328;582','Mestre','dhaniel.terto@unicet.edu.br',52),('2026.1','16','DIREITO','M1-D13',10145,'PRÁTICA DO DIREITO PENAL',54,'627','ENEDINA GIZELI ALBANO MOURA','26344266589','Mestre','enedinaalbanoadv@hotmail.com',53),('2026.1','16','DIREITO','M1-D13',10144,'DIREITO PROCESSUAL ADMINISTRATIVO E TRIBUTÁRIO',54,'705','LUIZA LOURDES PINHEIRO LEAL NUNES FERREIRA','32845:725;9','Mestre','luiza.ferreira@faculdadecet.edu.br',54),('2026.1','16','DIREITO','M1-D13',9814,'DIREITO PROCESSUAL  CIVIL II',72,'586','MAÍRA MELO CAVALCANTE','22939456267','Mestre','mcmaira@gmail.com',55),('2026.1','16','DIREITO','M1-D14',10006,'DIREITO PROCESSUAL  CIVIL II',72,'578','ANA CAROLINNA BARROS SILVA','25;57225529','Mestre','ana.barros@unicet.edu.br',56),('2026.1','16','DIREITO','M1-D14',9815,'DIREITO CIVIL V',54,'763','ELIANA FREIRE DO NASCIMENTO','72685463526','Doutor','elianafreirenascimento@gmail.com',57),('2026.1','16','DIREITO','M1-D14',10146,'DIREITO PROCESSUAL PENAL II',54,'565','ELSON JOSÉ DO RÊGO','882792655;3','Mestre','elsonrego@gmail.com',58),('2026.1','16','DIREITO','M1-D14',10005,'ÉTICA GERAL E PROFISSIONAL',36,'705','LUIZA LOURDES PINHEIRO LEAL NUNES FERREIRA','32845:725;9','Mestre','luiza.ferreira@faculdadecet.edu.br',59),('2026.1','16','DIREITO','M1-D15',9816,'DIREITO PROCESSUAL PENAL I',72,'565','ELSON JOSÉ DO RÊGO','882792655;3','Mestre','elsonrego@gmail.com',60),('2026.1','16','DIREITO','M1-D15',10008,'DIREITO TRIBUTÁRIO I',36,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',61),('2026.1','16','DIREITO','M1-D15',10125,'DIREITO ADMINISTRATIVO III',54,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',62),('2026.1','16','DIREITO','M1-D15',10007,'DIREITO CIVIL IV',54,'564','THALITA FURTADO MASCARENHAS LUSTOSA','2482:45857;','Mestre','professor41@faculdadecet.edu.br',63),('2026.1','16','DIREITO','M1-D16',10010,'DIREITO PENAL IV',54,'530','EULANE COELHO BATISTA','246;3323522','Mestre','draeulanecoelho@gmail.com',64),('2026.1','16','DIREITO','M1-D16',9817,'DIREITO ADMINISTRATIVO I',54,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',65),('2026.1','16','DIREITO','M1-D16',10009,'DIREITO EMPRESARIAL II',54,'587','TATIANA VELOSO MAGALHAES','239439:852;','Mestre','professor59@faculdadecet.edu.br',66),('2026.1','16','DIREITO','M1-D16',10147,'DIREITO CIVIL III',54,'513','VANESSA NUNES DE BARROS MENDES','2353:475528','Mestre','professor45@faculdadecet.edu.br',67),('2026.1','16','DIREITO','M1-D17',9818,'DIREITO CONSTITUCIONAL I',72,'366','GISELLE KAROLINA GOMES FREITAS IBIAPINA',':7;265;4542','Mestre','giselle.freitas@faculdadecet.edu.br',68),('2026.1','16','DIREITO','M1-D17',10011,'DIREITO PENAL I',72,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',69),('2026.1','16','DIREITO','M1-D17',10055,'DIREITO CIVIL I',72,'564','THALITA FURTADO MASCARENHAS LUSTOSA','2482:45857;','Mestre','professor41@faculdadecet.edu.br',70),('2026.1','16','DIREITO','M1-D18',10012,'PORTUGUÊS APLICADO AO DIREITO',54,'560','DEILLANY MARTINS MENDES',';;48:;;2522','Especialista','deillany.mendes@hotmail.com',71),('2026.1','16','DIREITO','M1-D18',9615,'INTRODUÇÃO AO ESTUDO DO DIREITO',72,'627','ENEDINA GIZELI ALBANO MOURA','26344266589','Mestre','enedinaalbanoadv@hotmail.com',72),('2026.1','16','DIREITO','M1-D18',10148,'FILOSOFIA GERAL E JURÍDICA',54,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',73),('2026.1','16','DIREITO','M1-D18',10013,'SOCIOLOGIA GERAL E JURÍDICA',54,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',74),('2026.1','16','DIREITO','M2-D13',9819,'DIREITO E INOVAÇÕES TECNOLÓGICAS',36,'565','ELSON JOSÉ DO RÊGO','882792655;3','Mestre','elsonrego@gmail.com',75),('2026.1','16','DIREITO','M2-D14',9972,'DIREITO DA SEGURIDADE SOCIAL',54,'578','ANA CAROLINNA BARROS SILVA','25;57225529','Mestre','ana.barros@unicet.edu.br',76),('2026.1','16','DIREITO','M2-D14',10016,'ESTÁGIO  SUPERVISIONADO II',150,'449','DANIEL CARVALHO SAMPAIO','22537645588','Mestre','professor04@faculdadecet.edu.br',77),('2026.1','16','DIREITO','M2-D14',10136,'DIREITO INTERNACIONAL PRIVADO',36,'763','ELIANA FREIRE DO NASCIMENTO','72685463526','Doutor','elianafreirenascimento@gmail.com',78),('2026.1','16','DIREITO','M2-D14',10137,'DIREITO PROCESSUAL DO TRABALHO',72,'565','ELSON JOSÉ DO RÊGO','882792655;3','Mestre','elsonrego@gmail.com',79),('2026.1','16','DIREITO','M2-D14',9985,'DIREITO DO TRABALHO II',54,'564','THALITA FURTADO MASCARENHAS LUSTOSA','2482:45857;','Mestre','professor41@faculdadecet.edu.br',80),('2026.1','16','DIREITO','M2-D14',9820,'DIREITO CIVIL VI',54,'513','VANESSA NUNES DE BARROS MENDES','2353:475528','Mestre','professor45@faculdadecet.edu.br',81),('2026.1','16','DIREITO','M2-D15',9821,'DIREITO PENAL III',54,'565','ELSON JOSÉ DO RÊGO','882792655;3','Mestre','elsonrego@gmail.com',82),('2026.1','16','DIREITO','M2-D15',9975,'DIREITO PROCESSUAL PENAL I',72,'627','ENEDINA GIZELI ALBANO MOURA','26344266589','Mestre','enedinaalbanoadv@hotmail.com',83),('2026.1','16','DIREITO','M2-D15',9976,'DIREITO TRIBUTÁRIO I',36,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',84),('2026.1','16','DIREITO','M2-D15',9974,'DIREITO EMPRESARIAL II',54,'587','TATIANA VELOSO MAGALHAES','239439:852;','Mestre','professor59@faculdadecet.edu.br',85),('2026.1','16','DIREITO','M2-D15',10138,'DIREITO CIVIL IV',54,'513','VANESSA NUNES DE BARROS MENDES','2353:475528','Mestre','professor45@faculdadecet.edu.br',86),('2026.1','16','DIREITO','M2-D16',10111,'DIREITO PENAL III',54,'530','EULANE COELHO BATISTA','246;3323522','Mestre','draeulanecoelho@gmail.com',87),('2026.1','16','DIREITO','M2-D16',9978,'DIREITO FINANCEIRO',36,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',88),('2026.1','16','DIREITO','M2-D16',9977,'ANTROPOLOGIA JURÍDICA',36,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',89),('2026.1','16','DIREITO','M2-D16',9822,'DIREITO EMPRESARIAL I',54,'586','MAÍRA MELO CAVALCANTE','22939456267','Mestre','mcmaira@gmail.com',90),('2026.1','16','DIREITO','M2-D16',10026,'DIREITO CIVIL III',54,'564','THALITA FURTADO MASCARENHAS LUSTOSA','2482:45857;','Mestre','professor41@faculdadecet.edu.br',91),('2026.1','16','DIREITO','M2-D17',9979,'DIREITO CIVIL II',54,'449','DANIEL CARVALHO SAMPAIO','22537645588','Mestre','professor04@faculdadecet.edu.br',92),('2026.1','16','DIREITO','M2-D17',10110,'DIREITO PENAL II',72,'627','ENEDINA GIZELI ALBANO MOURA','26344266589','Mestre','enedinaalbanoadv@hotmail.com',93),('2026.1','16','DIREITO','M2-D17',9823,'DIREITO CONSTITUCIONAL II',72,'366','GISELLE KAROLINA GOMES FREITAS IBIAPINA',':7;265;4542','Mestre','giselle.freitas@faculdadecet.edu.br',94),('2026.1','16','DIREITO','M2-D17',9980,'MEDIAÇÃO E ARBITRAGEM',36,'451','JUSTINA ALZIRA SOARES DO NASCIMENTO','8377375:556','Mestre','justina.alzira@unicet.edu.br',95),('2026.1','16','DIREITO','M2-D17',10140,'HERMENÊUTICA JURÍDICA',36,'586','MAÍRA MELO CAVALCANTE','22939456267','Mestre','mcmaira@gmail.com',96),('2026.1','16','DIREITO','M2-D18',9981,'DIREITO INTERNACIONAL PÚBLICO',54,'763','ELIANA FREIRE DO NASCIMENTO','72685463526','Doutor','elianafreirenascimento@gmail.com',97),('2026.1','16','DIREITO','M2-D18',9824,'DIREITO PENAL I',72,'565','ELSON JOSÉ DO RÊGO','882792655;3','Mestre','elsonrego@gmail.com',98),('2026.1','16','DIREITO','M2-D18',10109,'DIREITO CONSTITUCIONAL I',72,'366','GISELLE KAROLINA GOMES FREITAS IBIAPINA',':7;265;4542','Mestre','giselle.freitas@faculdadecet.edu.br',99),('2026.1','16','DIREITO','M2-D18',10141,'PSICOLOGIA FORENSE',36,'669','ISMAEL MENDES DA SILVA','2724754:536','Mestre','ismael.mendes@unicet.edu.br',100),('2026.1','16','DIREITO','M2-D18',9982,'HERMENÊUTICA JURÍDICA',36,'586','MAÍRA MELO CAVALCANTE','22939456267','Mestre','mcmaira@gmail.com',101),('2026.1','16','DIREITO','M2-D19',9983,'CIÊNCIA POLÍTICA E TEORIA GERAL DO ESTADO',54,'775','DHANIEL LUCKAS TERTO MADEIRA FERREIRA','8224328;582','Mestre','dhaniel.terto@unicet.edu.br',102),('2026.1','16','DIREITO','M2-D19',9984,'SOCIOLOGIA GERAL E JURÍDICA',54,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',103),('2026.1','16','DIREITO','M2-D19',10108,'HISTÓRIA DO DIREITO',54,'451','JUSTINA ALZIRA SOARES DO NASCIMENTO','8377375:556','Mestre','justina.alzira@unicet.edu.br',104),('2026.1','16','DIREITO','M2-D19',9825,'DIREITO CONSTITUCIONAL I',72,'705','LUIZA LOURDES PINHEIRO LEAL NUNES FERREIRA','32845:725;9','Mestre','luiza.ferreira@faculdadecet.edu.br',105),('2026.1','16','DIREITO','S-D1',9752,'PORTUGUÊS APLICADO AO DIREITO',54,'560','DEILLANY MARTINS MENDES',';;48:;;2522','Especialista','deillany.mendes@hotmail.com',106),('2026.1','16','DIREITO','S-D1',9618,'INTRODUÇÃO AO ESTUDO DO DIREITO',72,'775','DHANIEL LUCKAS TERTO MADEIRA FERREIRA','8224328;582','Mestre','dhaniel.terto@unicet.edu.br',107),('2026.1','16','DIREITO','S-D1',9755,'FILOSOFIA GERAL E JURÍDICA',54,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',108),('2026.1','16','DIREITO','S-D1',10082,'LÍNGUA BRASILEIRA DE SINAIS-LIBRAS',30,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',109),('2026.1','16','DIREITO','S-D1',9753,'ECONOMIA POLÍTICA',54,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',110),('2026.1','16','DIREITO','S-D1',9754,'METODOLOGIA DO TRABALHO CIENTÍFICO',36,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',111),('2026.1','16','DIREITO','S-D1',9751,'HISTÓRIA DO DIREITO',54,'564','THALITA FURTADO MASCARENHAS LUSTOSA','2482:45857;','Mestre','professor41@faculdadecet.edu.br',112),('2026.1','16','DIREITO','S-D3',9749,'DIREITO INTERNACIONAL PÚBLICO',54,'763','ELIANA FREIRE DO NASCIMENTO','72685463526','Doutor','elianafreirenascimento@gmail.com',113),('2026.1','16','DIREITO','S-D3',9747,'DIREITO CONSTITUCIONAL II',72,'366','GISELLE KAROLINA GOMES FREITAS IBIAPINA',':7;265;4542','Mestre','giselle.freitas@faculdadecet.edu.br',114),('2026.1','16','DIREITO','S-D3',9745,'PSICOLOGIA FORENSE',36,'669','ISMAEL MENDES DA SILVA','2724754:536','Mestre','ismael.mendes@unicet.edu.br',115),('2026.1','16','DIREITO','S-D3',9746,'DIREITO PENAL II',72,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',116),('2026.1','16','DIREITO','S-D3',9750,'HERMENÊUTICA JURÍDICA',36,'586','MAÍRA MELO CAVALCANTE','22939456267','Mestre','mcmaira@gmail.com',117),('2026.1','16','DIREITO','S-D3',9748,'DIREITO CIVIL II',54,'513','VANESSA NUNES DE BARROS MENDES','2353:475528','Mestre','professor45@faculdadecet.edu.br',118),('2026.1','10','ENFERMAGEM','GER-M2',9835,'FISIOLOGIA HUMANA',90,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',119),('2026.1','10','ENFERMAGEM','GER-M2',9833,'ANATOMIA HUMANA',90,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',120),('2026.1','10','ENFERMAGEM','GER-M2',9836,'BIOFÍSICA',60,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',121),('2026.1','10','ENFERMAGEM','M1-E3',9843,'ENFERMAGEM NA ATENÇÃO AO CLIENTE DE ALTO RISCO',75,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',122),('2026.1','10','ENFERMAGEM','M1-E3',9844,'ENFERMAGEM EM SAÚDE DO IDOSO',90,'351','MARIA NAUSIDE PESSOA DA SILVA','462:2:::58:','Doutor','nauside@yahoo.com.br',123),('2026.1','10','ENFERMAGEM','M1-E4',9845,'ENFERMAGEM EM INFECTOLOGIA E CONTROLE DE INFECÇÕES NOS SERVIÇOS DE SAÚDE',45,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',124),('2026.1','10','ENFERMAGEM','M1-E4',9846,'ENFERMAGEM PERIOPERATÓRIA',120,'571','LORENA ROCHA BATISTA CARVALHO','2262279;554','Mestre','professor49@faculdadecet.edu.br',125),('2026.1','10','ENFERMAGEM','M1-E4',9995,'DISCIPLINA OPTATIVA IV',30,'571','LORENA ROCHA BATISTA CARVALHO','2262279;554','Mestre','professor49@faculdadecet.edu.br',126),('2026.1','10','ENFERMAGEM','M1-E4',9848,'ESTÁGIO CURRICULAR SUPERVISIONADO I: ATENÇAO BÁSICA E MÉDIA COMPLEXIDADE',415,'494','MÁRCIA LAÍS FORTES RODRIGUES MATTOS','8878749:556','Especialista','professor30@faculdadecet.edu.br',127),('2026.1','10','ENFERMAGEM','M1-E4',9847,'ENFERMAGEM NA SAÚDE DA FAMILIA',90,'351','MARIA NAUSIDE PESSOA DA SILVA','462:2:::58:','Doutor','nauside@yahoo.com.br',128),('2026.1','10','ENFERMAGEM','M1-E5',9851,'TECNOLOGIAS EM SAÚDE',30,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',129),('2026.1','10','ENFERMAGEM','M1-E5',9850,'ENFERMAGEM EM SAÚDE MENTAL',120,'508','LAYANNE CAVALCANTE DE MOURA','2234;9:85;2','Mestre','layannecavalcante @hotmail.com',130),('2026.1','10','ENFERMAGEM','M1-E5',9849,'ENFERMAGEM NA ATENÇÃO A SAÚDE DA MULHER',120,'571','LORENA ROCHA BATISTA CARVALHO','2262279;554','Mestre','professor49@faculdadecet.edu.br',131),('2026.1','10','ENFERMAGEM','M1-E6',9857,'ATIVIDADE INTEGRADORA II',30,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',132),('2026.1','10','ENFERMAGEM','M1-E6',9856,'INTRODUÇÃO A METODOLOGIA DA PESQUISA',45,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',133),('2026.1','10','ENFERMAGEM','M1-E6',9855,'FUNDAMENTOS DE SAÚDE AMBIENTAL',45,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',134),('2026.1','10','ENFERMAGEM','M1-E6',9853,'ANTROPOLOGIA APLICADA À SAÚDE',30,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',135),('2026.1','10','ENFERMAGEM','M1-E6',9852,'PARASITOLOGIA',75,'216','MARIA DAS GRAÇAS PRIANTI','27583796:27','Doutor','mgprianti@gmail.com',136),('2026.1','10','ENFERMAGEM','M1-E6',9854,'FUNDAMENTAÇÃO DO PROCESSO DE CUIDAR',45,'351','MARIA NAUSIDE PESSOA DA SILVA','462:2:::58:','Doutor','nauside@yahoo.com.br',137),('2026.1','10','ENFERMAGEM','M2-E5',9866,'GERENCIAMENTO DO PROCESSO DE TRABALHO EM ENFERMAGEM',75,'539','EVERTON MORAES LOPES','24935327596','Doutor','evertonlopesufpi@gmail.com',138),('2026.1','10','ENFERMAGEM','M2-E5',9864,'TRABALHO DE CONCLUSÃO DE CURSO I',30,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',139),('2026.1','10','ENFERMAGEM','M2-E5',9867,'INTERPRETAÇÃO DE EXAMES COMPLEMENTARES',30,'508','LAYANNE CAVALCANTE DE MOURA','2234;9:85;2','Mestre','layannecavalcante @hotmail.com',140),('2026.1','10','ENFERMAGEM','M2-E5',9869,'ESTÁGIO CURRICULAR SUPERVISONADO II: ÁREA HOSPITALAR ALTA COMPLEXIDADE E PRÁTICA INTEGRADA EM SAÚDE',415,'494','MÁRCIA LAÍS FORTES RODRIGUES MATTOS','8878749:556','Especialista','professor30@faculdadecet.edu.br',141),('2026.1','10','ENFERMAGEM','M2-E5',9865,'ENFERMAGEM EM SAÚDE DO ADULTO E DO HOMEM',90,'351','MARIA NAUSIDE PESSOA DA SILVA','462:2:::58:','Doutor','nauside@yahoo.com.br',142),('2026.1','10','ENFERMAGEM','M2-E5',10139,'DIDÁTICA APLICADA A ENFERMAGEM',30,'351','MARIA NAUSIDE PESSOA DA SILVA','462:2:::58:','Doutor','nauside@yahoo.com.br',143),('2026.1','10','ENFERMAGEM','M2-E6',9841,'ATIVIDADE INTEGRADORA III',30,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',144),('2026.1','10','ENFERMAGEM','M2-E6',9840,'PROCEDIMENTOS BÁSICOS DE ENFERMAGEM',120,'539','EVERTON MORAES LOPES','24935327596','Doutor','evertonlopesufpi@gmail.com',145),('2026.1','10','ENFERMAGEM','M2-E6',9839,'PSICOLOGIA APLICADA Á SAUDE',30,'155','KATIA CILENE DE OLIVEIRA PEREIRA','84442528594','Mestre','katia.pereira@cet.edu.br',146),('2026.1','10','ENFERMAGEM','M2-E6',9837,'SUPORTE BÁSICO DE VIDA',30,'571','LORENA ROCHA BATISTA CARVALHO','2262279;554','Mestre','professor49@faculdadecet.edu.br',147),('2026.1','10','ENFERMAGEM','M2-E6',9842,'HOME CARE',30,'571','LORENA ROCHA BATISTA CARVALHO','2262279;554','Mestre','professor49@faculdadecet.edu.br',148),('2026.1','10','ENFERMAGEM','M2-E6',9838,'TERAPIAS COMPLEMENTARES EM SAÚDE',30,'216','MARIA DAS GRAÇAS PRIANTI','27583796:27','Doutor','mgprianti@gmail.com',149),('2026.1','10','ENFERMAGEM','M2-E7',9831,'FISIOLOGIA HUMANA',90,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',150),('2026.1','10','ENFERMAGEM','M2-E7',9829,'ANATOMIA HUMANA',90,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',151),('2026.1','10','ENFERMAGEM','M2-E7',9832,'BIOFÍSICA',60,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',152),('2026.1','10','ENFERMAGEM','PE-E',10081,'SOCIOLOGIA APLICADA A SAUDE',30,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',153),('2026.1','10','ENFERMAGEM','S-E1',10087,'HISTOLOGIA E EMBRIOLOGIA',75,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',154),('2026.1','10','ENFERMAGEM','S-E1',10089,'BIOFÍSICA',60,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',155),('2026.1','10','ENFERMAGEM','S-E1',10088,'BIOLOGIA CELULAR',60,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',156),('2026.1','10','ENFERMAGEM','S-E1',10084,'SOCIOLOGIA APLICADA A SAUDE',30,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',157),('2026.1','10','ENFERMAGEM','S-E1',10085,'ANATOMIA HUMANA',90,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',158),('2026.1','10','ENFERMAGEM','S-E1',10086,'METODOLOGIA CIENTÍFICA',45,'769','RUSBENE BRUNO FONSECA DE CARVALHO','252773::587','Doutor','rusbene.carvalho@unicet.edu.br',159),('2026.1','10','ENFERMAGEM','S-E2',9997,'ATIVIDADE INTEGRADORA I',30,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',160),('2026.1','10','ENFERMAGEM','S-E2',9998,'INTRODUÇÃO A METODOLOGIA DA PESQUISA',45,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',161),('2026.1','10','ENFERMAGEM','S-E2',9996,'SOCIOLOGIA APLICADA A SAUDE',30,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',162),('2026.1','10','ENFERMAGEM','S-E2',9999,'BIOLOGIA CELULAR',60,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',163),('2026.1','10','ENFERMAGEM','S-E2',10000,'GENÉTICA E EVOLUÇÃO HUMANA',45,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',164),('2026.1','10','ENFERMAGEM','S-E2',10001,'BIOFÍSICA',60,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',165),('2026.1','10','ENFERMAGEM','S-E3',9743,'ATIVIDADE INTEGRADORA III',30,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',166),('2026.1','10','ENFERMAGEM','S-E3',9744,'MICROBIOLOGIA E IMUNOLOGIA',60,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',167),('2026.1','10','ENFERMAGEM','S-E3',9741,'FARMACOLOGIA BASICA',75,'539','EVERTON MORAES LOPES','24935327596','Doutor','evertonlopesufpi@gmail.com',168),('2026.1','10','ENFERMAGEM','S-E3',9737,'PARASITOLOGIA',75,'414','KEYLLA DA CONCEIÇÃO MACHADO','24::4594567','Doutor','keyllamachado06@hotmail.com',169),('2026.1','10','ENFERMAGEM','S-E3',9739,'EPIDEMIOLOGIA',45,'762','LUCAS MATOS OLIVEIRA','283749455;8','Doutor','lucas.oliveira@faculdadecet.edu.br',170),('2026.1','10','ENFERMAGEM','S-E3',9742,'TERAPIAS COMPLEMENTARES EM SAÚDE',30,'216','MARIA DAS GRAÇAS PRIANTI','27583796:27','Doutor','mgprianti@gmail.com',171),('2026.1','10','ENFERMAGEM','S-E3',9738,'FUNDAMENTAÇÃO DO PROCESSO DE CUIDAR',45,'351','MARIA NAUSIDE PESSOA DA SILVA','462:2:::58:','Doutor','nauside@yahoo.com.br',172),('2026.1','10','ENFERMAGEM','S-E3',9740,'BIOESTATISTICA APLICADA A ENFERMAGEM',45,'567','NELSON AGAPITO BRANDÃO RIOS',':;23:274575','Mestre','professor35@faculdadecet.edu.br',173),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-01',9779,'BANCO DE DADOS',60,'783','ANTONIO ALBERTO IBIAPINA COSTA FILHO','259232;6528','Mestre','antonio.filho@unicet.edu.br',174),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-01',9776,'SISTEMAS EMBARCADOS E INTERNET DAS COISAS (IoT)',60,'790','DANILO RODRIGUES BARBOSA',';6;2;998542','Especialista','danilo.barbosa@unicet.edu.br',175),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-01',9775,'PROGRAMAÇÃO ORIENTADA A OBJETO',60,'736','LUCAS MATEUS DE LIMA NERIS','29877639564','Especialista','lucas.neris@faculdadecet.edu.br',176),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-01',9778,'PROBABILIDADE E BIBLIOTECAS COMPUTACIONAIS PARA ESTATÍSTICA',60,'567','NELSON AGAPITO BRANDÃO RIOS',':;23:274575','Mestre','professor35@faculdadecet.edu.br',177),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-01',9777,'PROCESSAMENTO DE LINGUAGEM NATURAL',60,'753','ROMULLO RANDELL MACEDO CARVALHO','25;64397577','Mestre','romullo.carvalho@faculdadecet.edu.br',178),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-01',9781,'ESTÁGIO SUPERVISIONADO I',80,'753','ROMULLO RANDELL MACEDO CARVALHO','25;64397577','Mestre','romullo.carvalho@faculdadecet.edu.br',179),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-01',9780,'PROJETO INTEGRADOR I',60,'758','VINICIUS SILVA GONÇALVES','29226396574','Especialista','vinisgon2@gmail.com',180),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-03S',9764,'ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES',60,'790','DANILO RODRIGUES BARBOSA',';6;2;998542','Especialista','danilo.barbosa@unicet.edu.br',181),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-03S',9766,'ÉTICA, PROPRIEDADE INTELECTUAL E PATENTES',60,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',182),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-03S',9765,'REDES NEURAIS ARTIFICIAIS',60,'753','ROMULLO RANDELL MACEDO CARVALHO','25;64397577','Mestre','romullo.carvalho@faculdadecet.edu.br',183),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-03S',9763,'PARADIGMA E LINGUAGENS DE PROGRAMAÇÃO',60,'771','TARCÍSIO FRANCO JAIME','84595375522','Mestre','tarcisiofj@gmail.com',184),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-03S',9767,'INTERAÇÃO HUMANO-COMPUTADOR E UX/UI DESIGN',60,'758','VINICIUS SILVA GONÇALVES','29226396574','Especialista','vinisgon2@gmail.com',185),('2026.1','56','ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL','ENG-CIA-03S',9794,'LABORATÓRIO DE INTELIGÊNCIA ARTIFICIAL – PROJETOS REAIS DO ZERO AO PROTÓTIPO',60,'758','VINICIUS SILVA GONÇALVES','29226396574','Especialista','vinisgon2@gmail.com',186),('2026.1','12','FARMÁCIA','GER-S',10102,'HISTOLOGIA E EMBRIOLOGIA',75,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',187),('2026.1','12','FARMÁCIA','GER-S',10104,'BIOFÍSICA APLICADA Á FARMÁCIA',60,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',188),('2026.1','12','FARMÁCIA','GER-S',10103,'BIOLOGIA CELULAR',60,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',189),('2026.1','12','FARMÁCIA','GER-S',10106,'SOCIOLOGIA',30,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',190),('2026.1','12','FARMÁCIA','GER-S',10105,'ANATOMIA HUMANA',90,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',191),('2026.1','12','FARMÁCIA','GER-S',10107,'METODOLOGIA CIENTÍFICA',30,'769','RUSBENE BRUNO FONSECA DE CARVALHO','252773::587','Doutor','rusbene.carvalho@unicet.edu.br',192),('2026.1','12','FARMÁCIA','M1-F10',9721,'TECNOLOGIA FARMACÊUTICA II',60,'585','ANA CRISTINA SOUSA GRAMOZA VILARINHO SANTANA','259499;7523','Doutor','ana.cristina@unicet.edu.br',193),('2026.1','12','FARMÁCIA','M1-F10',9717,'TRABALHO DE CONCLUSÃO DO CURSO I(TCC-I)',30,'559','ANA KAROLINE DA SILVA BRITO','26:533425:5','Doutor','ana.karolinne@unicet.edu.br',194),('2026.1','12','FARMÁCIA','M1-F10',9719,'BIOLOGIA MOLECULAR',45,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',195),('2026.1','12','FARMÁCIA','M1-F10',9718,'LEGISLAÇÃO E DEONTOLOGIA FARMACÊUTICA',30,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',196),('2026.1','12','FARMÁCIA','M1-F10',9720,'ESTÁGIO CURRICULAR SUPERVISIONADO III - ANÁLISES CLÍNICAS',240,'613','PEDRO SIMÃO DA SILVA AZEVEDO','2754;3425;2','Mestre','professor38@faculdadecet.edu.br',197),('2026.1','12','FARMÁCIA','M1-F10',9716,'FARMÁCIA HOSPITALAR',75,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',198),('2026.1','12','FARMÁCIA','M1-F11',9722,'FARMACOTÉCNICA II',60,'585','ANA CRISTINA SOUSA GRAMOZA VILARINHO SANTANA','259499;7523','Doutor','ana.cristina@unicet.edu.br',199),('2026.1','12','FARMÁCIA','M1-F11',9724,'ANÁLISES BROMATOLÓGICAS',60,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',200),('2026.1','12','FARMÁCIA','M1-F11',9725,'CITOLOGIA CLÍNICA',60,'414','KEYLLA DA CONCEIÇÃO MACHADO','24::4594567','Doutor','keyllamachado06@hotmail.com',201),('2026.1','12','FARMÁCIA','M1-F11',9723,'TECNOLOGIA FARMACÊUTICA I',60,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',202),('2026.1','12','FARMÁCIA','M1-F11',9726,'ATENÇÃO E CUIDADO FARMACÊUTICO',30,'511','THIARA LORENNA BEZERRA DA SILVA OLIVEIRA','2294;895538','Mestre','thiaralorenna@gmail.com',203),('2026.1','12','FARMÁCIA','M1-F12',9728,'PARASITOLOGIA CLÍNICA',45,'762','LUCAS MATOS OLIVEIRA','283749455;8','Doutor','lucas.oliveira@faculdadecet.edu.br',204),('2026.1','12','FARMÁCIA','M1-F12',9729,'HEMATOLOGIA CLÍNICA',60,'216','MARIA DAS GRAÇAS PRIANTI','27583796:27','Doutor','mgprianti@gmail.com',205),('2026.1','12','FARMÁCIA','M1-F12',10142,'ASSISTÊNCIA FARMACÊUTICA',30,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',206),('2026.1','12','FARMÁCIA','M1-F12',9730,'FARMACOLOGIA CLÍNICA',60,'613','PEDRO SIMÃO DA SILVA AZEVEDO','2754;3425;2','Mestre','professor38@faculdadecet.edu.br',207),('2026.1','12','FARMÁCIA','M1-F12',9727,'FÍSICO QUÍMICA APLICADA Á FARMÁCIA',45,'480','THALYTA PEREIRA OLIVEIRA','248;79:;573','Doutor','professor42@faculdadecet.edu.br',208),('2026.1','12','FARMÁCIA','M1-F12',10022,'BIOINFORMÁTICA APLICADA À SAÚDE',30,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',209),('2026.1','12','FARMÁCIA','M1-F13',9735,'BIOQUÍMICA BÁSICA',90,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',210),('2026.1','12','FARMÁCIA','M1-F13',9734,'SAÚDE PÚBLICA',30,'155','KATIA CILENE DE OLIVEIRA PEREIRA','84442528594','Mestre','katia.pereira@cet.edu.br',211),('2026.1','12','FARMÁCIA','M1-F13',9733,'QUÍMICA ANALÍTICA',60,'769','RUSBENE BRUNO FONSECA DE CARVALHO','252773::587','Doutor','rusbene.carvalho@unicet.edu.br',212),('2026.1','12','FARMÁCIA','M1-F13',9732,'QUÍMICA ORGÂNICA I',60,'480','THALYTA PEREIRA OLIVEIRA','248;79:;573','Doutor','professor42@faculdadecet.edu.br',213),('2026.1','12','FARMÁCIA','M1-F13',9736,'ASSISTÊNCIA FARMACÊUTICA',30,'511','THIARA LORENNA BEZERRA DA SILVA OLIVEIRA','2294;895538','Mestre','thiaralorenna@gmail.com',214),('2026.1','12','FARMÁCIA','M2-F6',9702,'CONTROLE DE QUALIDADE FÍSICO-QUÍMICO',45,'585','ANA CRISTINA SOUSA GRAMOZA VILARINHO SANTANA','259499;7523','Doutor','ana.cristina@unicet.edu.br',215),('2026.1','12','FARMÁCIA','M2-F6',9699,'TRABALHO DE CONCLUSÃO DO CURSO I(TCC-I)',30,'559','ANA KAROLINE DA SILVA BRITO','26:533425:5','Doutor','ana.karolinne@unicet.edu.br',216),('2026.1','12','FARMÁCIA','M2-F6',9698,'FARMÁCIA HOSPITALAR',75,'503','ANNA ERIKA PINHEIRO DA SILVA','24799223593','Especialista','anna.erika@unicet.edu.br',217),('2026.1','12','FARMÁCIA','M2-F6',9700,'ESTÁGIO CURRICULAR SUPERVISIONADO III - ANÁLISES CLÍNICAS',240,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',218),('2026.1','12','FARMÁCIA','M2-F6',9701,'CITOLOGIA CLÍNICA',60,'414','KEYLLA DA CONCEIÇÃO MACHADO','24::4594567','Doutor','keyllamachado06@hotmail.com',219),('2026.1','12','FARMÁCIA','M2-F6',9703,'ANÁLISES TOXICOLOGICAS',30,'613','PEDRO SIMÃO DA SILVA AZEVEDO','2754;3425;2','Mestre','professor38@faculdadecet.edu.br',220),('2026.1','12','FARMÁCIA','M2-F7',9705,'MICROBIOLOGIA BÁSICA',60,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',221),('2026.1','12','FARMÁCIA','M2-F7',9707,'BIOQUÍMICA CLÍNICA',60,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',222),('2026.1','12','FARMÁCIA','M2-F7',9704,'QUÍMICA ORGÂNICA II',60,'769','RUSBENE BRUNO FONSECA DE CARVALHO','252773::587','Doutor','rusbene.carvalho@unicet.edu.br',223),('2026.1','12','FARMÁCIA','M2-F7',9986,'FÍSICO QUÍMICA APLICADA Á FARMÁCIA',45,'480','THALYTA PEREIRA OLIVEIRA','248;79:;573','Doutor','professor42@faculdadecet.edu.br',224),('2026.1','12','FARMÁCIA','M2-F7',9708,'IMUNOLOGIA CLÍNICA',45,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',225),('2026.1','12','FARMÁCIA','M2-F8',9694,'FISIOLOGIA HUMANA',90,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',226),('2026.1','12','FARMÁCIA','M2-F8',9696,'ANATOMIA HUMANA',90,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',227),('2026.1','12','FARMÁCIA','M2-F8',9695,'BIOFÍSICA APLICADA Á FARMÁCIA',60,'584','VICTOR AUGUSTO ARAUJO BARBOSA','25873685533','Doutor','victor.augusto@unicet.edu.br',228),('2026.1','12','FARMÁCIA','S-F1',10090,'HISTOLOGIA E EMBRIOLOGIA',75,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',229),('2026.1','12','FARMÁCIA','S-F1',10092,'BIOFÍSICA APLICADA Á FARMÁCIA',60,'761','EUGENIO BARBOSA DE MELO JUNIOR','256293886;6','Doutor','eugeniobmj@gmail.com',230),('2026.1','12','FARMÁCIA','S-F1',10091,'BIOLOGIA CELULAR',60,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',231),('2026.1','12','FARMÁCIA','S-F1',10094,'SOCIOLOGIA',30,'541','LUIZ CARLOS CARVALHO DE OLIVEIRA','4489;:85594','Doutor','coliveira.luiz@gmail.com',232),('2026.1','12','FARMÁCIA','S-F1',10093,'ANATOMIA HUMANA',90,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',233),('2026.1','12','FARMÁCIA','S-F1',10095,'METODOLOGIA CIENTÍFICA',30,'769','RUSBENE BRUNO FONSECA DE CARVALHO','252773::587','Doutor','rusbene.carvalho@unicet.edu.br',234),('2026.1','12','FARMÁCIA','S-F3',9715,'ESTÁGIO CURRICULAR SUPERVISIONADO I - SAÚDE PÚBLICA E ASSISTÊNCIA FARMACÊUTICA',120,'503','ANNA ERIKA PINHEIRO DA SILVA','24799223593','Especialista','anna.erika@unicet.edu.br',235),('2026.1','12','FARMÁCIA','S-F3',9713,'BIOQUÍMICA BÁSICA',90,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',236),('2026.1','12','FARMÁCIA','S-F3',9712,'FISIOLOGIA HUMANA',90,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',237),('2026.1','12','FARMÁCIA','S-F3',9711,'FARMACOGNOSIA I',45,'625','MARIA DOS REMÉDIOS MENDES DE BRITO','2582;774532','Mestre','maria.brito@faculdadecet.edu.br',238),('2026.1','12','FARMÁCIA','S-F3',9710,'QUÍMICA ANALÍTICA E INSTRUMENTAL',60,'769','RUSBENE BRUNO FONSECA DE CARVALHO','252773::587','Doutor','rusbene.carvalho@unicet.edu.br',239),('2026.1','12','FARMÁCIA','S-F3',9709,'QUÍMICA ORGÂNICA II',60,'480','THALYTA PEREIRA OLIVEIRA','248;79:;573','Doutor','professor42@faculdadecet.edu.br',240),('2026.1','12','FARMÁCIA','S-F3',9714,'ATENÇÃO E CUIDADO FARMACÊUTICO',30,'511','THIARA LORENNA BEZERRA DA SILVA OLIVEIRA','2294;895538','Mestre','thiaralorenna@gmail.com',241),('2026.1','30','MEDICINA','MED-01A',9563,'ANATOMIA HUMANA I',90,'596','ADÉLIA DALVA DA SILVA OLIVEIRA','6682;354542','Doutor','adelia.oliveira@unicet.edu.br',242),('2026.1','30','MEDICINA','MED-01A',9557,'BASES DA CIÊNCIA MÉDICA (BIOQUÍMICA E BIOFÍSICA)',120,'559','ANA KAROLINE DA SILVA BRITO','26:533425:5','Doutor','ana.karolinne@unicet.edu.br',243),('2026.1','30','MEDICINA','MED-01A',9560,'INTRODUÇÃO À PESQUISA CIENTÍFICA',30,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',244),('2026.1','30','MEDICINA','MED-01A',9564,'HISTOLOGIA HUMANA',60,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',245),('2026.1','30','MEDICINA','MED-01A',9559,'HABILIDADES MÉDICAS I',30,'684','DAVES PRADO PONTES MOURA E SILVA',':3;22262566','Especialista','daves.pontes@faculdadecet.edu.br',246),('2026.1','30','MEDICINA','MED-01A',9556,'INTRODUÇÃO À VIDA ACADÊMICA EM MEDICINA',30,'757','FABIOLA FERREIRA HORTENCIO VERAS','66665499537','Especialista','fabiola.hortencio@unicet.edu.br',247),('2026.1','30','MEDICINA','MED-01A',9562,'INGLÊS INSTRUMENTAL',30,'748','ISABEL CHRISTYNA DE OLIVEIRA BATISTA','84;6:99858:','Especialista','isabel.batista@faculdadecet.edu.br',248),('2026.1','30','MEDICINA','MED-01A',9561,'ÉTICA E CIDADANIA I',30,'669','ISMAEL MENDES DA SILVA','2724754:536','Mestre','ismael.mendes@unicet.edu.br',249),('2026.1','30','MEDICINA','MED-01A',9558,'ATENÇÃO PRIMÁRIA À SAÚDE I',60,'568','NAYLA ANDRADE BARBOZA','2226;:95522','Mestre','nayla.barboza@faculdadecet.edu.br',250),('2026.1','30','MEDICINA','MED-01B',9572,'ANATOMIA HUMANA I',90,'596','ADÉLIA DALVA DA SILVA OLIVEIRA','6682;354542','Doutor','adelia.oliveira@unicet.edu.br',251),('2026.1','30','MEDICINA','MED-01B',9566,'BASES DA CIÊNCIA MÉDICA (BIOQUÍMICA E BIOFÍSICA)',120,'559','ANA KAROLINE DA SILVA BRITO','26:533425:5','Doutor','ana.karolinne@unicet.edu.br',252),('2026.1','30','MEDICINA','MED-01B',9569,'INTRODUÇÃO À PESQUISA CIENTÍFICA',30,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',253),('2026.1','30','MEDICINA','MED-01B',9573,'HISTOLOGIA HUMANA',60,'563','DANIELLE ZILDEANA SOUSA FURTADO','26;;2854584','Doutor','daniellefurttado@gmail.com',254),('2026.1','30','MEDICINA','MED-01B',9568,'HABILIDADES MÉDICAS I',30,'684','DAVES PRADO PONTES MOURA E SILVA',':3;22262566','Especialista','daves.pontes@faculdadecet.edu.br',255),('2026.1','30','MEDICINA','MED-01B',9571,'INGLÊS INSTRUMENTAL',30,'748','ISABEL CHRISTYNA DE OLIVEIRA BATISTA','84;6:99858:','Especialista','isabel.batista@faculdadecet.edu.br',256),('2026.1','30','MEDICINA','MED-01B',9567,'ATENÇÃO PRIMÁRIA À SAÚDE I',60,'592','ISABEL CRISTINA DE PAULA OLIVEIRA','33628439:7;','Mestre','professor62@faculdadecet.edu.br',257),('2026.1','30','MEDICINA','MED-01B',9570,'ÉTICA E CIDADANIA I',30,'669','ISMAEL MENDES DA SILVA','2724754:536','Mestre','ismael.mendes@unicet.edu.br',258),('2026.1','30','MEDICINA','MED-01B',9565,'INTRODUÇÃO À VIDA ACADÊMICA EM MEDICINA',30,'701','MIGUEL ANTONIO TEIXEIRA FERREIRA','24:;594;55;','Especialista','miguel.ferreira@faculdadecet.edu.br',259),('2026.1','30','MEDICINA','MED-02A',9623,'ANATOMIA HUMANA II',90,'596','ADÉLIA DALVA DA SILVA OLIVEIRA','6682;354542','Doutor','adelia.oliveira@unicet.edu.br',260),('2026.1','30','MEDICINA','MED-02A',9625,'FISIOLOGIA HUMANA',120,'791','ALDA CASSIA ALVES DA SILVA','284688:;54;','Doutor','alda.alves@unicet.edu.br',261),('2026.1','30','MEDICINA','MED-02A',9623,'ANATOMIA HUMANA II',90,'680','ANTONIO CARLOS LEAL CORTEZ','8837;:6;5:9','Doutor','antonio.cortez@unicet.edu.br',262),('2026.1','30','MEDICINA','MED-02A',9627,'EMBRIOLOGIA HUMANA',30,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',263),('2026.1','30','MEDICINA','MED-02A',9626,'BIOLOGIA MOLECULAR E GENÉTICA MÉDICA',60,'593','FRANCISCO HONEIDY CARVALHO AZEVEDO',':74299:25:9','Doutor','honeidy@gmail.com',264),('2026.1','30','MEDICINA','MED-02A',9624,'NEUROANATOMIA',60,'575','GIULIANO DA PAZ OLIVEIRA','2573633:583','Doutor','giulianopoliveira@gmail.com',265),('2026.1','30','MEDICINA','MED-02A',9628,'ATENÇÃO PRIMÁRIA À SAÚDE II',60,'592','ISABEL CRISTINA DE PAULA OLIVEIRA','33628439:7;','Mestre','professor62@faculdadecet.edu.br',266),('2026.1','30','MEDICINA','MED-02A',9625,'FISIOLOGIA HUMANA',120,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',267),('2026.1','30','MEDICINA','MED-02A',9629,'BIOESTATÍSTICA',30,'567','NELSON AGAPITO BRANDÃO RIOS',':;23:274575','Mestre','professor35@faculdadecet.edu.br',268),('2026.1','30','MEDICINA','MED-02A',9623,'ANATOMIA HUMANA II',90,'752','SERGIO HENRIQUE MOURÃO GUIMARÃES DE MORAIS MENESES','843899;258:','Especialista','dr.sergiomgm@outlook.com',269),('2026.1','30','MEDICINA','MED-02A',9625,'FISIOLOGIA HUMANA',120,'752','SERGIO HENRIQUE MOURÃO GUIMARÃES DE MORAIS MENESES','843899;258:','Especialista','dr.sergiomgm@outlook.com',270),('2026.1','30','MEDICINA','MED-02A',9630,'HABILIDADES MÉDICAS II',30,'641','THIAGO PEREIRA DINIZ','263:6357553','Especialista','thiagopereiradiniz@yahoo.com.br',271),('2026.1','30','MEDICINA','MED-02B',9631,'ANATOMIA HUMANA II',90,'596','ADÉLIA DALVA DA SILVA OLIVEIRA','6682;354542','Doutor','adelia.oliveira@unicet.edu.br',272),('2026.1','30','MEDICINA','MED-02B',9633,'FISIOLOGIA HUMANA',120,'791','ALDA CASSIA ALVES DA SILVA','284688:;54;','Doutor','alda.alves@unicet.edu.br',273),('2026.1','30','MEDICINA','MED-02B',9631,'ANATOMIA HUMANA II',90,'680','ANTONIO CARLOS LEAL CORTEZ','8837;:6;5:9','Doutor','antonio.cortez@unicet.edu.br',274),('2026.1','30','MEDICINA','MED-02B',9635,'EMBRIOLOGIA HUMANA',30,'518','FRANCISCA MAIRANA SILVA DE SOUSA','25653392596','Mestre','mairanassousa@hotmail.com',275),('2026.1','30','MEDICINA','MED-02B',9634,'BIOLOGIA MOLECULAR E GENÉTICA MÉDICA',60,'593','FRANCISCO HONEIDY CARVALHO AZEVEDO',':74299:25:9','Doutor','honeidy@gmail.com',276),('2026.1','30','MEDICINA','MED-02B',9632,'NEUROANATOMIA',60,'692','FREDERICO MAIA PRADO','23256397549','Mestre','fredprado21@hotmail.com',277),('2026.1','30','MEDICINA','MED-02B',9636,'ATENÇÃO PRIMÁRIA À SAÚDE II',60,'592','ISABEL CRISTINA DE PAULA OLIVEIRA','33628439:7;','Mestre','professor62@faculdadecet.edu.br',278),('2026.1','30','MEDICINA','MED-02B',9633,'FISIOLOGIA HUMANA',120,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',279),('2026.1','30','MEDICINA','MED-02B',9637,'BIOESTATÍSTICA',30,'567','NELSON AGAPITO BRANDÃO RIOS',':;23:274575','Mestre','professor35@faculdadecet.edu.br',280),('2026.1','30','MEDICINA','MED-02B',9631,'ANATOMIA HUMANA II',90,'752','SERGIO HENRIQUE MOURÃO GUIMARÃES DE MORAIS MENESES','843899;258:','Especialista','dr.sergiomgm@outlook.com',281),('2026.1','30','MEDICINA','MED-02B',9633,'FISIOLOGIA HUMANA',120,'752','SERGIO HENRIQUE MOURÃO GUIMARÃES DE MORAIS MENESES','843899;258:','Especialista','dr.sergiomgm@outlook.com',282),('2026.1','30','MEDICINA','MED-02B',9638,'HABILIDADES MÉDICAS II',30,'641','THIAGO PEREIRA DINIZ','263:6357553','Especialista','thiagopereiradiniz@yahoo.com.br',283),('2026.1','30','MEDICINA','MED-03A',9640,'MICROBIOLOGIA MÉDICA',90,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',284),('2026.1','30','MEDICINA','MED-03A',9643,'IMUNOLOGIA E ALERGOLOGIA',30,'593','FRANCISCO HONEIDY CARVALHO AZEVEDO',':74299:25:9','Doutor','honeidy@gmail.com',285),('2026.1','30','MEDICINA','MED-03A',9640,'MICROBIOLOGIA MÉDICA',90,'784','GEORGIA MARIA IZIDORIO AGOSTINHO',':;253785537','Mestre','geoagostinho@hotmail.com',286),('2026.1','30','MEDICINA','MED-03A',9644,'ATENÇÃO PRIMÁRIA À SAÚDE III',60,'592','ISABEL CRISTINA DE PAULA OLIVEIRA','33628439:7;','Mestre','professor62@faculdadecet.edu.br',287),('2026.1','30','MEDICINA','MED-03A',10020,'INTELIGÊNCIA ARTIFICIAL E TECNOLOGIAS EM SAÚDE',30,'772','JOCERLANO SANTOS DE SOUSA',':745679756;','Especialista','jocerlanosousa@hotmail.com',288),('2026.1','30','MEDICINA','MED-03A',9641,'PARASITOLOGIA MÉDICA',90,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',289),('2026.1','30','MEDICINA','MED-03A',9640,'MICROBIOLOGIA MÉDICA',90,'762','LUCAS MATOS OLIVEIRA','283749455;8','Doutor','lucas.oliveira@faculdadecet.edu.br',290),('2026.1','30','MEDICINA','MED-03A',9642,'FARMACOLOGIA',90,'613','PEDRO SIMÃO DA SILVA AZEVEDO','2754;3425;2','Mestre','professor38@faculdadecet.edu.br',291),('2026.1','30','MEDICINA','MED-03A',9639,'PATOLOGIA MÉDICA',60,'664','THIAGO HENRIQUE GONÇALVES MOREIRA','34643857952','Mestre','thiago.goncalves@unicet.edu.br',292),('2026.1','30','MEDICINA','MED-03B',9647,'MICROBIOLOGIA MÉDICA',90,'428','AKEMI SUZUKI CRUZIO','249252275:7','Mestre','akemi.cruzio@unicet.edu.br',293),('2026.1','30','MEDICINA','MED-03B',9650,'IMUNOLOGIA E ALERGOLOGIA',30,'593','FRANCISCO HONEIDY CARVALHO AZEVEDO',':74299:25:9','Doutor','honeidy@gmail.com',294),('2026.1','30','MEDICINA','MED-03B',9647,'MICROBIOLOGIA MÉDICA',90,'784','GEORGIA MARIA IZIDORIO AGOSTINHO',':;253785537','Mestre','geoagostinho@hotmail.com',295),('2026.1','30','MEDICINA','MED-03B',9651,'ATENÇÃO PRIMÁRIA À SAÚDE III',60,'592','ISABEL CRISTINA DE PAULA OLIVEIRA','33628439:7;','Mestre','professor62@faculdadecet.edu.br',296),('2026.1','30','MEDICINA','MED-03B',10021,'INTELIGÊNCIA ARTIFICIAL E TECNOLOGIAS EM SAÚDE',30,'772','JOCERLANO SANTOS DE SOUSA',':745679756;','Especialista','jocerlanosousa@hotmail.com',297),('2026.1','30','MEDICINA','MED-03B',9648,'PARASITOLOGIA MÉDICA',90,'398','KELLY BEATRIZ VIEIRA DE OLIVEIRA','25:35343578','Mestre','vieira.beatriz.kelly1@hotmail.com',298),('2026.1','30','MEDICINA','MED-03B',9647,'MICROBIOLOGIA MÉDICA',90,'762','LUCAS MATOS OLIVEIRA','283749455;8','Doutor','lucas.oliveira@faculdadecet.edu.br',299),('2026.1','30','MEDICINA','MED-03B',9649,'FARMACOLOGIA',90,'613','PEDRO SIMÃO DA SILVA AZEVEDO','2754;3425;2','Mestre','professor38@faculdadecet.edu.br',300),('2026.1','30','MEDICINA','MED-03B',9646,'PATOLOGIA MÉDICA',60,'664','THIAGO HENRIQUE GONÇALVES MOREIRA','34643857952','Mestre','thiago.goncalves@unicet.edu.br',301),('2026.1','30','MEDICINA','MED-04A',9953,'BASES DA TÉCNICA CIRÚRGICA',60,'609','EDISON DE ARAÚJO VALE','465776;858:','Mestre','professor69@faculdadecet.edu.br',302),('2026.1','30','MEDICINA','MED-04A',9954,'SEMIOLOGIA',180,'704','EURIPEDES FERREIRA ARAUJO MENDES',';395364;526','Mestre','euripedes_fam@hotmail.com',303),('2026.1','30','MEDICINA','MED-04A',9954,'SEMIOLOGIA',180,'787','FABRIZIO FREITAS NUNES','2469936853;','Especialista','fabrizio.freitas1043@gmail.com',304),('2026.1','30','MEDICINA','MED-04A',10019,'MEDICINA DO SONO',30,'575','GIULIANO DA PAZ OLIVEIRA','2573633:583','Doutor','giulianopoliveira@gmail.com',305),('2026.1','30','MEDICINA','MED-04A',9955,'IMAGENOLOGIA',60,'620','LARA BASILIO MEDEIROS VERAS','86;3;;;6542','Mestre','lara.veras@faculdadecet.edu.br',306),('2026.1','30','MEDICINA','MED-04A',9954,'SEMIOLOGIA',180,'611','LUIZ BEZERRA NETO',':622853758:','Mestre','professor71@faculdadecet.edu.br',307),('2026.1','30','MEDICINA','MED-04A',9827,'MEDICINA COMUNITÁRIA III',60,'608','MAGDA ROGERIA PEREIRA VIANA','73972962542','Doutor','professor73@faculdadecet.edu.br',308),('2026.1','30','MEDICINA','MED-04A',9951,'PSICOLOGIA MÉDICA',30,'629','MAURÍLIO BATISTA LIMA','267875::589','Especialista','maurilio.lima@faculdadecet.edu.br',309),('2026.1','30','MEDICINA','MED-04A',9954,'SEMIOLOGIA',180,'605','MAURO GUIMARÃES ALBUQUERQUE',':62387;2575','Mestre','mgalbuquerque9@hotmail.com',310),('2026.1','30','MEDICINA','MED-04A',9952,'ANESTESIOLOGIA E ESTUDO DA DOR',30,'701','MIGUEL ANTONIO TEIXEIRA FERREIRA','24:;594;55;','Especialista','miguel.ferreira@faculdadecet.edu.br',311),('2026.1','30','MEDICINA','MED-04A',9955,'IMAGENOLOGIA',60,'723','SILVIA AMÉLIA PRADO BURGOS MADEIRA CAMPOS',':38237955;3','Mestre','silvia.campos@faculdadecet.edu.br',312),('2026.1','30','MEDICINA','MED-04B',9959,'BASES DA TÉCNICA CIRÚRGICA',60,'609','EDISON DE ARAÚJO VALE','465776;858:','Mestre','professor69@faculdadecet.edu.br',313),('2026.1','30','MEDICINA','MED-04B',9960,'SEMIOLOGIA',180,'788','EDUARDO SALMITO SOARES PINTO','24386:68568','Mestre','eduardo.soares@unicet.edu.br',314),('2026.1','30','MEDICINA','MED-04B',10018,'LÍNGUA BRASILEIRA DE SINAIS-LIBRAS',30,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',315),('2026.1','30','MEDICINA','MED-04B',9960,'SEMIOLOGIA',180,'786','JULIO CESAR AYRES FERREIRA FILHO','8;57;947537','Doutor','julio.filho@unicet.edu.br',316),('2026.1','30','MEDICINA','MED-04B',9961,'IMAGENOLOGIA',60,'620','LARA BASILIO MEDEIROS VERAS','86;3;;;6542','Mestre','lara.veras@faculdadecet.edu.br',317),('2026.1','30','MEDICINA','MED-04B',9960,'SEMIOLOGIA',180,'631','LUIZ CARLOS NOGUEIRA FALCÃO','22696:75595','Mestre','luiz.falcao@faculdadecet.edu.br',318),('2026.1','30','MEDICINA','MED-04B',9828,'MEDICINA COMUNITÁRIA III',60,'608','MAGDA ROGERIA PEREIRA VIANA','73972962542','Doutor','professor73@faculdadecet.edu.br',319),('2026.1','30','MEDICINA','MED-04B',9957,'PSICOLOGIA MÉDICA',30,'629','MAURÍLIO BATISTA LIMA','267875::589','Especialista','maurilio.lima@faculdadecet.edu.br',320),('2026.1','30','MEDICINA','MED-04B',9958,'ANESTESIOLOGIA E ESTUDO DA DOR',30,'701','MIGUEL ANTONIO TEIXEIRA FERREIRA','24:;594;55;','Especialista','miguel.ferreira@faculdadecet.edu.br',321),('2026.1','30','MEDICINA','MED-04B',9960,'SEMIOLOGIA',180,'785','MOISÉS DA SILVA OLIVEIRA','57326474575','Não informado','moises.oliveira@unicet.edu.br',322),('2026.1','30','MEDICINA','MED-04B',9961,'IMAGENOLOGIA',60,'723','SILVIA AMÉLIA PRADO BURGOS MADEIRA CAMPOS',':38237955;3','Mestre','silvia.campos@faculdadecet.edu.br',323),('2026.1','30','MEDICINA','MED-04B',9959,'BASES DA TÉCNICA CIRÚRGICA',60,'641','THIAGO PEREIRA DINIZ','263:6357553','Especialista','thiagopereiradiniz@yahoo.com.br',324),('2026.1','30','MEDICINA','MED-05',9963,'CLINICA MÉDICA-GASTROENTEROLOGIA',60,'693','ANA VALERIA SANTOS PEREIRA DE ALMEIDA',':4:7;4;;522','Especialista','ana.almeida@unicet.edu.br',325),('2026.1','30','MEDICINA','MED-05',9970,'CLÍNICA CIRURGICA INTEGRADA',90,'607','ANTONIO MOREIRA MENDES FILHO','537675;6556','Doutor','professor68@faculdadecet.edu.br',326),('2026.1','30','MEDICINA','MED-05',9966,'HEMATOLOGIA',30,'716','DAYRTON RAULINO MOREIRA','24533;65538','Mestre','dayrton.moreira@gmail.com',327),('2026.1','30','MEDICINA','MED-05',9970,'CLÍNICA CIRURGICA INTEGRADA',90,'609','EDISON DE ARAÚJO VALE','465776;858:','Mestre','professor69@faculdadecet.edu.br',328),('2026.1','30','MEDICINA','MED-05',9969,'CARDIOLOGIA-CLÍNICO CIRURGICO',75,'635','EUCÁRIO LEITE MONTEIRO ALVES','4398;:99526','Doutor','eucmonteiro@yahoo.com.br',329),('2026.1','30','MEDICINA','MED-05',9965,'REUMATOLOGIA',30,'757','FABIOLA FERREIRA HORTENCIO VERAS','66665499537','Especialista','fabiola.hortencio@unicet.edu.br',330),('2026.1','30','MEDICINA','MED-05',9965,'REUMATOLOGIA',30,'784','GEORGIA MARIA IZIDORIO AGOSTINHO',':;253785537','Mestre','geoagostinho@hotmail.com',331),('2026.1','30','MEDICINA','MED-05',9968,'PNEUMOLOGIA-CLÍNICO CIRURGICO',75,'636','JOÃO LUIZ VIEIRA RIBEIRO','44993;6:542','Doutor','joao.ribeiro@faculdadecet.edu.br',332),('2026.1','30','MEDICINA','MED-05',9968,'PNEUMOLOGIA-CLÍNICO CIRURGICO',75,'633','JYSELDA DE JESUS LEMOS DUARTE','564425;;594','Mestre','jyselda.duarte@faculdadecet.edu.br',333),('2026.1','30','MEDICINA','MED-05',9826,'MEDICINA COMUNITÁRIA IV',60,'628','LILIAM MENDES DE ARAÚJO','52;6443956;','Doutor','liliam.mendes@faculdadecet.edu.br',334),('2026.1','30','MEDICINA','MED-05',9963,'CLINICA MÉDICA-GASTROENTEROLOGIA',60,'682','LORENA MARIA BARROS BRITO BATISTA',':277975:522','Mestre','lorena.batista@faculdadecet.edu.br',335),('2026.1','30','MEDICINA','MED-05',9964,'ENDOCRINOLOGIA',30,'719','LUCAS DA SILVEIRA TERTO','234627:5592','Especialista','lucas.terto@faculdadecet.edu.br',336),('2026.1','30','MEDICINA','MED-05',9967,'NEFROLOGIA',30,'719','LUCAS DA SILVEIRA TERTO','234627:5592','Especialista','lucas.terto@faculdadecet.edu.br',337),('2026.1','30','MEDICINA','MED-05',9969,'CARDIOLOGIA-CLÍNICO CIRURGICO',75,'611','LUIZ BEZERRA NETO',':622853758:','Mestre','professor71@faculdadecet.edu.br',338),('2026.1','30','MEDICINA','MED-05',9967,'NEFROLOGIA',30,'631','LUIZ CARLOS NOGUEIRA FALCÃO','22696:75595','Mestre','luiz.falcao@faculdadecet.edu.br',339),('2026.1','30','MEDICINA','MED-05',9969,'CARDIOLOGIA-CLÍNICO CIRURGICO',75,'605','MAURO GUIMARÃES ALBUQUERQUE',':62387;2575','Mestre','mgalbuquerque9@hotmail.com',340),('2026.1','30','MEDICINA','MED-05',9964,'ENDOCRINOLOGIA',30,'737','NAGELE DE SOUSA LIMA',';895;364522','Especialista','nagele.lima@faculdadecet.edu.br',341),('2026.1','30','MEDICINA','MED-05',9965,'REUMATOLOGIA',30,'737','NAGELE DE SOUSA LIMA',';895;364522','Especialista','nagele.lima@faculdadecet.edu.br',342),('2026.1','30','MEDICINA','MED-05',9967,'NEFROLOGIA',30,'737','NAGELE DE SOUSA LIMA',';895;364522','Especialista','nagele.lima@faculdadecet.edu.br',343),('2026.1','30','MEDICINA','MED-05',9964,'ENDOCRINOLOGIA',30,'770','PATRICIA MOREIRA MELO',';3:69223522','Especialista','patricia.melo@unicet.edu.br',344),('2026.1','30','MEDICINA','MED-05',9969,'CARDIOLOGIA-CLÍNICO CIRURGICO',75,'649','THADEU DO LAGO BARATTA MONTEIRO','9927:8:4594','Especialista','thadeu.monteiro@faculdadecet.edu.br',345),('2026.1','30','MEDICINA','MED-05',9970,'CLÍNICA CIRURGICA INTEGRADA',90,'641','THIAGO PEREIRA DINIZ','263:6357553','Especialista','thiagopereiradiniz@yahoo.com.br',346),('2026.1','30','MEDICINA','MED-05',9963,'CLINICA MÉDICA-GASTROENTEROLOGIA',60,'630','THIAGO SOARES GONDIM MEDEIROS',':2::26;75;3','Mestre','thiago.medeiros@faculdadecet.edu.br',347),('2026.1','30','MEDICINA','MED-05',9970,'CLÍNICA CIRURGICA INTEGRADA',90,'630','THIAGO SOARES GONDIM MEDEIROS',':2::26;75;3','Mestre','thiago.medeiros@faculdadecet.edu.br',348),('2026.1','30','MEDICINA','MED-05',9970,'CLÍNICA CIRURGICA INTEGRADA',90,'750','VIRGINIA PORTELA CARDOSO','246429495;:','Especialista','vii.portela@gmail.com',349),('2026.1','30','MEDICINA','MED-05',9970,'CLÍNICA CIRURGICA INTEGRADA',90,'639','WELLIGTON RIBEIRO FIGUEIREDO','8723568:575','Mestre','welligton.figueiredo@faculdadecet.edu.br',350),('2026.1','30','MEDICINA','MED-06',9655,'UROLOGIA',60,'656','ALESSE RIBEIRO DOS SANTOS',':2737682542','Doutor','alesse.santos@unicet.edu.br',351),('2026.1','30','MEDICINA','MED-06',9654,'OBSTETRÍCIA',90,'665','ANA MARIA PEARCE DE AREA LEÃO PINHEIRO',':6::3756522','Doutor','ana.pinheiro@unicet.edu.br',352),('2026.1','30','MEDICINA','MED-06',9653,'GINECOLOGIA',90,'658','IONE MARIA RIBEIRO SOARES LOPES','2885;:8258:','Doutor','ione.lopes@faculdadecet.edu.br',353),('2026.1','30','MEDICINA','MED-06',9656,'ORTOPEDIA E TRAUMATOLOGIA',90,'655','ISANIO VASCONCELOS MESQUITA','564;3;5:56;','Doutor','isanio.mesquita@faculdadecet.edu.br',354),('2026.1','30','MEDICINA','MED-06',9654,'OBSTETRÍCIA',90,'659','JOSÉ ARIMATÉA DOS SANTOS JUNIOR','6:4256545:9','Doutor','jose.santos@faculdadecet.edu.br',355),('2026.1','30','MEDICINA','MED-06',9657,'DERMATOLOGIA',60,'662','JOSÉ JAMES LIMA DA SILVA SEGUNDO','2266595;596','Especialista','jose.segundo@faculdadecet.edu.br',356),('2026.1','30','MEDICINA','MED-06',9657,'DERMATOLOGIA',60,'660','LAURO LOURIVAL LOPES FILHO','2884528;594','Doutor','lauro.filho@faculdadecet.edu.br',357),('2026.1','30','MEDICINA','MED-06',9656,'ORTOPEDIA E TRAUMATOLOGIA',90,'661','LEANDRO PONCE LEAL','3899:8;;:63','Especialista','leandro.leal@faculdadecet.edu.br',358),('2026.1','30','MEDICINA','MED-06',9658,'MEDICINA COMUNITÁRIA V',60,'628','LILIAM MENDES DE ARAÚJO','52;6443956;','Doutor','liliam.mendes@faculdadecet.edu.br',359),('2026.1','30','MEDICINA','MED-06',9655,'UROLOGIA',60,'667','MARCELO OLIVEIRA DA COSTA','92585872522','Especialista','marcelo.costa@faculdadecet.edu.br',360),('2026.1','30','MEDICINA','MED-06',9653,'GINECOLOGIA',90,'447','THAIS RODRIGUES CARVALHO','2722;353596','Não informado','thais-rod@hotmail.com',361),('2026.1','30','MEDICINA','MED-06',9659,'DISCIPLINA OPTATIVA VI',30,'641','THIAGO PEREIRA DINIZ','263:6357553','Especialista','thiagopereiradiniz@yahoo.com.br',362),('2026.1','30','MEDICINA','MED-07',9667,'TRABALHO DE CONCLUSÃO DE CURSO I',30,'596','ADÉLIA DALVA DA SILVA OLIVEIRA','6682;354542','Doutor','adelia.oliveira@unicet.edu.br',363),('2026.1','30','MEDICINA','MED-07',9666,'DISCIPLINA OPTATIVA VII',30,'756','AURUS DOURADO MENESES',';29:7283526','Especialista','aurus.meneses@unicet.edu.br',364),('2026.1','30','MEDICINA','MED-07',9660,'OFTALMOLOGIA',60,'687','BRUNO MACEDO GONÇALVES','23599:845;;','Especialista','brunomg.bruno@hotmail.com',365),('2026.1','30','MEDICINA','MED-07',9664,'PSIQUIATRIA',90,'683','DANILO GONÇALVES DANTAS','246:62:357;','Especialista','danilodantasmed@gmail.com',366),('2026.1','30','MEDICINA','MED-07',9661,'OTORRINOLARINGOLOGIA',60,'695','FLÁVIO CARVALHO SANTOS FILHO','265974:8564','Especialista','flavio0209@gmail.com',367),('2026.1','30','MEDICINA','MED-07',9662,'ANGIOLOGIA E CIRURGIA VASCULAR',30,'734','GERMANO DA PAZ OLIVEIRA',';348:86:575','Mestre','germano.oliveira@faculdadecet.edu.br',368),('2026.1','30','MEDICINA','MED-07',9663,'NEUROLOGIA',90,'691','GUSTAVO SOUSA NOLETO','22887394525','Doutor','gustavo.noleto@faculdadecet.edu.br',369),('2026.1','30','MEDICINA','MED-07',9660,'OFTALMOLOGIA',60,'690','LAÍS MOREIRA DE GALIZA','2428;6:;524','Especialista','lais.galiza@faculdadecet.edu.br',370),('2026.1','30','MEDICINA','MED-07',9665,'MEDICINA COMUNITÁRIA VI',60,'508','LAYANNE CAVALCANTE DE MOURA','2234;9:85;2','Mestre','layannecavalcante @hotmail.com',371),('2026.1','30','MEDICINA','MED-07',9663,'NEUROLOGIA',90,'689','LEONARDO DE MOURA SOUSA JUNIOR',';84886445:9','Doutor','leonardo.junior@faculdadecet.edu.br',372),('2026.1','30','MEDICINA','MED-07',9661,'OTORRINOLARINGOLOGIA',60,'685','MARIANA DE NOVAES SANTOS MAGALHÃES PINHEIRO','22:7:7;4526','Especialista','mariana.pinheiro@faculdadecet.edu.br',373),('2026.1','30','MEDICINA','MED-07',9664,'PSIQUIATRIA',90,'629','MAURÍLIO BATISTA LIMA','267875::589','Especialista','maurilio.lima@faculdadecet.edu.br',374),('2026.1','30','MEDICINA','MED-08',9673,'MEDICINA LEGAL E DEONTOLOGIA MÉDICA',60,'714','ANTONIO NUNES NUNES PEREIRA','528:24;:526','Especialista','antonio.pereira@unicet.edu.br',375),('2026.1','30','MEDICINA','MED-08',9669,'PEDIATRIA',150,'715','ATÊNCIO PEREIRA DE QUEIROGA FILHO','774624895;3','Especialista','atenciofilho@hotmail.com',376),('2026.1','30','MEDICINA','MED-08',9669,'PEDIATRIA',150,'716','DAYRTON RAULINO MOREIRA','24533;65538','Mestre','dayrton.moreira@gmail.com',377),('2026.1','30','MEDICINA','MED-08',9669,'PEDIATRIA',150,'735','DENISE DELMONDE MEDEIROS','822624465:6','Especialista','denisedelmonde@hotmail.com',378),('2026.1','30','MEDICINA','MED-08',9668,'DOENÇAS INFECCIOSAS E PARASITÁRIA',150,'717','ELNA JOELANE LOPES DA SILVA DO AMARAL','983;69:958:','Mestre','elna.amaral@faculdadecet.edu.br',379),('2026.1','30','MEDICINA','MED-08',9669,'PEDIATRIA',150,'722','FLAVIA CARVALHAL FRAZÃO CORREA ARRAIS',':62:;8:956;','Especialista','flaviafrazao@hotmail.com',380),('2026.1','30','MEDICINA','MED-08',9671,'GERIATRIA',30,'712','FLÁVIA VERÍSSIMO MELO E SILVA','8225:298587','Mestre','fverissima@gmail.com',381),('2026.1','30','MEDICINA','MED-08',9668,'DOENÇAS INFECCIOSAS E PARASITÁRIA',150,'784','GEORGIA MARIA IZIDORIO AGOSTINHO',':;253785537','Mestre','geoagostinho@hotmail.com',382),('2026.1','30','MEDICINA','MED-08',9671,'GERIATRIA',30,'719','LUCAS DA SILVEIRA TERTO','234627:5592','Especialista','lucas.terto@faculdadecet.edu.br',383),('2026.1','30','MEDICINA','MED-08',9669,'PEDIATRIA',150,'720','LUIZA IVETE VIEIRA BATISTA','5644999858:','Mestre','luiza.batista@faculdadecet.edu.br',384),('2026.1','30','MEDICINA','MED-08',9674,'BIOÉTICA',30,'720','LUIZA IVETE VIEIRA BATISTA','5644999858:','Mestre','luiza.batista@faculdadecet.edu.br',385),('2026.1','30','MEDICINA','MED-08',9675,'TRABALHO DE CONCLUSÃO DE CURSO II',30,'608','MAGDA ROGERIA PEREIRA VIANA','73972962542','Doutor','professor73@faculdadecet.edu.br',386),('2026.1','30','MEDICINA','MED-08',9670,'URGÊNCIAS E EMERGÊNCIAS MÉDICAS',60,'737','NAGELE DE SOUSA LIMA',';895;364522','Especialista','nagele.lima@faculdadecet.edu.br',387),('2026.1','30','MEDICINA','MED-08',9668,'DOENÇAS INFECCIOSAS E PARASITÁRIA',150,'721','RAIMUNDO FELIX DOS SANTOS JUNIOR','74899::75:9','Mestre','raimundo.junior@faculdadecet.edu.br',388),('2026.1','30','MEDICINA','MED-08',9672,'ONCOLOGIA',30,'641','THIAGO PEREIRA DINIZ','263:6357553','Especialista','thiagopereiradiniz@yahoo.com.br',389),('2026.1','30','MEDICINA','MED-08',9672,'ONCOLOGIA',30,'750','VIRGINIA PORTELA CARDOSO','246429495;:','Especialista','vii.portela@gmail.com',390),('2026.1','30','MEDICINA','MED-08',9673,'MEDICINA LEGAL E DEONTOLOGIA MÉDICA',60,'727','WILLIAMS CARDEC DA SILVA',';;5624:558:','Mestre','williams.silva@faculdadecet.edu.br',391),('2026.1','30','MEDICINA','MED-09',9678,'CICLO III - ESTÁGIO SUPERVISIONADO EM ATENÇÃO PRIMÁRIA À SAÚDE I',240,'508','LAYANNE CAVALCANTE DE MOURA','2234;9:85;2','Mestre','layannecavalcante @hotmail.com',392),('2026.1','30','MEDICINA','MED-09',9677,'CICLO II - ESTÁGIO SUPERVISIONADO EM URGÊNCIA E EMERGÊNCIA I',240,'737','NAGELE DE SOUSA LIMA',';895;364522','Especialista','nagele.lima@faculdadecet.edu.br',393),('2026.1','30','MEDICINA','MED-09',9676,'CICLO I - ESTÁGIO SUPERVISIONADO EM CLÍNICA MÉDICA',480,'649','THADEU DO LAGO BARATTA MONTEIRO','9927:8:4594','Especialista','thadeu.monteiro@faculdadecet.edu.br',394),('2026.1','30','MEDICINA','MED-10',9679,'CICLO IV - ESTÁGIO SUPERVISIONADO EM GINECOLOGIA-OBSTETRÍCIA',480,'658','IONE MARIA RIBEIRO SOARES LOPES','2885;:8258:','Doutor','ione.lopes@faculdadecet.edu.br',395),('2026.1','30','MEDICINA','MED-10',9681,'CICLO VI - ESTÁGIO SUPERVISIONADO EM ATENÇÃO PRIMÁRIA À SAÚDE II',240,'508','LAYANNE CAVALCANTE DE MOURA','2234;9:85;2','Mestre','layannecavalcante @hotmail.com',396),('2026.1','30','MEDICINA','MED-10',9680,'CICLO V - ESTÁGIO SUPERVISIONADO EM URGÊNCIA E EMERGÊNCIA II',240,'737','NAGELE DE SOUSA LIMA',';895;364522','Especialista','nagele.lima@faculdadecet.edu.br',397),('2026.1','30','MEDICINA','MED-11',9683,'CICLO VIII - ESTÁGIO SUPERVISIONADO EM URGÊNCIA E EMERGÊNCIA III',180,'793','GERARDO VIANA DO MONTE NETO','86945;3956;','Especialista','dr.gerardoviana@hotmail.com',398),('2026.1','30','MEDICINA','MED-11',9684,'CICLO IX - ESTÁGIO SUPERVISIONADO EM ATENÇÃO PRIMÁRIA À SAÚDE III',180,'508','LAYANNE CAVALCANTE DE MOURA','2234;9:85;2','Mestre','layannecavalcante @hotmail.com',399),('2026.1','30','MEDICINA','MED-11',9682,'CICLO VII - ESTÁGIO SUPERVISIONADOEM CLÍNICA CIRÚRGICA',360,'630','THIAGO SOARES GONDIM MEDEIROS',':2::26;75;3','Mestre','thiago.medeiros@faculdadecet.edu.br',400),('2026.1','30','MEDICINA','PE-M1',9993,'BIOÉTICA',30,'508','LAYANNE CAVALCANTE DE MOURA','2234;9:85;2','Mestre','layannecavalcante @hotmail.com',401),('2026.1','30','MEDICINA','PE-M1',9992,'FARMACOLOGIA',90,'613','PEDRO SIMÃO DA SILVA AZEVEDO','2754;3425;2','Mestre','professor38@faculdadecet.edu.br',402),('2026.1','30','MEDICINA','PE-M1',9994,'CLINICA MÉDICA-CARDIOLOGIA',60,'649','THADEU DO LAGO BARATTA MONTEIRO','9927:8:4594','Especialista','thadeu.monteiro@faculdadecet.edu.br',403),('2026.1','30','MEDICINA','PE-M2',9989,'FISIOLOGIA HUMANA',120,'752','SERGIO HENRIQUE MOURÃO GUIMARÃES DE MORAIS MENESES','843899;258:','Especialista','dr.sergiomgm@outlook.com',404),('2026.1','52','ODONTOLOGIA','ODONTO-01',9872,'ESTÁGIO DE ATENDIMENTO INTEGRADO I',120,'768','EGIDIA MARIA MOURA DE PAULO MARTINS VIEIRA','7758:329537','Doutor','egidia.moura@unicet.edu.br',405),('2026.1','52','ODONTOLOGIA','ODONTO-01',9870,'CLÍNICA DE ATENDIMENTO EM CIRURGIA E IMPLANTONDONTIA II',45,'740','FRANCISCO BRUNO NUNES NASCIMENTO SILVA','26;65427543','Especialista','bruno.nunes@unicet.edu.br',406),('2026.1','52','ODONTOLOGIA','ODONTO-01',9872,'ESTÁGIO DE ATENDIMENTO INTEGRADO I',120,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',407),('2026.1','52','ODONTOLOGIA','ODONTO-01',9872,'ESTÁGIO DE ATENDIMENTO INTEGRADO I',120,'780','ISABEL CRISTINA QUARESMA RÊGO','4238;3:5522','Doutor','isabel.quaresma@unicet.edu.br',408),('2026.1','52','ODONTOLOGIA','ODONTO-01',9873,'CLÍNICA DE ATENDIMENTO EM ODONTOPEDIATRIA II E MATERNOINFANTIL',60,'780','ISABEL CRISTINA QUARESMA RÊGO','4238;3:5522','Doutor','isabel.quaresma@unicet.edu.br',409),('2026.1','52','ODONTOLOGIA','ODONTO-01',9873,'CLÍNICA DE ATENDIMENTO EM ODONTOPEDIATRIA II E MATERNOINFANTIL',60,'776','ISABELA FLORIANO NUNES','22956;2955:','Doutor','isabela.floriano@unicet.edu.br',410),('2026.1','52','ODONTOLOGIA','ODONTO-01',9874,'CLÍNICA DE FUNDAMENTOS EM REABILITAÇÃO ORAL',90,'730','JAIRON DESIDÉRIO CARDOSO','2949864554:','Especialista','jairon.cardoso@faculdadecet.edu.br',411),('2026.1','52','ODONTOLOGIA','ODONTO-01',9870,'CLÍNICA DE ATENDIMENTO EM CIRURGIA E IMPLANTONDONTIA II',45,'733','JOSÉ CARLOS DE OLIVEIRA GOMES FILHO',';798726458:','Mestre','jose.oliveira@unicet.edu.br',412),('2026.1','52','ODONTOLOGIA','ODONTO-01',9871,'CLÍNICA DE ATENÇÃO À SAÚDE BUCAL PARA MINORIAS E ETNIAS I',30,'778','KARINA OLIVEIRA LUSTOSA','2795;882582','Mestre','karina.lustosa@unicet.edu.br',413),('2026.1','52','ODONTOLOGIA','ODONTO-01',9872,'ESTÁGIO DE ATENDIMENTO INTEGRADO I',120,'778','KARINA OLIVEIRA LUSTOSA','2795;882582','Mestre','karina.lustosa@unicet.edu.br',414),('2026.1','52','ODONTOLOGIA','ODONTO-01',9871,'CLÍNICA DE ATENÇÃO À SAÚDE BUCAL PARA MINORIAS E ETNIAS I',30,'666','LUANA KELLE BATISTA MOURA','23739354577','Doutor','luana.moura@unicet.edu.br',415),('2026.1','52','ODONTOLOGIA','ODONTO-01',9874,'CLÍNICA DE FUNDAMENTOS EM REABILITAÇÃO ORAL',90,'666','LUANA KELLE BATISTA MOURA','23739354577','Doutor','luana.moura@unicet.edu.br',416),('2026.1','52','ODONTOLOGIA','ODONTO-01',9875,'CLÍNICA DE REABILITAÇÃO ORAL PARA PACIENTES VÍTIMAS DE VIOLÊNCIAS I',30,'666','LUANA KELLE BATISTA MOURA','23739354577','Doutor','luana.moura@unicet.edu.br',417),('2026.1','52','ODONTOLOGIA','ODONTO-01',9872,'ESTÁGIO DE ATENDIMENTO INTEGRADO I',120,'699','LUCAS FERNANDES FALCÃO','255:3443559','Mestre','lucas.falcao@unicet.edu.br',418),('2026.1','52','ODONTOLOGIA','ODONTO-01',9874,'CLÍNICA DE FUNDAMENTOS EM REABILITAÇÃO ORAL',90,'741','MARCELYA CHRYSTIAN MOURA ROCHA','249689295;2','Mestre','marcelya.chrystian@hotmail.com',419),('2026.1','52','ODONTOLOGIA','ODONTO-01',9872,'ESTÁGIO DE ATENDIMENTO INTEGRADO I',120,'664','THIAGO HENRIQUE GONÇALVES MOREIRA','34643857952','Mestre','thiago.goncalves@unicet.edu.br',420),('2026.1','52','ODONTOLOGIA','ODONTO-01',9876,'CLÍNICA DE PRONTO ATENDIMENTO II',30,'672','VICTOR WILLIAN FERREIRA DOURADO','2835767657:','Mestre','victor.dourado@unicet.edu.br',421),('2026.1','52','ODONTOLOGIA','ODONTO-01',9872,'ESTÁGIO DE ATENDIMENTO INTEGRADO I',120,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',422),('2026.1','52','ODONTOLOGIA','ODONTO-01',9876,'CLÍNICA DE PRONTO ATENDIMENTO II',30,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',423),('2026.1','52','ODONTOLOGIA','ODONTO-01',9877,'METODOLOGIA DA PESQUISA',15,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',424),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9895,'LEGISLAÇÃO, ÉTICA, CIDADANIA E SUSTENTABILIDADE NA ODONTOLOGIA',30,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',425),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9901,'FUNDAMENTOS EM CLÍNICA ODONTOLÓGICA',30,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',426),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9900,'LIBRAS E PSICOLOGIA PARA ODONTOLOGIA',45,'669','ISMAEL MENDES DA SILVA','2724754:536','Mestre','ismael.mendes@unicet.edu.br',427),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9900,'LIBRAS E PSICOLOGIA PARA ODONTOLOGIA',45,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',428),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9898,'ATENÇÃO PRIMÁRIA À SAÚDE - I',30,'746','LUCIANA REINALDO LIMA','88::9462522','Especialista','luciana.lima@unicet.edu.br',429),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9899,'ATENÇÃO PRIMÁRIA À SAÚDE - II',30,'746','LUCIANA REINALDO LIMA','88::9462522','Especialista','luciana.lima@unicet.edu.br',430),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9894,'ANATOMIA FUNCIONAL HUMANA',90,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',431),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9896,'ORGANIZAÇÃO CELULAR E MOLECULAR',45,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',432),('2026.1','52','ODONTOLOGIA','ODONTO-01S',9897,'ANATOMIA E ESCULTURA DENTAL',30,'741','MARCELYA CHRYSTIAN MOURA ROCHA','249689295;2','Mestre','marcelya.chrystian@hotmail.com',433),('2026.1','52','ODONTOLOGIA','ODONTO-01S',10083,'FOTOGRAFIA ODONTOLÓGICA',30,'773','THIAGO LIMA MONTE',':5398978594','Doutor','thiago.monte@unicet.edu.br',434),('2026.1','52','ODONTOLOGIA','ODONTO-01S',10083,'FOTOGRAFIA ODONTOLÓGICA',30,'767','WILANA DA SILVA MOURA','22952292523','Doutor','wilana.moura@unicet.edu.br',435),('2026.1','52','ODONTOLOGIA','ODONTO-02',9884,'CLÍNICA DE PRONTO ATENDIMENTO I',30,'732','CARINE SOARES BORGES',':5:6467658:','Mestre','carine.borges@unicet.edu.br',436),('2026.1','52','ODONTOLOGIA','ODONTO-02',9882,'CLÍNICA DE ATENDIMENTO EM CIRURGIA E IMPLANTONDONTIA I',45,'740','FRANCISCO BRUNO NUNES NASCIMENTO SILVA','26;65427543','Especialista','bruno.nunes@unicet.edu.br',437),('2026.1','52','ODONTOLOGIA','ODONTO-02',9878,'CLÍNICA DE ATENDIMENTO BÁSICO',120,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',438),('2026.1','52','ODONTOLOGIA','ODONTO-02',9879,'CLÍNICA DE ATENDIMENTO EM ENDODONTIA',75,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',439),('2026.1','52','ODONTOLOGIA','ODONTO-02',9884,'CLÍNICA DE PRONTO ATENDIMENTO I',30,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',440),('2026.1','52','ODONTOLOGIA','ODONTO-02',9883,'CLÍNICA DE ATENDIMENTO EM ODONTOPEDIATRIA I E MATERNOINFANTIL ',30,'780','ISABEL CRISTINA QUARESMA RÊGO','4238;3:5522','Doutor','isabel.quaresma@unicet.edu.br',441),('2026.1','52','ODONTOLOGIA','ODONTO-02',9883,'CLÍNICA DE ATENDIMENTO EM ODONTOPEDIATRIA I E MATERNOINFANTIL ',30,'776','ISABELA FLORIANO NUNES','22956;2955:','Doutor','isabela.floriano@unicet.edu.br',442),('2026.1','52','ODONTOLOGIA','ODONTO-02',9882,'CLÍNICA DE ATENDIMENTO EM CIRURGIA E IMPLANTONDONTIA I',45,'733','JOSÉ CARLOS DE OLIVEIRA GOMES FILHO',';798726458:','Mestre','jose.oliveira@unicet.edu.br',443),('2026.1','52','ODONTOLOGIA','ODONTO-02',9880,'CLÍNICA INTEGRADA DE ESTOMATOLOGIA II',60,'778','KARINA OLIVEIRA LUSTOSA','2795;882582','Mestre','karina.lustosa@unicet.edu.br',444),('2026.1','52','ODONTOLOGIA','ODONTO-02',9879,'CLÍNICA DE ATENDIMENTO EM ENDODONTIA',75,'699','LUCAS FERNANDES FALCÃO','255:3443559','Mestre','lucas.falcao@unicet.edu.br',445),('2026.1','52','ODONTOLOGIA','ODONTO-02',9879,'CLÍNICA DE ATENDIMENTO EM ENDODONTIA',75,'746','LUCIANA REINALDO LIMA','88::9462522','Especialista','luciana.lima@unicet.edu.br',446),('2026.1','52','ODONTOLOGIA','ODONTO-02',9878,'CLÍNICA DE ATENDIMENTO BÁSICO',120,'741','MARCELYA CHRYSTIAN MOURA ROCHA','249689295;2','Mestre','marcelya.chrystian@hotmail.com',447),('2026.1','52','ODONTOLOGIA','ODONTO-02',9881,'CLÍNICA DE ATENDIMENTO PARA PACIENTES ONCOLÓGICOS',45,'766','PATRÍCIA JOST','267:6387557','Mestre','patricia.jost@unicet.edu.br',448),('2026.1','52','ODONTOLOGIA','ODONTO-02',9884,'CLÍNICA DE PRONTO ATENDIMENTO I',30,'766','PATRÍCIA JOST','267:6387557','Mestre','patricia.jost@unicet.edu.br',449),('2026.1','52','ODONTOLOGIA','ODONTO-02',9880,'CLÍNICA INTEGRADA DE ESTOMATOLOGIA II',60,'664','THIAGO HENRIQUE GONÇALVES MOREIRA','34643857952','Mestre','thiago.goncalves@unicet.edu.br',450),('2026.1','52','ODONTOLOGIA','ODONTO-02',9881,'CLÍNICA DE ATENDIMENTO PARA PACIENTES ONCOLÓGICOS',45,'664','THIAGO HENRIQUE GONÇALVES MOREIRA','34643857952','Mestre','thiago.goncalves@unicet.edu.br',451),('2026.1','52','ODONTOLOGIA','ODONTO-02',9884,'CLÍNICA DE PRONTO ATENDIMENTO I',30,'672','VICTOR WILLIAN FERREIRA DOURADO','2835767657:','Mestre','victor.dourado@unicet.edu.br',452),('2026.1','52','ODONTOLOGIA','ODONTO-02',9878,'CLÍNICA DE ATENDIMENTO BÁSICO',120,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',453),('2026.1','52','ODONTOLOGIA','ODONTO-02',9884,'CLÍNICA DE PRONTO ATENDIMENTO I',30,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',454),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9862,'CLINICA DE ATENDIMENTO DE PACIENTES COM BRUXISMO E SINTOMAS DE DESORDENS TEMPOROMANDIBULARES I',30,'732','CARINE SOARES BORGES',':5:6467658:','Mestre','carine.borges@unicet.edu.br',455),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9892,'CLINICA DE ATENDIMENTO DE PACIENTES COM BRUXISMO E SINTOMAS DE DESORDENS TEMPOROMANDIBULARES II',45,'732','CARINE SOARES BORGES',':5:6467658:','Mestre','carine.borges@unicet.edu.br',456),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9863,'CLÍNICA DE DIAGNÓSTICO POR IMAGEM II',30,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',457),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9893,'ODONTOLOGIA DO ESPORTE',30,'730','JAIRON DESIDÉRIO CARDOSO','2949864554:','Especialista','jairon.cardoso@faculdadecet.edu.br',458),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9861,'ANESTESIOLOGIA E TERAPÊUTICA MEDICAMENTOSA',45,'733','JOSÉ CARLOS DE OLIVEIRA GOMES FILHO',';798726458:','Mestre','jose.oliveira@unicet.edu.br',459),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9860,'CLÍNICA DE SEMIOLOGIA II',30,'699','LUCAS FERNANDES FALCÃO','255:3443559','Mestre','lucas.falcao@unicet.edu.br',460),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9858,'RADIOLOGIA CLÍNICA',75,'702','SERGIO ANTONIO PEREIRA FREITAS','6;948;65575','Doutor','sergio.freitas@unicet.edu.br',461),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9863,'CLÍNICA DE DIAGNÓSTICO POR IMAGEM II',30,'702','SERGIO ANTONIO PEREIRA FREITAS','6;948;65575','Doutor','sergio.freitas@unicet.edu.br',462),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9893,'ODONTOLOGIA DO ESPORTE',30,'664','THIAGO HENRIQUE GONÇALVES MOREIRA','34643857952','Mestre','thiago.goncalves@unicet.edu.br',463),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9862,'CLINICA DE ATENDIMENTO DE PACIENTES COM BRUXISMO E SINTOMAS DE DESORDENS TEMPOROMANDIBULARES I',30,'672','VICTOR WILLIAN FERREIRA DOURADO','2835767657:','Mestre','victor.dourado@unicet.edu.br',464),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9892,'CLINICA DE ATENDIMENTO DE PACIENTES COM BRUXISMO E SINTOMAS DE DESORDENS TEMPOROMANDIBULARES II',45,'672','VICTOR WILLIAN FERREIRA DOURADO','2835767657:','Mestre','victor.dourado@unicet.edu.br',465),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9858,'RADIOLOGIA CLÍNICA',75,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',466),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9860,'CLÍNICA DE SEMIOLOGIA II',30,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',467),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9863,'CLÍNICA DE DIAGNÓSTICO POR IMAGEM II',30,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',468),('2026.1','52','ODONTOLOGIA','ODONTO-03S',9859,'MATERIAIS DE USO ODONTOLÓGICO ',45,'767','WILANA DA SILVA MOURA','22952292523','Doutor','wilana.moura@unicet.edu.br',469),('2026.1','52','ODONTOLOGIA','ODONTO-04',9889,'CLINICA DE ATENDIMENTO DE PACIENTES COM BRUXISMO E SINTOMAS DE DESORDENS TEMPOROMANDIBULARES I',30,'732','CARINE SOARES BORGES',':5:6467658:','Mestre','carine.borges@unicet.edu.br',470),('2026.1','52','ODONTOLOGIA','ODONTO-04',9890,'CLINICA DE ATENDIMENTO DE PACIENTES COM BRUXISMO E SINTOMAS DE DESORDENS TEMPOROMANDIBULARES II',45,'732','CARINE SOARES BORGES',':5:6467658:','Mestre','carine.borges@unicet.edu.br',471),('2026.1','52','ODONTOLOGIA','ODONTO-04',9891,'CLÍNICA DE DIAGNÓSTICO POR IMAGEM II',30,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',472),('2026.1','52','ODONTOLOGIA','ODONTO-04',10014,'OPTATIVA II',30,'730','JAIRON DESIDÉRIO CARDOSO','2949864554:','Especialista','jairon.cardoso@faculdadecet.edu.br',473),('2026.1','52','ODONTOLOGIA','ODONTO-04',9888,'ANESTESIOLOGIA E TERAPÊUTICA MEDICAMENTOSA',45,'733','JOSÉ CARLOS DE OLIVEIRA GOMES FILHO',';798726458:','Mestre','jose.oliveira@unicet.edu.br',474),('2026.1','52','ODONTOLOGIA','ODONTO-04',9887,'CLÍNICA DE SEMIOLOGIA II',30,'699','LUCAS FERNANDES FALCÃO','255:3443559','Mestre','lucas.falcao@unicet.edu.br',475),('2026.1','52','ODONTOLOGIA','ODONTO-04',9886,'MATERIAIS DE USO ODONTOLÓGICO ',45,'766','PATRÍCIA JOST','267:6387557','Mestre','patricia.jost@unicet.edu.br',476),('2026.1','52','ODONTOLOGIA','ODONTO-04',9885,'RADIOLOGIA CLÍNICA',75,'702','SERGIO ANTONIO PEREIRA FREITAS','6;948;65575','Doutor','sergio.freitas@unicet.edu.br',477),('2026.1','52','ODONTOLOGIA','ODONTO-04',9891,'CLÍNICA DE DIAGNÓSTICO POR IMAGEM II',30,'702','SERGIO ANTONIO PEREIRA FREITAS','6;948;65575','Doutor','sergio.freitas@unicet.edu.br',478),('2026.1','52','ODONTOLOGIA','ODONTO-04',10014,'OPTATIVA II',30,'664','THIAGO HENRIQUE GONÇALVES MOREIRA','34643857952','Mestre','thiago.goncalves@unicet.edu.br',479),('2026.1','52','ODONTOLOGIA','ODONTO-04',9889,'CLINICA DE ATENDIMENTO DE PACIENTES COM BRUXISMO E SINTOMAS DE DESORDENS TEMPOROMANDIBULARES I',30,'672','VICTOR WILLIAN FERREIRA DOURADO','2835767657:','Mestre','victor.dourado@unicet.edu.br',480),('2026.1','52','ODONTOLOGIA','ODONTO-04',9890,'CLINICA DE ATENDIMENTO DE PACIENTES COM BRUXISMO E SINTOMAS DE DESORDENS TEMPOROMANDIBULARES II',45,'672','VICTOR WILLIAN FERREIRA DOURADO','2835767657:','Mestre','victor.dourado@unicet.edu.br',481),('2026.1','52','ODONTOLOGIA','ODONTO-04',9885,'RADIOLOGIA CLÍNICA',75,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',482),('2026.1','52','ODONTOLOGIA','ODONTO-04',9887,'CLÍNICA DE SEMIOLOGIA II',30,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',483),('2026.1','52','ODONTOLOGIA','ODONTO-04',9891,'CLÍNICA DE DIAGNÓSTICO POR IMAGEM II',30,'765','WALLESK GOMES MORENO SILVA','634728;;526','Mestre','wallesk.moreno@unicet.edu.br',484),('2026.1','52','ODONTOLOGIA','ODONTO-05M',9903,'LEGISLAÇÃO, ÉTICA, CIDADANIA E SUSTENTABILIDADE NA ODONTOLOGIA',30,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',485),('2026.1','52','ODONTOLOGIA','ODONTO-05M',9909,'FUNDAMENTOS EM CLÍNICA ODONTOLÓGICA',30,'698','GISELLE TORRES FEITOSA',';6597;635;3','Mestre','giselle.feitosa@faculdadecet.edu.br',486),('2026.1','52','ODONTOLOGIA','ODONTO-05M',9908,'LIBRAS E PSICOLOGIA PARA ODONTOLOGIA',45,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',487),('2026.1','52','ODONTOLOGIA','ODONTO-05M',9906,'ATENÇÃO PRIMÁRIA À SAÚDE - I',30,'666','LUANA KELLE BATISTA MOURA','23739354577','Doutor','luana.moura@unicet.edu.br',488),('2026.1','52','ODONTOLOGIA','ODONTO-05M',9902,'ANATOMIA FUNCIONAL HUMANA',90,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',489),('2026.1','52','ODONTOLOGIA','ODONTO-05M',9904,'ORGANIZAÇÃO CELULAR E MOLECULAR',45,'353','MARA RAMEL DE SOUSA SILVA MATIAS','77644552537','Doutor','mara.silva@unicet.edu.br',490),('2026.1','52','ODONTOLOGIA','ODONTO-05M',9905,'ANATOMIA E ESCULTURA DENTAL',30,'672','VICTOR WILLIAN FERREIRA DOURADO','2835767657:','Mestre','victor.dourado@unicet.edu.br',491),('2026.1','2','SISTEMAS PARA INTERNET','S-SI01',9806,'INTRODUÇÃO AO BANCO DE DADOS',60,'697','CARLOS ALBERTO SOUSA SILVEIRA','99854;4556;','Mestre','ca25te@hotmail.com',492),('2026.1','2','SISTEMAS PARA INTERNET','S-SI01',9801,'INTRODUÇÃO À TECNOLOGIA DA INFORMAÇÃO PARA WEB',80,'790','DANILO RODRIGUES BARBOSA',';6;2;998542','Especialista','danilo.barbosa@unicet.edu.br',493),('2026.1','2','SISTEMAS PARA INTERNET','S-SI01',9805,'OPTATIVA I',40,'442','JANE KARLA DE OLIVEIRA SANTOS',':2;:8669537','Mestre','jane.karla@unicet.edu.br',494),('2026.1','2','SISTEMAS PARA INTERNET','S-SI01',9804,'PROJETO INTEGRADOR I',40,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',495),('2026.1','2','SISTEMAS PARA INTERNET','S-SI01',9802,'LÓGICA DE PROGRAMAÇÃO',80,'344','MÁRIO RODRIGUES GOMES MEIRELES FILHO','675;;7;2566','Mestre','professor47@faculdadecet.edu.br',496),('2026.1','2','SISTEMAS PARA INTERNET','S-SI01',9803,'INTRODUÇÃO AO DESENVOLVIMENTO WEB (HTML/CSS/JAVASCRIPT)',80,'758','VINICIUS SILVA GONÇALVES','29226396574','Especialista','vinisgon2@gmail.com',497),('2026.1','2','SISTEMAS PARA INTERNET','SI-04S',9807,'CLOUD COMPUTING',80,'697','CARLOS ALBERTO SOUSA SILVEIRA','99854;4556;','Mestre','ca25te@hotmail.com',498),('2026.1','2','SISTEMAS PARA INTERNET','SI-04S',9812,'OPTATIVA III',40,'790','DANILO RODRIGUES BARBOSA',';6;2;998542','Especialista','danilo.barbosa@unicet.edu.br',499),('2026.1','2','SISTEMAS PARA INTERNET','SI-04S',9808,'PROJETO INTEGRADOR IV',40,'456','JOELMA DANNIELY CAVALCANTI MEIRELES','93:3998259:','Mestre','joelmameireles@hotmail.com',500),('2026.1','2','SISTEMAS PARA INTERNET','SI-04S',9810,'INTRODUÇÃO À CIÊNCIA DE DADOS',60,'344','MÁRIO RODRIGUES GOMES MEIRELES FILHO','675;;7;2566','Mestre','professor47@faculdadecet.edu.br',501),('2026.1','2','SISTEMAS PARA INTERNET','SI-04S',9809,'DEVOPS E CI/CD',60,'731','MISAEL COSTA JÚNIOR','275;6:;:546','Doutor','misael.junior@faculdadecet.edu.br',502),('2026.1','2','SISTEMAS PARA INTERNET','SI-04S',9811,'DESENVOLVIMENTO MOBILE',80,'758','VINICIUS SILVA GONÇALVES','29226396574','Especialista','vinisgon2@gmail.com',503);
/*!40000 ALTER TABLE `pla_curso_disciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pla_curso_ies`
--

DROP TABLE IF EXISTS `pla_curso_ies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pla_curso_ies` (
  `codcurso` int NOT NULL,
  `nome_curso` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codcurso`),
  KEY `pla_curso_IES_nome_curso_IDX` (`nome_curso`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pla_curso_ies`
--

LOCK TABLES `pla_curso_ies` WRITE;
/*!40000 ALTER TABLE `pla_curso_ies` DISABLE KEYS */;
INSERT INTO `pla_curso_ies` VALUES (25,'BACHARELADO EM ADMINISTRAÇÃO'),(26,'BACHARELADO EM CIÊNCIAS CONTÁBEIS'),(9,'BIOMEDICINA'),(38,'DESIGN GRÁFICO'),(16,'DIREITO'),(10,'ENFERMAGEM'),(56,'ENGENHARIA DE COMPUTAÇÃO COM INTELIGÊNCIA ARTIFICIAL'),(12,'FARMÁCIA'),(30,'MEDICINA'),(52,'ODONTOLOGIA'),(2,'SISTEMAS PARA INTERNET');
/*!40000 ALTER TABLE `pla_curso_ies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pla_professor_curso`
--

DROP TABLE IF EXISTS `pla_professor_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pla_professor_curso` (
  `cpf` varchar(255) DEFAULT NULL,
  `codcurso` varchar(3) DEFAULT NULL,
  KEY `pla_professor_curso_cpf_IDX` (`cpf`,`codcurso`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pla_professor_curso`
--

LOCK TABLES `pla_professor_curso` WRITE;
/*!40000 ALTER TABLE `pla_professor_curso` DISABLE KEYS */;
INSERT INTO `pla_professor_curso` VALUES ('2226;:95522','30'),('2234;9:85;2','10'),('2234;9:85;2','30'),('22537645588','16'),('2262279;554','10'),('2265538;525','38'),('2266595;596','30'),('22696:75595','30'),('22887394525','30'),('228;486;59;','25'),('22939456267','16'),('2294;895538','12'),('22952292523','52'),('22956;2955:','52'),('22:3449;523','38'),('22:7:7;4526','30'),('23256397549','30'),('234627:5592','30'),('2353:475528','16'),('23599:845;;','30'),('23739354577','52'),('239439:852;','16'),('2428;6:;524','30'),('24386:68568','30'),('24533;65538','30'),('246429495;:','30'),('2469936853;','30'),('246:62:357;','30'),('246;3323522','16'),('24799223593','12'),('2482:45857;','16'),('248;79:;573','12'),('249252275:7','10'),('249252275:7','12'),('249252275:7','30'),('249252275:7','9'),('24935327596','10'),('249689295;2','52'),('24::4594567','10'),('24::4594567','12'),('24:;594;55;','30'),('252773::587','10'),('252773::587','12'),('252773::587','9'),('255:3443559','52'),('256293886;6','10'),('256293886;6','12'),('256293886;6','9'),('25653392596','10'),('25653392596','12'),('25653392596','30'),('25653392596','9'),('2573633:583','30'),('2582;774532','10'),('2582;774532','12'),('2582;774532','9'),('25873685533','10'),('25873685533','12'),('25873685533','9'),('259232;6528','56'),('259499;7523','12'),('25:35343578','10'),('25:35343578','12'),('25:35343578','30'),('25;57225529','16'),('25;64397577','56'),('26344266589','16'),('263:6357553','30'),('265974:8564','30'),('267875::589','30'),('267:6387557','52'),('26:533425:5','12'),('26:533425:5','25'),('26:533425:5','26'),('26:533425:5','30'),('26;65427543','52'),('26;;2854584','12'),('26;;2854584','30'),('26;;2854584','9'),('2722;353596','30'),('2724754:536','16'),('2724754:536','30'),('2724754:536','52'),('2754;3425;2','12'),('2754;3425;2','30'),('27583796:27','10'),('27583796:27','12'),('27583796:27','9'),('275;6:;:546','2'),('2795;882582','52'),('2835767657:','52'),('283749455;8','10'),('283749455;8','12'),('283749455;8','30'),('283749455;8','9'),('284688:;54;','30'),('2884528;594','30'),('2885;:8258:','30'),('29226396574','2'),('29226396574','38'),('29226396574','56'),('2949864554:','52'),('29877639564','56'),('32845:725;9','16'),('33628439:7;','30'),('34643857952','30'),('34643857952','52'),('3899:8;;:63','30'),('4238;3:5522','52'),('4398;:99526','30'),('4489;:85594','10'),('4489;:85594','12'),('4489;:85594','16'),('4489;:85594','9'),('44993;6:542','30'),('462:2:::58:','10'),('465776;858:','30'),('528:24;:526','30'),('52;6443956;','30'),('537675;6556','30'),('564425;;594','30'),('5644999858:','30'),('564;3;5:56;','30'),('57326474575','30'),('634728;;526','52'),('66665499537','30'),('6682;354542','30'),('675;;7;2566','2'),('675;;7;2566','38'),('6853;6:656;','25'),('6853;6:656;','26'),('6:4256545:9','30'),('6;948;65575','52'),('72685463526','16'),('73972962542','30'),('74899::75:9','30'),('774624895;3','30'),('7758:329537','52'),('77644552537','10'),('77644552537','12'),('77644552537','52'),('77644552537','56'),('77644552537','9'),('8224328;582','16'),('8225:298587','30'),('822624465:6','30'),('8377375:556','16'),('843899;258:','30'),('84442528594','10'),('84442528594','12'),('84595375522','56'),('84;6:99858:','30'),('86945;3956;','30'),('86;3;;;6542','30'),('8723568:575','30'),('882792655;3','16'),('8837;:6;5:9','30'),('8878749:556','10'),('88::9462522','52'),('8;57;947537','30'),('92585872522','30'),('93:3998259:','16'),('93:3998259:','2'),('93:3998259:','26'),('93:3998259:','38'),('9458544556;','25'),('9458544556;','26'),('983;69:958:','30'),('9927:8:4594','30'),('99854;4556;','2'),('99854;4556;','38'),(':2737682542','30'),(':277975:522','30'),(':2::26;75;3','30'),(':2;:8669537','16'),(':2;:8669537','2'),(':2;:8669537','30'),(':2;:8669537','52'),(':38237955;3','30'),(':3;22262566','30'),(':4:7;4;;522','30'),(':5398978594','52'),(':5:6467658:','52'),(':622853758:','30'),(':62387;2575','30'),(':62:;8:956;','30'),(':6::3756522','30'),(':74299:25:9','30'),(':745679756;','30'),(':7;265;4542','16'),(':;23:274575','10'),(':;23:274575','30'),(':;23:274575','56'),(':;253785537','30'),(';29:7283526','30'),(';348:86:575','30'),(';395364;526','30'),(';3:69223522','30'),(';6597;635;3','52'),(';6;2;998542','2'),(';6;2;998542','56'),(';798726458:','52'),(';84886445:9','30'),(';895;364522','30'),(';;48:;;2522','16'),(';;48:;;2522','25'),(';;48:;;2522','26'),(';;5624:558:','30');
/*!40000 ALTER TABLE `pla_professor_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_assinatura`
--

DROP TABLE IF EXISTS `projeto_assinatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_assinatura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_projeto` int NOT NULL,
  `id_pessoa` int NOT NULL,
  `Assinatura` varchar(500) NOT NULL,
  `data_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  `ordem` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pa_projeto` (`id_projeto`),
  KEY `fk_pa_pessoa` (`id_pessoa`),
  CONSTRAINT `fk_pa_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE CASCADE,
  CONSTRAINT `fk_pa_projeto` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_assinatura`
--

LOCK TABLES `projeto_assinatura` WRITE;
/*!40000 ALTER TABLE `projeto_assinatura` DISABLE KEYS */;
INSERT INTO `projeto_assinatura` VALUES (7,4,175,'4A1175A811A3617A372026A3','2026-06-11 17:07:45',1),(8,4,177,'4A1177A811A7617A7182026A7','2026-06-11 17:18:46',1),(9,4,269,'4A1269A811A3617A3232026A3','2026-06-11 17:23:50',2);
/*!40000 ALTER TABLE `projeto_assinatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_curso`
--

DROP TABLE IF EXISTS `projeto_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_curso` (
  `id_projeto` int NOT NULL,
  `id_curso` int NOT NULL,
  PRIMARY KEY (`id_projeto`,`id_curso`),
  KEY `id_curso` (`id_curso`),
  CONSTRAINT `projeto_curso_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_curso`
--

LOCK TABLES `projeto_curso` WRITE;
/*!40000 ALTER TABLE `projeto_curso` DISABLE KEYS */;
INSERT INTO `projeto_curso` VALUES (5,2),(4,38);
/*!40000 ALTER TABLE `projeto_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_custo`
--

DROP TABLE IF EXISTS `projeto_custo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_custo` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `id_projeto` int DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `quantitativo` decimal(10,2) DEFAULT NULL,
  `valor_unitario` decimal(10,2) DEFAULT NULL,
  `justificativa` text,
  `realizado` int DEFAULT NULL,
  `tipo` int DEFAULT NULL,
  `fonte_recurso` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `id_projeto` (`id_projeto`),
  CONSTRAINT `projeto_custo_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_custo`
--

LOCK TABLES `projeto_custo` WRITE;
/*!40000 ALTER TABLE `projeto_custo` DISABLE KEYS */;
INSERT INTO `projeto_custo` VALUES (1,4,'Cópias e impressões',200.00,0.25,'Boneca do livro',NULL,NULL,NULL),(2,4,'Criação de ilustrações',10.00,200.00,'',NULL,NULL,NULL),(3,4,'Emissão do número do ISBN',1.00,100.00,'Para registro do livro',NULL,NULL,NULL),(4,4,'Gerar ficha catalográfica',1.00,200.00,'Para registro do livro',NULL,NULL,NULL),(5,4,'Impressão',500.00,5.00,'Para impressão',NULL,NULL,NULL),(6,4,'Coquetel de lançamento',5.00,50.00,'Lançamento',NULL,NULL,NULL),(7,4,'Gerar código de barras ISBN',1.00,100.00,'Para registro do livro',NULL,NULL,NULL),(8,4,'Convite',15.00,100.00,'convidar alunos',NULL,NULL,NULL);
/*!40000 ALTER TABLE `projeto_custo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_extensao`
--

DROP TABLE IF EXISTS `projeto_extensao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_extensao` (
  `id_projeto` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `id_tipo_plano` int DEFAULT NULL,
  `coordenador_id` int DEFAULT NULL,
  `periodo_inicio` date DEFAULT NULL,
  `periodo_fim` date DEFAULT NULL,
  `carga_horaria_total` int DEFAULT NULL,
  `id_publico_alvo` int DEFAULT NULL,
  `objetivo` text,
  `metodologia` text,
  `status` enum('rascunho','em_avaliacao','aprovado','rejeitado','em_execucao','concluido') NOT NULL DEFAULT 'rascunho',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `resultados_esperados` text,
  `avaliacao_descricao` text,
  `referencias` text,
  `justificativa` text,
  `resultados_alcancados` text,
  `avaliacao_comunidade` text,
  `avaliacao_equipe` text,
  `produtos_gerados` text,
  `ods` text,
  `observacao_final` text,
  `anexos` text,
  PRIMARY KEY (`id_projeto`),
  KEY `coordenador_id` (`coordenador_id`),
  KEY `id_tipo_plano` (`id_tipo_plano`),
  KEY `id_publico_alvo` (`id_publico_alvo`),
  CONSTRAINT `projeto_extensao_ibfk_1` FOREIGN KEY (`coordenador_id`) REFERENCES `pessoa` (`id_pessoa`),
  CONSTRAINT `projeto_extensao_ibfk_2` FOREIGN KEY (`id_tipo_plano`) REFERENCES `tipo_plano` (`id_tipo_plano`),
  CONSTRAINT `projeto_extensao_ibfk_3` FOREIGN KEY (`id_publico_alvo`) REFERENCES `publico_alvo` (`id_publico_alvo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_extensao`
--

LOCK TABLES `projeto_extensao` WRITE;
/*!40000 ALTER TABLE `projeto_extensao` DISABLE KEYS */;
INSERT INTO `projeto_extensao` VALUES (4,'Criando Arte e Revista',1,269,'2026-03-01','2026-06-01',45,3,'<p><strong>Geral</strong>: Desenvolver projeto de design gráfico editorial (livro) voltado para publicação.</p><p><strong>Específicos</strong>:</p><ol><li data-list=\"ordered\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Apresentar o livro como um tipo de peça publicitária da Uni-Cet, reforçando o trabalho da instituição e dos alunos, servindo como catálogo produzido pelo curso de Design Gráfico.</li><li data-list=\"ordered\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Realizar projeto de acordo com instruções concisas e objetivas sobre missão ou tarefa a ser executada (briefing) de um possível cliente;</li><li data-list=\"ordered\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Projetar um livro com conteúdo literária, simulando obra exigida por cliente;</li><li data-list=\"ordered\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Imprimir o livro, exercitando todo o conteúdo trabalhado na disciplina de Fundamentos do Design Gráfico Editorial.</li></ol>','<p>A partir do desenvolvimento teórico aplicado na disciplina Fundamentos do Design Gráfico Editorial, os alunos estarão aptos a criar um projeto de livro. serão trabalhados os conceitos essenciais do design editorial, incluindo: Tipografia e hierarquia visual, Grid e composição, Legibilidade e ergonomia da leitura, entre outros. Os alunos irão selecionar textos literários de domínio público (ex.: Machado de Assis, autores piauienses como Abdias Neves e Da Costa e Silva), definir o público-alvo da obra, elaborar o conceito editorial (linguagem visual, proposta estética e posicionamento). Os alunos irão trabalhar o texto, ilustrações, capas e todos os demais elementos, pensando em um público alvo específico. O livro terá parceria com a editora Quinta Capa, que arcará com os custos de ISBN e Ficha Catalográfica, além de contribuir com o projeto editorial e criação de artes. O livro será impresso em forma física e trará a marca da Uni-Cet.</p>','aprovado','2026-06-03 22:47:54','2026-06-11 20:24:05',NULL,NULL,NULL,'<p>O projeto justifica-se por:</p>','<p>Os resultados Alcançados foram</p>','<p>A avaliação da Comunidade foi</p>','<p>A avaliação da equipe foi</p>','<p>Os produtos Gerados Foram</p>','<p>AS Vinculação com os ODS foram</p>','<p>Este relatório atende às diretrizes da Resolução CNE/CES nº 7/2018 e às orientações da política de extensão da instituição, visando demonstrar o impacto social da ação, sua articulação com o ensino e a formação cidadã dos estudantes.</p>','anexado  1'),(5,'projeto X',1,269,'2026-06-11','2026-06-24',40,3,'','<p>teste</p>','rascunho','2026-06-11 19:42:57','2026-06-11 19:42:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `projeto_extensao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_instituicao`
--

DROP TABLE IF EXISTS `projeto_instituicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_instituicao` (
  `id_projeto` int NOT NULL,
  `id_instituicao` int NOT NULL,
  PRIMARY KEY (`id_projeto`,`id_instituicao`),
  KEY `id_instituicao` (`id_instituicao`),
  CONSTRAINT `projeto_instituicao_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`),
  CONSTRAINT `projeto_instituicao_ibfk_2` FOREIGN KEY (`id_instituicao`) REFERENCES `instituicao` (`id_instituicao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_instituicao`
--

LOCK TABLES `projeto_instituicao` WRITE;
/*!40000 ALTER TABLE `projeto_instituicao` DISABLE KEYS */;
INSERT INTO `projeto_instituicao` VALUES (4,1);
/*!40000 ALTER TABLE `projeto_instituicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_linhaprogramatica`
--

DROP TABLE IF EXISTS `projeto_linhaprogramatica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_linhaprogramatica` (
  `id_projeto` int NOT NULL,
  `id_linha` int NOT NULL,
  PRIMARY KEY (`id_projeto`,`id_linha`),
  KEY `id_linha` (`id_linha`),
  CONSTRAINT `projeto_linhaprogramatica_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`),
  CONSTRAINT `projeto_linhaprogramatica_ibfk_2` FOREIGN KEY (`id_linha`) REFERENCES `linha_programatica` (`id_linha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_linhaprogramatica`
--

LOCK TABLES `projeto_linhaprogramatica` WRITE;
/*!40000 ALTER TABLE `projeto_linhaprogramatica` DISABLE KEYS */;
INSERT INTO `projeto_linhaprogramatica` VALUES (4,2),(4,7),(5,8);
/*!40000 ALTER TABLE `projeto_linhaprogramatica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_local`
--

DROP TABLE IF EXISTS `projeto_local`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_local` (
  `id_projeto` int NOT NULL,
  `id_local` int NOT NULL,
  PRIMARY KEY (`id_projeto`,`id_local`),
  KEY `id_local` (`id_local`),
  CONSTRAINT `projeto_local_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`),
  CONSTRAINT `projeto_local_ibfk_2` FOREIGN KEY (`id_local`) REFERENCES `local_execucao` (`id_local`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_local`
--

LOCK TABLES `projeto_local` WRITE;
/*!40000 ALTER TABLE `projeto_local` DISABLE KEYS */;
INSERT INTO `projeto_local` VALUES (4,1);
/*!40000 ALTER TABLE `projeto_local` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_pessoa`
--

DROP TABLE IF EXISTS `projeto_pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_pessoa` (
  `id_projeto` int NOT NULL,
  `id_pessoa` int NOT NULL,
  `id_papel` int DEFAULT NULL,
  `cargahoraria` int DEFAULT '0',
  `Disciplina` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_projeto`,`id_pessoa`),
  KEY `id_pessoa` (`id_pessoa`),
  KEY `id_papel` (`id_papel`),
  CONSTRAINT `projeto_pessoa_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`),
  CONSTRAINT `projeto_pessoa_ibfk_3` FOREIGN KEY (`id_papel`) REFERENCES `papel_projeto` (`id_papel`),
  CONSTRAINT `projeto_pessoa_pla_curso_disciplina_FK` FOREIGN KEY (`id_pessoa`) REFERENCES `pla_curso_disciplina` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_pessoa`
--

LOCK TABLES `projeto_pessoa` WRITE;
/*!40000 ALTER TABLE `projeto_pessoa` DISABLE KEYS */;
INSERT INTO `projeto_pessoa` VALUES (4,41,1,15,'FUNDAMENTOS DO DESIGN PARA PRODUÇÃO GRÁFICA EDITORIA - M2-DG-01'),(4,43,1,15,'FERRAMENTAS DE DESIGN - M2-DG-01'),(5,500,1,0,'PROJETO INTEGRADOR IV - SI-04S');
/*!40000 ALTER TABLE `projeto_pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_tipoacao`
--

DROP TABLE IF EXISTS `projeto_tipoacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_tipoacao` (
  `id_projeto` int NOT NULL,
  `id_acao` int NOT NULL,
  PRIMARY KEY (`id_projeto`,`id_acao`),
  KEY `id_acao` (`id_acao`),
  CONSTRAINT `projeto_tipoacao_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`),
  CONSTRAINT `projeto_tipoacao_ibfk_2` FOREIGN KEY (`id_acao`) REFERENCES `tipo_acao` (`id_acao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_tipoacao`
--

LOCK TABLES `projeto_tipoacao` WRITE;
/*!40000 ALTER TABLE `projeto_tipoacao` DISABLE KEYS */;
INSERT INTO `projeto_tipoacao` VALUES (4,6),(5,12);
/*!40000 ALTER TABLE `projeto_tipoacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publico_alvo`
--

DROP TABLE IF EXISTS `publico_alvo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publico_alvo` (
  `id_publico_alvo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_publico_alvo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publico_alvo`
--

LOCK TABLES `publico_alvo` WRITE;
/*!40000 ALTER TABLE `publico_alvo` DISABLE KEYS */;
INSERT INTO `publico_alvo` VALUES (1,'Interno'),(2,'Externo'),(3,'Ambos');
/*!40000 ALTER TABLE `publico_alvo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionario_impacto`
--

DROP TABLE IF EXISTS `questionario_impacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionario_impacto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_projeto` int DEFAULT NULL,
  `nome_acao` varchar(255) DEFAULT NULL,
  `instituicao` varchar(255) DEFAULT NULL,
  `data_realizacao` date DEFAULT NULL,
  `tipo_acao` varchar(100) DEFAULT NULL,
  `local_realizacao` varchar(255) DEFAULT NULL,
  `faixa_etaria` varchar(50) DEFAULT NULL,
  `escolaridade` varchar(100) DEFAULT NULL,
  `reside_local` varchar(10) DEFAULT NULL,
  `aval_conteudo` text,
  `expectativas` text,
  `impacto_desc` text,
  `aplicacao_conhecimento` text,
  `gostou` varchar(10) DEFAULT NULL,
  `melhorias` text,
  `consentimento` tinyint(1) DEFAULT '0',
  `data_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_quest_projeto` (`id_projeto`),
  CONSTRAINT `fk_quest_projeto` FOREIGN KEY (`id_projeto`) REFERENCES `projeto_extensao` (`id_projeto`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionario_impacto`
--

LOCK TABLES `questionario_impacto` WRITE;
/*!40000 ALTER TABLE `questionario_impacto` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionario_impacto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_acao`
--

DROP TABLE IF EXISTS `tipo_acao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_acao` (
  `id_acao` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id_acao`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_acao`
--

LOCK TABLES `tipo_acao` WRITE;
/*!40000 ALTER TABLE `tipo_acao` DISABLE KEYS */;
INSERT INTO `tipo_acao` VALUES (1,'Programa'),(2,'Projeto'),(3,'Curso'),(4,'Evento'),(5,'Prestação de Serviço'),(6,'Produção e Publicação'),(7,'Incubadora'),(8,'Empresa Júnior'),(9,'Observatório'),(10,'Clínica Escola / Escritório Modelo'),(11,'Laboratório de Práticas Extensionistas'),(12,'Oficina');
/*!40000 ALTER TABLE `tipo_acao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_instituicao`
--

DROP TABLE IF EXISTS `tipo_instituicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_instituicao` (
  `id_tipo_instituicao` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_instituicao`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_instituicao`
--

LOCK TABLES `tipo_instituicao` WRITE;
/*!40000 ALTER TABLE `tipo_instituicao` DISABLE KEYS */;
INSERT INTO `tipo_instituicao` VALUES (1,'Pública'),(2,'Privada');
/*!40000 ALTER TABLE `tipo_instituicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_pessoa`
--

DROP TABLE IF EXISTS `tipo_pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_pessoa` (
  `id_tipo_pessoa` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_pessoa`
--

LOCK TABLES `tipo_pessoa` WRITE;
/*!40000 ALTER TABLE `tipo_pessoa` DISABLE KEYS */;
INSERT INTO `tipo_pessoa` VALUES (1,'Coordenador'),(2,'Professor'),(3,'Técnico'),(4,'PROPEC');
/*!40000 ALTER TABLE `tipo_pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_plano`
--

DROP TABLE IF EXISTS `tipo_plano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_plano` (
  `id_tipo_plano` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_plano`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_plano`
--

LOCK TABLES `tipo_plano` WRITE;
/*!40000 ALTER TABLE `tipo_plano` DISABLE KEYS */;
INSERT INTO `tipo_plano` VALUES (1,'Curricular'),(2,'Extracurricular');
/*!40000 ALTER TABLE `tipo_plano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `id_pessoa` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `fk_usuario_pessoa` (`id_pessoa`),
  CONSTRAINT `fk_usuario_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=843 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'admin','admin26','admin',121,'2026-03-20 12:13:49'),(587,'katia.pereira','622203@K','professor',67,'2026-06-11 19:39:26'),(588,'maria.prianti','053615@M','professor',69,'2026-06-11 19:39:26'),(589,'maria.silva','240808@M','professor',71,'2026-06-11 19:39:26'),(590,'giselle.ibiapina','859043@G','professor',72,'2026-06-11 19:39:26'),(591,'kelly.oliveira','038131@K','professor',73,'2026-06-11 19:39:26'),(592,'keylla.machado','028823@K','professor',74,'2026-06-11 19:39:26'),(593,'akemi.cruzio','027030@A','professor',76,'2026-06-11 19:39:26'),(594,'jane.santos','809864@J','professor',78,'2026-06-11 19:39:26'),(595,'daniel.sampaio','003154@D','coordenador',80,'2026-06-11 19:39:26'),(596,'justina.nascimento','615515@J','professor',81,'2026-06-11 19:39:26'),(597,'joelma.meireles','718177@J','professor',82,'2026-06-11 19:39:26'),(598,'thalyta.oliveira','026957@T','professor',84,'2026-06-11 19:39:26'),(599,'márcia.mattos','665652@M','coordenador',86,'2026-06-11 19:39:26'),(600,'anna.silva','025770@A','professor',88,'2026-06-11 19:39:26'),(601,'thiara.oliveira','007296@T','coordenador',89,'2026-06-11 19:39:26'),(602,'vanessa.mendes','013182@V','professor',90,'2026-06-11 19:39:26'),(603,'francisca.sousa','034311@F','professor',91,'2026-06-11 19:39:26'),(604,'eulane.batista','024911@E','professor',95,'2026-06-11 19:39:26'),(605,'everton.lopes','027131@E','professor',96,'2026-06-11 19:39:26'),(606,'luiz.oliveira','226798@L','professor',97,'2026-06-11 19:39:26'),(607,'deillany.mendes','992689@D','professor',100,'2026-06-11 19:39:26'),(608,'thalita.lustosa','026082@T','professor',103,'2026-06-11 19:39:26'),(609,'elson.rêgo','660570@E','professor',104,'2026-06-11 19:39:26'),(610,'nelson.rios','890180@N','professor',105,'2026-06-11 19:39:26'),(611,'nayla.barboza','000498@N','professor',106,'2026-06-11 19:39:26'),(612,'lorena.carvalho','004005@L','professor',108,'2026-06-11 19:39:26'),(613,'ana.silva','039350@A','professor',109,'2026-06-11 19:39:26'),(614,'victor.barbosa','036514@V','professor',110,'2026-06-11 19:39:26'),(615,'ana.santana','037277@A','professor',111,'2026-06-11 19:39:26'),(616,'maíra.cavalcante','007172@M','professor',112,'2026-06-11 19:39:26'),(617,'tatiana.magalhaes','017217@T','professor',113,'2026-06-11 19:39:26'),(618,'isabel.oliveira','114062@I','professor',116,'2026-06-11 19:39:26'),(619,'francisco.azevedo','852077@F','coordenador',117,'2026-06-11 19:39:26'),(620,'adélia.oliveira','446091@A','professor',118,'2026-06-11 19:39:26'),(621,'danielle.furtado','049906@D','professor',131,'2026-06-11 19:39:26'),(622,'anderson.andrade','220610@A','professor',132,'2026-06-11 19:39:26'),(623,'antonio.filho','315453@A','professor',133,'2026-06-11 19:39:26'),(624,'edison.vale','243554@E','professor',136,'2026-06-11 19:39:26'),(625,'giuliano.oliveira','035141@G','professor',139,'2026-06-11 19:39:26'),(626,'luiz.neto','840063@L','professor',140,'2026-06-11 19:39:26'),(627,'magda.viana','517507@M','professor',141,'2026-06-11 19:39:26'),(628,'mauro.albuquerque','840165@M','professor',143,'2026-06-11 19:39:26'),(629,'pedro.azevedo','053291@P','professor',146,'2026-06-11 19:39:26'),(630,'enedina.moura','041220@E','professor',150,'2026-06-11 19:39:26'),(631,'eduardo.lira','087182@E','professor',154,'2026-06-11 19:39:26'),(632,'danilo.barbosa','949097@D','professor',155,'2026-06-11 19:39:26'),(633,'fernanda.santana','030084@F','professor',160,'2026-06-11 19:39:26'),(634,'artur.veloso','052121@A','professor',163,'2026-06-11 19:39:26'),(635,'tarcísio.jaime','623731@T','professor',164,'2026-06-11 19:39:26'),(636,'antonio.ibiabina','037010@A','professor',165,'2026-06-11 19:39:26'),(637,'rusbene.carvalho','030551@R','professor',167,'2026-06-11 19:39:26'),(638,'ana.brito','048311@A','professor',168,'2026-06-11 19:39:26'),(639,'marcio.batista','723632@M','coordenador',169,'2026-06-11 19:39:26'),(640,'mara.matias','554223@M','professor',170,'2026-06-11 19:39:26'),(641,'lucas.oliveira','061527@L','professor',171,'2026-06-11 19:39:26'),(642,'eugenio.junior','034071@E','professor',172,'2026-06-11 19:39:26'),(643,'maria.brito','036095@M','professor',173,'2026-06-11 19:39:26'),(644,'acacio.junior','008122@A','professor',174,'2026-06-11 19:39:26'),(645,'bernardo.oliveira','004331@B','professor',175,'2026-06-11 19:39:26'),(646,'carlos.silveira','776329@C','professor',176,'2026-06-11 19:39:26'),(647,'vinicius.gonçalves','070041@V','professor',177,'2026-06-11 19:39:26'),(648,'dhaniel.ferreira','600210@D','professor',178,'2026-06-11 19:39:26'),(649,'luiza.ferreira','106238@L','professor',179,'2026-06-11 19:39:26'),(650,'eliana.nascimento','504632@E','professor',180,'2026-06-11 19:39:26'),(651,'layanne.moura','001297@L','professor',181,'2026-06-11 19:39:26'),(652,'lucas.neris','076554@L','professor',182,'2026-06-11 19:39:26'),(653,'daves.silva','819000@D','professor',183,'2026-06-11 19:39:26'),(654,'fabiola.veras','444432@F','professor',184,'2026-06-11 19:39:26'),(655,'miguel.ferreira','028937@M','professor',185,'2026-06-11 19:39:26'),(656,'alda.silva','062466@A','professor',186,'2026-06-11 19:39:26'),(657,'antonio.cortez','661598@A','PROPEC',187,'2026-06-11 19:39:26'),(658,'sergio.meneses','621677@S','professor',188,'2026-06-11 19:39:26'),(659,'thiago.diniz','041841@T','professor',189,'2026-06-11 19:39:26'),(660,'frederico.prado','010341@F','professor',190,'2026-06-11 19:39:26'),(661,'georgia.agostinho','890315@G','professor',191,'2026-06-11 19:39:26'),(662,'thiago.moreira','124216@T','professor',192,'2026-06-11 19:39:26'),(663,'euripedes.mendes','917314@E','professor',193,'2026-06-11 19:39:26'),(664,'fabrizio.nunes','024771@F','professor',194,'2026-06-11 19:39:26'),(665,'lara.veras','649199@L','coordenador',195,'2026-06-11 19:39:26'),(666,'maurílio.lima','045653@M','professor',196,'2026-06-11 19:39:26'),(667,'silvia.campos','816015@S','professor',197,'2026-06-11 19:39:26'),(668,'eduardo.pinto','021648@E','professor',198,'2026-06-11 19:39:26'),(669,'julio.filho','693597@J','professor',199,'2026-06-11 19:39:26'),(670,'luiz.falcão','004748@L','professor',200,'2026-06-11 19:39:26'),(671,'moisés.oliveira','351042@M','professor',201,'2026-06-11 19:39:26'),(672,'ana.almeida','828592@A','professor',202,'2026-06-11 19:39:26'),(673,'dayrton.moreira','023119@D','professor',203,'2026-06-11 19:39:26'),(674,'eucário.alves','217698@E','professor',204,'2026-06-11 19:39:26'),(675,'jyselda.duarte','342203@J','professor',205,'2026-06-11 19:39:26'),(676,'liliam.araújo','309422@L','professor',206,'2026-06-11 19:39:26'),(677,'lorena.batista','805575@L','professor',207,'2026-06-11 19:39:26'),(678,'lucas.terto','012405@L','professor',208,'2026-06-11 19:39:26'),(679,'nagele.lima','967391@N','professor',209,'2026-06-11 19:39:26'),(680,'patricia.melo','918470@P','professor',210,'2026-06-11 19:39:26'),(681,'thadeu.monteiro','770586@T','professor',211,'2026-06-11 19:39:26'),(682,'thiago.medeiros','808804@T','professor',212,'2026-06-11 19:39:26'),(683,'virginia.cardoso','024207@V','professor',213,'2026-06-11 19:39:26'),(684,'welligton.figueiredo','650134@W','professor',214,'2026-06-11 19:39:26'),(685,'alesse.santos','805154@A','professor',215,'2026-06-11 19:39:26'),(686,'ana.pinheiro','848815@A','professor',216,'2026-06-11 19:39:26'),(687,'lauro.filho','066230@L','professor',217,'2026-06-11 19:39:26'),(688,'leandro.leal','167786@L','professor',218,'2026-06-11 19:39:26'),(689,'marcelo.costa','703636@M','professor',219,'2026-06-11 19:39:26'),(690,'thais.carvalho','050091@T','professor',220,'2026-06-11 19:39:26'),(691,'aurus.meneses','907850@A','professor',221,'2026-06-11 19:39:26'),(692,'bruno.gonçalves','013778@B','professor',222,'2026-06-11 19:39:26'),(693,'danilo.dantas','024840@D','professor',223,'2026-06-11 19:39:26'),(694,'flávio.filho','043752@F','professor',224,'2026-06-11 19:39:26'),(695,'germano.oliveira','912686@G','professor',225,'2026-06-11 19:39:26'),(696,'laís.galiza','020694@L','professor',226,'2026-06-11 19:39:26'),(697,'leonardo.junior','962664@L','professor',227,'2026-06-11 19:39:26'),(698,'mariana.pinheiro','008585@M','professor',228,'2026-06-11 19:39:26'),(699,'antonio.pereira','306802@A','professor',229,'2026-06-11 19:39:26'),(700,'atêncio.filho','552402@A','professor',230,'2026-06-11 19:39:26'),(701,'denise.medeiros','600402@D','professor',231,'2026-06-11 19:39:26'),(702,'elna.amaral','761947@E','professor',232,'2026-06-11 19:39:26'),(703,'flavia.arrais','840896@F','professor',233,'2026-06-11 19:39:26'),(704,'flávia.silva','600380@F','professor',234,'2026-06-11 19:39:26'),(705,'luiza.batista','342277@L','professor',235,'2026-06-11 19:39:26'),(706,'raimundo.junior','526778@R','professor',236,'2026-06-11 19:39:26'),(707,'williams.silva','993402@W','professor',237,'2026-06-11 19:39:26'),(708,'gerardo.neto','647239@G','professor',238,'2026-06-11 19:39:26'),(709,'egidia.vieira','553681@E','professor',239,'2026-06-11 19:39:26'),(710,'francisco.silva','049432@F','professor',240,'2026-06-11 19:39:26'),(711,'giselle.feitosa','943759@G','professor',241,'2026-06-11 19:39:26'),(712,'josé.filho','957650@J','professor',242,'2026-06-11 19:39:26'),(713,'karina.lustosa','057396@K','professor',243,'2026-06-11 19:39:26'),(714,'luana.moura','015171@L','coordenador',244,'2026-06-11 19:39:26'),(715,'lucas.falcão','033812@L','professor',245,'2026-06-11 19:39:26'),(716,'marcelya.rocha','027467@M','professor',246,'2026-06-11 19:39:26'),(717,'victor.dourado','061354@V','professor',247,'2026-06-11 19:39:26'),(718,'luciana.lima','668872@L','professor',248,'2026-06-11 19:39:26'),(719,'thiago.monte','831767@T','professor',249,'2026-06-11 19:39:26'),(720,'wilana.moura','007300@W','professor',250,'2026-06-11 19:39:26'),(721,'carine.borges','838424@C','professor',251,'2026-06-11 19:39:26'),(722,'patrícia.jost','045841@P','professor',252,'2026-06-11 19:39:26'),(723,'sergio.freitas','497269@S','professor',253,'2026-06-11 19:39:26'),(724,'misael.júnior','053948@M','professor',254,'2026-06-11 19:39:26'),(725,'guilhermina.silva','463194@G','professor',255,'2026-06-11 19:39:26'),(726,'joélcio.sousa','006926@J','professor',256,'2026-06-11 19:39:26'),(727,'ismael.silva','050253@I','professor',257,'2026-06-11 19:39:26'),(728,'isabel.batista','629487@I','professor',258,'2026-06-11 19:39:26'),(729,'jocerlano.sousa','852345@J','professor',259,'2026-06-11 19:39:26'),(730,'joão.ribeiro','227719@J','professor',260,'2026-06-11 19:39:26'),(731,'ione.lopes','066398@I','professor',261,'2026-06-11 19:39:26'),(732,'isanio.mesquita','342919@I','professor',262,'2026-06-11 19:39:26'),(733,'josé.junior','482034@J','professor',263,'2026-06-11 19:39:26'),(734,'josé.segundo','004437@J','professor',264,'2026-06-11 19:39:26'),(735,'gustavo.noleto','006651@G','professor',265,'2026-06-11 19:39:26'),(736,'isabel.rêgo','201691@I','professor',266,'2026-06-11 19:39:26'),(737,'isabela.nunes','007349@I','professor',267,'2026-06-11 19:39:26'),(738,'jairon.cardoso','072764@J','professor',268,'2026-06-11 19:39:26'),(739,'mariofilho','453995@M','coordenador',269,'2026-06-11 19:39:26'),(842,'coordenador','coord123','coordenador',321,'2026-06-12 11:34:19');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'projetos_extensao2'
--
/*!50003 DROP FUNCTION IF EXISTS `anonimizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `anonimizar`(nomeanonimizar varchar(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
    RETURN concat(SUBSTRING(nomeanonimizar,1,4), REPEAT('*', 3), SUBSTRING(nomeanonimizar,-4));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `anonimizar_pessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `anonimizar_pessoa`(nomeanonimizar varchar(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
  DECLARE nome varchar(255);

	SET  nome = (
		CONCAT(SUBSTRING_INDEX(nomeanonimizar, ' ', 1),
		REPEAT('*', 6 ) ,
            SUBSTRING_INDEX(nomeanonimizar, ' ', -1))
		);
	RETURN nome; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `busca_chave` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `busca_chave`(nome varchar(255)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE valor varchar(5);
    DECLARE total INT;
    set total = length(nome);
   
    if total>9 THEN
    	set total =  ret_codigo_palavra(length(nome)) ;
	    if total>9 THEN
	    	set total =  ret_codigo_palavra(cast(total as char)) ;
	   end if ;
    
    
   end if ;
    
	RETURN total; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `criptografar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `criptografar`(nomeanonimizar varchar(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
	DECLARE NomeRetorno varchar(255);
	DECLARE position INT;
	DECLARE codigo INT;
	DECLARE string CHAR(8);  	
    DECLARE novonome  varchar(255);
    DECLARE novapos int;
	SET position = 1;  
	SET codigo = busca_chave( nomeanonimizar);
	SET novonome = '';
	WHILE position <= length(nomeanonimizar)  do		  			
			set novapos = ASCII(SUBSTRING(nomeanonimizar, position, 1));
			if novapos <> 32 THEN
				SET novapos  = ASCII(SUBSTRING(nomeanonimizar, position, 1)) + codigo;
			end if;
			set novonome = concat(novonome, CHAR(novapos) );
			SET position = position + 1  ;
		END WHILE;
   SET NomeRetorno = novonome;
   RETURN NomeRetorno;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `decriptografar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `decriptografar`(nomeanonimizar varchar(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
	DECLARE NomeRetorno varchar(255);
	DECLARE position INT;
	DECLARE codigo INT;
	DECLARE string CHAR(8);  	
    DECLARE novonome  varchar(255);
    DECLARE novapos int;
	SET position = 1;  
	SET codigo = busca_chave( nomeanonimizar);
	SET novonome = '';
	WHILE position <= length(nomeanonimizar)  do		  			
			set novapos = ASCII(SUBSTRING(nomeanonimizar, position, 1));
			if novapos <> 32 THEN
				SET novapos  = ASCII(SUBSTRING(nomeanonimizar, position, 1)) - codigo;
			end if;
			set novonome = concat(novonome, CHAR(novapos) );
			SET position = position + 1  ;
		END WHILE;
   SET NomeRetorno = novonome;
   RETURN NomeRetorno;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ret_codigo_palavra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ret_codigo_palavra`(valor varchar(5)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE total INT;
	  if length(valor) = 2 then	         
	      SET total = ( CAST(SUBSTRING(valor,1,1) AS UNSIGNED)+ 
	          				 CAST(SUBSTRING(valor,2,1) AS UNSIGNED)	)	  ;	    
	  else	    
	      if length(valor) = 3 then	            
	           SET total = ( CAST(SUBSTRING(valor,1,1) AS UNSIGNED)+ 
	          				 CAST(SUBSTRING(valor,2,1) AS UNSIGNED)+ 
	          				 CAST(SUBSTRING(valor,3,1) AS UNSIGNED) );	 
	        
	      else
	        
	          if length(valor) = 4 then	                 
	                SET total = ( CAST(SUBSTRING(valor,1,1) AS UNSIGNED)+ 
	                			  CAST(SUBSTRING(valor,2,1) AS UNSIGNED)+
	                              CAST(SUBSTRING(valor,3,1) AS UNSIGNED) + 
	                              CAST(SUBSTRING(valor,4,1) AS UNSIGNED) ) ;
	            end if  ;
	        end if ;
	     end if ;
  RETURN total;
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

-- Dump completed on 2026-06-14 10:27:25
