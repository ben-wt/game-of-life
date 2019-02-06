function outArray = runGameOfLife(seedArray, numSteps, displayOptions, worldType, stepTime)
%runGameOfLife: Performs specified number of steps in Game of Life, using
%specified seed. Option for visual display, including "End now" button.
%
% INPUT
% seedArray - 2D matrix (0 for dead cells, 1 for live cells)
% numSteps - positive integer OR inf - number of game steps to perform
% displayOptions - can be a string (case-insensitive) - 'continuous'
%                   displays progress of game frame-by-frame. Any other
%                   value gives no display.
% worldType - string (case-insensitive)
%                   - 'torus' game world wraps around on itself to be
%                       boundless
%                   - 'finite' game world is finite, bounded grid
%                   - 'expanding' game world expands when live cells reach
%                       the edge, so replicates behaviour of an infinite
%                       game world within the computer's capacity
%                       (default value if empty or unrecognised input)
% stepTime - OPTIONAL - positive number - if displayOptions is 'continuous',
%               this specifies seconds pause per generation and will
%               default to 0.2 if unspecified (N.B. this excludes
%               processing time, which could be long for extremely large
%               game worlds)
%
% OUTPUT
% outArray - 2D matrix (0 for dead cells, 1 for live cells)
%
% "End now" button, or closing the display figure, terminates the game
% early and outputs the state of the array at that point.
%
% BT, Feb 2019

%% validate numSteps, stepTime and worldType input
% (seedArray validation within gameOfLife function is sufficient)

% numSteps should be a single number, positive, and either integer OR infinite
if ~isscalar(numSteps) || numSteps < 1 || (rem(numSteps, 1) ~= 0 && ~isinf(numSteps))
    error('numSteps should be a single positive integer')
end

% If stepTime is unspecified, set it to 0.2 seconds. If specified, it must
% be a single number, with value at least 0
if ~exist('stepTime', 'var') || isempty(stepTime)
    stepTime = 0.2;
elseif ~isscalar(stepTime) || stepTime < 0
    error('stepTime must be a single number, with value at least 0')
end

% if world type is left empty, or unrecognised, set to expanding
possible_worldTypes = {'torus', 'finite', 'expanding'};
if isempty(worldType) || all(~strcmp(worldType, possible_worldTypes))
    worldType = 'expanding';
end

%%
% initialise
currentArray = seedArray;

if strcmpi(displayOptions, 'continuous')
    dispFig = figure;
    ax = axes;
    % draw grid 
    im = image(currentArray, 'CDataMapping', 'scaled', 'Visible', 'off');
    title('Game of Life')
    xlabel('Generation 0')
    formatDisplay(ax, size(currentArray));
    im.Visible = 'on';
    % create an "End now" button
    stopButton = uicontrol('Style','toggle','string', 'End now');
end
    
%run steps
for s=1:numSteps
    
    % handle display
    if strcmpi(displayOptions, 'continuous')
        
        % pause so each step is visible
        pause(stepTime)

        % check if the 'stop' button has been pressed, or the display
        % has been closed. If so halt and exit before performing this
        % generation
        drawnow
        if ~ishghandle(dispFig) || stopButton.Value == 1
            display(['Exited at generation ' num2str(s-1)]);
            break
        end
        
        % if displaying and worldType is 'expanding', track array size to
        % see if it does expand
        if strcmpi(worldType, 'expanding')
            startArraySize = size(currentArray);
        end
    end    
    
    % carry out GoL step
    currentArray = gameOfLife(currentArray, worldType);
    
    % handle display
    if strcmpi(displayOptions, 'continuous')
        
        % CData - draw on the axes retaining existing formatting
        image('CData', currentArray, 'CDataMapping', 'scaled')
        
        % if worldType is 'expanding', check if array has expanded and
        % display therefore needs to be re-formatted
        if strcmpi(worldType, 'expanding') && any(size(currentArray) ~= startArraySize)
            formatDisplay(ax, size(currentArray));
        end
        
        % Label the generation number
        xlabel(['Generation ' num2str(s)])
        
    end
end

%assign output
outArray = currentArray;

end

function formatDisplay(ax, siz)
% format the display appearance appropriately

% set extent of axes to the limits of the array, and scale of both the same
ax.DataAspectRatio = [1 1 1];
ax.XLim =  0.5 + [ 0 siz(2) ];
ax.YLim =  0.5 + [ 0 siz(1) ];

% display grid lines between cells, space coordinate labels appropriately
% (labels must be multiples of 10)

ax.YTick = 0.5 : 1 : siz(1)+0.5;
YLabelInterval = round(length(ax.YTick)/5, -1);
YLabels = [YLabelInterval : YLabelInterval : length(ax.YTick)]';
ax.YTickLabel = cellstr(blanks(length(ax.YTick)'));
ax.YTickLabel(YLabels) = cellstr(num2str(YLabels));

ax.XTick = 0.5 : 1 : siz(2)+0.5;
XLabelInterval = round(length(ax.XTick)/5, -1);
XLabels = [XLabelInterval : XLabelInterval : length(ax.XTick)]';
ax.XTickLabel = cellstr(blanks(length(ax.XTick)'));
ax.XTickLabel(XLabels) = cellstr(num2str(XLabels));

ax.TickLength = [0 0];
grid on

% set white/blue colormap for cells: 0=dead=white and 1=live=blue

colmap = [1 1 1; 0 0 1];
colormap(colmap);
caxis([0 1])
end
