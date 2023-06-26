#! /bin/bash

psql -U freecodecamp -d postgres -c "CREATE DATABASE salon"
psql -U freecodecamp -d postgres -c "DROP TABLE customers, services, appointments"
PSQL="psql -U freecodecamp -d salon -c"

# Connect to the salon database, create all tables.
psql -U freecodecamp -d salon <<EOF
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    phone VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS appointments (
    appointment_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    service_id INT REFERENCES services(service_id),
    time VARCHAR NOT NULL
);

INSERT INTO services (name)
SELECT name
FROM (VALUES ('cut'), ('color'), ('style'), ('exit')) AS services(name)
WHERE NOT EXISTS (
    SELECT 1
    FROM services
    WHERE services.name = services.name
);
EOF

# Start the program.
echo -e "\n
\033[0;32m
...+ -------------------- +
...| \033[1mWELCOME TO THE SALON\033[0m\033[0;32m |
...+ -------------------- +
...///////////////////////\033[0m
\n
"
# The additional `-t` flag means tuples-only or `SELECT` only the row values.
PSQL_ROWS="psql -U freecodecamp -d salon -t -c"

function options() {
  # Prompt for user input starting from read SERVICE_ID_SELECTED, 
  # then read CUSTOMER_PHONE, then read CUSTOMER_NAME, and read SERVICE_TIME at last.
  read -p "Select a service (enter the service number): " SERVICE_ID_SELECTED
  if [[ "$SERVICE_ID_SELECTED" = "4" ]]; then echo -e "\nThank you. Goodbye.\n"; exit; fi;
  # If selection is invalid print the same menu.
  if ! [[ "$SERVICE_ID_SELECTED" =~ ^[1-4]$ ]]; then main_menu;
  else
    # Check for existing user.
    echo -e " ⤷ \033[1mHave you an account here?\033[0m"
    echo -e "   Tell me your phone in this format: 555-555-555\n"
    read -p "Enter phone number: " CUSTOMER_PHONE
    CUSTOMER_ID=$($PSQL_ROWS "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    if [ -z "$CUSTOMER_ID" ]; then
      # Customer does not exist, prompt for name.
      echo -e " ⤷ \033[1mYour phone doesn't match our database. Let's sign you up.\033[0m"
      echo -e "   Tell me your name:\n"
      read -p "Enter name: " CUSTOMER_NAME

      # Insert the new customer into the customers table.
      $PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')"
      CUSTOMER_ID=$($PSQL_ROWS "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    fi

    # Prompt for time.
    read -p "Enter the desired time: " SERVICE_TIME
    # Insert the appointment into the appointments table
    $PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')"

    # Output the confirmation message
    SERVICE_NAME=$($PSQL_ROWS "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    CUSTOMER_NAME=$($PSQL_ROWS "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID")
    echo "I have put you down for a$SERVICE_NAME at $SERVICE_TIME,$CUSTOMER_NAME."
  fi
}

# Main menu
function main_menu() {
  # Display the numbered list of services.
  echo "Services offered:"
  # Set the ') ' formatting requirement.
  $PSQL_ROWS "SELECT CONCAT(service_id, ') ', name) FROM services"
  options
}

main_menu
