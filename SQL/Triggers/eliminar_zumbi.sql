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