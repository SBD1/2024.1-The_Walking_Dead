-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 15/08/2024                                                --
-- Autor(es) ..............: Joel Soares                                            --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Consulta das tabelas do banco de dados.                        --
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 18/08/2024                                                --
-- Autor(es) ..............: Joel Soares, Daniel Rocha, Matheus Oliveira                                 --
-- Versao ..............: 1.1                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Consulta das tabelas do banco de dados.                        --
-- --------------------------------------------------------------------------------------

SELECT * FROM personagem
WHERE forca > 70;

SELECT nome, localizacao FROM personagem
WHERE localizacao = 'Fazenda';

SELECT * FROM zumbi;

SELECT * FROM zumbi
WHERE hp > 120;

SELECT * FROM npc;

SELECT * FROM habilidades
WHERE descricao ILIKE '%combate%';

SELECT nome, descricao FROM habilidades;



-- Seleciona todas as colunas da tabela Região
SELECT * FROM Região;

-- Seleciona todas as colunas da tabela Local
SELECT * FROM Local;

-- Seleciona os nomes e as dimensões dos locais na região de 'Prisão'
SELECT nome, Dimensões FROM Local WHERE tipo = 'Cadeia';

-- Seleciona todas as colunas da tabela Item
SELECT * FROM Item;

-- Seleciona o nome e o valor de todos os itens do tipo 'equipamento'
SELECT nome, Valor FROM Item WHERE Tipo = 'equipamento';

-- Seleciona todos os itens com valor maior que 1000
SELECT nome, Descrição, Valor FROM Item WHERE Valor > 1000;

-- Seleciona os estados e tipos de todos os equipamentos do tipo 'Arma'
SELECT Estado, Tipo FROM Item_Equipamento WHERE Tipo = 'Arma';

-- Seleciona todas as colunas da tabela Item-Equipamento-Arma
SELECT * FROM Item_Equipamento_Arma;

-- Seleciona os poderes de defesa de todas as armaduras
SELECT Item_ID, Poder_de_defesa FROM Item_Equipamento_Armadura;
-- Seleciona todos os consumíveis com poder de regeneração maior que 100
SELECT Item_ID, Poder_de_Regeneração FROM Item_Consumível WHERE Poder_de_Regeneração > 100;
-- Seleciona os IDs dos itens que estão na 'Prisão'
SELECT ID, Item_ID FROM Instancia_Item WHERE Localização = 'Prisão';

-- Mostra o ID e nome de todos os itens que são premio de alguma missão 
SELECT ID, nome FROM Item, Missao
WHERE Item.ID = Missao.premio
