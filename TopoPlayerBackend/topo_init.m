function settings = topo_init(p,anim,settings)
    
    % Make a settings variable for things you need to pass so
    % as to reduce confusion and make things cleaner
    
    % Export to .avi file? (bool)
    settings.export = p.Results.Export;
    
    % Sample Rate
    settings.srate = p.Results.Settings.srate;
    
    % Durations
    settings.durations.waitTime = p.Results.WaitTime; % ms
    
    % Animation Video
    settings.anim = anim;
    
    % Deconstruct Objects from inputParser
    
    % Individual Frames
    if ~isempty(p.Results.AddIndividualFrames)
        
        % Convert ms input to frame numbers
        cframes = [];
        for i = p.Results.AddIndividualFrames.times(1:end)
            if ~mod(i,2)
                cframes = [cframes, time2frame(settings,i)];
            end
        end
        
        % Make sure there are equal frames and titles
        assert(length(cframes) == length(p.Results.AddIndividualFrames.titles),['You have ' num2str(length(cframes))...
                                                                                ' frames you are trying to capture and ' ...
                                                                                num2str(length(p.Results.AddIndividualFrames.titles))...
                                                                                ' titles, you must have a title for every frame.']);
        for i = 1:length(cframes)
            
            settings.display.(['d' num2str(cframes(i))]).title = p.Results.AddIndividualFrames.titles{i};
            if all(settings.matlab == '(R2018a)') || all(settings.matlab == '(R2018b)')
                settings.display.(['d' num2str(cframes(i))]).frame = settings.anim{cframes(i)};
            else
                settings.display.(['d' num2str(cframes(i))]).frame = settings.anim(cframes(i)).cdata;
            end
            
        end
        
    end
    
    if ~isempty(p.Results.AddCustomFrames)
        
        for i = 1:length(p.Results.AddCustomFrames.times)
            
            settings.display.(['d' num2str(time2frame(settings,p.Results.AddCustomFrames.times(i)))]).title = p.Results.AddCustomFrames.titles{i};
            try 
                load(p.Results.AddCustomFrames.files{i},'frameData');
            catch
                warning([p.Results.AddCustomFrames.files{i} ' did not have the frameData variable we were looking for, double check your file']);
            end
            settings.display.(['d' num2str(time2frame(settings,p.Results.AddCustomFrames.times(i)))]).frame = frameData;
            
        end
        
    end
    
    % Get all positions [X Y W H]
    if isfield(settings,'display')
        numframes = length(fieldnames(settings.display)); % how many frames are we going to capture?
    else
        numframes = 0;
    end
    
    % Establish widths and heights
    startW = .3;
    movieW = 17/60; movieH = 27/60;
    hsub = .05; wsub = ((1/3)/10); h = .5; w = 1/3;
    xpos = [];
    % Make adjustments to widths depending on the number
    % of capture frames
    if numframes == 0
        movieX = (1/2) - (movieW/2);
        movieY = 1/2 - (movieH/2);
    elseif numframes == 1 % if we're only capturing 1 frame, go horizontal to save space
        movieX = (1/6); movieY = 1/4; % movie adjustments
        cframeX = (3/6)+.1; cframeY = 1/4;
        xpos = [cframeX cframeY movieW movieH];
    else
        movieX = .5-(movieW/2); movieY = 33/60; % movie adjustments
        h = h - (hsub*numframes);
        w = w - (wsub*numframes);
        y = (.5/2) - (h/2);
        for i = 1:numframes
            x = (i)/(numframes+1);
            x = x-(w/2);
            p = [x y w h];
            xpos = [xpos;p];
        end
    end 
    
    % Set new adjusted positions
    settings.positions.cframes = xpos;
    settings.positions.movie = [movieX movieY movieW movieH];
    
    % Button and progress bar positions
    if numframes ~= 1
        settings.positions.start = [.68 .95 .31 .04];
        settings.positions.exit = [.84 .9 .15 .04];
        settings.positions.reset = [.68 .9 .15 .04];
        settings.positions.pbar = [movieX movieY-.08 movieW .018];
    elseif numframes == 1
        settings.positions.start = [.5-(startW/2) .95 startW .04];
        settings.positions.exit = [.5-(startW/2)+.15 .9 .15 .04];
        settings.positions.reset = [.5-(startW/2) .9 .15 .04];
        settings.positions.pbar = [movieX movieY-.08 movieW .018];
    end
    
    % Screen Dimensions
    settings.screen.owd = get(0,'ScreenSize');
    
end