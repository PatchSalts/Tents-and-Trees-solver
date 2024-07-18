# Tents and Trees solver

This was a final project for my Concepts of Computer Systems class. It solves Tents and Trees puzzles. It was written in MIPS assembly.

## About Tents and Trees

Tents and Trees is a pencil-and-paper puzzle game played on a grid with numbers along the rows and columns, a bit like Nonograms or Picross. The grid displays mostly empty cells, but some of these cells have trees. Your job is to place tents on the empty cells according to the rules of the game. These rules are:
- The number along each row and column must match the number of tents in each row and column, respectively
- Each tree must have a corresponding tent, placed in any adjacent cell in one of the cardinal directions
- No tent can be placed in any of the eight immediate neighboring cells of another tent

Many other versions of the rules contain many more rules, but these are the 3 core rules that all the others are derived from.

For example:

![A Tents and Trees puzzle displayed in 3 different states: blank, marked-up, and solved. The grid for each displays "101" in a row above and "011" in a column to the left. The grid is blank, except there is a tree in the top-right cell, and another tree in the bottom-middle cell.](example_puzzle.png)

In the example here, we can see how a simple game might be set up on the left. In the middle is a marked-up version, demonstrating where the tents relative to each tree *might* be. On the right, we see the puzzle solved. It demonstrates all 3 rules of the game:

The 0s tell us that the top-right tree must only have a tent below it and not to its left. That tent eliminates the possible neighboring tent placements for the other tree, so the remaining tent can only go in the bottom-left corner.

## Usage

The program was written for an in-house MIPS suite of programs called RASM, RLINK, and RSIM. I'm working on getting access back to those programs so I can record more detailed usage information.

To be completely honest, I can't find any documentation on what the input format was, but based on my code, it must have been a plaintext file formatted as the following:

1. 1 line containing the board size (N, an integer from 2 to 12 inclusive)
2. 1 line containing the row sums (N digits 0-9 with no separation)
3. 1 line containing the column sums (N digits 0-9 with no separation)
4. N lines containing rows of N cells the initial state of the puzzle board
    1. Use "`.`" to represent a blank (grass) cell
    2. Use "`T`" to represent a tree cell

The above example puzzle's input would look like this:

```
3
101
011
..T
...
.T.
```

If I recall correctly, RSIM accepts the compiled program as input and you would input the puzzle to the program by piping it via standard input. It displays the read puzzle (formatted more nicely than the input, of course), attempts to solve it, and displays the solved results (formatted again) with "`A`" representing the tents.

## About the Project

I am very proud of this program because up until this point in the class each assignment had always given us some code to start with, but this assignment consisted of a document with some specifications and suggestions. This code was written entirely on my own from scratch (mostly sitting at a table at Salsarita's on campus). It was thrilling, just sitting down and writing some of the lowest-level code imaginable to solve a task, and watching it slowly come together as the days went by. Eventually, it was just... done. I kinda sat there staring for a bit, but sure enough I had done it. I submitted it and walked out of the Salsarita's with a weight off of my shoulders. I really enjoyed working with such low-level code. I always described it as micro-managing the data and control flow, which was super fun and satisfying. I certainly encountered bugs but they were always fun to debug.
