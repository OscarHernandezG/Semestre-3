function varargout = exercise2(varargin)
% EXERCISE2 MATLAB code for exercise2.fig
%      EXERCISE2, by itself, creates a new EXERCISE2 or raises the existing
%      singleton*.
%
%      H = EXERCISE2 returns the handle to a new EXERCISE2 or the handle to
%      the existing singleton*.
%
%      EXERCISE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXERCISE2.M with the given input arguments.
%
%      EXERCISE2('Property','Value',...) creates a new EXERCISE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exercise2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exercise2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exercise2

% Last Modified by GUIDE v2.5 09-Dec-2017 18:01:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exercise2_OpeningFcn, ...
                   'gui_OutputFcn',  @exercise2_OutputFcn, ...
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


% --- Executes just before exercise2 is made visible.
function exercise2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exercise2 (see VARARGIN)


% Choose default command line output for exercise2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exercise2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = exercise2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function x_0_u_Callback(hObject, eventdata, handles)
% hObject    handle to x_0_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_0_u as text
%        str2double(get(hObject,'String')) returns contents of x_0_u as a double


% --- Executes during object creation, after setting all properties.
function x_0_u_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_0_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_0_u_Callback(hObject, eventdata, handles)
% hObject    handle to y_0_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_0_u as text
%        str2double(get(hObject,'String')) returns contents of y_0_u as a double


% --- Executes during object creation, after setting all properties.
function y_0_u_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_0_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function velocity_Callback(hObject, eventdata, handles)
% hObject    handle to velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.velocity_text,'String', get(hObject,'Value'))

% --- Executes during object creation, after setting all properties.
function velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angle_Callback(hObject, eventdata, handles)
% hObject    handle to angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.angle_text,'String', get(hObject,'Value'))

% --- Executes during object creation, after setting all properties.
function angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in calc.
function calc_Callback(hObject, eventdata, handles)
% hObject    handle to calc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = 149;
x0 = str2double(get(handles.x_0_u,'String'));
y0 = str2double(get(handles.y_0_u,'String'));
v0 =  get(handles.velocity,'Value');
angle = get(handles.angle,'Value');
angle = degtorad(angle);
x = zeros(s);
y = zeros(s);
g = 9.81;

%info

t_max = 2 * (v0 * sin(angle))/g;
range = x0+t_max*(v0 * cos(angle));


t = 0:t_max/100:(t_max);
x = x0+t*(v0 * cos(angle));
y = y0 + (t * (v0 * sin(angle))) - (g*t.^2)/2;

plot(x,y);

set(handles.max_range,'String', range);

max_height = (((v0 * sin(angle))^2/2*g)/100) + x0;
set(handles.max_height,'String', max_height);
