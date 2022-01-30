-- Função recuperando disciplinas e notas máximas cursadas pelo aluno
-- Se uma disciplina aparece mais de uma vez, é retornado apenas o registro com maior nota.
CREATE OR REPLACE FUNCTION retornar_alunos_disciplina (nome_aluno TEXT) 
RETURNS TABLE (cod_disciplina INT, nome_disciplina VARCHAR(100), nota DOUBLE PRECISION) AS $$
DECLARE
matricula INTEGER;
BEGIN
SELECT a1.mat FROM alunos a1 WHERE nome = nome_aluno LIMIT 1 INTO matricula;

RETURN QUERY SELECT sb.cod_disc, sb.nome, sb.nota from (
	SELECT t1.cod_disc, t2.nome, t1.nota, ROW_NUMBER() OVER(PARTITION BY t1.cod_disc ORDER BY t1.nota DESC) AS contagem_linha 
	FROM historico t1
	INNER JOIN disciplinas t2 ON t2.cod_disc = t1.cod_disc
	WHERE t1.mat = matricula
	GROUP BY t1.cod_disc, t2.cod_disc, t1.nota) AS sb
WHERE contagem_linha = 1;

END;$$ LANGUAGE plpgsql;

-- Executando função.
SELECT * FROM retornar_alunos_disciplina('Theo Barbosa');
