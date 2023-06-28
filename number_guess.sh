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
