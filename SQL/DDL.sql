BEGIN TRANSACTION; 

-- Criação do tipo ENUM para o campo 'Tipo' da tabela Item
CREATE TYPE tipo_item AS ENUM ('equipamento', 'consumivel');

-- Criação do tipo ENUM para o campo 'Tipo' da tabela Item_Equipamento
CREATE TYPE tipo_equipamento AS ENUM ('Arma', 'ferramenta', 'vestimenta', 'alimento', 'medicamento');

-- Criação do tipo ENUM para o campo 'Tipo' da tabela Missao
CREATE TYPE tipo_missao AS ENUM ('combate', 'busca', 'dialogo');

-- Criação do tipo ENUM para o campo 'Tipo' da tabela Local
CREATE TYPE tipo_local AS ENUM('Cidade', 'Cadeia', 'Floresta');

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

-- Criando a tabela Personagem
CREATE TABLE Personagem (
    ID INT PRIMARY KEY,
    Nome VARCHAR(60) NOT NULL,
    Genero VARCHAR(50) NOT NULL,
    HP INT CHECK(HP >= 0) NOT NULL,
    Status VARCHAR(60) NOT NULL,
    Localizacao VARCHAR(60) NOT NULL
);

-- Tabela: Inventário
CREATE TABLE Inventario (
    ID INT PRIMARY KEY,
    Personagem_ID INT NOT NULL,
    Tamanho INT CHECK(Tamanho >= 1 AND Tamanho <= 50) NOT NULL,
    FOREIGN KEY (Personagem_ID) REFERENCES Personagem(ID)
);

CREATE TABLE inventario_item (
    ID_inventario INT,
    ID_item INT,
    PRIMARY KEY (ID_inventario, ID_item),
    FOREIGN KEY (ID_inventario) REFERENCES inventario(ID),
    FOREIGN KEY (ID_item) REFERENCES Instancia_Item(ID)
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

-- Criando a tabela Instancia_Zumbi
CREATE TABLE Instancia_Zumbi (
    ID_Instancia SERIAL PRIMARY KEY,  -- ID único para cada instância de zumbi
    ID_Zumbi INT NOT NULL,            -- Referência ao zumbi na tabela Zumbi
    Status VARCHAR(60) NOT NULL,
    Localizacao VARCHAR(60) NOT NULL,
    FOREIGN KEY (ID_Zumbi) REFERENCES Zumbi(ID)
);

-- Criando a tabela Jogador com referência à tabela Personagem
CREATE TABLE Jogador (
    ID INT PRIMARY KEY,
    Forca INT CHECK(Forca >= 0) NOT NULL,
    Velocidade INT CHECK(Velocidade >= 0) NOT NULL,
    Habilidades_ID INT,
    FOREIGN KEY (ID) REFERENCES Personagem(ID),
    FOREIGN KEY (Habilidades_ID) REFERENCES Habilidades(ID)
);

-- Criando a tabela NPC com referência à tabela Personagem
CREATE TABLE NPC (
    ID INT PRIMARY KEY,
    Funcao VARCHAR(60) NOT NULL,
    Dialogo VARCHAR(5000) NOT NULL,
    FOREIGN KEY (ID) REFERENCES Personagem(ID)
);

-- Tabela: Missao
CREATE TABLE Missao (
    ID INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    tipo tipo_missao NOT NULL,
    premio INT,
    FOREIGN KEY (premio) REFERENCES Item(ID)
);

CREATE TABLE Local (
    ID INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    dimensoes INT NOT NULL CHECK (dimensoes BETWEEN 1 AND 100000),
    tipo tipo_local NOT NULL,
    descricao VARCHAR(200),
    recursos INT CHECK (recursos BETWEEN 1 AND 99),
    dificuldade INT CHECK (dificuldade BETWEEN 1 AND 99)
);
CREATE TABLE Regiao (
    ID INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    descricao VARCHAR(200)
);
