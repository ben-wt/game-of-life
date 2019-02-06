# Game of Life

Conway's Game of Life implemented in MATLAB. You can run the game from a seed, with the option to display its progress visually.

The GoL is set in a 2D grid, in which cells are either live or dead and interact with their neighbours at each generation. In the GoL as originally described, the grid is infinite. This implementation allows the user to select 3 types of game world: a grid that expands when live cells are at the edge, so as to accommodate the pattern as if it were an infinite grid (within the limits of the computer's capacity); a finite grid wrapped around on itself (as a torus) so as to be boundless; or a bounded finite grid (the boundaries are assumed to influence neighbours as if they were empty cells).

## Requirements

The game runs within the MATLAB application. Download the files, open MATLAB and add the files to the search path.

## Usage

The function `runGameOfLife.m` runs the game from a given seed (starting state; example seeds are available in the `/GoL seeds` folder) for a given number of steps. You can also select to display the game progress (and if so, the speed) and select a world type (see below). Command format is:

```
outArray = runGameOfLife(seedArray, numSteps, displayOptions, worldType, stepTime);
```

If the option to display is used, the game's changing state is presented on a grid (white cells are dead, blue cells are live). You can stop the game early and exit at the current generation by clicking the "End now" button in the display or by closing the figure.

### Inputs as follows

`seedArray` - (2D matrix, double-precision) 0 for dead cells, 1 for live cells

`numSteps` - (positive integer OR inf) number of game steps to perform

`displayOptions` - (string; case-insensitive) '`continuous`' displays progress of game frame-by-frame. Any other value gives no display.

`worldType` - (string; case-insensitive):
* `expanding` - game world expands when live cells reach the edge, so replicates behaviour of an infinite game world within the computer's capacity (default value if empty or unrecognised input)
* `torus` - game world wraps around on itself, so is unbounded
* `finite` game world is finite, bounded grid

`stepTime` - (positive number; OPTIONAL) if displayOptions is 'continuous', this pause (in seconds) per generation and will default to 0.2 if unspecified (N.B. this excludes processing time, which could be significant for extremely large game worlds)

For example, to run from a given seed for 200 steps in an expanding game world and display it at a speed of 0.5 seconds per generation:

```
outArray = runGameOfLife(seedArray, 200, 'continuous', 'expanding', 0.5);
```

### Output

`outArray` - (matrix, same format as `seedArray`) The game state at the specified end. If the displayed game is ended early (see above) `outArray` will give the state at the point of exit.

## Other content

### gameOfLife.m

`gameOfLife` is the function that runs each step of the game. `runGameOfLife` uses it and it may also be called independently. Command format is:

```outArray = gameOfLife(seedArray, worldType)```

(Inputs and outputs same as above for `runGameOfLife`)

### testing_script.m

`testing_script` tests the `gameOfLife` function against the 6 scenarios given as specification for the game. To run it, call it from the Command Window:

```
testing_script
```

It will return the results of each test:

```
Passed test scenario 0
Passed test scenario 1
Passed test scenario 2
Passed test scenario 3
Passed test scenario 4
Passed test scenario 5
Passed test scenario 6
```

### /GoL seeds

These files contain example seed grids that yield interesting behaviours in the Game of Life. Load as in this example:

```
load('GoL seeds\Gosper gun.mat')
```
