-- a. Quais as peças com custo unitário inferior a 10€ e cujo código contém '98'?
SELECT
	*
FROM
	pecas
WHERE
	custo < 10
	AND codigo LIKE '%98%';

-- b. Quais as matrículas dos carros que foram reparados no mês de Setembro de 2010, i.e., cuja reparação terminou nesse mês?
SELECT
	carros.matricula
FROM
	reparacoes
	INNER JOIN carros ON reparacoes.carro_id = carros.carro_id
WHERE
	data_fim BETWEEN '2010-09-01'
	AND '2010-09-30';

-- c. Quais os nomes dos clientes proprietários de carros que utilizaram peças com custo unitário superior a 10€? Apresente o resultado ordenado por ordem descendente do custo unitário.
SELECT
	clientes.nome
FROM
	clientes
	INNER JOIN proprietarios ON clientes.cliente_id = proprietarios.proprietario
	INNER JOIN reparacoes ON proprietarios.cliente_id = reparacoes.cliente_id
	INNER JOIN pecasUtilizadas ON reparacoes.reparacao_id = pecasUtilizadas.reparacao_id
	INNER JOIN pecas ON pecasUtilizadas.peca_id = pecas.peca_id
WHERE
	pecas.custo > 10
ORDER BY
	pecas.custo DESC;

-- d. Quais os nomes dos clientes que não têm (tanto quanto se saiba) carro?
SELECT
	*
FROM
	clientes
	LEFT JOIN proprietarios ON clientes.cliente_id = proprietarios.cliente_id
WHERE
	proprietarios.carro_id IS NULL;

-- e. Qual o número de reparações feitas a cada carro?
SELECT
	COUNT(carro_id),
	carro_id
FROM
	reparacoes
GROUP BY
	carro_id;

-- f. Qual o número de dias em que cada carro esteve em reparação?
SELECT
	TIMESTAMPDIFF(Day, data_inicio, data_fim) AS nr_days,
	carro_id
FROM
	reparacoes;

-- g. Qual o custo unitário médio, o valor total e o número de unidades das peças, bem como o valor da peça mais cara e da mais barata?
SELECT
	peca_id,
	stock
FROM
	pecas;

SELECT
	avg(custo) AS valor_medio
FROM
	pecas;

SELECT
	SUM(custo * stock) AS valor_total
FROM
	pecas;

SELECT
	max(custo)
FROM
	pecas;

SELECT
	min(custo)
FROM
	pecas;

-- h. Qual a especialidade que foi utilizada mais vezes nas reparações dos carros de cada marca?


-- i. Qual o preço total de cada reparação?
SELECT
	(SUM(pecasUtilizadas.quantidade * pecas.custo) + SUM(especialidades.custoHora * funcionarios_horasTrabalho.horas)) AS total,
	reparacoes.reparacao_id
FROM
	pecas
	INNER JOIN pecasUtilizadas ON pecas.peca_id = pecasUtilizadas.peca_id
	INNER JOIN reparacoes ON pecasUtilizadas.reparacao_id = reparacoes.reparacao_id
	INNER JOIN funcionarios_horasTrabalho ON reparacoes.reparacao_id = funcionarios_horasTrabalho.reparacao_id
	INNER JOIN funcionarios ON funcionarios_horasTrabalho.funcionario_id = funcionarios.funcionario_id
	INNER JOIN especialidades ON funcionarios.especialidade_id = especialidades.especialidade_id
GROUP BY
	reparacoes.reparacao_id;

-- j. Qual o preço total das reparações com custo total superior a 60€?
  SELECT
	total,
	reparacao_id
FROM (
	SELECT
		(SUM(pecasUtilizadas.quantidade * pecas.custo) + SUM(especialidades.custoHora * funcionarios_horasTrabalho.horas)) AS total,
		reparacoes.reparacao_id AS reparacao_id
	FROM
		pecas
		INNER JOIN pecasUtilizadas ON pecas.peca_id = pecasUtilizadas.peca_id
		INNER JOIN reparacoes ON pecasUtilizadas.reparacao_id = reparacoes.reparacao_id
		INNER JOIN funcionarios_horasTrabalho ON reparacoes.reparacao_id = funcionarios_horasTrabalho.reparacao_id
		INNER JOIN funcionarios ON funcionarios_horasTrabalho.funcionario_id = funcionarios.funcionario_id
		INNER JOIN especialidades ON funcionarios.especialidade_id = especialidades.especialidade_id
	GROUP BY
		reparacoes.reparacao_id) AS soma
WHERE
	total > 60;

-- k. Qual o proprietário do carro que teve a reparação mais cara?


-- l. Qual a matrícula do carro com a segunda reparação mais cara?


-- m. Quais são as três reparações mais caras (ordenadas por ordem descendente de preço)?

 
-- n. Quais os nomes dos clientes responsáveis por reparações de carros e respectivos proprietários (só para os casos em que não são coincidentes)?


-- o. Quais as localidades onde mora alguém, seja ele cliente ou funcionário?


-- p. Quais as localidades onde moram clientes e funcionários?


-- q. Quais as peças compatíveis com modelos da Volvo cujo preço é maior do que o de qualquer peça compatível com modelos da Renault?


-- r. Quais as peças compatíveis com modelos da Volvo cujo preço é maior do que o de alguma peça compatível com modelos da Renault?


-- s. Quais as matriculas dos carros que foram reparados mais do que uma vez?


-- t. Quais as datas de início e de fim e nome do proprietário das reparações feitas por carros que foram reparados mais do que uma vez?


-- u. Quais as reparações que envolveram todas as especialidades?


-- v. Qual o número de reparações feitas por cada carro?
SELECT COUNT(reparacao_id), carro_id FROM reparacoes GROUP BY carro_id;

-- w. Calcule as durações de cada reparação, contabilizando até à data actual os não entregues.


-- x. Substitua Renault por Top, Volvo por Down e os restantes por NoWay.
UPDATE marcas set nome = 'NoWay' where nome <> 'Renault' and nome <> 'Volvo';
Update marcas Set nome = 'Top' where nome = 'Renault';
Update marcas Set nome = 'Down' where nome = 'Volvo';