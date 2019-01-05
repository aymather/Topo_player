function settings = topo_init(p,anim)
    
    % Make a settings variable for things you need to pass so
    % as to reduce confusion and make things cleaner
    
    % Sample Rate
    settings.srate = 500; % Hz
    
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
            settings.display.(['d' num2str(cframes(i))]).frame = settings.anim{cframes(i)};
            
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
    
    if length(fieldnames(settings.display)) ~= 1
        settings.buttonPos.start = [.68 .95 .31 .03];
        settings.buttonPos.exit = [.84 .9 .15 .03];
        settings.buttonPos.reset = [.68 .9 .15 .03];
    else
        settings.buttonPos.start = [.38 .95 .31 .03];
        settings.buttonPos.exit = [.54 .9 .15 .03];
        settings.buttonPos.reset = [.38 .9 .15 .03];
    end
    
    % Screen Dimensions
    settings.screen.owd = get(0,'ScreenSize');
    
end