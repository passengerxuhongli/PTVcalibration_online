function varargout = VISSIMparametersselection(varargin)
%VISSIMPARAMETERSSELECTION MATLAB code file for VISSIMparametersselection.fig
%      VISSIMPARAMETERSSELECTION, by itself, creates a new VISSIMPARAMETERSSELECTION or raises the existing
%      singleton*.
%
%      H = VISSIMPARAMETERSSELECTION returns the handle to a new VISSIMPARAMETERSSELECTION or the handle to
%      the existing singleton*.
%
%      VISSIMPARAMETERSSELECTION('Property','Value',...) creates a new VISSIMPARAMETERSSELECTION using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to VISSIMparametersselection_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      VISSIMPARAMETERSSELECTION('CALLBACK') and VISSIMPARAMETERSSELECTION('CALLBACK',hObject,...) call the
%      local function named CALLBACK in VISSIMPARAMETERSSELECTION.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VISSIMparametersselection

% Last Modified by GUIDE v2.5 12-Feb-2017 17:45:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VISSIMparametersselection_OpeningFcn, ...
                   'gui_OutputFcn',  @VISSIMparametersselection_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before VISSIMparametersselection is made visible.
function VISSIMparametersselection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for VISSIMparametersselection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VISSIMparametersselection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VISSIMparametersselection_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global paraselectag
 paraselectag = zeros(1,3);%初始化三类许标定的参数，“~0”表示考虑；“0”表示用户不考虑



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',1);

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
set(handles.checkbox1,'value',1);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paraselectag
if get(handles.radiobutton1,'value')
  paraselectag(1,1)=1;
elseif get(handles.radiobutton2,'value')
  paraselectag(1,2)=1;
end
if get(handles.checkbox1,'value')
  paraselectag(1,3)=1;
end
save('paraselectag.mat','paraselectag')
sensitivityanalysis

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
