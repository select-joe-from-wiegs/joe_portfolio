-- Let's begin our analysis with finding out which campaign raised the most money
-- First, I will calculate the total donations per campaign
-- Then, I'll rank the campaigns by those total donations, highest to lowest
-- I will need to join the campaigns, campaign_donations, and donations tables


SELECT c.campaign_id, c.campaign_name, SUM(d.amount) AS total_donations
FROM campaigns AS c
JOIN campaign_donations AS cd
	ON c.campaign_id = cd.campaign_id
JOIN donations AS d
	ON cd.donation_id = d.donation_id
GROUP BY c.campaign_id
ORDER BY total_donations DESC
;

-- This shows that the top-performing campaign was "Fair Wages Movement" ($1,028.75)
-- The lowest-performing campaign was "Voter Registration Drive" ($743.25)
-- The distribution appears to be fairly even among the campaigns

-- Now let's look at the average donation amount per campaign

SELECT c.campaign_id, c.campaign_name, ROUND(AVG(d.amount), 2) AS avg_donation
FROM campaigns AS c
JOIN campaign_donations AS cd
	ON c.campaign_id = cd.campaign_id
JOIN donations AS d
	ON cd.donation_id = d.donation_id
GROUP BY c.campaign_id
ORDER BY avg_donation DESC
;
-- This shows that "Fair Wages Movement" had both the highest sum and highest average of donations
-- The "Affordable Housing Initiative" was top 3 in each list, showing strong financial support for affordable housing.

-- Keeping with this donation analysis, let's move on to finding the # of unique donors per campaign

SELECT c.campaign_id, c.campaign_name, COUNT(DISTINCT(d.voter_id)) AS donor_count
FROM campaigns AS c
JOIN campaign_donations AS cd
	ON c.campaign_id = cd.campaign_id
JOIN donations AS d
	ON cd.donation_id = d.donation_id
GROUP BY c.campaign_id
ORDER BY donor_count DESC
;

-- This suggests that "Climate Action Campaign" is likely funded by many small grassroots donations,
-- rather than a few larger donors.
-- The "Fair Wages Movement" has the highest total and average donations, but only 10 unique donors,
-- suggesting that it is supported by fewer, but larger donors

-- Moving on to analyzing donations by demographic
-- Will need to join the campaigns, campaign_donations, donations, and voters Tables

SELECT 
(CASE
	WHEN v.age BETWEEN 18 AND 29 THEN 'Young Adult'
    WHEN v.age BETWEEN 30 AND 44 THEN 'Adult'
    WHEN v.age BETWEEN 45 AND 59 THEN 'Older Adult'
    WHEN v.age >= 60 THEN 'Elderly'
    END) AS age_group,
    SUM(d.amount) AS total_amount,
    ROUND(AVG(d.amount), 2) AS average_amount,
    COUNT(DISTINCT(v.voter_id)) AS unique_voters
FROM campaigns AS c
JOIN campaign_donations AS cd
	ON c.campaign_id = cd.campaign_id
JOIN donations AS d
	ON cd.donation_id = d.donation_id
JOIN voters AS v
	ON v.voter_id = d.voter_id
GROUP BY (CASE
	WHEN v.age BETWEEN 18 AND 29 THEN 'Young Adult'
    WHEN v.age BETWEEN 30 AND 44 THEN 'Adult'
    WHEN v.age BETWEEN 45 AND 59 THEN 'Older Adult'
    WHEN v.age >= 60 THEN 'Elderly'
    END)
ORDER BY total_amount DESC
;
-- This would seem to indicate that more people in the 'Adult' age group donate than the other three age groups combined
-- If larger sample size, this trend would likely be less visible

-- Now let's investigate donation patterns by gender

SELECT v.gender,
    SUM(d.amount) AS total_amount,
    ROUND(AVG(d.amount), 2) AS average_amount,
    COUNT(DISTINCT(v.voter_id)) AS unique_voters
FROM campaigns AS c
JOIN campaign_donations AS cd
	ON c.campaign_id = cd.campaign_id
JOIN donations AS d
	ON cd.donation_id = d.donation_id
JOIN voters AS v
	ON v.voter_id = d.voter_id
GROUP BY v.gender
ORDER BY total_amount DESC
;
-- This would suggest that women donate higher amounts on average, but more men donated than women

-- Now let's try donation patterns by party affiliation

SELECT v.party_affiliation,
    SUM(d.amount) AS total_amount,
    ROUND(AVG(d.amount), 2) AS average_amount,
    COUNT(DISTINCT(v.voter_id)) AS unique_voters
FROM campaigns AS c
JOIN campaign_donations AS cd
	ON c.campaign_id = cd.campaign_id
JOIN donations AS d
	ON cd.donation_id = d.donation_id
JOIN voters AS v
	ON v.voter_id = d.voter_id
GROUP BY v.party_affiliation
ORDER BY total_amount DESC
;
-- This result set seems to show that even Independents and Republicans donate higher sums of money than Democrats
-- Given this is a randomly generated sample of data, it's unsurprising that the distribution is nearly even across the board
-- A more realistic dataset would show that Independents do not have as many voters as Republicans or Democrats















