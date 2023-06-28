#!/bin/bash

# psql with -q (quiet) -t (tuples-only) -A (no-align)
PSQL="psql -U freecodecamp -d number_guess -qtA -c"

# Function to execute SQL queries and store the result in an Array
execute_query() {
    local QUERY="$1"
    # Parse the incoming "string here" into an Array
    IFS=$'\n' read -d '' -r -a QUERY_RESULT <<< "$($PSQL "$QUERY")"
    echo "${QUERY_RESULT[@]}"
}

# Execute the SQL commands to create the table if it doesn't exist
execute_query "BEGIN;
SAVEPOINT unmodified_6272023_13_30;

CREATE TABLE IF NOT EXISTS users (
  username VARCHAR(22) PRIMARY KEY,
  games_played INTEGER DEFAULT 0,
  best_game INTEGER DEFAULT NULL
);

COMMIT;"

SECRET_NUMBER=$(($RANDOM % 1000 + 1))

echo "Enter your username:"
read USERNAME

EXISTING_USER=$(execute_query "SELECT * FROM users WHERE username = '${USERNAME}'")

if [[ -z $EXISTING_USER ]]; then
  execute_query "INSERT INTO users (username) VALUES ('${USERNAME}')"
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  # Parse the current user stats in the database into an Array
  IFS="|" read -ra USER_STATS <<< "$EXISTING_USER"
  GAMES_PLAYED=${USER_STATS[1]}
  BEST_GAME=${USER_STATS[2]}
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000:"
NUMBER_OF_GUESSES=0

# Start guess loop
while true; do
  read -p "Your guess:" GUESS

  if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    continue
  fi

  # The user have guessed, increment +1
  (( NUMBER_OF_GUESSES++ ))

  if [[ $GUESS -lt $SECRET_NUMBER ]]; then
    echo "It's higher than that, guess again:"
    continue
  fi

  if [[ $GUESS -gt $SECRET_NUMBER ]]; then
    echo "It's lower than that, guess again:"
    continue
  fi

  echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

  execute_query "UPDATE users SET games_played = games_played + 1, best_game = LEAST(COALESCE(best_game, 1000), $NUMBER_OF_GUESSES) WHERE username = '${USERNAME}'"
  break
done
