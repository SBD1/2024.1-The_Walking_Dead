BEGIN TRANSACTION;

CREATE TYPE tipo_item as ENUM ('equipamento', 'consumivel');
-- Criação do tipo ENUM para o campo 'Tipo' da tabela Item_Equipamento
CREATE TYPE tipo_equipamento AS ENUM ('arma', 'armadura');

CREATE TYPE parte_do_corpo AS ENUM ('cabeca', 'torso');

CREATE TYPE t_genero AS ENUM ('Masculino', 'Feminino');

-- Criação do tipo ENUM para o campo 'Tipo' da tabela Missao
CREATE TYPE tipo_missao AS ENUM ('combate', 'busca', 'dialogo');

CREATE TYPE tipo_local AS ENUM('Cidade', 'Cadeia', 'Floresta');

-- Save
CREATE TABLE IF NOT EXISTS save (
    ID INT NOT NULL,
    PRIMARY KEY(ID)
);


CREATE TABLE Item (
    ID INT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    tipo tipo_item NOT NULL,
    valor INT
);

-- Tabela: Item-Equipamento
CREATE TABLE Item_Equipamento (
    ID INT PRIMARY KEY,
    estado VARCHAR(20) NOT NULL,
    durabilidade INT,
    tipo tipo_equipamento NOT NULL,
    FOREIGN KEY (ID) REFERENCES Item(ID)    
);

-- Tabela: Item-Equipamento-Arma
CREATE TABLE Item_Equipamento_Arma (
    ID INT PRIMARY KEY,
    poder_de_ataque INT NOT NULL,
    municao INT,
    FOREIGN KEY (ID) REFERENCES Item_Equipamento(ID)
);

-- Tabela: Item-Equipamento-Armadura
CREATE TABLE Item_Equipamento_Armadura (
    ID INT PRIMARY KEY,
    poder_de_defesa INT NOT NULL,
    protege parte_do_corpo NOT NULL, 
    FOREIGN KEY (ID) REFERENCES Item_Equipamento(ID)
);

-- Tabela: Item-Consumível
CREATE TABLE Item_Consumivel (
    ID INT PRIMARY KEY,
    poder_de_regeneracao INT NOT NULL,
    FOREIGN KEY (ID) REFERENCES Item(ID)
);

-- Tabela: Habilidades
CREATE TABLE Habilidades (
    ID INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(300) NOT NULL
);

CREATE TABLE Personagem (
    ID INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    genero t_genero NOT NULL,
    hp INT CHECK(HP >= 0) NOT NULL,
    estado VARCHAR(60) NOT NULL,
    localizacao VARCHAR(60) NOT NULL
);

CREATE TABLE Jogador (
    ID SERIAL PRIMARY KEY,
    ID_personagem INT,
    nome VARCHAR(60) NOT NULL,
    forca INT CHECK(forca >= 0) NOT NULL,
    agilidade INT CHECK(agilidade >= 0) NOT NULL,
    habilidades_ID INT,
    missao_completada INT,
    hp INT CHECK(HP >= 0) NOT NULL,
    estado VARCHAR(60) NOT NULL,
    localizacao VARCHAR(60) NOT NULL,
    FOREIGN KEY (ID_personagem) REFERENCES Personagem(ID),
    FOREIGN KEY (habilidades_ID) REFERENCES Habilidades(ID)
);

-- Criando a tabela NPC com referência à tabela Personagem
CREATE TABLE NPC (
    ID INT PRIMARY KEY,
    funcao VARCHAR(60) NOT NULL,
    dialogo VARCHAR(5000) NOT NULL,
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

-- Tabela: Zumbi
CREATE TABLE Zumbi (
    ID INT PRIMARY KEY,
    forca INT CHECK(Forca >= 0) NOT NULL,
    velocidade INT CHECK(velocidade >= 0) NOT NULL,
    hp INT NOT NULL
);

-- Criando a tabela Instancia_Zumbi
CREATE TABLE Instancia_Zumbi (
    ID_Instancia SERIAL PRIMARY KEY,  -- ID único para cada instância de zumbi
    ID_Zumbi INT NOT NULL,            -- Referência ao zumbi na tabela Zumbi
    estado VARCHAR(60) NOT NULL,
    localizacao VARCHAR(60) NOT NULL,
    FOREIGN KEY (ID_Zumbi) REFERENCES Zumbi(ID)
);

-- Tabela: Instância_Item
CREATE TABLE Instancia_Item (
    ID INT PRIMARY KEY,
    Item_ID INT NOT NULL,
    localizacao VARCHAR(60),
    FOREIGN KEY (Item_ID) REFERENCES Item(ID)
);

-- Tabela: Inventário
CREATE TABLE Inventario (
    ID SERIAL PRIMARY KEY,
    Jogador_ID INT NOT NULL,
    Tamanho INT CHECK(Tamanho >= 1 AND Tamanho <= 50) NOT NULL,
    FOREIGN KEY (Jogador_ID) REFERENCES Jogador(ID)
);

CREATE TABLE Inventario_item (
    ID_inventario INT,
    ID_item INT,
    PRIMARY KEY (ID_inventario, ID_item),
    FOREIGN KEY (ID_inventario) REFERENCES Inventario(ID),
    FOREIGN KEY (ID_item) REFERENCES Instancia_Item(ID)
);

commit;