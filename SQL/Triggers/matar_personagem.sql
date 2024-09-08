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
