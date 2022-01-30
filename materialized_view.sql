-- View recuperando quantidade de turmas por disciplina
CREATE MATERIALIZED VIEW IF NOT EXISTS v_disciplinas_turmas AS
SELECT t1.nome, COUNT(*) AS quantidade FROM disciplinas t1 
INNER JOIN turmas t2 ON t2.cod_disc = t1.cod_disc
GROUP BY t1.cod_disc;