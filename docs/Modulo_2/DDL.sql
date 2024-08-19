BEGIN TRANSACTION; 

-- Criação do tipo ENUM para o campo 'Tipo' da tabela Item
CREATE TYPE tipo_item AS ENUM ('equipamento', 'consumivel');

-- Criação do tipo ENUM para o campo 'Tipo' da tabela Item_Equipamento
CREATE TYPE tipo_equipamento AS ENUM ('Arma', 'ferramenta', 'vestimenta', 'alimento', 'medicamento');

-- Tabela: Item
CREATE TABLE Item (
    ID INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    Descricao VARCHAR(200) NOT NULL,
    Tipo tipo_item NOT NULL,
    Valor INT CHECK(Valor >= 1 AND Valor <= 5000) -- Permitido NULL por padrão
);

-- Tabela: Instância_Item
CREATE TABLE Instancia_Item (
    ID INT PRIMARY KEY,
    Item_ID INT NOT NULL,
    Localizacao VARCHAR(60),
    FOREIGN KEY (Item_ID) REFERENCES Item(ID)
);

-- Tabela: Habilidades
CREATE TABLE Habilidades (
    ID INT PRIMARY KEY,
    Nome VARCHAR(60) NOT NULL,
    Descricao VARCHAR(5000) NOT NULL
);

-- Tabela: Personagem (Referência à tabela Habilidades)
CREATE TABLE Personagem (
    ID INT PRIMARY KEY,
    Nome VARCHAR(60) NOT NULL,
    Genero VARCHAR(50) NOT NULL,
    Forca INT CHECK(Forca >= 0) NOT NULL,
    Velocidade INT CHECK(Velocidade >= 0) NOT NULL,
    HP INT CHECK(HP >= 0) NOT NULL,
    Habilidades_ID INT,
    Status VARCHAR(60) NOT NULL,
    Localizacao VARCHAR(60) NOT NULL,
    FOREIGN KEY (Habilidades_ID) REFERENCES Habilidades(ID)
);

-- Tabela: Inventário
CREATE TABLE Inventario (
    ID INT PRIMARY KEY,
    Instancia_Item_ID INT NOT NULL,
    Personagem_ID INT NOT NULL,
    Tamanho INT CHECK(Tamanho >= 1 AND Tamanho <= 50) NOT NULL,
    FOREIGN KEY (Instancia_Item_ID) REFERENCES Instancia_Item(ID),
    FOREIGN KEY (Personagem_ID) REFERENCES Personagem(ID)
);

-- Tabela: Item-Equipamento
CREATE TABLE Item_Equipamento (
    ID INT PRIMARY KEY,
    Estado VARCHAR(20) NOT NULL,
    Tipo tipo_equipamento NOT NULL,
    FOREIGN KEY (ID) REFERENCES Item(ID)
);

-- Tabela: Item-Equipamento-Arma
CREATE TABLE Item_Equipamento_Arma (
    ID INT PRIMARY KEY,
    Poder_de_Ataque INT CHECK(Poder_de_Ataque >= 0 AND Poder_de_Ataque <= 5000) NOT NULL,
    FOREIGN KEY (ID) REFERENCES Item_Equipamento(ID)
);

-- Tabela: Item-Equipamento-Armadura
CREATE TABLE Item_Equipamento_Armadura (
    ID INT PRIMARY KEY,
    Poder_de_Defesa INT CHECK(Poder_de_Defesa >= 0 AND Poder_de_Defesa <= 5000) NOT NULL,
    FOREIGN KEY (ID) REFERENCES Item_Equipamento(ID)
);

-- Tabela: Item-Consumível
CREATE TABLE Item_Consumivel (
    ID INT PRIMARY KEY,
    Poder_de_Regeneracao INT CHECK(Poder_de_Regeneracao >= 0 AND Poder_de_Regeneracao <= 5000) NOT NULL,
    FOREIGN KEY (ID) REFERENCES Item(ID)
);

-- Tabela: Zumbi
CREATE TABLE Zumbi (
    ID INT PRIMARY KEY,
    Forca INT CHECK(Forca >= 0) NOT NULL,
    Velocidade INT CHECK(Velocidade >= 0) NOT NULL,
    HP INT CHECK(HP >= 0) NOT NULL
);

-- Tabela: NPC
CREATE TABLE NPC (
    ID INT PRIMARY KEY,
    Funcao VARCHAR(60) NOT NULL,
    Dialogo VARCHAR(5000) NOT NULL
);