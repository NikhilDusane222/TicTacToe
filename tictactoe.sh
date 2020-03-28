#!/bin/bash -x

#variables
X="X"
O="O"
DOT=0
CROSS=1
USER=0
COMPUTER=1
declare -a gameBoard
gameBoard=("0" "1" "2" "3" "4" "5" "6" "7" "8")

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
function checkWin()
{
	letter=$1
	if [ "${gameBoard[0]}${gameBoard[1]}${gameBoard[2]}"=="$letter$letter$letter" ]
	then
		result="wins"
	elif [ "${gameBoard[3]}${gameBoard[4]}${gameBoard[5]}"=="$letter$letter$letter" ]
	then
		result="wins"
	elif [ "${gameBoard[6]}${gameBoard[7]}${gameBoard[8]}"=="$letter$letter$letter" ]
	then
		result="wins"
	elif [ "${gameBoard[0]}${gameBoard[3]}${gameBoard[6]}"=="$letter$letter$letter" ]
	then
		result="wins"
	elif [ "${gameBoard[1]}${gameBoard[4]}${gameBoard[7]}"=="$letter$letter$letter" ]
	then
		result="wins"
	elif [ "${gameBoard[2]}${gameBoard[5]}${gameBoard[8]}"=="$letter$letter$letter" ]
	then
		result="wins"
	elif [ "${gameBoard[0]}${gameBoard[4]}${gameBoard[8]}"=="$letter$letter$letter" ]
	then
		result="wins"
	elif [ "${gameBoard[2]}${gameBoard[4]}${gameBoard[6]}"=="$letter$letter$letter" ]
	then
		result="wins"
	else
		flag=0
		for((index=0;index<${#gameBoard[@]};index++))
		do
			if [[ "${gameBoard[$response]}"!=X || "${gameBoard[$response]}"!=O ]]
			then
				flag=1
			fi
		done
		if [ $flag==0 ]
		then
			result="draw"
		else
			result="change"
		fi
	fi
	echo $result
}
function computerTurn()
{
	computerLetter=$1
	response=$((RANDOM%9))
	if [[ "${gameBoard[$response]}"!=X && "${gameBoard[$response]}"!=O ]]
	then
		echo "Computer turn"
		gameBoard[$response]="$computerLetter"
		displayBoard
	else
		computerTurn $computerLetter
	fi
}
function assignLetter()
{
	letterCheck=$((RANDOM%2))
	case $letterCheck in
		$DOT)
			playerLetter=$O
			computerLetter=$X
		;;
		$CROSS)
			playerLetter=$X
			computerLetter=$O
		;;
	esac
}
function getTurn()
{
	firstTurn=$((RANDOM%2))
	case $firstTurn in
		$USER)
			 echo "User plays first"
		;;
		$COMPUTER)
			 echo "Computer plays first"
		;;
	esac
}
displayBoard
assignLetter
chance="$(getTurn)"
#checkWin $playerLetter
flag=0
if [[ "$chance"=="Computer plays first" ]]
then
	flag=1
fi
while((1))
do
	if [[ $flag%2==0 ]]
	then
		computerTurn $computerLetter
		result="$(checkWin $computerLetter)"
		if [[ $result=="wins" || $result=="draw" ]]
		then
			printf "Computer $result\n"
			break
		fi
	else
		playerTuen $playerLetter
		result="$(checkWin $playerLetter)"
		if [[$result=="wins" || $result=="draw" ]]
		then
			printf "Player $result \n"
			break
		fi
	fi
	flag=$((flag+1))
done
