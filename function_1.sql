-- Função recuperando turmas ministradas por professor a partir do nome
CREATE OR REPLACE FUNCTION retornar_turmas_professor(nome_professor TEXT) 
RETURNS TABLE (cod_turma INT, cod_prof INT, ano VARCHAR(100)) AS $$
DECLARE
codigo_prof INTEGER;
BEGIN
SELECT p1.cod_prof FROM professores p1 WHERE nome = nome_professor LIMIT 1 INTO codigo_prof;
RETURN QUERY SELECT t1.cod_turma, t1.cod_prof, t1.ano FROM turmas t1 WHERE t1.cod_prof = codigo_prof;
END;$$ LANGUAGE plpgsql;

-- Executando função.
SELECT * FROM retornar_turmas_professor('Javam Machado');