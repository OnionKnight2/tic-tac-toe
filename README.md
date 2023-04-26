# tic-tac-toe
Building a tic-tac-toe game on the command line where two human players can play against each other 
and the board is displayed in between turns.

It involves a couple of players, a simple board, checking for victory in a game loop.

----------------------------------------------------------------------------------------------------------

    
Board class is defined.
Instance variable size holds an array of x and o values that users played
Method #to_s is overridden with a nice display of users' moves. 

Positions on the board are numbered from 0 to 8

Instance method update(move, field) updates the board_status array based on the field and a x or o.

Instance variable full? checks if all fields are filled and it will mean that it's a draw

----------------------------------------------------------------------------------------------------------

Game class initializes the board and contains a loop for a game to be played.
It also initializes both players and has a winner variable.

Instance method over? checks if there are 3 consecutive symbols
It checks if a board has 3 same symbols on any of win condition lines
According to that, it's able to declare a winner.

Instance method play contains all the logic neccessary for the game to actualy be played.
Users are first asked what their name is and they are given a random symbol (x or o) each.
Then, until the game's not over, users are prompted to enter their symbol into the field they want

When user inputs a place where he wants to put their symbol, there is a check for a TypeError in begin..rescue block

----------------------------------------------------------------------------------------------------------

Player class initializes a player with his name.
Also it initializes a players' symbol (x or o).
There is also a turn variable that is true if the player is on the move

----------------------------------------------------------------------------------------------------------

Module called TicTacTo contains all the helper methods and classes

 ----------------------------------------------------------------------------------------------------------
