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
