#! /bin/bash

PSQL="psql --username=freecodecamp --tuples-only --dbname=salon -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "$1"
  fi
  # Display services
  echo -e "\nWhich service do you want to book?\n"
  SERVICES=$($PSQL "SELECT * FROM services")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  # Pick service
  read SERVICE_ID_SELECTED
  SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  # If service does not exist
  if [[ -z $SERVICE_SELECTED ]]
  then
    # Main Menu
    MAIN_MENU "\nPick a number between 1 - 3"
  # If exist
  else
    # Input Phone number
    echo -e "\nYou have selected $SERVICE_SELECTED"
    echo -e "\nType in your phone number"
    read CUSTOMER_PHONE
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    # If not exist
    if [[ -z $CUSTOMER_ID ]]
    then
      # Input name
      echo -e "\nWe do not have your phone number. Please type in your name"
      read CUSTOMER_NAME
      # Add to customers table
      ADD_CUSOMTER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      echo "Welcome $CUSTOMER_NAME"
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '$CUSTOMER_NAME'")
    # If Exist
    else
      # Return name
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID")
      echo "Welcome back $CUSTOMER_NAME" | sed 's/  / /'
    fi
    # Input time
    echo -e "\nPlease state your appointment time"
    read SERVICE_TIME
    # Add to appointments table
    ADD_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id, time, customer_id) VALUES($SERVICE_ID_SELECTED, '$SERVICE_TIME', $CUSTOMER_ID)")
    # Output message
    echo -e "\nI have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME." | sed 's/  / /g'
  fi
}

MAIN_MENU
