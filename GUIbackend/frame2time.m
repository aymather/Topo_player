function timestamp = frame2time(settings,framenum)
    
    % Convert the frame number to a timestamp (from zero)
    % which is returned in ms
    framenum = framenum - 1; % we want to start at zero, so frame 1 in 0ms
    timestamp = framenum * (1000/settings.srate);

end