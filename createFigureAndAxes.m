% Create a figure window and two axes with titles to display two videos.
function [hFig, hAxes] = createFigureAndAxes(settings)

    % Init frame counter
    global framenum;

    % Close figure opened by last run
    figTag = 'Video_Figure';
    close(findobj('tag',figTag));

    % Create new figure
    hFig = figure('numbertitle', 'off', ...
           'name', 'Topo Player', ...
           'menubar','none', ...
           'toolbar','none', ...
           'resize', 'on', ...
           'tag',figTag, ...
           'renderer','painters', ...
           'Color','w',...
           'position',settings.screen.owd);

    % Create axes and titles [X Y W H]
    movieSize = [21/60 33/60 17/60 27/60];
    [hAxes.axis1, hAxes.ui1] = createPanelAxisTitle(hFig,movieSize,['Frame ' num2str(framenum) ' : Time Lapsed ' num2str(frame2time(settings.srate,framenum)) 'ms']); 
    numframes = 0; 
    if isfield(settings,'cframes')
        if isfield(settings.cframes,'individualDisplayFrames')
            numframes = length(settings.cframes.individualDisplayFrames);
        end
    end
    if isfield(settings, 'displayFrames')
        if isfield(settings.displayFrames, 'averaged'); numframes = numframes + 1; end
        if isfield(settings.displayFrames, 'montage'); numframes = numframes + 1; end
    end
    h = movieSize(4) - .1;
    w = movieSize(3) - (.066 * 2);
    while true
        
        if w * numframes <= .8
            break
        else
            w = w - .05;
            h = h - .066;
        end
        
    end
    y = (.5/2) - (h/2);
    xpos = [];
    for i = 1:numframes
        x = (i)/(numframes+1);
        x = x-(w/2);
        xpos = [xpos;x];
    end
    for i = 1:length(settings.allCFrames)
        pos = [xpos(i) y w h]; % get position of frame
        [hAxes.(['axis' num2str(settings.allCFrames(i))]), hAxes.(['ui' num2str(settings.allCFrames(i))])] = createPanelAxisTitle(gcf, pos, settings.allTitles{i});
    end
    
end