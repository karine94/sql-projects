--QUERY INICIAL DE TUDO ONDE O ROL� COME�OU
SELECT AccountName, AccountType, AccountDescription
FROM DimAccount
WHERE (AccountType='Expense' OR AccountType='Income')
ORDER BY AccountDescription;

--SELECIONE TODAS AS LINHAS DA TABELA EM QUE A MARCA CONTOSO E A COR � PRATA
SELECT BrandName, ColorName
FROM DimProduct
WHERE (BrandName = 'contoso' AND ColorName='Silver');

--SELECIONE TODAS AS LINHAS DA TABELA EM QUE A COR � AZUL OU A COR � PRATA
SELECT BrandName, ColorName
FROM DimProduct
WHERE (ColorName='Blue' OR ColorName='Silver');

--SELECIONE TODAS AS LINHAS DA TABELA EM QUE A COR N�O � AZUL
SELECT *
FROM DimProduct
WHERE ColorName != 'Blue';

--SELECIONE TODAS AS LINHAS DA TABELA ONDE O CONTINENTE � A EUROPA MAS O PAIS N�O � A IT�LIA
SELECT * 
FROM DimSalesTerritory
WHERE SalesTerritoryGroup = 'Europe' AND NOT SalesTerritoryCountry='Italy';

SELECT DISTINCT SalesTerritoryCountry
FROM DimSalesTerritory;