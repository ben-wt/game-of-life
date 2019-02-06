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
% worldType - string, as per inputs to gameOfLife
% stepTime - OPTIONAL - positive number - if displayOptions is 'continuous',
%               this specifies seconds per generation (N.B. this excludes
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

%% validate numSteps input (seedArray & worldType already validated within gameOfLife)

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

    end
    % carry out GoL step
    currentArray = gameOfLife(currentArray, worldType);
    if strcmpi(displayOptions, 'continuous')
        % CData - draw on the axes retaining existing formatting
        image('CData', currentArray, 'CDataMapping', 'scaled')
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

% display lines between cells, no numbering
ax.YTick = 0.5 : 1 : siz(1)+0.5 ;
ax.YTickLabel = '';
ax.XTick = 0.5 : 1 : siz(2)+0.5 ;
ax.XTickLabel = '';
ax.TickLength = [0 0];
grid on

% set white/blue colormap for cells: 0=dead=white and 1=live=blue
colmap = [1 1 1; 0 0 1];
colormap(colmap);
caxis([0 1])
end
