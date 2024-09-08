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

