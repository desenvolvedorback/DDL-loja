# 🛒 Loja Virtual — Banco de Dados

Banco de dados relacional desenvolvido em **MySQL** para gerenciamento de uma loja virtual, permitindo cadastrar categorias, produtos e clientes, além de registrar pedidos e seus respectivos itens.

## 🗄️ Tecnologias

* **MySQL**
* **SQL**
* Banco de dados relacional
* Chaves primárias e estrangeiras
* `AUTO_INCREMENT`
* Restrições `NOT NULL`
* Relacionamentos entre tabelas
* Tipos `DECIMAL` para valores monetários

---

## 📌 Estrutura do Banco

O banco de dados utilizado pelo projeto é:

```text
loja_virtual_db
```

O sistema possui cinco tabelas principais:

```text
loja_virtual_db
│
├── categoria
│
├── produto
│     └── id_categoria → categoria.id
│
├── cliente
│
├── pedido
│     └── id_cliente → cliente.id
│
└── item_pedido
      ├── id_pedido  → pedido.id
      └── id_produto → produto.id
```

A tabela `item_pedido` funciona como uma tabela de associação entre **pedidos** e **produtos**, permitindo que um pedido possua vários produtos e que um produto apareça em vários pedidos.

---

## 🏷️ Tabela `categoria`

Armazena as categorias utilizadas para organizar os produtos da loja.

| Campo       | Tipo         | Descrição                        |
| ----------- | ------------ | -------------------------------- |
| `id`        | INT          | Identificador único da categoria |
| `nome`      | VARCHAR(50)  | Nome da categoria                |
| `descricao` | VARCHAR(255) | Descrição da categoria           |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

O campo `id` identifica cada categoria de forma única e é gerado automaticamente.

---

## 📦 Tabela `produto`

Armazena os produtos disponíveis na loja virtual.

| Campo          | Tipo          | Descrição                           |
| -------------- | ------------- | ----------------------------------- |
| `id`           | INT           | Identificador único do produto      |
| `id_categoria` | INT           | Categoria à qual o produto pertence |
| `nome`         | VARCHAR(100)  | Nome do produto                     |
| `descricao`    | VARCHAR(255)  | Descrição do produto                |
| `preco`        | DECIMAL(10,2) | Preço do produto                    |
| `estoque`      | INT           | Quantidade disponível em estoque    |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

### Chave estrangeira

```sql
FOREIGN KEY (id_categoria) REFERENCES categoria(id)
```

O campo `id_categoria` relaciona cada produto a uma categoria existente.

### Relação

Uma categoria pode possuir vários produtos:

```text
categoria 1 ───────── N produto
```

---

## 👤 Tabela `cliente`

Armazena os dados dos clientes cadastrados na loja.

| Campo      | Tipo         | Descrição                      |
| ---------- | ------------ | ------------------------------ |
| `id`       | INT          | Identificador único do cliente |
| `nome`     | VARCHAR(100) | Nome do cliente                |
| `cpf`      | VARCHAR(15)  | CPF do cliente                 |
| `email`    | VARCHAR(50)  | E-mail do cliente              |
| `telefone` | VARCHAR(20)  | Telefone para contato          |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

O campo `id` identifica cada cliente de forma única.

---

## 🧾 Tabela `pedido`

Armazena os pedidos realizados pelos clientes.

| Campo         | Tipo          | Descrição                       |
| ------------- | ------------- | ------------------------------- |
| `id`          | INT           | Identificador único do pedido   |
| `id_cliente`  | INT           | Cliente responsável pelo pedido |
| `data_pedido` | DATETIME      | Data e horário do pedido        |
| `status`      | VARCHAR(25)   | Status do pedido                |
| `valor_total` | DECIMAL(10,2) | Valor total do pedido           |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

### Chave estrangeira

```sql
FOREIGN KEY (id_cliente) REFERENCES cliente(id)
```

O campo `id_cliente` relaciona cada pedido ao cliente que realizou a compra.

### Relação

Um cliente pode realizar vários pedidos:

```text
cliente 1 ───────── N pedido
```

---

## 🛍️ Tabela `item_pedido`

Armazena os produtos pertencentes a cada pedido.

| Campo            | Tipo          | Descrição                           |
| ---------------- | ------------- | ----------------------------------- |
| `id`             | INT           | Identificador único do item         |
| `id_pedido`      | INT           | Pedido ao qual o item pertence      |
| `id_produto`     | INT           | Produto incluído no pedido          |
| `quantidade`     | INT           | Quantidade do produto               |
| `preco_unitario` | DECIMAL(10,2) | Preço unitário do produto no pedido |

### Chave primária

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

### Chaves estrangeiras

Relacionamento com o pedido:

```sql
FOREIGN KEY (id_pedido) REFERENCES pedido(id)
```

Relacionamento com o produto:

```sql
FOREIGN KEY (id_produto) REFERENCES produto(id)
```

Essa tabela permite registrar **quais produtos fazem parte de cada pedido**, além da quantidade e do preço unitário.

---

## 🔗 Relacionamentos

A estrutura do banco pode ser representada da seguinte forma:

```text
┌──────────────────┐
│    categoria     │
├──────────────────┤
│ id (PK)          │
│ nome             │
│ descricao        │
└────────┬─────────┘
         │
         │ 1:N
         ▼
┌──────────────────┐
│     produto      │
├──────────────────┤
│ id (PK)          │
│ id_categoria(FK) │
│ nome             │
│ descricao        │
│ preco            │
│ estoque          │
└────────┬─────────┘
         │
         │ 1:N
         │
         ▼
┌──────────────────────┐
│     item_pedido      │
├──────────────────────┤
│ id (PK)              │
│ id_pedido (FK)       │
│ id_produto (FK)      │
│ quantidade           │
│ preco_unitario       │
└──────────┬───────────┘
           │
           │ N:1
           ▼
┌──────────────────┐
│      pedido      │
├──────────────────┤
│ id (PK)          │
│ id_cliente (FK)  │
│ data_pedido      │
│ status           │
│ valor_total      │
└────────┬─────────┘
         │
         │ N:1
         ▼
┌──────────────────┐
│     cliente      │
├──────────────────┤
│ id (PK)          │
│ nome             │
│ cpf              │
│ email            │
│ telefone         │
└──────────────────┘
```

### Relação `categoria` → `produto`

Uma categoria pode possuir vários produtos, enquanto cada produto pertence a uma categoria.

### Relação `cliente` → `pedido`

Um cliente pode realizar vários pedidos, enquanto cada pedido está associado a um cliente.

### Relação `pedido` → `item_pedido`

Um pedido pode possuir vários itens.

### Relação `produto` → `item_pedido`

Um produto pode aparecer em vários itens de diferentes pedidos.

### Relação `pedido` ↔ `produto`

A relação entre pedidos e produtos é **N:N (muitos para muitos)** e é implementada pela tabela `item_pedido`.

```text
pedido N ───── N produto
       \       /
        \     /
       item_pedido
```

---

## ⚙️ Como executar

### 1. Pré-requisitos

É necessário possuir um servidor **MySQL** instalado e em execução.

Algumas opções:

* MySQL Server
* MySQL Workbench
* XAMPP
* WAMP
* Laragon

### 2. Executar o script

Abra seu cliente MySQL e execute o arquivo:

```text
loja_virtual.sql
```

O script cria automaticamente o banco de dados:

```sql
CREATE DATABASE IF NOT EXISTS loja_virtual_db;
```

Em seguida, seleciona o banco:

```sql
USE loja_virtual_db;
```

Depois são criadas as cinco tabelas:

```text
categoria
produto
cliente
pedido
item_pedido
```

---

## 🧱 Comandos SQL utilizados

O projeto utiliza principalmente comandos de **DDL (Data Definition Language)**, responsáveis pela definição da estrutura do banco de dados.

### `CREATE DATABASE`

Cria o banco de dados:

```sql
CREATE DATABASE IF NOT EXISTS loja_virtual_db;
```

O `IF NOT EXISTS` evita erro caso o banco já exista.

### `USE`

Seleciona o banco que será utilizado:

```sql
USE loja_virtual_db;
```

### `CREATE TABLE`

Cria as tabelas do sistema:

```sql
CREATE TABLE IF NOT EXISTS categoria (...);
CREATE TABLE IF NOT EXISTS produto (...);
CREATE TABLE IF NOT EXISTS cliente (...);
CREATE TABLE IF NOT EXISTS pedido (...);
CREATE TABLE IF NOT EXISTS item_pedido (...);
```

### `PRIMARY KEY`

Define o identificador único de cada registro:

```sql
PRIMARY KEY
```

### `AUTO_INCREMENT`

Gera automaticamente os IDs:

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

### `FOREIGN KEY`

Estabelece os relacionamentos entre as tabelas:

```sql
FOREIGN KEY (id_categoria) REFERENCES categoria(id)
```

```sql
FOREIGN KEY (id_cliente) REFERENCES cliente(id)
```

```sql
FOREIGN KEY (id_pedido) REFERENCES pedido(id)
```

```sql
FOREIGN KEY (id_produto) REFERENCES produto(id)
```

### `NOT NULL`

Determina que um campo não pode receber valor nulo:

```sql
nome VARCHAR(100) NOT NULL
```

### `DECIMAL`

Utilizado para armazenar valores monetários:

```sql
DECIMAL(10,2)
```

Nesse projeto, é utilizado nos campos `preco`, `valor_total` e `preco_unitario`.

---

## 📋 Regras definidas no banco

O banco possui regras para garantir a integridade dos dados:

* Cada categoria possui um ID único.
* Cada produto possui um ID único.
* Cada cliente possui um ID único.
* Cada pedido possui um ID único.
* Cada item de pedido possui um ID único.
* Os IDs são gerados automaticamente.
* Os campos definidos como `NOT NULL` são obrigatórios.
* Todo produto deve estar associado a uma categoria existente.
* Todo pedido deve estar associado a um cliente existente.
* Todo item de pedido deve estar associado a um pedido existente.
* Todo item de pedido deve estar associado a um produto existente.
* Valores monetários utilizam `DECIMAL(10,2)`.
* A data e horário do pedido são armazenados com `DATETIME`.

---

## 🛒 Fluxo básico do sistema

O relacionamento entre as entidades representa um fluxo de compra:

```text
Categoria
    ↓
Produto
    ↓
Cliente
    ↓
Pedido
    ↓
Item do Pedido
    ↓
Produto + Quantidade + Preço
```

Por exemplo:

```text
Categoria: Eletrônicos
        ↓
Produto: Teclado
        ↓
Cliente: João
        ↓
Pedido #1
        ↓
2x Teclado
R$ 150,00 cada
```

A tabela `item_pedido` é responsável por armazenar a relação entre o pedido e o produto, incluindo a quantidade e o preço unitário.

---

## 📁 Estrutura sugerida do projeto

```text
loja-virtual/
│
├── README.md
└── loja_virtual.sql
```

O arquivo `loja_virtual.sql` contém os comandos responsáveis pela criação da estrutura do banco de dados.

---

## 🎯 Objetivo

O projeto tem como objetivo praticar conceitos fundamentais de **SQL e bancos de dados relacionais**, utilizando como cenário uma loja virtual.

Entre os conceitos aplicados estão:

* Criação de banco de dados;
* Criação de tabelas;
* Definição de tipos de dados;
* Chaves primárias;
* Chaves estrangeiras;
* Relacionamentos `1:N`;
* Relacionamento `N:N`;
* Tabela associativa;
* Integridade referencial;
* `AUTO_INCREMENT`;
* Restrições `NOT NULL`;
* Armazenamento de datas e horários;
* Armazenamento de valores monetários com `DECIMAL`.

---

## 👨‍💻 Autor

**Davi Leonardo**

Projeto desenvolvido para fins de estudo e prática de **SQL, modelagem e gerenciamento de bancos de dados relacionais**.
