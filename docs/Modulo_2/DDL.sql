-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 15/08/2024                                                --
-- Autor(es) ..............: Joel Soares                                            --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Inclusão de CREATE TABLE de todas as tabelas do banco de dados.--
-- --------------------------------------------------------------------------------------

BEGIN TRANSACTION; 

-- Tabela: Item
CREATE TABLE Item (
    ID INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    Descricao VARCHAR(200) NOT NULL,
    Tipo ENUM('equipamento', 'consumivel') NOT NULL,
    Valor INT CHECK(Valor >= 1 AND Valor <= 5000) -- Permitido NULL por padrão
);

-- Tabela: Instância_Item
CREATE TABLE Instancia_Item (
    ID INT PRIMARY KEY,
    Item_ID INT NOT NULL,
    Localizacao VARCHAR(60),
    FOREIGN KEY (Item_ID) REFERENCES Item(ID)
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
    Tipo ENUM('Arma', 'ferramenta', 'vestimenta', 'alimento', 'medicamento') NOT NULL,
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
