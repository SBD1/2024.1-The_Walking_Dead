CREATE OR REPLACE FUNCTION proxima_missao()
RETURNS TRIGGER AS $$
DECLARE
mission_type VARCHAR(10);
BEGIN
    -- Aciona a próxima missão da tabela correta
    -- Se uma missao muda de status para completa, a missão seguinte é dada o status de ativa
    IF NOT EXISTS (
        SELECT 1
        FROM Missao_Status_Valores
        WHERE NEW.missao_status = Missao_Status_Valores.missao_status;
    ) THEN
        RAISE EXCEPTION 'Valor Errado para Missão Status';
        RETURN OLD;
    ELSE
        IF NEW.missao_status = (
            SELECT ID FROM Missao_Status_Valores
            WHERE missao_status = 'Completa';
        ) THEN
            UPDATE Missao_Status SET missao_status = (
                SELECT ID FROM Missao_Status_Valores
                WHERE missao_status = 'Ativa';
            ) WHERE missao_id = (
                IF (SELECT tipo FROM Missao
                WHERE Missao_Status.missao_id = Missao.ID = 'combate')
                THEN
                    SELECT missao_seguinte_ID FROM Missao_Combate
                    WHERE Missao_Combate.ID = Missao_Status.missao_id;
                ELSIF (SELECT tipo FROM Missao
                WHERE Missao_Status.missao_id = Missao.ID = 'dialogo')
                THEN
                    SELECT missao_seguinte_ID FROM Missao_Dialogo
                    WHERE Missao_Dialogo.ID = Missao_Status.missao_id;
                ELSIF (SELECT tipo FROM Missao
                WHERE Missao_Status.missao_id = Missao.ID = 'busca')
                THEN
                    SELECT missao_seguinte_ID FROM Missao_Busca
                    WHERE Missao_Busca.ID = Missao_Status.missao_id;
                END IF;
            );
        ELSIF NEW.missao_status = (
            SELECT ID FROM Missao_Status_Valores
            WHERE missao_status = 'Ativa';
        ) THEN
            IF (SELECT tipo FROM Missao
                WHERE Missao_Status.missao_id = Missao.ID;
            ) = 'combate' THEN
                SELECT Nome, Descricao FROM Missao_Combate
                WHERE Missao.ID = Missao_Combate.ID;
            ELSIF (SELECT tipo FROM Missao
                WHERE Missao_Status.missao_id = Missao.ID;
            ) = 'dialogo' THEN
                SELECT Nome, Descricao FROM Missao_Dialogo
                WHERE Missao.ID = Missao_Dialogo.ID;
            ELSIF (SELECT tipo FROM Missao
                WHERE Missao_Status.missao_id = Missao.ID;
            ) = 'busca' THEN
                SELECT Nome, Descricao FROM Missao_Busca
                WHERE Missao.ID = Missao_Busca.ID;
            END IF;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger

CREATE TRIGGER trigger_missao_seguinte
BEFORE UPDATE ON Missao_Status
FOR EACH ROW
EXECUTE FUNCTION proxima_missao();

-- Testando Trigger

UPDATE 