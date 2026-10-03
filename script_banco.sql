CREATE DATABASE IF NOT EXISTS sistema_clientes;

USE sistema_clientes;



CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    status ENUM('ativo','inativo') DEFAULT 'ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT DEFAULT 0,
    status ENUM('ativo','inativo') DEFAULT 'ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('admin', 'operador') DEFAULT 'operador',
    status ENUM('ativo', 'inativo') DEFAULT 'ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',
    valor_total DECIMAL(10, 2) DEFAULT 0.00,

    FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
        ON DELETE RESTRICT
);




CREATE TABLE IF NOT EXISTS itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,

    FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id)
        ON DELETE CASCADE,

    FOREIGN KEY (produto_id)
        REFERENCES produtos(id)
        ON DELETE RESTRICT
);


-- =========================================
-- DADOS INICIAIS DE TESTE
-- =========================================

INSERT INTO clientes (nome, email, telefone, status)
VALUES
('João Silva', 'joao@email.com', '47999999999', 'ativo');


INSERT INTO produtos (nome, descricao, preco, estoque, status)
VALUES
('Notebook', 'Notebook para testes', 2500.00, 10, 'ativo');


INSERT INTO usuarios (nome, email, senha, perfil, status)
VALUES
('Administrador', 'admin@email.com', '123456', 'admin', 'ativo');


-- =========================================
-- PEDIDO DE TESTE
-- =========================================

INSERT INTO pedidos (cliente_id, status, valor_total)
VALUES
(1, 'pendente', 5000.00);


-- =========================================
-- ITEM DO PEDIDO DE TESTE
-- =========================================

INSERT INTO itens_pedido
(pedido_id, produto_id, quantidade, preco_unitario)
VALUES
(1, 1, 2, 2500.00);