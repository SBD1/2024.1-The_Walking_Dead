-- Atualizar inventário
CREATE OR REPLACE FUNCTION atualizar_inventario()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o item já está no inventário do personagem
    IF EXISTS (
        SELECT 1
        FROM Inventario
        WHERE Personagem_ID = NEW.Personagem_ID
          AND instancia_item_id = NEW.instancia_item_id
    ) THEN
        -- Atualiza o tamanho do item no inventário
        UPDATE Inventario
        SET Tamanho = Tamanho + NEW.Tamanho
        WHERE Personagem_ID = NEW.Personagem_ID
          AND instancia_item_id = NEW.instancia_item_id;
    ELSE
        -- Adiciona o item ao inventário
        INSERT INTO Inventario (instancia_item_id, Personagem_ID, Tamanho)
        VALUES (NEW.instancia_item_id, NEW.Personagem_ID, NEW.Tamanho);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger

CREATE TRIGGER trigger_atualizar_inventario
AFTER INSERT ON Inventario
FOR EACH ROW
EXECUTE FUNCTION atualizar_inventario();

-- Testando Trigger

INSERT INTO EventoColeta (Personagem_ID, instancia_item_id, tamanho)
VALUES (123, 2, 10);

---------------------------------------------------------------------

-- Função Trigger para atualizar a localização do personagem

CREATE OR REPLACE FUNCTION atualizar_localizacao_personagem()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a localização foi alterada
    IF NEW.Localizacao IS DISTINCT FROM OLD.Localizacao THEN
        RAISE NOTICE 'Personagem % moveu-se para %', NEW.Nome, NEW.Localizacao;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para acionar a função de atualização de localização
CREATE TRIGGER trigger_atualizar_localizacao
AFTER UPDATE OF Localizacao ON Personagem
FOR EACH ROW
EXECUTE FUNCTION atualizar_localizacao_personagem();

-- Testando Trigger
-- Atualizar a localização de Rick Grimes

UPDATE Personagem
SET Localizacao = 'Cidade'
WHERE Nome = 'Rick Grimes';

---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION eliminar_zumbi()
RETURNS TRIGGER AS $$
BEGIN
    -- Exemplo: após eliminar o zumbi, podemos atualizar alguma outra tabela ou apenas retornar a mensagem
    RAISE NOTICE 'Zumbi com ID % foi eliminado.', OLD.id;

    -- Aqui pode incluir alguma lógica para atualizar outra tabela se necessário

    RETURN OLD;  -- OLD contém os dados do zumbi que foi eliminado
END;
$$ LANGUAGE plpgsql;

-- Trigger para eliminar zumbi

CREATE TRIGGER trigger_eliminar_zumbi
AFTER DELETE ON Zumbi
FOR EACH ROW
EXECUTE FUNCTION eliminar_zumbi();

-- Testando Trigger

DELETE FROM instancia_zumbi WHERE id_zumbi = 1;
DELETE FROM Zumbi WHERE id = 1;

CREATE OR REPLACE FUNCTION respawn_zumbi(jogador_id INT, local_id INT)
RETURNS VOID AS $$
DECLARE
    local_nome VARCHAR;
BEGIN
    -- Recupera o nome do local
    SELECT nome INTO local_nome FROM local WHERE id = local_id;

    -- Respawn de um novo zumbi após o jogador sair do local
    INSERT INTO instancia_zumbi (id_zumbi, status, localizacao)
    VALUES (1, 'Ativo', local_nome); -- Respawn de um zumbi do tipo 1 no local

    RAISE NOTICE 'Novo zumbi criado no local % após a saída do jogador %.', local_nome, jogador_id;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_respawn_zumbi
AFTER DELETE OR UPDATE ON jogador_local 
FOR EACH ROW
WHEN (OLD.local_id IS NOT NULL) -- Apenas quando o jogador sair de um local
EXECUTE FUNCTION respawn_zumbi(OLD.jogador_id, OLD.local_id);

---------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE MatarPersonagem(IN p_ID INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o personagem já está morto
    IF (SELECT Status FROM Personagem WHERE ID = p_ID) = 'Morto' THEN
        RAISE NOTICE 'O personagem já está morto.';
        RETURN;
    END IF;

    -- Atualiza o status para 'Morto'
    UPDATE Personagem
    SET Status = 'Morto'
    WHERE ID = p_ID;

    -- Exibe uma mensagem de sucesso
    RAISE NOTICE 'Personagem com ID % foi morto.', p_ID;
END;
$$;

CREATE OR REPLACE FUNCTION VerificarMorte() 
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Se o HP do personagem for 0 ou menor, executa a stored procedure
    IF NEW.HP <= 0 THEN
        PERFORM MatarPersonagem(NEW.ID);
    END IF;

    RETURN NEW;
END;
$$;

-- Criação do Trigger para a tabela Personagem
CREATE TRIGGER TriggerMorte
AFTER UPDATE OF HP
ON Personagem
FOR EACH ROW
EXECUTE FUNCTION VerificarMorte();

------------------------------------------------------------------------
--- VERIFICANDO AS VARIAVEIS DE TIPO E GARANTINDO A INTEGRIDADE --------

CREATE OR REPLACE FUNCTION verificar_tipo_item()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o tipo do item é válido
    IF NEW.tipo NOT IN ('equipamento', 'consumivel') THEN
        RAISE EXCEPTION 'Tipo de item % inválido.', NEW.tipo;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_tipo_item
BEFORE INSERT OR UPDATE ON Item
FOR EACH ROW
EXECUTE FUNCTION verificar_tipo_item();

CREATE OR REPLACE FUNCTION verificar_tipo_equipamento()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o tipo de equipamento é válido
    IF NEW.tipo NOT IN ('arma', 'armadura') THEN
        RAISE EXCEPTION 'Tipo de equipamento % inválido.', NEW.tipo;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_tipo_equipamento
BEFORE INSERT OR UPDATE ON Item_Equipamento
FOR EACH ROW
EXECUTE FUNCTION verificar_tipo_equipamento();

CREATE OR REPLACE FUNCTION verificar_parte_do_corpo()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a parte do corpo é válida
    IF NEW.protege NOT IN ('cabeca', 'torso') THEN
        RAISE EXCEPTION 'Parte do corpo % inválida.', NEW.protege;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_parte_do_corpo
BEFORE INSERT OR UPDATE ON Item_Equipamento_Armadura
FOR EACH ROW
EXECUTE FUNCTION verificar_parte_do_corpo();

CREATE OR REPLACE FUNCTION verificar_genero()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o gênero é válido
    IF NEW.genero NOT IN ('Masculino', 'Feminino') THEN
        RAISE EXCEPTION 'Gênero % inválido.', NEW.genero;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_genero
BEFORE INSERT OR UPDATE ON Personagem
FOR EACH ROW
EXECUTE FUNCTION verificar_genero();

CREATE OR REPLACE FUNCTION verificar_tipo_missao()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o tipo de missão é válido
    IF NEW.tipo NOT IN ('combate', 'busca', 'dialogo') THEN
        RAISE EXCEPTION 'Tipo de missão % inválido.', NEW.tipo;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_tipo_missao
BEFORE INSERT OR UPDATE ON Missao
FOR EACH ROW
EXECUTE FUNCTION verificar_tipo_missao();

CREATE OR REPLACE FUNCTION verificar_tipo_local()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o tipo de local é válido
    IF NEW.tipo NOT IN ('Cidade', 'Cadeia', 'Floresta') THEN
        RAISE EXCEPTION 'Tipo de local % inválido.', NEW.tipo;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_tipo_local
BEFORE INSERT OR UPDATE ON Local
FOR EACH ROW
EXECUTE FUNCTION verificar_tipo_local();
