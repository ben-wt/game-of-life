function outArray = runGameOfLife(seedArray, numSteps, displayOptions, worldType)
%runGameOfLife: Performs specified number of steps in Game of Life, using
%specified seed. Option for visual display, including "End now" button.
%
% INPUT
% seedArray - 2D matrix (0 for dead cells, 1 for live cells)
% numSteps - positive integer, number of game steps to perform
% displayOptions - string (case-insensitive)
%                   - 'continuous' displays progress of game frame-by-frame
%                   with 0.5 second pause. Any other value gives no display.
% worldType - string, as per inputs to gameOfLife
%
% OUTPUT
% outArray - 2D matrix (0 for dead cells, 1 for live cells)
%
% "End now" button terminates the game early and outputs the state of the
% array at that point.
% Closing the display figure removes the display function and removes the
% per-generation pause, accelerating the game directly to the end.
%
% BT, Feb 2019

%% validate numSteps input (seedArray & worldType already validated within gameOfLife)

% numSteps should be a single positive integer
if ~isscalar(numSteps) || rem(numSteps, 1) ~= 0 || numSteps < 1
    error('numSteps should be a single positive integer')
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
        pause(0.5)
        % Check if the display has been closed. If so, proceed to end at 
        % full speed without display.
        if ~ishghandle(dispFig)
            displayOptions = 'none';        
        else
            % check if the 'stop' button has been pressed, if so halt and
            % exit before performing this generation
            drawnow
            if stopButton.Value == 1
                display(['Exited at generation ' num2str(s-1)]);
                break
            end
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
