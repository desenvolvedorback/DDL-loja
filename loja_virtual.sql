CREATE DATABASE IF NOT EXISTS loja_virtual_db;

USE loja_virtual_db;

CREATE TABLE IF NOT EXISTS categoria(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL, 
    descricao VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS produto(
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria int not null,
    nome VARCHAR(100) NOT NULL, 
    descricao VARCHAR(255) NOT NULL,
    preco decimal(10.2) not null,
    estoque int not null,
    FOREIGN KEY (id_categoria) REFERENCES categoria (id)
);

CREATE TABLE IF NOT EXISTS cliente(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    cpf varchar(15) not null,
    email varchar(50) not null,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS pedido(
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente int not null,
    data_pedido datetime NOT NULL, 
    status VARCHAR(25) NOT NULL,
    valor_total decimal(10.2) not null,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id)
);

CREATE TABLE IF NOT EXISTS item_pedido(
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido int not null,
    id_produto int not null,
    quantidade int NOT NULL,
    preco_unitario decimal(10.2) not null,
    FOREIGN KEY (id_pedido) REFERENCES pedido (id),
    foreign key (id_produto) references produto (id)
);

