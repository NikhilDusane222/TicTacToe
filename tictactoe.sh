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

#Function for display board(design board)
function displayBoard()
{
	echo "Welcome to tic tac toe game"
	echo "		${gameBoard[0]}  | ${gameBoard[1]} | ${gameBoard[2]}"
	echo "		-----------"
	echo "		${gameBoard[3]}  | ${gameBoard[4]} | ${gameBoard[5]}"
	echo "		-----------"
	echo "		${gameBoard[6]}  | ${gameBoard[7]} | ${gameBoard[8]}"
}
#function for player turn
function playerTurn()
{
	playerLetter=$1
	printf "Player turn\n"
	printf "Enter any number between 0 to 8 : "
	read response
	if [[ "${gameBoard[$response]}"!="X" || "${gameBoard[$response]}"!="O" ]]
	then
		gameBoard[$response]="$playerLetter"
		displayBoard
	else
		printf "Invalid input\n"
		playerTurn $playerLetter
	fi
}
# Function to fill corners randomly
function fillCorners()
{
	local letter=$1
	compPlay=0
	randomCorner=$((RANDOM%4))
	case $randomCorner in
		0)
			if [[ "${gameBoard[0]}" == $IS_EMPTY ]]
			then
				gameBoard[0]=$letter
				compPlay=1
				return
			else
				fillCorners $letter
			fi
		;;
		1)
			if [[ "${gameBoard[2]}" == $IS_EMPTY ]]
			then
				gameBoard[2]=$letter
				compPlay=1
				return
			else
				fillCorners $letter
			fi 
		;;
		2)
			if [[ "${gameBoard[6]}" == $IS_EMPTY ]]
			then
				gameBoard[6]=$letter
				compPlay=1
				return
			else
				fillCorners $letter
			fi
		;;
		3)
			if [[ "${gameBoard[8]}" == $IS_EMPTY ]]
			then
				gameBoard[2]=$letter
				compPlay=1
				return
			else
				fillCorners $letter
			fi
	esac
}
# Function to take center
function takeCenter()
{
	computerLetter=$1
	compPlay=0
	if [[ "${gameBoard[4]}" == $IS_EMPTY ]]
	then
		gameBoard[4]=$computerLetter
		compPlay=1
	fi
}
#Function to take sides
function takeSides()
{
	local letter=$1
	compPlay=0
	randomCorner=$((RANDOM%4))
	case $randomCorner in
	0)
		if [[ "${gameBoard[1]}" == $IS_EMPTY ]]
		then
			gameBoard[1]=$letter
			compPlay=1
			return
		else
			fillCorners $letter
		fi
	;;
	1)
		if [[ "${gameBoard[3]}" == $IS_EMPTY ]]
		then
			gameBoard[3]=$letter
			compPlay=1
			return
		else
			fillCorners $letter
		fi
	;;
	2)
		if [[ "${gameBoard[5]}" == $IS_EMPTY ]]
		then
			gameBoard[5]=$letter
			compPlay=1
			return
		else
			fillCorners $letter
		fi 
	;;
	3)
		if [[ "${gameBoard[7]}" == $IS_EMPTY ]]
		then
			gameBoard[7]=$letter
			compPlay=1
			return
		else
			fillCorners $letter
		fi
	;;
	esac
}

function checkWin()
{
	letter=$1
	if [[ "${gameBoard[0]}" == $letter && "${gameBoard[1]}" == $letter && "${gameBoard[2]}" == $letter ]]
	then
		result="wins"
	elif [[ "${gameBoard[3]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[5]}" == $letter ]]
	then
		result="wins"
	elif [[ "${gameBoard[6]}" == $letter && "${gameBoard[7]}" == $letter && "${gameBoard[8]}" == $letter ]]
	then
		result="wins"
	elif [[ "${gameBoard[0]}" == $letter && "${gameBoard[3]}" == $letter && "${gameBoard[6]}" == $letter ]]
	then
		result="wins"
	elif [[ "${gameBoard[1]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[7]}" == $letter ]]
	then
		result="wins"
	elif [[ "${gameBoard[2]}" == $letter && "${gameBoard[5]}" == $letter && "${gameBoard[8]}" == $letter ]]
	then
		result="wins"
	elif [[ "${gameBoard[0]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[8]}" == $letter ]]
	then
		result="wins"
	elif [[ "${gameBoard[2]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[6]}" == $letter ]]
	then
		result="wins"
	else
		flag=0
		for((index=0;index<${#gameBoard[@]};index++))
		do
			if [[ ${gameBoard[$letter]} != "X" || ${gameBoard[$letter]} != "O" ]]
			then
				flag=1
			fi
		done
		if(($flag==0))
		then
			result="draw"
		else
			result="change"
		fi
	fi
	echo $result
}
#function to check winning moves
function checkWinningMove()
{
	local letter=$1
	index=0
	#Check winning moves for row
	while(($index<9))
	do
		if [[ "${gameBoard[index]}" == $letter && "${gameBoard[$((index+1))]}" == $letter && "${gameBoard[$((index+2))]}" == $IS_EMPTY ]]
		then
			gameBoard[$((index+2))]=$letter
			compPlay=1
			return
		elif [[ "${gameBoard[$index]}" == $letter && "${gameBoard[$((index+2))]}" == $letter && "${gameBoard[$((index+1))]}" == $IS_EMPTY ]]
		then
			gameBoard[$((index+1))]=$letter
			compPlay=1
			return
		elif [[ "${gameBoard[$((index+2))]}" == $letter && "${gameBoard[$((index+1))]}" == $letter && "${gameBoard[$index]}" == $IS_EMPTY ]]
		then
			gameBoard[$index]=$letter
			compPlay=1
			return
		fi
		index=$((index+3))
	done
	#check winning moves for column
	index=0
	while(($index<9))
	do
		if [[ "${gameBoard[index]}" == $letter && "${gameBoard[$((index+3))]}" == $letter && "${gameBoard[$((index+6))]}" == $IS_EMPTY ]]
		then
			gameBoard[$((index+6))]=$letter
			compPlay=1
			return
		elif [[ "${gameBoard[$index]}" == $letter && "${gameBoard[$((index+6))]}" == $letter && "${gameBoard[$((index+3))]}" == $IS_EMPTY ]]
		then
			gameBoard[$((index+3))]=$letter
			compPlay=1
			return
		elif [[ "${gameBoard[$((index+3))]}" == $letter && "${gameBoard[$((index+6))]}" == $letter && "${gameBoard[$index]}" == $IS_EMPTY ]]
		then
			gameBoard[$index]=$letter
			compPlay=1
			return
		fi
		index=$((index+1))
	done
	#Check winning moves primary diagonal
	if [[ "${gameBoard[0]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[8]}" == $IS_EMPTY ]]
	then
		gameBoard[8]=$letter
		compPlay=1
		return
	elif [[ "${gameBoard[0]}" == $letter && "${gameBoard[8]}" == $letter && "${gameBoard[4]}" == $IS_EMPTY ]]
	then
		gameBoard[4]=$letter
		compPlay=1
		return
	elif [[ "${gameBoard[8]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[0]}" == $IS_EMPTY ]]
	then
		gameBoard[0]=$letter
		compPlay=1
		return
	fi
	# Check winning moves for secondary diagonal
	if [[ "${gameBoard[2]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[6]}" == $IS_EMPTY ]]
	then
		gameBoard[6]=$letter
		compPlay=1
		return
	elif [[ "${gameBoard[2]}" == $letter && "${gameBoard[6]}" == $letter && "${gameBoard[4]}" == $IS_EMPTY ]]
	then
		gameBoard[4]=$letter
		compPlay=1
		return
	elif [[ "${gameBoard[6]}" == $letter  && "${gameBoard[4]}" == $letter && "${gameBoard[2]}" == $IS_EMPTY ]]
	then
		gameBoard[2]=$letter
		compPlay=1
		return
	fi
}
# Function to block the winning moves
function blockPlayerWin()
{
	compPlay=0
	letter=$1
	computerLetter=$2
	index=0
	#Check winning moves for row
	while(($index<9))
	do
		if [[ "${gameBoard[index]}" == $letter && "${gameBoard[$((index+1))]}" == $letter && "${gameBoard[$((index+2))]}" == $IS_EMPTY ]]
		then
			gameBoard[$((index+2))]=$computerLetter
			compPlay=1
			return
		elif [[ "${gameBoard[$index]}" == $letter && "${gameBoard[$((index+2))]}" == $letter && "${gameBoard[$((index+1))]}" == $IS_EMPTY ]]
		then
			gameBoard[$((index+1))]=$computerLetter
			compPlay=1
			return
		elif [[ "${gameBoard[$((index+2))]}" == $letter && "${gameBoard[$((index+1))]}" == $letter && "${gameBoard[$index]}" == $IS_EMPTY ]]
		then
			gameBoard[$index]=$computerLetter
			compPlay=1
			return
		fi
		index=$((index+3))
	done
	#check winning moves for column
	index=0
	while(($index<9))
	do
		if [[ "${gameBoard[index]}" == $letter && "${gameBoard[$((index+3))]}" == $letter && "${gameBoard[$((index+6))]}" == $IS_EMPTY ]]
		then
			gameBoard[$((index+6))]=$computerLetter
			compPlay=1
			return
		elif [[ "${gameBoard[$index]}" == $letter && "${gameBoard[$((index+6))]}" == $letter && "${gameBoard[$((index+3))]}" == $IS_EMPTY ]]
		then
			gameBoard[$((index+3))]=$computerLetter
			compPlay=1
			return
		elif [[ "${gameBoard[$((index+3))]}" == $letter && "${gameBoard[$((index+6))]}" == $letter && "${gameBoard[$index]}" == $IS_EMPTY ]]
		then
			gameBoard[$index]=$computerLetter
			compPlay=1
			return
		fi
		index=$((index+1))
	done
	#Check winning moves primary diagonal
	if [[ "${gameBoard[0]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[8]}" == $IS_EMPTY ]]
	then
		gameBoard[8]=$computerLetter
		compPlay=1
		return
	elif [[ "${gameBoard[0]}" == $letter && "${gameBoard[8]}" == $letter && "${gameBoard[4]}" == $IS_EMPTY ]]
	then
		gameBoard[4]=$computerLetter
		compPlay=1
		return
	elif [[ "${gameBoard[8]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[0]}" == $IS_EMPTY ]]
	then
		gameBoard[0]=$computerLetter
		compPlay=1
		return
	fi
	# Check winning moves for secondary diagonal
	if [[ "${gameBoard[2]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[6]}" == $IS_EMPTY ]]
	then
		gameBoard[6]=$computerLetter
		compPlay=1
		return
	elif [[ "${gameBoard[2]}" == $letter && "${gameBoard[6]}" == $letter && "${gameBoard[4]}" == $IS_EMPTY ]]
	then
		gameBoard[4]=$computerLetter
		compPlay=1
		return
	elif [[ "${gameBoard[6]}" == $letter && "${gameBoard[4]}" == $letter && "${gameBoard[2]}" == $IS_EMPTY ]]
	then
		gameBoard[2]=$computerLetter
		compPlay=1
		return
	fi
}
function computerTurn()
{
	computerLetter=$1
	playerLetter=$2
	compPlay=0
	echo "Computer turn: "
	checkWinningMove $computerLetter
	if(($compPlay==0))
	then
		blockPlayerWin $playerLetter $computerLetter
	fi
	if(($compPlay==0))
	then
		fillCorners $computerLetter
	fi
	if(($compPlay==0))
	then
		takeCenter $computerLetter
	fi
	if(($compPlay==0))
	then
		takeSides $computerLetter
	fi
	displayBoard
}
# Function to play alternatively
function alternatePlay()
{
	chance="$(firstChance)"
	echo $chance
	flag=0
	if [[ "$chance"=="computerChance" ]]
	then
		flag=1
	fi
	while((0==0))
	do
   	if((flag%2!=0))
   	then
			computerTurn $computerLetter $playerLetter
			result="$(checkWin $computerLetter)"
			if [[ $result == "wins" || $result == "draw" ]]
			then
				printf "Computer $result\n"
				break
			fi
		else
			playerTurn $playerLetter
			result="$(checkWin $playerLetter)"
			if [[ $result == "wins" || $result == "draw" ]]
			then
				printf "Player $result \n"
				break
			fi
		fi
		flag=$((flag+1))
	done
}
#function to assign letter to the player
function assignLetter()
{
	letterCheck=$((RANDOM%2))
	case $letterCheck in
		$DOT)
			playerLetter="O"
			computerLetter="X"
		;;
		$CROSS)
			playerLetter="X"
			computerLetter="O"
		;;
	esac
}

function firstChance()
{
	chanceCheck=$((RANDOM%2))
	case $chanceCheck in
		$PLAYER)
			 echo "playerChance"
		;;
		$COMPUTER)
			 echo "computerChance"
		;;
	esac
}

#function calls
displayBoard
assignLetter
alternatePlay
