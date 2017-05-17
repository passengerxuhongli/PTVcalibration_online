function varargout = VISSIMparameterscalibrationdirect(varargin)
% VISSIMPARAMETERSCALIBRATIONDIRECT MATLAB code for VISSIMparameterscalibrationdirect.fig
%      VISSIMPARAMETERSCALIBRATIONDIRECT, by itself, creates a new VISSIMPARAMETERSCALIBRATIONDIRECT or raises the existing
%      singleton*.
%
%      H = VISSIMPARAMETERSCALIBRATIONDIRECT returns the handle to a new VISSIMPARAMETERSCALIBRATIONDIRECT or the handle to
%      the existing singleton*.
%
%      VISSIMPARAMETERSCALIBRATIONDIRECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISSIMPARAMETERSCALIBRATIONDIRECT.M with the given input arguments.
%
%      VISSIMPARAMETERSCALIBRATIONDIRECT('Property','Value',...) creates a new VISSIMPARAMETERSCALIBRATIONDIRECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VISSIMparameterscalibrationdirect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VISSIMparameterscalibrationdirect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VISSIMparameterscalibrationdirect

% Last Modified by GUIDE v2.5 16-May-2017 13:25:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VISSIMparameterscalibrationdirect_OpeningFcn, ...
                   'gui_OutputFcn',  @VISSIMparameterscalibrationdirect_OutputFcn, ...
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


% --- Executes just before VISSIMparameterscalibrationdirect is made visible.
function VISSIMparameterscalibrationdirect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VISSIMparameterscalibrationdirect (see VARARGIN)

% Choose default command line output for VISSIMparameterscalibrationdirect
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VISSIMparameterscalibrationdirect wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VISSIMparameterscalibrationdirect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global paracalibtag
 paracalibtag = zeros(1,3);%初始化三类许标定的参数，“~0”表示考虑；“0”表示用户不考虑
 global TARGET
    global TRAVELTIME
    TRAVELTIME=0;
    global DELAY
    DELAY=0;
    global QUEUEMAX
    QUEUEMAX=0;
    global QUEUEMEAN 
    QUEUEMEAN=0;   %“0”表示不考虑，“~0”表示考虑，获取相应的收敛值
    global CAPACITY 
    CAPACITY = 0;
 TARGET = zeros(5,1);%初始化五种优化指标相应的取值：

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
% global paracalibtag
set(handles.checkbox1,'value',1);

% paracalibtag(1,3)=get(handles.checkbox1,'Value');

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
    global TRAVELTIME 
TRAVELTIME=get(handles.checkbox2,'Value');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
 global TARGET
TARGET(1,1)=str2double(get(handles.edit1,'String'));

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


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
     global DELAY
DELAY=get(handles.checkbox3,'Value');


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

 global TARGET
TARGET(2,1)=str2double(get(handles.edit2,'String'));

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


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

     global QUEUEMAX
QUEUEMAX=get(handles.checkbox4,'Value');


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global TARGET
TARGET(3,1)=str2double(get(handles.edit3,'String'));

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


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
        global QUEUEMEAN 
QUEUEMEAN=get(handles.checkbox5,'Value');


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
 global TARGET

TARGET(4,1)=str2double(get(handles.edit4,'String'));

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



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('最终的参数取值')
 a = importdata('drivingparameters_final.mat')
 try
 sprintf('=================vissim parameters %3.0f =================\nW74ax=%2.2f, W74bxAdd=%2.2f,W74bxMult = %2.2f, LookBackDistMax =%2.2f, CC5=%2.2f\n minD=%2.2f, safe=%2.2f, maxCD = %2.2f, maxSD =%2.2f, lcDist = %2.2f\n\nSimulating...\n',...
       a(1),a(2),a(3),a(4),a(5),a(6),a(7),a(8),a(9));
 catch try
 sprintf('=================vissim parameters %3.0f =================\nW74ax=%2.2f, W74bxAdd=%2.2f,W74bxMult = %2.2f, LookBackDistMax =%2.2f\n\nSimulating...\n',...
       a(1),a(2),a(3),a(4));
     catch try
 sprintf('=================vissim parameters %3.0f =================\nCC0=%2.2f, CC1=%2.2f, CC2 = %2.2f, CC4 =%2.2f, CC5=%2.2f\n\nSimulating...\n',...
       a(1),a(2),a(3),-a(4),a(4));  
         catch try
             sprintf('=================vissim parameters %3.0f =================\nAXADD=%2.2f, BXADD=%2.2f,BXMULT = %2.2f, LANECHANGEDISTANCE = %2.2f\n\nSimulating...\n',...
                   a(1),a(2),a(3),a(4));
             catch try
                   sprintf('=================vissim parameters %3.0f =================\nAXADD=%2.2f, BXADD=%2.2f,BXMULT = %2.2f...\n',...
                   a(1),a(2),a(3));
                 catch try
             sprintf('=================vissim parameters %3.0f =================\nCC0=%2.2f, CC1=%2.2f, CC2 = %2.2f, CC4 =%2.2f,CC5=%2.2f,LANECHANGEDISTANCE = %2.2f\n\nSimulating...\n',...
                   a(1),a(2),a(3),-a(4),a(4),a(5));
                     catch try
             sprintf('=================vissim parameters %3.0f =================\nCC0=%2.2f, CC1=%2.2f, CC2 = %2.2f, CC4 =%2.2f, CC5=%2.2f\n\nSimulating...\n',...
                   a(1),a(2),a(3),-a(4),a(4));  
                         end
                     end
                 end
             end
         end
     end
 end
    global evaluationMin
disp('最终的仿真误差')    
    evaluationMin
disp('标定算法GA的评价指标')      
 FVAL = importdata('ga_evaluation_fval.mat')  
disp('标定算法GA的停止的原因') 
 EXITFLAG = importdata('ga_stopped_reason.mat')  



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



% --- Executes during object deletion, before destroying properties.
function text2_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
        global CAPACITY 
CAPACITY=get(handles.checkbox6,'Value');


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
 global TARGET
TARGET(5,1)=str2double(get(handles.edit5,'String'));

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




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paracalibtag
global TARGET
if get(handles.radiobutton1,'value')
  paracalibtag(1,1)=1;
elseif get(handles.radiobutton2,'value')
  paracalibtag(1,2)=1;
end
if get(handles.checkbox1,'value')
  paracalibtag(1,3)=1;
end
save('paracalibtag.mat','paracalibtag')
save('TARGET.mat','TARGET')
gaCalibration_main_direct
