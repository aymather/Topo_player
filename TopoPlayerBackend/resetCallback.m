function resetCallback(~,~,hAxes,settings)

    % Reset frame counter to 1
    global framenum; framenum = 1;
    
    showFrameOnAxis(hAxes.axis1, settings.anim(framenum).cdata);
        
    % Reset title
    hAxes.ui1.String = ['Time Lapsed ' num2str(frame2time(settings,framenum)) 'ms'];
    
    % Reset progress bar
    status = framenum/length(settings.anim); % get length of loaded frames
    uiProgressBar(settings,hAxes.pBar,status); % update bar length
    
end