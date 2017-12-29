function varargout = exercise3(varargin)
% EXERCISE3 MATLAB code for exercise3.fig
%      EXERCISE3, by itself, creates a new EXERCISE3 or raises the existing
%      singleton*.
%
%      H = EXERCISE3 returns the handle to a new EXERCISE3 or the handle to
%      the existing singleton*.
%
%      EXERCISE3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXERCISE3.M with the given input arguments.
%
%      EXERCISE3('Property','Value',...) creates a new EXERCISE3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exercise3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exercise3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exercise3

% Last Modified by GUIDE v2.5 09-Dec-2017 18:37:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exercise3_OpeningFcn, ...
                   'gui_OutputFcn',  @exercise3_OutputFcn, ...
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


% --- Executes just before exercise3 is made visible.
function exercise3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exercise3 (see VARARGIN)

plot3([0;-1],[0;0],[0;0],'Color',[0,0,1],'LineWidth',2);
hold on;
plot3([0;0],[0;-1],[0;0],'Color',[0,1,0],'LineWidth',2);
plot3([0;0],[0;0],[0;1],'Color',[1,0,0],'LineWidth',2);
hold off;

% Choose default command line output for exercise3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exercise3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = exercise3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function SetRotation_Callback(hObject, eventdata, handles)
% hObject    handle to SetRotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

u_1 = str2double(get(handles.u_1,'String'));
u_2 = str2double(get(handles.u_2,'String'));
u_3 = str2double(get(handles.u_3,'String'));

v_1 = str2double(get(handles.v_1,'String'));
v_2 = str2double(get(handles.v_2,'String'));
v_3 = str2double(get(handles.v_3,'String'));

angle = get(handles.SetRotation,'Value');
set(handles.angle_text,'String', angle);

q1 = [cosd(angle/2); sind(angle/2)*[u_1;u_2;u_3]];
qp = [0; v_1; v_2; v_3];

qf = quaternionproduct(quaternionproduct(q1,qp),[cosd(angle/2);sind(angle/2)*[-u_1;-u_2;-u_3]]);

plot3([0;-1],[0;0],[0;0],'Color',[0,0,1],'LineWidth',2);
hold on;
plot3([0;0],[0;-1],[0;0],'Color',[0,1,0],'LineWidth',2);
plot3([0;0],[0;0],[0;1],'Color',[1,0,0],'LineWidth',2);

plot3([qf(2);0],[qf(3);0],[qf(4);0],'Color',[1,1,0],'LineWidth',2);
hold off;



% --- Executes during object creation, after setting all properties.
function SetRotation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SetRotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function v_1_Callback(hObject, eventdata, handles)
% hObject    handle to v_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_1 as text
%        str2double(get(hObject,'String')) returns contents of v_1 as a double


% --- Executes during object creation, after setting all properties.
function v_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_2_Callback(hObject, eventdata, handles)
% hObject    handle to v_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_2 as text
%        str2double(get(hObject,'String')) returns contents of v_2 as a double


% --- Executes during object creation, after setting all properties.
function v_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_3_Callback(hObject, eventdata, handles)
% hObject    handle to v_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_3 as text
%        str2double(get(hObject,'String')) returns contents of v_3 as a double


% --- Executes during object creation, after setting all properties.
function v_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u_1_Callback(hObject, eventdata, handles)
% hObject    handle to u_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u_1 as text
%        str2double(get(hObject,'String')) returns contents of u_1 as a double


% --- Executes during object creation, after setting all properties.
function u_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u_2_Callback(hObject, eventdata, handles)
% hObject    handle to u_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u_2 as text
%        str2double(get(hObject,'String')) returns contents of u_2 as a double


% --- Executes during object creation, after setting all properties.
function u_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u_3_Callback(hObject, eventdata, handles)
% hObject    handle to u_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u_3 as text
%        str2double(get(hObject,'String')) returns contents of u_3 as a double


% --- Executes during object creation, after setting all properties.
function u_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
