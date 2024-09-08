CREATE OR REPLACE FUNCTION atualizar_inventario()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o item já está no inventário do jogador
    IF EXISTS (
        SELECT 1
        FROM Inventario
        WHERE id_jogador = NEW.id_jogador
          AND id_item = NEW.id_item
    ) THEN
        -- Se o item já existe, atualize a quantidade
        UPDATE Inventario
        SET quantidade = quantidade + NEW.quantidade
        WHERE id_jogador = NEW.id_jogador
          AND id_item = NEW.id_item;
    ELSE
        -- Se o item não existe, insira uma nova linha
        INSERT INTO Inventario (id_jogador, id_item, quantidade)
        VALUES (NEW.id_jogador, NEW.id_item, NEW.quantidade);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger

CREATE TRIGGER trigger_atualizar_inventario
AFTER INSERT ON Inventario
FOR EACH ROW
EXECUTE FUNCTION atualizar_inventario();

