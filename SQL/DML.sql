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
(4, 'Negan', 'Masculino', 1500, 'Vivo', 'Cidade');

INSERT INTO NPC (ID, funcao, dialogo)
VALUES
(2, 'Daryl', 'Estou com depressao'),  -- Daryl
(4, 'Líder dos Salvadores', 'Aqui as coisas são feitas do meu jeito.');  -- Negan

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
(8, 'Muralha de Woodbury', 'Cidade', 'A fortificação que protege a cidade de invasores e zumbis.', 7, 60);

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
(4, 55, 35, 65);

INSERT INTO Instancia_Zumbi (ID_Zumbi, estado, localizacao)
VALUES
(1, 'Ativo', 'Floresta'),
(2, 'Ativo', 'Fazenda'),
(3, 'Inativo', 'Cidade'),
(4, 'Ativo', 'Posto de Controle');

INSERT INTO Instancia_Item (ID, Item_ID, localizacao)
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

--INSERT INTO Inventario (ID, tamanho)
--VALUES
--(1, 10);



---INSERT INTO inventario_item (ID_inventario, ID_item)
---VALUES
---(1, 1), (1, 2), (1, 3), (1, 4);

commit;