% Play Button Callback
function playCallback(hObject,~,hAxes,mySettings)
   
   % Init global variables
   global framenum; global IDF; global ADF; global MDF;

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
            hAxes.ui1.String = ['Frame ' num2str(framenum) ' : Time Lapsed ' num2str(frame2time(mySettings.srate,framenum)) 'ms'];

            % Display main video frame on axis
            showFrameOnAxis(hAxes.axis1, mySettings.anim{framenum});
            
            % If frame is equal to input display it
            if isfield(mySettings,'allCFrames')
                for i = 1:length(mySettings.allCFrames)
                    if isfield(mySettings.cframes,'individualDisplayFrames') && IDF
                        if framenum == mySettings.allCFrames(i)
                            showFrameOnAxis(hAxes.(['axis' num2str(mySettings.allCFrames(i))]), mySettings.anim{framenum});
                            if framenum == mySettings.cframes.individualDisplayFrames(end); IDF = false; end
                        end
                    end
                    if isfield(mySettings.cframes,'averagedDisplayFrame') && ADF
                        if framenum == mySettings.cframes.averagedDisplayFrame
                            showFrameOnAxis(hAxes.(['axis' num2str(mySettings.cframes.averagedDisplayFrame)]), mySettings.displayFrames.averaged);
                            ADF = false;
                        end
                    end
                    if isfield(mySettings.cframes,'montageDisplayFrame') && MDF
                        if framenum == mySettings.cframes.montageDisplayFrame
                            showFrameOnAxis(hAxes.(['axis' num2str(mySettings.cframes.montageDisplayFrame)]), mySettings.displayFrames.montage);
                            MDF = false;
                        end
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