-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 15/08/2024                                                --
-- Autor(es) ..............: Joel Soares                                            --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Consulta das tabelas do banco de dados.                        --
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 18/08/2024                                                --
-- Autor(es) ..............: Joel Soares, Daniel Rocha                                 --
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
