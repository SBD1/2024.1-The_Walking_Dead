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

-- Inserção de dados na tabela Personagem
INSERT INTO Personagem (ID, Nome, Genero, HP, Status, Localizacao)
VALUES
(1, 'Rick Grimes', 'Masculino', 2000, 'Vivo', 'Fazenda'),
(2, 'Daryl Dixon', 'Masculino', 1800, 'Vivo', 'Floresta'),
(3, 'Michonne', 'Feminino', 1600, 'Vivo', 'Fazenda'),
(4, 'Negan', 'Masculino', 1500, 'Vivo', 'Cidade');

-- Inserção de dados na tabela Jogador (herda de Personagem)
INSERT INTO Jogador (ID, Forca, Velocidade, Habilidades_ID)
VALUES
(1, 90, 200, 1),  -- Rick Grimes
(2, 80, 250, 2),  -- Daryl Dixon
(3, 85, 220, 3);  -- Michonne

-- Inserção de dados na tabela NPC (herda de Personagem)
INSERT INTO NPC (ID, Funcao, Dialogo)
VALUES
(4, 'Líder dos Salvadores', 'Aqui as coisas são feitas do meu jeito.');  -- Negan

-- Inserção de dados na tabela Instancia_Zumbi
INSERT INTO Instancia_Zumbi (ID_Zumbi, Status, Localizacao)
VALUES
(1, 'Ativo', 'Floresta'),
(2, 'Ativo', 'Fazenda'),
(3, 'Inativo', 'Cidade'),
(4, 'Ativo', 'Posto de Controle');


INSERT INTO zumbi (id, forca, velocidade, hp)
VALUES
(1, 40, 30, 100),
(2, 50, 20, 150),
(3, 60, 25, 120),
(4, 55, 35, 130);

INSERT INTO habilidades (id, nome, descricao)
VALUES
(1, 'Facão', 'Habilidade em combate com facão.'),
(2, 'Katana', 'Habilidade em combate com arco a Katana.'),
(3, 'Furtividade', 'Habilidade para passar pelos inimigos sem ser percebido'),
(4, 'Sniper', 'Habilidade para dar HS com sniper');

INSERT INTO Inventario (ID, instancia_item_id, Personagem_ID, Tamanho)
VALUES
(1, 1, 1, 10),
(2, 2, 2, 5),
(3, 3, 3, 5),
(4, 4, 4, 5);


INSERT INTO inventario_item (ID_inventario, ID_item)
VALUES
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 1), (2, 2), (2, 3),
(3, 1), (3, 2), (3, 3),
(4, 1), (4, 2), (4, 3);

INSERT INTO Item (ID, nome, Descrição, Tipo, Valor) 
VALUES 
(1, 'Machete', 'Uma grande faca usada para combate corpo a corpo', 'equipamento', 500),
(2, 'Revolver', 'Uma arma de fogo de pequeno porte', 'equipamento', 1500),
(3, 'Jaqueta de Couro', 'Jaqueta resistente usada para proteção', 'equipamento', 800),
(4, 'Bandagem', 'Usada para tratar feridas menores', 'consumível', 50),
(5, 'Pílula de Antibiótico', 'Ajuda a combater infecções', 'consumível', 300),
(6, 'Espingarda', 'Arma de fogo poderosa de longo alcance', 'equipamento', 2500),
(7, 'Capacete de Combate', 'Protege a cabeça contra impactos', 'equipamento', 1000),
(8, 'Capacete', 'Capacete de combate resistente, usado para proteger a cabeça contra impactos e mordidas de zumbis.', 'equipamento', 700),
(9, 'Faca de Combate', 'Faca afiada usada em combates próximos', 'equipamento', 400),
(10, 'Armadura Corporal', 'Equipamento de proteção completa', 'equipamento', 2000),
(11, 'Kit de Primeiros Socorros', 'Contém suprimentos médicos essenciais', 'consumível', 500),
(12, 'Água Purificada', 'Garrafa de água segura para consumo', 'consumível', 100);

INSERT INTO Item_Equipamento (ID, Estado, Tipo) 
VALUES 
(1, 'Nova', 'Arma'),
(2, 'Com Municao', 'Arma'),
(3, 'Usada', 'vestimenta'),
(6, 'Carregada', 'Arma'),
(7, 'Nova', 'vestimenta'),
(8, 'Pronta para uso', 'vestimenta'),
(9, 'Afiação Média', 'medicamento'),
(10, 'Sem Danos', 'vestimenta');

INSERT INTO Item_Equipamento_Arma (ID, Poder_de_ataque) 
VALUES 
(1, 350),
(2, 500),
(6, 700),
(9, 300);

INSERT INTO Item_Equipamento_Armadura (ID, Poder_de_defesa)
VALUES 
(3, 250),
(7, 300),
(8, 450),
(10, 500);

INSERT INTO Item_Consumivel (Item_ID, Poder_de_Regeneracao) 
VALUES 
(4, 50),
(5, 150),
(11, 300),
(12, 100);

INSERT INTO Instancia_Item (ID, Item_ID, Localizacao)
VALUES 
(1, 1, 'Posto de Gasolina'),
(2, 2, 'Casa Abandonada'),
(3, 3, 'Loja de Roupas'),
(4, 4, 'Farmácia'),
(5, 5, 'Hospital'),
(6, 6, 'Escola Abandonada'),
(7, 7, 'Quartel Militar'),
(8, 8, 'Oficina Mecânica'),
(9, 9, 'Posto de Guarda'),
(10, 10, 'Departamento de Polícia'),
(11, 11, 'Centro Comunitário'),
(12, 12, 'Refúgio');

INSERT INTO Regiao (ID, nome, Descricao) 
VALUES 
(1, 'Atlanta', 'A cidade devastada de Atlanta, cheia de arranha-céus abandonados e ruas perigosas.'),
(2, 'Prisão', 'Uma prisão de segurança máxima, agora transformada em um refúgio contra os zumbis.'),
(3, 'Floresta Nacional', 'Uma vasta floresta densa que oferece tanto abrigo quanto perigo.'),
(4, 'Woodbury', 'Uma cidade aparentemente pacífica, mas com segredos sombrios escondidos atrás de suas muralhas.');

INSERT INTO Local (ID, nome, Dimensoes, tipo, Descricao, Recursos, Dificuldade) 
VALUES 
(1, 'Centro de Atlanta', 10000, 'Cidade', 'O coração da cidade, com edifícios altos e ruas desertas, repletas de perigos.', 10, 80),
(2, 'Subúrbios de Atlanta', 8000, 'Cidade', 'Bairros residenciais abandonados, onde o silêncio esconde ameaças.', 15, 60),
(3, 'Bloco C', 3000, 'Cadeia', 'O bloco principal da prisão, que foi convertido em uma zona segura.', 20, 70),
(4, 'Pátio da Prisão', 5000, 'Cadeia', 'Uma área aberta dentro da prisão, cercada por arame farpado.', 10, 50),
(5, 'Cabana Abandonada', 500, 'Floresta', 'Uma pequena cabana no meio da floresta, isolada e de difícil acesso.', 5, 30),
(6, 'Rio Congelado', 2000, 'Floresta', 'Um rio que corta a floresta, perigoso por suas águas rápidas e geladas.', 8, 40),
(7, 'Praça Central de Woodbury', 4000, 'Cidade', 'O centro da cidade, cercado por lojas e casas abandonadas.', 12, 50),
(8, 'Muralha de Woodbury', 2000, 'Cidade', 'A fortificação que protege a cidade de invasores e zumbis.', 7, 60);

INSERT INTO Missao (ID, nome, descricao, tipo, premio)
VALUES
(1, 'Matar Patrick', 'O novo sobrevivente Patrick virou um zumbi, mate-o', 'combate', 1),
(2, 'Explorar Faculdade Veterinária', 'Busque remédio para os porcos na faculdade veterinária', 'busca', 5),
(3, 'Converse com Carol', 'Dê a mensagem de Rick para a Carol', 'dialogo', 4),
(4, 'Negocie com o Governador', 'Tente negociar um tratado de paz com o Governador', 'dialogo', NULL);

commit;