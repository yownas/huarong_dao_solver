# Solver for Huarong Dao / Klotski puzzles

Not intended to be too serious.

Shell script to solve the Huarong Dao/Klotski puzzle. (https://en.wikipedia.org/wiki/Klotski)

I made a joke that you could solve it using sed and awk. Even if it is a stupid way to do it, it didn't seem impossible. So I had to try.

To run the solver: ````solver.sh solve````

To just parse the data and print the solution: ````solver.sh show````

The moves for the blocks and rotations are hard-coded but should work for any board that is 4 wide.

(I also made a Rush Hour solver since the problem is more or less the same.)
