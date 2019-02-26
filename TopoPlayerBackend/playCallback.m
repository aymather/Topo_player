% Play Button Callback
function exportObj = playCallback(hObject,~,hAxes,mySettings)
   
   % Init global variables
   global framenum;

   try
        
        if ~mySettings.export
            % Check the status of play button
            isTextStart = strcmp(hObject.String,'Start');
            isTextCont  = strcmp(hObject.String,'Continue');
            if (isTextStart || isTextCont)
                hObject.String = 'Pause';
            else
                hObject.String = 'Continue';
            end
            isPaused = strcmp(hObject.String,'Pause');
        else
            isPaused = 1;
        end
        
        % Rotate input video frame and display original and rotated
        % frames on figure
        while framenum <= length(mySettings.anim) && isPaused
            
            if mySettings.export
                exportObj(framenum) = getframe(gcf);
            end
            
            % Update main movie
            hAxes.ui1.String = ['Time Lapsed ' num2str(frame2time(mySettings,framenum)) 'ms'];

            showFrameOnAxis(hAxes.axis1, mySettings.anim(framenum).cdata);
            
            % Update progress bar
            status = framenum / length(mySettings.anim);
            uiProgressBar(mySettings,hAxes.pBar,status);
            
            if isfield(mySettings,'display')
                fnames = fieldnames(mySettings.display);
                for ib = 1:length(fnames)

                    if framenum == str2double(strip_it(fnames{ib}))

                        showFrameOnAxis(hAxes.(['axis' strip_it(fnames{ib})]), mySettings.display.(fnames{ib}).frame); 

                    end

                end
            end
                 
            % Pause for slow motion
            pause(mySettings.durations.waitTime/1000);
                        
            if framenum <= length(mySettings.anim)
                framenum = framenum + 1;
            end

            % When video reaches the end of file, display "Start" on the
            % play button.
            if framenum == length(mySettings.anim) && ~mySettings.export
               framenum = 1;
            end
            
            if ~mySettings.export && strcmp(hObject.String, 'Continue')
                isPaused = 0;
            end
            
        end
        
   catch ME

       % Re-throw error message if it is not related to invalid handle 
       if ~strcmp(ME.identifier, 'MATLAB:class:InvalidHandle')
           rethrow(ME);
       end

   end

end