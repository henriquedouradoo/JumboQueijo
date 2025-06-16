CREATE DATABASE jumboQueijo;
USE jumboQueijo;

CREATE TABLE empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
	razao_social VARCHAR(50) NOT NULL,
	cnpj CHAR(14) NOT NULL,
	codigo_ativacao VARCHAR(50)
);

create table salaMaturacao (
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(300) NOT NULL,
	fk_empresa INT NOT NULL,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

create table medida (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dht11_umidade DECIMAL NOT NULL,
	dht11_temperatura DECIMAL NOT NULL,
	momento DATETIME NOT NULL,
	fk_salaMaturacao INT NOT NULL,
	FOREIGN KEY (fk_salaMaturacao) REFERENCES salaMaturacao(id)
);

CREATE TABLE loteQueijo (
  idqueijo INT PRIMARY KEY AUTO_INCREMENT,
  marca varchar(45),
  data_producao DATE NOT NULL,
  peso_kg DECIMAL(5,2),
  tempo_maturacao_dias INT,
  temperatura_armazenamento DECIMAL(4,1),
  observacoes TEXT
);

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	senha VARCHAR(50) NOT NULL, 
	fk_empresa INT NOT NULL,
	fkQueijo INT NOT NULL,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id),
	FOREIGM KEY (fkQueijo) REFERENCES loteQueijo(idQueijo)
);

-- CRIAÇÃO DE TRIGGER PARA QUANDO HOUVER A INSERÇÃO DE NOVA SENHA, A MESMA SER CRIPTOGRAFADA.
DELIMITER $
CREATE TRIGGER crip_senha
BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
     SET NEW.senha = SHA2(NEW.senha, 256);
END;
$
DELIMITER ;

CREATE TABLE aviso (
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(100) NOT NULL,
	descricao VARCHAR(150) NOT NULL,
	fk_usuario INT NOT NULL,
	FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
);


CREATE TABLE queijoNota (
  idnota INT PRIMARY KEY AUTO_INCREMENT,
  idusuario INT,
  idqueijo INT,
  idade varchar(255),
  origem VARCHAR(255),
  marca varchar(45),
  comentarios TEXT,
  foto VARCHAR(255),
  FOREIGN KEY (idusuario) REFERENCES usuario(id),
  FOREIGN KEY (idqueijo) REFERENCES queijo(idqueijo)
);

-- INSERÇÕES BASE
INSERT INTO loteQueijo (data_producao, peso_kg, tempo_maturacao_dias, temperatura_armazenamento, observacoes) VALUES
('2025-06-15', 2.50, 2, 4.0, 'Mussarela tradicional - lote 001');

insert into empresa VALUES
(1, 'GVINAH', '75152878521298', 'ED145B');

insert into empresa values
(2, 'Tirolez', '18210358741203', 'A1B2C3');

-- drop database jumboQueijo;