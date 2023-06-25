#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Reset teams and games tables before any insertion.
RESET="$($PSQL 'TRUNCATE TABLE teams, games;')"
echo "$RESET"

# Create teams table and columns.
CREATE_TEAMS_TABLE="$($PSQL 'CREATE TABLE IF NOT EXISTS teams (
  team_id SERIAL, name VARCHAR UNIQUE NOT NULL, PRIMARY KEY(team_id));')"

echo "$CREATE_TEAMS_TABLE teams"

# Create games table and columns.
CREATE_GAMES_TABLE="$($PSQL 'CREATE TABLE IF NOT EXISTS games (
  game_id SERIAL PRIMARY KEY,
  year INT NOT NULL,
  round VARCHAR NOT NULL,
  winner_id INT NOT NULL,
  opponent_id INT NOT NULL,
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL,
  FOREIGN KEY (winner_id) REFERENCES teams(team_id),
  FOREIGN KEY (opponent_id) REFERENCES teams(team_id) );')"

echo "$CREATE_GAMES_TABLE games"

# A trick learned from `Rust`: you can use `{ }` blocks to enclose code
# and apply something to it like a input redirection in shell scripts in this case.

# Insert `teams` and `games` from a .csv file.
{
  # Use read <empty> to discard the header (first line) and start from the second line and forward.
  read # discarding header
  while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    # Another trick to minimze queries to database (data I/O) is to use a subquery `SELECT` as a condition to fill data into table in a single command.
    # The result from the subquery (`true` or `false`) will set the UNIQUE VALUE name or not.
    # Insert unique `name` into the `teams` table.
    INSERT_TEAM_WINNER="$($PSQL "INSERT INTO teams(name) SELECT '$WINNER' WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = '$WINNER');")"
    echo "Inserting winner: '$WINNER'"
    INSERT_TEAM_OPPONENT="$($PSQL "INSERT INTO teams(name) SELECT '$OPPONENT' WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = '$OPPONENT');")"
    echo "Inserting opponent: '$OPPONENT'"

    # Here we can use the same `SELECT` subquery technique to fill values efficiently (less data I/O).
    # Insert rows into `games` table by comparing `team_id`.
    INSERT_GAME="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
    SELECT $YEAR,
    '$ROUND',
    (SELECT team_id FROM teams WHERE name = '$WINNER'),
    (SELECT team_id FROM teams WHERE name = '$OPPONENT'),
    $WINNER_GOALS,
    $OPPONENT_GOALS;")"

    echo "Inserting game: [ year: $YEAR | round: $ROUND | win: $WINNER(score: $WINNER_GOALS) | opo: $OPPONENT(score: $OPPONENT_GOALS)" ]
  done
} < "games.csv" # The Rust trick mentioned.
