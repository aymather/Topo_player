function frame = time2frame(settings,ms)
    
    % Convert a time in ms to a specific sample point
    
    % Un-zero it out first
    ms = ms + (1000/settings.srate);
    
    % Get frame
    frame = ms * settings.srate/1000;

end