-- Now let's do some outreach analysis
-- We want to find outreach effectiveness
-- Which method was used the most, and how many unique voters reached per method?

SELECT *
FROM outreach
;

SELECT contact_method, COUNT(DISTINCT(outreach_id)) AS total_contacts, COUNT(DISTINCT(voter_id)) AS voters_reached
FROM outreach
GROUP BY contact_method
;
-- Again, due to generated data by chatgpt, the distribution on this dataset is evenly spread

-- Let's find out which campaigns conducted the most outreach
-- Will need to join the outreach and campaigns tables

SELECT c.campaign_id, c.campaign_name, COUNT(o.outreach_id) AS outreach_efforts, COUNT(DISTINCT(o.voter_id)) AS unique_voters
FROM outreach AS o
JOIN campaigns AS c
	ON 	o.campaign_id = c.campaign_id
GROUP BY c.campaign_id
ORDER BY outreach_efforts DESC
;
-- This dataset is not complete, as it does not include data for all campaigns, only 3 of them
-- This outreach table was generated after the campaigns table, so there should not be any data missing
-- Would need to retrieve more data to get better insight into the outreach efforts per campaign


-- Let's instead look at patterns in outreach and even attendance

SELECT COUNT(DISTINCT o.voter_id) AS contacted_voters,
    COUNT(DISTINCT ea.voter_id) AS event_attendees,
    ROUND((COUNT(DISTINCT ea.voter_id) / COUNT(DISTINCT o.voter_id)) * 100, 2) AS contact_to_event_percent
FROM outreach AS o
LEFT JOIN event_attendance AS ea
    ON o.voter_id = ea.voter_id
    ;
-- This sample size is too small, but the result does indicate that outreach efforts were extremely successful, with 88% participation




































