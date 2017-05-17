function varargout = lowvissimeditionparameterselection(varargin)
% LOWVISSIMEDITIONPARAMETERSELECTION MATLAB code for lowvissimeditionparameterselection.fig
%      LOWVISSIMEDITIONPARAMETERSELECTION, by itself, creates a new LOWVISSIMEDITIONPARAMETERSELECTION or raises the existing
%      singleton*.
%
%      H = LOWVISSIMEDITIONPARAMETERSELECTION returns the handle to a new LOWVISSIMEDITIONPARAMETERSELECTION or the handle to
%      the existing singleton*.
%
%      LOWVISSIMEDITIONPARAMETERSELECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOWVISSIMEDITIONPARAMETERSELECTION.M with the given input arguments.
%
%      LOWVISSIMEDITIONPARAMETERSELECTION('Property','Value',...) creates a new LOWVISSIMEDITIONPARAMETERSELECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lowvissimeditionparameterselection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lowvissimeditionparameterselection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lowvissimeditionparameterselection

% Last Modified by GUIDE v2.5 15-May-2017 20:41:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lowvissimeditionparameterselection_OpeningFcn, ...
                   'gui_OutputFcn',  @lowvissimeditionparameterselection_OutputFcn, ...
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


% --- Executes just before lowvissimeditionparameterselection is made visible.
function lowvissimeditionparameterselection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lowvissimeditionparameterselection (see VARARGIN)

% Choose default command line output for lowvissimeditionparameterselection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lowvissimeditionparameterselection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lowvissimeditionparameterselection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
 %自选参数标定
   global tag74540
   tag74540 = zeros(4,1);
    global tag99540
   tag99540 = zeros(11,1);

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
   global tag99540
   tag99540(1,1)=get(handles.checkbox5,'Value');

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
   global tag99540
   tag99540(2,1)=get(handles.checkbox6,'Value');

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
   global tag99540
   tag99540(3,1)=get(handles.checkbox7,'Value');

% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8
   global tag99540
   tag99540(4,1)=get(handles.checkbox8,'Value');

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9
   global tag99540
   tag99540(5,1)=get(handles.checkbox9,'Value');

% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10
   global tag99540
   tag99540(6,1)=get(handles.checkbox10,'Value');

% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11
   global tag99540
   tag99540(7,1)=get(handles.checkbox11,'Value');

% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12
   global tag99540
   tag99540(8,1)=get(handles.checkbox12,'Value');

% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13
   global tag99540
   tag99540(9,1)=get(handles.checkbox13,'Value');

% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14
   global tag99540
   tag99540(10,1)=get(handles.checkbox14,'Value');

% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox15
   global tag99540
   tag99540(11,1)=get(handles.checkbox15,'Value');

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
 %自选参数标定
   global tag74540
   tag74540(1,1)=get(handles.checkbox1,'Value');


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
   global tag74540
   tag74540(2,1)=get(handles.checkbox2,'Value');

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
   global tag74540
   tag74540(3,1)=get(handles.checkbox3,'Value');

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
   global tag74540
   tag74540(4,1)=get(handles.checkbox4,'Value');