function topo_player(filename,varargin)

    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    %
    % Credit for basic GUI function framework to Mathworks
    %
    % Function Customized By: Alec Mather - University of Iowa - Wessel Lab - Dec. 2018
    %
    % Preview: This function is the second part in a two step process. See
    % the compile_topo() function for part one. This function will display
    % a movie of topographical data in a MATLAB GUI with a 'pause' button,
    % a reset button and an 'exit' button. In order for this function to work,
    % your file must be in .mat format.
    %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % 
    % Function Requirements: MATLAB 2018b/EEG Lab
    %
    % Links for Download:
    %   
    %   MATLAB 2018b: https://www.mathworks.com/downloads/
    %   EEG Lab: https://sccn.ucsd.edu/eeglab/download.php
    %   
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    %
    % Inputs:
    %
    %   REQUIRED: videoFile (str) == file which has been compiled by the
    %        compile_topo() function. This should end with a .mat extension.
    %        Example: videoFile = 'exampleVideo.mat';
    %
    %   REQUIRED: waitTime (int) == this is the amount of time (in seconds)
    %       that the program will wait between frames. If this input is 0 then
    %       the program will run as fast as it can through the frame sequence.
    %       Recommended is 0.02
    %
    %   REQUIRED: title1 (str) == this will be the title of the first frame
    %       capture that you specify.
    %
    %       Note: If you don't want to capture a frame and only watch the
    %       movie, then I recommend using the implay() function on your
    %       .avi file. There are many control features of the GUI that it
    %       creates.
    %
    %   REQUIRED: captureframe1 (int) == this will be the frame that you
    %       would like to draw to the adjacent to your ongoing movie.
    %
    %   OPTIONAL: title2 (str) == title of second capture frame
    %   REQUIRED IF title2 EXISTS (int) == frame of second capture frame
    %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

    % Initialize the video reader.
    disp('Loading in Video File...');
    assert(endsWith(filename,'.mat'),'Filename must have a .mat extension');
    try load(filename,'anim'); catch; disp('Your movie file does not contain the anim variable, you may be loading the wrong file'); end
    
    % Defaults
    defaultWaitTime = 0;
    
    % Function checks
    validSingleObj = @(x) isstruct(x) && ... % object is a struct with fields
                          isfield(x,'times') && ... % has a frame field
                          isfield(x,'titles') && ... % has a title field
                          isa(x.times,'double') && ... % capture frames field is a double
                          isnumeric(x.times); % frames are numeric values
    
    validAveragedObj = @(x) isstruct(x) && ... % object is a struct with fields
                            isfield(x,'presentationTime') && ... % object has a field for time to display frame
                            iscell(x.title) && ... % title is a character string
                            length(x.title) == 1 && ... % title cell only contains one string
                            ...
                            ((isfield(x,'chanlocs') && ... % object has a chanlocs field
                            isfield(x,'data') && ... % object has a field for eeg data matrix
                            isa(x.data,'double') && ... % frames field is populated by a double
                            isnumeric(x.data)) ... % frames is a numeric value
                            || ... % either manually add data, or give an already created avi file
                            (isfield(x,'matFile') && ... % has a file 
                            ischar(x.matFile) && ... % is a character string
                            endsWith(x.matFile,'.mat'))); % has a .avi extension
                        
    validMontageObj = @(x) isstruct(x) && ... % object is a struct with fields
                           isfield(x,'title') && ... % object has a title field
                           iscell(x.title) && ... % title must be a cell array
                           length(x.title) == 1 && ... % cell array can only contain one title for a montage object
                           isfield(x,'presentationTime') && ... % has a field for display time
                           isnumeric(x.presentationTime) && ... % presentation time is a numeric value
                           ...
                           (isfield(x,'timeWindow') && ... % object has a timeWindow field
                           isa(x.timeWindow,'double') && ... % frames are of type 'double'
                           isnumeric(x.timeWindow) && ... % frames have a numeric value
                           length(x.timeWindow) == 2) ... % can only contain the range (2 integers) between which the data will be averaged
                           || ... % either create a unique image with a time window or use an existing image
                           (isfield(x,'matFile') && ... % has a matFile field
                           ischar(x.matFile) && ... % matFile field is a character array
                           endsWith(x.matFile,'.mat')); % matFile has a .mat extension
                           
    
    % Create custom scheme for Key Value pair inputs
    p = inputParser;
    addRequired(p,'FileName');
    addParameter(p,'WaitTime',defaultWaitTime);
    addParameter(p,'AddIndividualFrames',[],validSingleObj);
    addParameter(p,'AddAveragedFrame',[],validAveragedObj);
    addParameter(p,'AddMontageFrame',[],validMontageObj);
    
    % Parse inputs and validate
    parse(p,filename,varargin{:});
    
    % Initialize settings
    settings = topo_init(p,anim);
    
    % Init frame counter
    global framenum; framenum = 1;

    % Axes/Buttons
    % Create a figure window and axes to display
    [hFig, hAxes] = createFigureAndAxes(settings);

    % Add buttons to control video playback.
    insertButtons(hFig, hAxes, settings);
    
    % Display input video frame on axis
    showFrameOnAxis(hAxes.axis1, settings.anim{framenum});

end
