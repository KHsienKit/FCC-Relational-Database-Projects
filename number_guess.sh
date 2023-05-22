#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=guess -t --no-align -c"

# Enter your username:
echo -e "\nEnter your username:"
read USERNAME
USERNAME_RESULT=$($PSQL "SELECT * FROM game_data WHERE username='$USERNAME'")

# If old
if [[ -z $USERNAME_RESULT ]]
then
  # Welcome
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  # Add to DB
  INSERT_USERNAME=$($PSQL "INSERT INTO game_data(username, games_played, best_game) VALUES('$USERNAME', 1, 0)")
# Else
else
  # Welcome Back
  echo $USERNAME_RESULT | while IFS="|" read USERNAME GAMES_PLAYED BEST_GAME
  do
    echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
  # Add games played
  UPDATE_GAME_COUNT=$($PSQL "UPDATE game_data SET games_played = games_played + 1 WHERE username='$USERNAME'")
fi

# Guess the number
echo -e "\nGuess the secret number between 1 and 1000:"
let RANDOM_NUMBER=$RANDOM%1000+1
TRIES=0
while [[ true ]]
do
  ((TRIES++))
  read GUESS
  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
    # If too low
    if [[ $GUESS < $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's higher than that, guess again:"
    # If too high
    elif [[ $GUESS > $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"
    # Correct
    else
      echo -e "\nYou guessed it in $TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"
      USERNAME_RESULT=$($PSQL "SELECT * FROM game_data WHERE username='$USERNAME'")
      echo $USERNAME_RESULT | while IFS="|" read USERNAME GAMES_PLAYED BEST_GAME
      do
        if [[ $TRIES < $BEST_GAME || $BEST_GAME == 0 ]]
        then
          UPDATE_BEST_GAME=$($PSQL "UPDATE game_data SET best_game = $TRIES WHERE username = '$USERNAME'")
        fi
      done
      break
    fi
  else
  # If not intger
    echo -e "\nThat is not an integer, guess again:"
  fi
done
