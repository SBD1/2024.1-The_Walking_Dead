BEGIN TRANSACTION;

INSERT INTO Item (ID, nome, descricao, tipo, valor)
VALUES
(1, 'Machete', 'Uma grande faca usada para combate corpo a corpo', 'equipamento', 200),
(2, 'Revolver', 'Uma arma de fogo de pequeno porte', 'equipamento', 1000),
(3, 'Jaqueta de Couro', 'Jaqueta resistente usada para proteção', 'equipamento', 300),
(4, 'Bandagem', 'Usada para tratar feridas menores', 'consumivel', 20),
(5, 'Pílula de Antibiótico', 'Ajuda a combater infecções', 'consumivel', 50),
(6, 'Espingarda', 'Arma de fogo poderosa de longo alcance', 'equipamento', 2000),
(7, 'Capacete de Combate', 'Protege a cabeça contra impactos', 'equipamento', 350),
(8, 'Capacete', 'Capacete de combate resistente, usado para proteger a cabeça contra impactos e mordidas de zumbis.', 'equipamento', 200),
(9, 'Faca de Combate', 'Faca afiada usada em combates próximos', 'equipamento', 100),
(10, 'Armadura Corporal', 'Equipamento de proteção completa', 'equipamento', 1500),
(11, 'Kit de Primeiros Socorros', 'Contém suprimentos médicos essenciais', 'consumivel', 200),
(12, 'Água Purificada', 'Garrafa de água segura para consumo', 'consumivel', 50);

INSERT INTO Item_Equipamento (ID, estado, durabilidade, tipo)
VALUES
(1, 'Utilizável', 100, 'arma'),
(2, 'Com Municao', 100, 'arma'),
(3, 'Utilizável', 100, 'armadura'),
(6, 'Sem municao', 100, 'arma'),
(7, 'Utilizável', 100, 'armadura'),
(8, 'Utilizável', 100, 'armadura'),
(9, 'Utilizável', 100, 'arma'),
(10, 'Desgastada', 100, 'armadura');

INSERT INTO Item_Equipamento_Arma (ID, poder_de_ataque, municao) 
VALUES 
(1, 50, NULL),
(2, 200, 6),
(6, 500, 4),
(9, 30, NULL);

INSERT INTO Item_Equipamento_Armadura (ID, poder_de_defesa, protege)
VALUES 
(3, 250, 'torso'),
(7, 300, 'cabeca'),
(8, 450, 'cabeca'),
(10, 500, 'torso');

INSERT INTO Item_Consumivel (ID, poder_de_regeneracao) 
VALUES 
(4, 50),
(5, 150),
(11, 300),
(12, 100);

INSERT INTO Habilidades (id, nome, descricao)
VALUES
(1, 'Facão', 'Habilidade em combate com facão.'),
(2, 'Katana', 'Habilidade em combate com arco a Katana.'),
(3, 'Furtividade', 'Habilidade para passar pelos inimigos sem ser percebido'),
(4, 'Sniper', 'Habilidade para aumentar precisao com a arma');

INSERT INTO Personagem (ID, nome, genero, hp, estado, localizacao)
VALUES
(1, 'Rick Grimes', 'Masculino', 1000, 'Vivo', 'Fazenda'),
(2, 'Michonne', 'Feminino', 1000, 'Vivo', 'Fazenda'),
(3, 'Daryl Dixon', 'Masculino', 1800, 'Vivo', 'Floresta'),
(4, 'Negan', 'Masculino', 1500, 'Vivo', 'Cidade'),
(5, 'Fazendeiro', 'Masculino', 1000, 'Vivo', 'Fazenda'),
(6, 'Governador', 'Masculino', 1500, 'Vivo', 'Pátio da Prisão'),
(7, 'Gleen Rhee', 'Masculino', 1000, 'Vivo', 'Cabana Abandonada'),
(8, 'Maggie Greene', 'Feminino', 1000, 'Vivo', 'Cabana Abandonada'),
(9, 'Sasha Williams', 'Feminino', 1000, 'Vivo', 'Praça Central de Woodbury'),
(10, 'Abraham', 'Masculino', 2000, 'Vivo', 'Praça Central de Woodbury'),
(11, 'Carl Grimes', 'Masculino', 1000, 'Vivo', 'Fazenda'),
(12, 'Rosita Espinosa', 'Feminino', 1000, 'Vivo', 'Bloco C');

INSERT INTO NPC (ID, funcao, dialogo)
VALUES
(3, 'Daryl', 'Estou com depressao'),
(4, 'Líder dos Salvadores', 'Aqui as coisas são feitas do meu jeito.'),
(5, 'Fazendeiro', 'Vamos começar os trabalhos.'),  
(6, 'Lider de Alexandria', 'Hora de tomar essa prisão'),
(8, 'Exploradora', 'O que será que eu irei achar aqui?'),
(9, 'Soldada', 'Irei defender minha cidade'),
(10, 'Soldado', 'Vou proteger a Sasha a qualquer custo'),
(11, 'Filho do Rick', 'Vou reclamar com meu pai'),
(12, 'Coadjunvante', 'Vou morrer para o Negan em 2 temporadas');
(3, 'Daryl', 'Estou com depressao'),
(4, 'Líder dos Salvadores', 'Aqui as coisas são feitas do meu jeito.'),
(5, 'Fazendeiro', 'Vamos começar os trabalhos.'),  
(6, 'Lider de Alexandria', 'Hora de tomar essa prisão'),
(8, 'Exploradora', 'O que será que eu irei achar aqui?'),
(9, 'Soldada', 'Irei defender minha cidade'),
(10, 'Soldado', 'Vou proteger a Sasha a qualquer custo'),
(11, 'Filho do Rick', 'Vou reclamar com meu pai'),
(12, 'Coadjunvante', 'Vou morrer para o Negan em 2 temporadas');
INSERT INTO Regiao (ID, nome, descricao) 
VALUES 
(1, 'Atlanta', 'A cidade devastada de Atlanta, cheia de arranha-céus abandonados e ruas perigosas.'),
(2, 'Prisão', 'Uma prisão de segurança máxima, agora transformada em um refúgio contra os zumbis.'),
(3, 'Floresta Nacional', 'Uma vasta floresta densa que oferece tanto abrigo quanto perigo.'),
(4, 'Woodbury', 'Uma cidade aparentemente pacífica, mas com segredos sombrios escondidos atrás de suas muralhas.');

INSERT INTO Local (ID, nome, tipo, descricao, recursos, dificuldade) 
VALUES 
(1, 'Centro de Atlanta', 'Cidade', 'O coração da cidade, com edifícios altos e ruas desertas, repletas de perigos.', 10, 80),
(2, 'Subúrbios de Atlanta', 'Cidade', 'Bairros residenciais abandonados, onde o silêncio esconde ameaças.', 15, 60),
(3, 'Bloco C', 'Cadeia', 'O bloco principal da prisão, que foi convertido em uma zona segura.', 20, 70),
(4, 'Pátio da Prisão', 'Cadeia', 'Uma área aberta dentro da prisão, cercada por arame farpado.', 10, 50),
(5, 'Cabana Abandonada', 'Floresta', 'Uma pequena cabana no meio da floresta, isolada e de difícil acesso.', 5, 30),
(6, 'Rio Congelado', 'Floresta', 'Um rio que corta a floresta, perigoso por suas águas rápidas e geladas.', 8, 40),
(7, 'Praça Central de Woodbury', 'Cidade', 'O centro da cidade, cercado por lojas e casas abandonadas.', 12, 50),
(8, 'Muralha de Woodbury', 'Cidade', 'A fortificação que protege a cidade de invasores e zumbis.', 7, 60),
(9, 'Fazenda', 'Floresta', 'Zona inicial dos jogadores', 3, 10);

INSERT INTO Missao (ID, nome, descricao, tipo, premio)
VALUES
(1, 'Matar Patrick', 'O novo sobrevivente Patrick virou um zumbi, mate-o', 'combate', 1),
(2, 'Explorar Faculdade Veterinária', 'Busque remédio para os porcos na faculdade veterinária', 'busca', 5),
(3, 'Converse com Carol', 'Dê a mensagem de Rick para a Carol', 'dialogo', 4),
(4, 'Negocie com o Governador', 'Tente negociar um tratado de paz com o Governador', 'dialogo', NULL);


INSERT INTO Zumbi (id, forca, velocidade, hp)
VALUES
(1, 40, 30, 50),
(2, 50, 20, 75),
(3, 60, 25, 60),
(4, 55, 35, 65),
(5, 80, 30, 50),
(6, 90, 20, 75),
(7, 30, 25, 60),
(8, 100, 35, 65),
(9, 350, 30, 50),
(10, 30, 20, 75),
(11, 70, 25, 60),
(12, 55, 35, 65),
(13, 40, 30, 50),
(14, 50, 20, 75),
(15, 800, 25, 100),
(16, 53, 35, 65),
(17, 43, 30, 50),
(18, 56, 20, 75),
(19, 64, 25, 60),
(20, 55, 35, 65),
(21, 40, 30, 50),
(22, 50, 20, 75),
(23, 60, 25, 60),
(24, 55, 35, 65);
(4, 55, 35, 65),
(5, 80, 30, 50),
(6, 90, 20, 75),
(7, 30, 25, 60),
(8, 100, 35, 65),
(9, 350, 30, 50),
(10, 30, 20, 75),
(11, 70, 25, 60),
(12, 55, 35, 65),
(13, 40, 30, 50),
(14, 50, 20, 75),
(15, 800, 25, 100),
(16, 53, 35, 65),
(17, 43, 30, 50),
(18, 56, 20, 75),
(19, 64, 25, 60),
(20, 55, 35, 65),
(21, 40, 30, 50),
(22, 50, 20, 75),
(23, 60, 25, 60),
(24, 55, 35, 65);

INSERT INTO Instancia_Zumbi (ID_Zumbi, estado, localizacao)
VALUES
(1, 'Ativo', 'Floresta'),
(2, 'Ativo', 'Fazenda'),
(3, 'Inativo', 'Cidade'),
(4, 'Ativo', 'Posto de Controle'),
(5, 'Ativo', 'Centro de Atlanta'),
(6, 'Ativo', 'Subúrbios de Atlanta'),
(7, 'Ativo', 'Bloco C'),
(8, 'Ativo', 'Pátio da Prisão'),
(9, 'Ativo', 'Cabana Abandonada'),
(10, 'Ativo', 'Rio Congelado'),
(11, 'Ativo', 'Praça Central de Woodbury'),
(12, 'Ativo', 'Muralha de Woodbury'),
(13, 'Ativo', 'Centro de Atlanta'),
(14, 'Ativo', 'Subúrbios de Atlanta'),
(15, 'Ativo', 'Bloco C'),
(16, 'Ativo', 'Pátio da Prisão'),
(17, 'Ativo', 'Cabana Abandonada'),
(18, 'Ativo', 'Rio Congelado'),
(19, 'Ativo', 'Praça Central de Woodbury'),
(20, 'Ativo', 'Muralha de Woodbury'),
(21, 'Ativo', 'Centro de Atlanta'),
(22, 'Ativo', 'Subúrbios de Atlanta'),
(23, 'Ativo', 'Bloco C'),
(24, 'Ativo', 'Pátio da Prisão');
(4, 'Ativo', 'Posto de Controle'),
(5, 'Ativo', 'Centro de Atlanta'),
(6, 'Ativo', 'Subúrbios de Atlanta'),
(7, 'Ativo', 'Bloco C'),
(8, 'Ativo', 'Pátio da Prisão'),
(9, 'Ativo', 'Cabana Abandonada'),
(10, 'Ativo', 'Rio Congelado'),
(11, 'Ativo', 'Praça Central de Woodbury'),
(12, 'Ativo', 'Muralha de Woodbury'),
(13, 'Ativo', 'Centro de Atlanta'),
(14, 'Ativo', 'Subúrbios de Atlanta'),
(15, 'Ativo', 'Bloco C'),
(16, 'Ativo', 'Pátio da Prisão'),
(17, 'Ativo', 'Cabana Abandonada'),
(18, 'Ativo', 'Rio Congelado'),
(19, 'Ativo', 'Praça Central de Woodbury'),
(20, 'Ativo', 'Muralha de Woodbury'),
(21, 'Ativo', 'Centro de Atlanta'),
(22, 'Ativo', 'Subúrbios de Atlanta'),
(23, 'Ativo', 'Bloco C'),
(24, 'Ativo', 'Pátio da Prisão');

INSERT INTO Instancia_Item (ID, Item_ID, localizacao)
VALUES
(1, 1, 'Centro de Atlanta'), -- Machete
(2, 2, 'Centro de Atlanta'), -- Revolver
(3, 4, 'Centro de Atlanta'), -- Bandagem
(4, 3, 'Subúrbios de Atlanta'), -- Jaqueta de Couro
(5, 5, 'Subúrbios de Atlanta'), -- Pílula de Antibiótico
(6, 6, 'Subúrbios de Atlanta'), -- Espingarda
(7, 7, 'Bloco C'), -- Capacete de Combate
(8, 10, 'Bloco C'), -- Armadura Corporal
(9, 11, 'Bloco C'), -- Kit de Primeiros Socorros
(10, 1, 'Pátio da Prisão'), -- Machete
(11, 9, 'Pátio da Prisão'), -- Faca de Combate
(12, 6, 'Cabana Abandonada'), -- Espingarda
(13, 4, 'Cabana Abandonada'), -- Bandagem
(14, 5, 'Rio Congelado'), -- Pílula de Antibiótico
(15, 12, 'Rio Congelado'), -- Água Purificada
(16, 3, 'Praça Central de Woodbury'), -- Jaqueta de Couro
(17, 2, 'Praça Central de Woodbury'), -- Revolver
(18, 11, 'Praça Central de Woodbury'), -- Kit de Primeiros Socorros
(19, 7, 'Muralha de Woodbury'), -- Capacete de Combate
(20, 10, 'Muralha de Woodbury'), -- Armadura Corporal
(21, 9, 'Fazenda'), -- Faca de Combate
(22, 12, 'Fazenda'); -- Água Purificada


--INSERT INTO Inventario (ID, tamanho)
--VALUES
--(1, 10);



---INSERT INTO inventario_item (ID_inventario, ID_item)
---VALUES
---(1, 1), (1, 2), (1, 3), (1, 4);

commit;