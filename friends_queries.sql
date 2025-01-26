SELECT *
FROM friendsepisodes
;

SELECT *
FROM friendsscripts
;


SELECT *
FROM friends
;


SELECT *
FROM friends_info
;


SELECT fs.Character, COUNT(fs.Character) AS num_lines
FROM friendsepisodes AS fe
JOIN friendsscripts AS fs
ON fe.season = fs.Season
GROUP BY fs.Character
ORDER BY COUNT(fs.Character) DESC
;










