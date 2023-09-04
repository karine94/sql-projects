
--QUERY 1: Observando os dados
SELECT *
FROM Portfolio_Project_SQL..CovidVaccinations
WHERE continent IS NOT NULL
ORDER BY 3, 4

--QUERY 2: Selecionando apenas os dados de interesse 
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Portfolio_Project_SQL..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

--QUERY 3: Observando a rela��o entre o total de casos vs o total de mortes 
--Mostra a probabilidade de voc� falecer se pegar o v�rus da covid em seu pa�s)
SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS NUMERIC)/CAST(total_cases AS NUMERIC))*100 AS DeathPercentage
FROM Portfolio_Project_SQL..CovidDeaths
WHERE location LIKE '%Braz%' AND continent IS NOT NULL
ORDER BY 1, 2

-- QUERY 4: Observando o total de casos vs popula��o
-- Mostra qual porcentagem da popula��o pegou covid em cada uma das datas registradas
SELECT location, date, total_cases, population, (CAST(total_cases AS NUMERIC)/CAST(population AS NUMERIC))*100 AS PercentagePopulationInfected
FROM Portfolio_Project_SQL..CovidDeaths
ORDER BY 1, 2

-- QUERY 5: Observando os pa�ses com maior taxa de infec��o por popula��o
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX(CAST(total_cases AS NUMERIC)/CAST(population AS NUMERIC))*100 AS PercentagePopulationInfected
FROM Portfolio_Project_SQL..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentagePopulationInfected DESC

-- QUERY 6: Qual o total de mortes por continente?
SELECT continent, MAX(total_deaths) as TotalDeathsCount
FROM Portfolio_Project_SQL..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC

-- QUERY 7: Qual os pa�ses com maior contagem de mortes por popula��o?
SELECT location, MAX(total_deaths) as TotalDeathsCount
FROM Portfolio_Project_SQL..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathsCount DESC

-- UNINDO TABELAS	
-- QUERY 8: Qual o total de pessoas vacinadas no mundo?
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(numeric, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM Portfolio_Project_SQL..CovidDeaths dea
JOIN Portfolio_Project_SQL..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2, 3
