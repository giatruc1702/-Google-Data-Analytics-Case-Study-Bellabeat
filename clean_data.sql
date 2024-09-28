-- first thing we want to do is create a clone table. In case something happens, we still have the data

CREATE TABLE
BellaBeat.Daily_Activity_Clone
CLONE `BellaBeat.Daily_Activity`;

INSERT BellaBeat.Daily_Activity_Clone
SELECT * FROM `BellaBeat.Daily_Activity`;
DROP TABLE `BellaBeat.Daily_Activity_Clone`;


-- find duplicate data from daily actitivy clone table
SELECT 
    Id,ActivityDate,TotalSteps,TotalDistance, TrackerDistance,LoggedActivitiesDistance, VeryActiveDistance,ModeratelyActiveDistance,LightActiveDistance,SedentaryActiveDistance,VeryActiveMinutes,FairlyActiveMinutes,LightlyActiveMinutes,SedentaryMinutes,Calories,
    COUNT(*) AS duplicate_count
FROM 
    `BellaBeat.Daily_Activity`
GROUP BY 
    Id,ActivityDate,TotalSteps,TotalDistance, TrackerDistance,LoggedActivitiesDistance, VeryActiveDistance,ModeratelyActiveDistance,LightActiveDistance,SedentaryActiveDistance,VeryActiveMinutes,FairlyActiveMinutes,LightlyActiveMinutes,SedentaryMinutes, Calories
HAVING 
    COUNT(*) > 1;

--Clean duplicate data
DELETE FROM `BellaBeat.Daily_Activity`
WHERE id = 1644430081 
AND ActivityDate = '2016-04-02' 
AND TotalSteps = 20237 
AND TotalDistance = 14.710000038147 
AND TrackerDistance = 14.710000038147 
AND VeryActiveMinutes = 34 
AND Calories = 4029;
