function outArray = gameOfLife(seedArray, worldType)

% Performs 1 step in Game of Life
%
% INPUT
% seedArray - 2D matrix (0 for dead cells, 1 for live cells)
% worldType - string (case-insensitive)
%                   - 'torus' game world wraps around on itself to be
%                       boundless
%                   - 'finite' game world is finite, bounded grid
%                   - 'expanding' game world expands when live cells reach
%                       the edge, so replicates behaviour of an infinite
%                       game world within the computer's capacity
%                       (default value if empty or unrecognised input)
%
% OUTPUT
% outArray - 2D matrix (0 for dead cells, 1 for live cells)
%
% BT, Feb 2019

%% check inputs are appropriate variable types

% seedArray should be a 2D matrix, class 'double'
if ~ismatrix(seedArray) || ~isa(seedArray,'double')
    error('seedArray input to gameOfLife must be a 2D matrix with double-precision number format')
end

% default - if world type is left empty, or unrecognised, set to expanding
possible_worldTypes = {'torus', 'finite', 'expanding'};
if isempty(worldType) || all(~strcmp(worldType, possible_worldTypes))
    worldType = 'expanding';
end

%% run the step

% if 'torus', pad the array and copy edges across for 'wrap around' effect
if strcmpi(worldType,'torus')
    seedArray = padarray(seedArray, [1 1], 'circular');
end

% if 'expanding', check if any cells at the edge are live and if so expand
% in that direction
if strcmpi(worldType,'expanding')
    seedArray = checkAndExpand(seedArray);
end

% use convolution to count the number of live neighbours for every cell
neighboursKernel = [1 1 1 ; 1 0 1; 1 1 1];
numNeighbours = conv2(seedArray, neighboursKernel, 'same');

% if 'torus', crop arrays back down to original size
if strcmpi(worldType,'torus')
    seedArray = seedArray( 2:end-1 , 2:end-1 );
    numNeighbours = numNeighbours( 2:end-1 , 2:end-1 );
end

% cells in output are live where:
% (they were live before AND had at least 2 neighbours AND had no more than 3 neighbours)
% OR
% (they were dead before AND have exactly 3 neighbours)
% and set the output to standard number format (double-precision) so it can be fed back in
outArray = double((seedArray & numNeighbours >= 2 & numNeighbours <= 3)...
            | (~seedArray & numNeighbours == 3));
end

function A2 = checkAndExpand(A1)
% Copies the grid. Checks if any cells at the edge are live, and if so,
% expands the copy 5 units in that direction

expandAmount = 5;

% initialise
A2 = A1;

%check each side

% top
if any(A1(1,:))
    A2 = padarray(A2, [expandAmount 0], 'pre');
end

% bottom
if any(A1(end,:))
    A2 = padarray(A2, [expandAmount 0], 'post');
end

% left
if any(A1(:,1))
    A2 = padarray(A2, [0 expandAmount], 'pre');
end

% right
if any(A1(:,end))
    A2 = padarray(A2, [0 expandAmount], 'post');
end

end