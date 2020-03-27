#!/bin/bash -x

#variables
X="X"
O="O"
declare -a gameBoard
gameBoard=(" " " " " " " " " " " " " " " " " ")

printf "Welcome to tic tac toe game \n"
#board design
echo "${gameBoard[0]}  | ${gameBoard[1]} | ${gameBoard[2]}"
echo "-----------"
echo "${gameBoard[3]}  | ${gameBoard[4]} | ${gameBoard[5]}"
echo "-----------"
echo "${gameBoard[6]}  | ${gameBoard[7]} | ${gameBoard[8]}"

#assign the sign X or O
letterCheck=$((RANDOM%2))
case $letterCheck in
	0) echo "You sign is : "$O
		;;
	1) echo "You sign is : "$X
		;;
esac

#first ture
firstTurn=$((RANDOM%2))
case $firstTurn in
	0) echo "User plays first"
	;;
	1) echo "Computer plays first"
	;;
esac
