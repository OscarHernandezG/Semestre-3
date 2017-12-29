function varargout = exercise1(varargin)
% EXERCISE1 MATLAB code for exercise1.fig
%      EXERCISE1, by itself, creates a new EXERCISE1 or raises the existing
%      singleton*.
%
%      H = EXERCISE1 returns the handle to a new EXERCISE1 or the handle to
%      the existing singleton*.
%
%      EXERCISE1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXERCISE1.M with the given input arguments.
%
%      EXERCISE1('Property','Value',...) creates a new EXERCISE1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exercise1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exercise1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exercise1

% Last Modified by GUIDE v2.5 09-Dec-2017 15:59:22

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exercise1_OpeningFcn, ...
                   'gui_OutputFcn',  @exercise1_OutputFcn, ...
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


% --- Executes just before exercise1 is made visible.
function exercise1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exercise1 (see VARARGIN)

% Choose default command line output for exercise1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exercise1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = exercise1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function q_a0_Callback(hObject, eventdata, handles)
% hObject    handle to q_a0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: gte(hObject,'String') returns contents of q_a0 as text
%        str2double(get(hObject,'String')) returns contents of q_a0 as a double



% --- Executes during object creation, after setting all properties.
function q_a0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_a0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_a1_Callback(hObject, eventdata, handles)
% hObject    handle to q_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_a1 as text
%        str2double(get(hObject,'String')) returns contents of q_a1 as a double


% --- Executes during object creation, after setting all properties.
function q_a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_a3_Callback(hObject, eventdata, handles)
% hObject    handle to q_a3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_a3 as text
%        str2double(get(hObject,'String')) returns contents of q_a3 as a double


% --- Executes during object creation, after setting all properties.
function q_a3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_a3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_a2_Callback(hObject, eventdata, handles)
% hObject    handle to q_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_a2 as text
%        str2double(get(hObject,'String')) returns contents of q_a2 as a double



% --- Executes during object creation, after setting all properties.
function q_a2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_b0_Callback(hObject, eventdata, handles)
% hObject    handle to q_b0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_b0 as text
%        str2double(get(hObject,'String')) returns contents of q_b0 as a double


% --- Executes during object creation, after setting all properties.
function q_b0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_b0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_b1_Callback(hObject, eventdata, handles)
% hObject    handle to q_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_b1 as text
%        str2double(get(hObject,'String')) returns contents of q_b1 as a double


% --- Executes during object creation, after setting all properties.
function q_b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_b3_Callback(hObject, eventdata, handles)
% hObject    handle to q_b3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_b3 as text
%        str2double(get(hObject,'String')) returns contents of q_b3 as a double


% --- Executes during object creation, after setting all properties.
function q_b3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_b3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_b2_Callback(hObject, eventdata, handles)
% hObject    handle to q_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_b2 as text
%        str2double(get(hObject,'String')) returns contents of q_b2 as a double


% --- Executes during object creation, after setting all properties.
function q_b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_c0_Callback(hObject, eventdata, handles)
% hObject    handle to q_c0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_c0 as text
%        str2double(get(hObject,'String')) returns contents of q_c0 as a double


% --- Executes during object creation, after setting all properties.
function q_c0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_c0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_c1_Callback(hObject, eventdata, handles)
% hObject    handle to q_c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_c1 as text
%        str2double(get(hObject,'String')) returns contents of q_c1 as a double


% --- Executes during object creation, after setting all properties.
function q_c1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_c3_Callback(hObject, eventdata, handles)
% hObject    handle to q_c3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_c3 as text
%        str2double(get(hObject,'String')) returns contents of q_c3 as a double


% --- Executes during object creation, after setting all properties.
function q_c3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_c3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_c2_Callback(hObject, eventdata, handles)
% hObject    handle to q_c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_c2 as text
%        str2double(get(hObject,'String')) returns contents of q_c2 as a double


% --- Executes during object creation, after setting all properties.
function q_c2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


q_a0 = str2double(get(handles.q_a0,'String'))
q_a1 = str2double(get(handles.q_a1,'String'))
q_a2 = str2double(get(handles.q_a2,'String'))
q_a3 = str2double(get(handles.q_a3,'String'))

q_b0 = str2double(get(handles.q_b0,'String'))
q_b1 = str2double(get(handles.q_b1,'String'))
q_b2 = str2double(get(handles.q_b2,'String'))
q_b3 = str2double(get(handles.q_b3,'String'))

q_c = quaternionproduct([q_a0;q_a1;q_a2;q_a3],[q_b0;q_b1;q_b2;q_b3])

set(handles.q_c0,'String', q_c(1,1))
set(handles.q_c1,'String', q_c(2,1))
set(handles.q_c2,'String', q_c(3,1))
set(handles.q_c3,'String', q_c(4,1))

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over q_c0.
function q_c0_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to q_c0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
