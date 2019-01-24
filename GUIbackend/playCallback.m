% Play Button Callback
function playCallback(hObject,~,hAxes,mySettings)
   
   % Init global variables
   global framenum;

   try
       
        % Check the status of play button
        isTextStart = strcmp(hObject.String,'Start');
        isTextCont  = strcmp(hObject.String,'Continue');
        if (isTextStart || isTextCont)
            hObject.String = 'Pause';
        else
            hObject.String = 'Continue';
        end

        % Rotate input video frame and display original and rotated
        % frames on figure
        while strcmp(hObject.String, 'Pause')

            if framenum < length(mySettings.anim)
                framenum = framenum + 1;
            end
            
            % Update main movie
            hAxes.ui1.String = ['Frame ' num2str(framenum) ' : Time Lapsed ' num2str(frame2time(mySettings,framenum)) 'ms'];

            % Display main video frame on axis
            showFrameOnAxis(hAxes.axis1, mySettings.anim{framenum});
            
            % Update progress bar
            status = framenum / length(mySettings.anim);
            uiProgressBar(mySettings,hAxes.pBar,status);
            
            if isfield(mySettings,'display')
                fnames = fieldnames(mySettings.display);
                for ib = 1:length(fnames)

                    if framenum == str2double(strip(fnames{ib},'left','d'))

                        showFrameOnAxis(hAxes.(['axis' strip(fnames{ib},'left','d')]), mySettings.display.(fnames{ib}).frame); 

                    end

                end
            end
                 
            % Pause for slow motion
            pause(mySettings.durations.waitTime/1000);

        end

        % When video reaches the end of file, display "Start" on the
        % play button.
        if framenum == length(mySettings.anim)
           hObject.String = 'Start';
           framenum = 1;
        end

   catch ME

       % Re-throw error message if it is not related to invalid handle 
       if ~strcmp(ME.identifier, 'MATLAB:class:InvalidHandle')
           rethrow(ME);
       end

   end

end