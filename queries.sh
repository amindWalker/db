#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:" #68
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:" #90
SCORE_TOTAL="$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"
echo "$SCORE_TOTAL"

echo -e "\nAverage number of goals in all games from the winning teams:" #2.1250000000000000
SCORE_TOTAL_AVG="$($PSQL "SELECT AVG(winner_goals) FROM games")"
echo "$SCORE_TOTAL_AVG"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:" # 2.13
SCORE_WIN_AVG="$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"
echo "$SCORE_WIN_AVG"

echo -e "\nAverage number of goals in all games from both teams:" # 2.8125000000000000
SCORE_OVERALL_AVG="$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"
echo "$SCORE_OVERALL_AVG"

echo -e "\nMost goals scored in a single game by one team:" # 7
MAX_SCORE_SINGLE_MATCH="$($PSQL "SELECT MAX(winner_goals) FROM games;")"
echo "$MAX_SCORE_SINGLE_MATCH"

echo -e "\nNumber of games where the winning team scored more than two goals:" # 6
MAX_SCORE_WINNER="$($PSQL "SELECT COUNT(1) FROM games WHERE winner_goals > 2")"
echo "$MAX_SCORE_WINNER"

echo -e "\nWinner of the 2018 tournament team name:" # France
WINNER_2018="$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' AND year = 2018;")"
echo "$WINNER_2018"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:" 
EIGHTH_FINAL="$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE round = 'Eighth-Final' AND year = '2014' ORDER BY name")"
echo "$EIGHTH_FINAL"

echo -e "\nList of unique winning team names in the whole data set:"
WINNERS_SET="$($PSQL "SELECT DISTINCT(name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id ORDER BY name")"
echo "$WINNERS_SET"

echo -e "\nYear and team name of all the champions:"
WINNERS_YEAR="$($PSQL "SELECT year, name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' ORDER BY year")"
echo "$WINNERS_YEAR"

echo -e "\nList of teams that start with 'Co':"
TEAMS_STARTING_WITH="$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"
echo "$TEAMS_STARTING_WITH"
