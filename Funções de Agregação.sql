/*
1) O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade
Devolvida para o canal de venda mais importante da empresa: Store.
Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa
análise considerando a tabela FactSales.
*/

SELECT * FROM FactSales
SELECT * FROM DimChannel

SELECT 
	SUM (SalesQuantity) AS 'Quantidade Vendida',
	SUM (ReturnQuantity) AS 'Quantidade Devolvida'
FROM 
	FactSales
WHERE
	channelKey = 1



/*
2) Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes
da empresa, mas apenas de ocupação Professional. Utilize um comando SQL para atingir esse
resultado.
*/

SELECT * FROM DimCustomer

SELECT
	AVG(YearlyIncome) AS 'Média salarial de todos os clientes sendo da ocupação profissional'
FROM
	DimCustomer
WHERE
	Occupation = 'Professional'

  

/*
3) Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na
empresa. O seu gerente te pediu os seguintes números e informações:
a) Quantos funcionários tem a loja com mais funcionários?
b) Qual é o nome dessa loja?
c) Quantos funcionários tem a loja com menos funcionários?
d) Qual é o nome dessa loja?
*/


SELECT * FROM DimStore

SELECT
	TOP (1)
	StoreName,
	EmployeeCount
FROM
	DimStore
ORDER BY
	EmployeeCount DESC


SELECT
	TOP (1)
	StoreName,
	EmployeeCount
FROM
	DimStore
WHERE
	EmployeeCount IS NOT NULL
ORDER BY
	EmployeeCount ASC
	


/*
4. A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade 
total de funcionários do sexo Masculino e do sexo Feminino.  
a) Descubra essas duas informações utilizando o SQL. 
b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as 
seguintes informações de cada um deles: Nome, E-mail, Data de Contratação.
*/

SELECT * FROM DimEmployee

--Qtd Masculino 206
SELECT 
	FirstName as 'Primeiro Nome',
	EmailAddress as 'Endereço de e-mail',
	StartDate as 'Data de contratação',
	Gender as 'Gênero'
FROM
	DimEmployee
WHERE
	Gender = 'M'
ORDER BY
	StartDate ASC

--Qtd Feminino 87
SELECT 
	FirstName as 'Primeiro Nome',
	EmailAddress as 'Endereço de e-mail',
	StartDate as 'Data de contratação',
	Gender as 'Gênero'
FROM
	DimEmployee
WHERE
	Gender = 'F'
ORDER BY
	StartDate ASC

  

/*
Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes 
informações: 
a) Quantidade distinta de cores de produtos. 
b) Quantidade distinta de marcas 
c) Quantidade distinta de classes de produto 
Para simplificar, você pode fazer isso em uma mesma consulta.
*/

SELECT * FROM DimProduct

SELECT 
	COUNT(DISTINCT ColorName) AS 'Quantidade de Cores',
	COUNT(DISTINCT BrandName) AS 'Quantidade de Marcas',
	COUNT(DISTINCT ClassName) AS 'Quantidade de Classe'
FROM
	DimProduct
