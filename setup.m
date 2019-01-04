
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% BASIC FRAME CAPTURES SETUP
%arrayObj.times = [50:56,60:62]; % ms
%arrayObj.titles = {'this','is','my','titles','cell','array'};

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% MONTAGE FRAME SETUP

% Required Fields
montageObj.title = {'A montage accepts only one title as a cell'}; % title
montageObj.presentationTime = 100; % when should we present this image during the movie?

% Field for creating a custom image
% time window for montage in ms
%montageObj.timeWindow = [50,100]; % ms

% or

% use existing montage image from .mat file
montageObj.matFile = 'A montage accepts only one title as a cell.mat'; % .mat file

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% AVERAGED FRAME SETUP

% Required inputs
averageObj.presentationTime = 150; % ms
averageObj.title = {'An averaged object will have only one title as well'}; % title

% create unique averaged image from data
% load('example_data.mat','GL'); % data matrix for topoplot
% x = GL(:,50:100); % cut out data you want to average together
% load('Wessellab_Chanlocs.mat'); % load chanlocs file
% averageObj.chanlocs = chanlocs; % chanlocs
% averageObj.data = x; % data

% or

% use existing .mat file image
averageObj.matFile = 'An averaged object will have only one title as well.mat'; % .mat file

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% Example
topo_player('testFile.mat', ...
            'WaitTime',50, ... 
            'AddAveragedFrame',averageObj, ...
            'AddMontageFrame',montageObj);
        
        
        
        
        
        