--QUERY INICIAL DE TUDO ONDE O ROLÊ COMEÇOU
SELECT AccountName, AccountType, AccountDescription
FROM DimAccount
WHERE (AccountType='Expense' OR AccountType='Income')
ORDER BY AccountDescription;

--SELECIONE TODAS AS LINHAS DA TABELA EM QUE A MARCA CONTOSO E A COR É PRATA
SELECT BrandName, ColorName
FROM DimProduct
WHERE (BrandName = 'contoso' AND ColorName='Silver');

--SELECIONE TODAS AS LINHAS DA TABELA EM QUE A COR É AZUL OU A COR É PRATA
SELECT BrandName, ColorName
FROM DimProduct
WHERE (ColorName='Blue' OR ColorName='Silver');

--SELECIONE TODAS AS LINHAS DA TABELA EM QUE A COR NÃO É AZUL
SELECT *
FROM DimProduct
WHERE ColorName != 'Blue';

--SELECIONE TODAS AS LINHAS DA TABELA ONDE O CONTINENTE É A EUROPA MAS O PAIS NÃO É A ITÁLIA
SELECT * 
FROM DimSalesTerritory
WHERE SalesTerritoryGroup = 'Europe' AND NOT SalesTerritoryCountry='Italy';

SELECT DISTINCT SalesTerritoryCountry
FROM DimSalesTerritory;