function varargout = TopoStudio(varargin)
% TOPOSTUDIO MATLAB code for TopoStudio.fig
%      TOPOSTUDIO, by itself, creates a new TOPOSTUDIO or raises the existing
%      singleton*.
%
%      H = TOPOSTUDIO returns the handle to a new TOPOSTUDIO or the handle to
%      the existing singleton*.
%
%      TOPOSTUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TOPOSTUDIO.M with the given input arguments.
%
%      TOPOSTUDIO('Property','Value',...) creates a new TOPOSTUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TopoStudio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TopoStudio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TopoStudio

% Last Modified by GUIDE v2.5 25-Jan-2019 21:15:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TopoStudio_OpeningFcn, ...
                   'gui_OutputFcn',  @TopoStudio_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TopoStudio is made visible.
function TopoStudio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TopoStudio (see VARARGIN)

% Choose default command line output for TopoStudio
handles.output = hObject;
handles.IFrameTimes = [];
handles.IFrameTitles = {};
handles.CFrameTimes = [];
handles.CFrameTitles = {};
handles.CFrameFiles = {};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TopoStudio wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TopoStudio_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    topo_player('testFile.mat');


function pushbutton5_Callback(hObject, eventdata, handles)


function pushbutton4_Callback(hObject, eventdata, handles)


% --- iframe add to stage pushbutton3 --- %
function pushbutton3_Callback(hObject, eventdata, handles)

    if checkIFrame(str2double(handles.edit1.String),handles.edit2.String)
        
        % Check frames and add to handles
        handles.IFrameTitles = horzcat(handles.IFrameTitles,handles.edit2.String);
        handles.IFrameTimes = horzcat(handles.IFrameTimes,str2double(handles.edit1.String));
       
        % Update staged frames
        handles.text24.String = horzcat(handles.text24.String, ['  ' handles.edit2.String]);
       
        % Reset strings in text boxes
        handles.edit1.String = '';
        handles.edit2.String = '';
       
    else
        
        % Give warning if something goes wrong
        warn = 'Invalid inputs!';
        warn = [warn newline 'Both a title and a capture time are required'];
        warn = [warn newline 'Capture Time must be an even number and not contain any special characters including spaces.'];
        warning(warn);

    end


function edit1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

    % hObject    handle to edit1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function edit2_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

    % hObject    handle to edit2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function edit3_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

    % hObject    handle to edit4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in pushbutton6.
% --- Select custom.mat file pushbutton
function pushbutton6_Callback(hObject, eventdata, handles)

    % Open a file to select
    customFile = uigetfile;
    handles.text10.String = customFile;


function pushbutton8_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushbutton7.
% --- Stage Custom Frames pushbutton
function pushbutton7_Callback(hObject, eventdata, handles)

    if checkCFrame(str2double(handles.edit3.String), handles.edit4.String, handles.text10.String)
        
        % Check frames and add to handles
       handles.CFrameTitles = horzcat(handles.CFrameTitles,handles.edit4.String);
       handles.CFrameTimes = horzcat(handles.CFrameTimes,str2double(handles.edit3.String));
       handles.CFrameFiles = horzcat(handles.CFrameFiles,handles.text10.String);
       
       % Update staged frames
       handles.text25.String = horzcat(handles.text25.String, ['  ' handles.edit4.String]);
       
       % Reset strings in text boxes
       handles.edit3.String = '';
       handles.edit4.String = '';
       handles.text10.String = 'No File Selected';
       
    else
        
        % Give warning if something goes wrong
        warn = 'Invalid Inputs!';
        warn = [warn newline 'All fields required: .mat file, display time, and title.'];
        warn = [warn newline 'File must exist and display time must be an even number without any special characters including spaces.'];
        warning(warn);
        
    end


% --- Executes on button press in pushbutton9.
% --- Create Montage Frame pushbutton
function pushbutton9_Callback(hObject, eventdata, handles)

    % Convert time window
    timeWindow = [str2double(handles.edit10.String), str2double(handles.edit11.String)];

    if checkCreateMontageFrame(handles.text18.String, ... 
                               timeWindow(1), ...
                               timeWindow(2), ...
                               handles.edit12.String)
    
        % Get data from user input
        file = handles.text18.String;
        name = handles.edit12.String;

        % Use the input to create montage frame
        handles.pushbutton9.String = 'Creating...';
        topo_montage(file, timeWindow, name);

        % Clear user input
        handles.text18.String = 'No File Selected';
        handles.edit10.String = '';
        handles.edit11.String = '';
        handles.edit12.String = '';
        handles.pushbutton9.String = 'Create';
        
    else
        
        % Give warning if something goes wrong
        warn = 'Invalid Inputs!';
        warn = [warn newline 'All fields required: a compiled .mat file, time window, and title without an extension.'];
        warn = [warn newline 'Compiled file must exist, time window must be even integers without any special characters including spaces.'];
        warning(warn);
        
    end


% --- Executes on button press in pushbutton10.
% --- Create Averaged Frame pushbutton
function pushbutton10_Callback(hObject, eventdata, handles)

    % Convert timewindow
    timeWindow = [str2double(handles.edit5.String), str2double(handles.edit6.String)];

    if checkCreateAveragedFrame(handles.text13.String, ...
                                handles.text14.String, ...
                                timeWindow(1), ...
                                timeWindow(2), ...
                                handles.edit7.String)

        % Extract data from file
        loadData = load(handles.text13.String);
        dataFieldnames = fieldnames(loadData);
        data = loadData.(dataFieldnames{1});

        % Extract chanlocs from file
        loadChanlocs = load(handles.text14.String);
        chanlocsFieldnames = fieldnames(loadChanlocs);
        chanlocs = loadChanlocs.(chanlocsFieldnames{1});

        name = handles.edit7.String;

        % Create the frame
        handles.pushbutton10.String = 'Creating...'; % display to user creating frame
        topo_average(data, chanlocs, timeWindow, name);

        % Reset values
        handles.text13.String = 'No File Selected';
        handles.text14.String = 'No File Selected';
        handles.edit5.String = '';
        handles.edit6.String = '';
        handles.edit7.String = '';
        
        % Reset pushbutton string
        handles.pushbutton10.String = 'Create';
        
    else
        
        % Give warning if something goes wrong
        warn = 'Invalid Inputs!';
        warn = [warn newline 'All fields required: a compiled .mat file, time window, and title without an extension.'];
        warn = [warn newline 'Files must exist, time window must be even integers without any special characters including spaces.'];
        warning(warn);
        
    end


% --- Executes on button press in pushbutton11.
% --- Select Data for Create Averaged Frame
function pushbutton11_Callback(hObject, eventdata, handles)

    % Open a window to get file
    dataFile = uigetfile;
    handles.text13.String = dataFile;


% --- Executes on button press in pushbutton12.
% --- Select Chanlocs for Create Averaged Frame
function pushbutton12_Callback(hObject, eventdata, handles)

    % Open a window to get file
    chanlocsFile = uigetfile;
    handles.text14.String = chanlocsFile;


function edit5_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
    
    % hObject    handle to edit5 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function edit6_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)

    % hObject    handle to edit6 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function edit7_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)

    % hObject    handle to edit7 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in pushbutton13.
% --- Select compiled file pushbutton
function pushbutton13_Callback(hObject, eventdata, handles)

    file = uigetfile;
    handles.text18.String = file;


function edit10_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)

    % hObject    handle to edit10 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function edit11_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)

    % hObject    handle to edit11 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function edit12_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)

    % hObject    handle to edit12 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in pushbutton14.
% --- Reset stage pushbutton
function pushbutton14_Callback(hObject, eventdata, handles)

    % Reset all handles that hold staging information
    handles.IFrameTimes = [];
    handles.IFrameTitles = {};
    handles.CFrameTimes = [];
    handles.CFrameTitles = {};
    handles.CFrameFiles = {};
    handles.text24.String = {};
    handles.text25.String = {};
    handles.text29.String = 'No File Selected';


% --- Executes on button press in pushbutton15.
% --- Pushbutton for get movie file
function pushbutton15_Callback(hObject, eventdata, handles)

    file = uigetfile;
    handles.text29.String = file;
