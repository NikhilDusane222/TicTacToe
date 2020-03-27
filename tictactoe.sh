#!/bin/bash -x

#variables
X="X"
O="O"
DOT=0
CROSS=1
USER=0
COMPUTER=1
declare -a gameBoard
gameBoard=(" " " " " " " " " " " " " " " " " ")

printf "Welcome to tic tac toe game \n"

function displayBoard()
{
	echo "Welcome to tic tac toe game"
	echo "		${gameBoard[0]}  | ${gameBoard[1]} | ${gameBoard[2]}"
	echo "		-----------"
	echo "		${gameBoard[3]}  | ${gameBoard[4]} | ${gameBoard[5]}"
	echo "		-----------"
	echo "		${gameBoard[6]}  | ${gameBoard[7]} | ${gameBoard[8]}"
}
function playerTurn()
{
	playerLetter=$1
	printf "Enter any number between 0 to 8 : "
	read response
	if [[ $response>=0 && $response<=8 ]]
	then
		if [[ "${gameBoard[$response]}"!=X || "${gameBoard[$response]}"!=O ]]
		then
			gameBoard[$response]="$playerLetter"
		else
			playerTurn $playerLetter
		fi
	else
		printf "Invalid input \n"
	fi
	displayBoard
}
function getLetter()
{
	letterCheck=$((RANDOM%2))
	case $letterCheck in
		$DOT)
			playerLetter=$O
		;;
		$CROSS)
			playerLetter=$X
		;;
	esac
	echo $playerLetter
}
function getTurn()
{
	firstTurn=$((RANDOM%2))
	case $firstTurn in
		$USER)
			 printf "User plays first \n"
		;;
		$COMPUTER)
			 printf "Computer plays first \n"
		;;
	esac
}
letter="$( getLetter)"
getTurn
playerTurn $letter
