-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 15/08/2024                                                --
-- Autor(es) ..............: Joel Soares                                               --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Carga de todas as tabelas do banco de dados.                   --
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- Data de Alteração ...........: 18/08/2024                                           --
-- Autor(es) ..............: Joel Soares, Daniel Rocha                                 --
-- Versao ..............: 1.1                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Inserção das Tuplas nas tabelas                                --
-- --------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 15/08/2024                                                --
-- Autor(es) ..............: Joel Soares                                               --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Carga de todas as tabelas do banco de dados.                   --
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- Data de Alteração ...........: 18/08/2024                                           --
-- Autor(es) ..............: Joel Soares, Daniel Rocha                                 --
-- Versao ..............: 1.1                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Inserção das Tuplas nas tabelas                                --
-- --------------------------------------------------------------------------------------

INSERT INTO personagem (id, nome, genero, forca, velocidade, hp, habilidades_id, status, localizacao)
VALUES
(1, 'Rick', 'Masculino', 90, 200, 2000, 1, 'Vivo', 'Fazenda'),
(2, 'Michonne', 'Feminino', 70, 400, 1200, 2, 'Vivo', 'Fazenda'),
(3, 'Glenn', 'Masculino', 70, 500, 1800, 3, 'Vivo', 'Floresta'),
(4, 'Maggie', 'Feminino', 50, 300, 1000, 4, 'Vivo', 'Floresta');

INSERT INTO zumbi (id, forca, velocidade, hp)
VALUES
(1, 40, 30, 100),
(2, 50, 20, 150),
(3, 60, 25, 120),
(4, 55, 35, 130);

INSERT INTO npc (id, funcao, dialogo)
VALUES
(1, 'Vendedor', 'Bem-vindo ao mercado!'),
(2, 'Guarda', 'Apenas os autorizados podem passar.'),
(3, 'Curandeiro', 'Precisa de um tratamento?'),
(4, 'Informante', 'Tenho informações valiosas para você.');

INSERT INTO habilidades (id, nome, descricao)
VALUES
(1, 'Facão', 'Habilidade em combate com facão.'),
(2, 'Katana', 'Habilidade em combate com arco a Katana.'),
(3, 'Furtividade', 'Habilidade para passar pelos inimigos sem ser percebido'),
(4, 'Sniper', 'Habilidade para dar HS com sniper');