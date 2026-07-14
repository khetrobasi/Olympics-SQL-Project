use OlympicsDB
select * from athlete_events
select * from noc_regions
-- ============================================
-- Olympics SQL Project
-- SQL Interview Queries
-- Author : K Bisoi
-- ============================================
-- BASIC SQL QUERIES
------------------------------------------------
-- Q1. Display all athlete records.
select * from athlete_events

-- Q2. Display only Name, Sex, Age, Sport, and Medal columns.
select Name,Sex,Age,Sport, Medal from athlete_events

-- Q3. Find all athletes who won a Gold medal.
select * from athlete_events where medal = 'Gold'

-- Q4. Find all female athletes.
select * from athlete_events where Sex='F'

-- Q5. Display athletes who participated in the 2016 Olympics.
select * from athlete_events where Year=2016

-- Q6. Find all athletes from India.
select * from athlete_events where NOC = 'IND'

-- Q7. Display athletes whose age is greater than 30.
select * from athlete_Events where Age > 30

-- Q8. Find athletes whose height is greater than 180 cm.
select * from athlete_Events where Height > 180

-- Q9. Display athletes whose weight is greater than 80 kg.
select * from athlete_events where weight > 80

-- Q10. Show the list of unique sports.
select distinct sport from athlete_events

------------------------------------------------
-- AGGREGATE FUNCTIONS
------------------------------------------------
-- Q11. Count the total number of athletes.
select count(*) as Total_Anthlete from athlete_events

-- Q12. Count the number of male and female athletes.
select Sex,count(sex) as Total_Male_Female from athlete_events group by sex

-- Q13. Find the average age of athletes.
select avg(Age) as Average from athlete_events

-- Q14. Find the maximum height of athletes.
select max(height) as Max_Height from athlete_events

-- Q15. Find the minimum weight of athletes.
select min(weight) as Min_Weight from athlete_Events

------------------------------------------------
-- GROUP BY & HAVING
------------------------------------------------
-- Q16. Count the number of athletes in each sport.
select sport, count(*) as Number_Sports from athlete_events group by sport

-- Q17. Count the number of athletes from each country (NOC)
SELECT NOC as Region,count(*) as Counts from athlete_events group by noc

-- Q18. Find sports having more than 5,000 athletes.
select Sport as Sport_Name,count(*) as Sport_Counts from athlete_events group by sport having count(*) >5000

-- Q19. Count the number of medals won by each medal type. here use where clause due to null value
select medal as Mendal_Name,count(*) as Medal_Counts from athlete_events where medal in ('Gold','Silver','Bronze') group by medal
-- Q20. Find the top 10 sports with the highest number of participants.
select top 10 Sport as Sports_name, count(*) as Total_Particiants from athlete_events group by Sport order by Total_Particiants desc
------------------------------------------------
-- INTERMEDIATE SQL QUERIES
------------------------------------------------
-- Q21. Display athlete name, country (Region), sport, and medal using INNER JOIN.
select a.name as Athlete_Name, n.region as Country,a.Sport, a.Medal from athlete_events a inner join noc_regions n on a.noc = n.noc
where medal in ('Gold','Silver','Bronze')

-- Q22. Display all athletes along with their country name, including those without a matching region (LEFT JOIN).
select a.name as Athlete_Name, n.region as Country_Name from athlete_events a left join noc_regions n on n.noc=a.noc

-- Q23. Find the total number of athletes from each country using JOIN.
select n.region as Country, count(*) as Total_Athletes from athlete_Events a inner join noc_regions n on a.noc=n.noc group by n.region

-- Q24. Find the top 10 countries with the highest number of athletes.
select top 10 n.region as Country, count(*) as total_Athletes from athlete_events a inner join noc_regions n on a.noc=n.noc group by n. region 
order by  total_Athletes desc
-- Q25. Find the top 10 countries that won the most Gold medals.
select top 10 n.region as Country, count(*) as total_Gold_Medals from athlete_events a inner join noc_regions n on a.noc=n.noc
where medal = 'Gold'group by n.region order by total_Gold_Medals desc
------------------------------------------------
-- SUBQUERIES
------------------------------------------------
-- Q26. Find athletes whose age is greater than the average age of all athletes.
select * from athlete_events where Age >
(SELECT avg(age) as Avg_Age from athlete_events)

-- Q27. Find athletes whose height is equal to the maximum height.
select * from athlete_events where Height =
(select max(Height) as Max_Height from athlete_events)

-- Q28. Find athletes who won more than one medal.
select * from athlete_events where medal in ('Gold','Silver','Bronze') and Name in
(select Name from athlete_events where medal in ('Gold','Silver','Bronze') group by Name having count(*)>1)

-- Q29. Find sports with participation greater than the average participation of all sports.
select Sport, count(*) as Participation from athlete_events group by Sport having count(*)> (
select AVG(participation) from (
select count(*) as participation from athlete_events group by Sport) as Avg_Participation ) order by Participation desc

-- Q30. Find countries whose athlete count is greater than the average athlete count.
select noc as Countries, count(*) as Avg_athlete from athlete_events group by noc having count(*) >(
select Avg(Total_athlete) from (
select count(*) as Total_athlete from athlete_events group by NOC) as Avg_Total_athlete) order by Avg_athlete desc

------------------------------------------------
-- CTE (COMMON TABLE EXPRESSIONS)
------------------------------------------------
-- Q31. Display the top 10 tallest athletes using a CTE.

with Athlete_CTE
as (
select top 10 * from athlete_events order by height desc
	) select * from Athlete_CTE

-- Q32. Find the average age of athletes by sport using a CTE.

with Athlete_Avg_age 
as
(select Sport, avg(age) as Avg_Age from athlete_events group by Sport) 
select * from athlete_Avg_age order by Avg_age desc

-- Q33. Find countries with more than 5000 athlete records using a CTE.
with athlete_500 as
(
select n.region as Country,count(*) as total_athlete from athlete_events a join noc_regions n on a.NOC=n.NOC group by n.Region having count(*)>5000)
select * from athlete_500 order by total_athlete desc

------------------------------------------------
-- WINDOW FUNCTIONS
------------------------------------------------
-- Q34. Assign a row number to athletes based on height (highest to lowest).

select *, ROW_NUMBER() over (order by height desc) as Height_Row_number from athlete_events order by Height_Row_number 

-- Q35. Rank athletes based on weight.
	select *,
		rank() over (order by weight desc) as Rank_Weight from athlete_events where Weight <> 0

-- Q36. Dense rank athletes based on age.
select *, DENSE_RANK() over (order by age desc) as Ranks_Age from athlete_events 

-- Q37. Display the top 3 tallest athletes in each sport using ROW_NUMBER().
with Hight_CTE AS
(
select *,ROW_NUMBER() over (partition by Sport order by Height desc) as Sport_Row_Number from athlete_events where Height <> 0 )
select *from hight_CTE where sport_row_number<=3

-- Q38. Find the previous athlete's age using LAG().
select Name,Age,lag( age) over (order by age desc) as previous_age from athlete_events where Age is not null order by age desc

-- Q39. Find the next athlete's age using LEAD().
select Name,Age,lead( age) over (order by age desc) as previous_age from athlete_events where Age is not null order by age desc
------------------------------------------------
-- ADVANCED ANALYSIS
------------------------------------------------

-- Q40. Find the top 10 athletes who participated in the highest number of Olympic Games.

select top 10 Name, count(Distinct Games) as Participation from athlete_events group by Name order by Participation desc

------------------------------------------------
-- BUSINESS INSIGHTS (ADVANCED SQL)
------------------------------------------------
-- Q41. Which country won the highest number of Gold medals?
select top 1
n.region as Country, count(medal) as Gold_Total from athlete_events a join noc_regions n on a.NOC=n.NOC where Medal = 'Gold'
group by n.Region order by Gold_Total desc

-- Q42. Top 10 athletes(Person) with the most medals.
select top 10 Name,count(*) as Medals_Total from athlete_events where medal in ('Gold','Silver','Bronze')group by Name order by Medals_Total desc

-- Q43. Which sport has the highest participation?
select top 1 with ties Sport, count(*) as Total_Participation from athlete_events group by Sport order by Total_Participation desc

-- Q44. Which Olympic Games had the highest number of participants?
select top 1 Games,count(*) as Year_Total from athlete_events group by Games order by Year_Total desc

-- Q45. Male vs Female participation by Olympic Games.
select Games, Sex,count(*) as Male_Female_Total from athlete_events group by Sex,Games order by sex, Games

-- Q46. Top 5 countries by total medals.
select top 5 NOC as Country, count(medal) as Total_Medals from athlete_events where medal in ('Gold','Silver','Bronze') 
group by NOC order by Total_Medals desc

-- Q47. Average age of medal winners by sport.
select Sport,Avg(age) as Avg_Age from athlete_events where medal in ('Gold','Silver','Bronze') group by Sport order by Avg_Age desc

-- Q48. Which city hosted the most Olympic Games?
select top 1 City,Count(distinct games) as Hosted_Games from athlete_events group by city order by Hosted_Games desc

-- Q49. Top 10 sports with the highest number of medal events.
select TOP 10 Sport, count(*) as Hightest_medal from athlete_events where medal in ('Gold','Silver','Bronze') 
group by Sport order by Hightest_medal desc

-- Q50. Which country participated in the highest number of Olympic Games?
select top 1 n.region as Country,count(distinct Games) as Participation_Games from athlete_events a join noc_regions n on a.NOC=n.NOC 
group by n.Region order by Participation_Games desc
