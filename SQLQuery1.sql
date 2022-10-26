SELECT Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
from portfolioproject..CovidDeaths
where location LIKE '%states%' AND total_deaths IS NOT NULL
order by 1,2

--looking at Total cases vs Population 
-- shows what percentage of population got covid

SELECT location, date, population, total_cases, (total_cases/population)*100 as DeathPercentage
from portfolioproject..CovidDeaths
where location ='India' AND population is NOT NULL
order by 1,2

--looking at the countriees wiht the highest INfection rate  compared to the population 

SELECT location, population, MAX(total_cases), MAX(total_cases/population)*100 as PercentagePopulationInfected
from portfolioproject..CovidDeaths
where population IS NOT NULL
GROUP BY location, population
order by PercentagePopulationInfected desc

--showing countries with highest death count per population

SELECT location, MAX(total_cases) as TotalDeathCount
from portfolioproject..CovidDeaths
where continent IS NOT NULL
--By continent 

SELECT continent, MAX(total_cases) as TotalDeathCount
from portfolioproject..CovidDeaths
where continent IS NOT NULL
GROUP BY continent
Order BY TotalDeathCount desc

--showing the continent with the highest death counts

 --looking at the total population vs vaccination

 SELECT dea.continent, dea.date, dea.population, vac.new_people_vaccinated_smoothed
 from portfolioproject..CovidDeaths dea
 JOIN portfolioproject..CovidVaccination vac
	on dea.location=vac.location
	AND dea.date=vac.date
where dea.continent IS NOT NULL AND population IS NOT NULL
order by 2,3	


	







