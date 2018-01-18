function varargout = trackBall(varargin)
% TRACKBALL MATLAB code for trackBall.fig
%      TRACKBALL, by itself, creates a new TRACKBALL or raises the existing
%      singleton*.
%
%      H = TRACKBALL returns the handle to a new TRACKBALL or the handle to
%      the existing singleton*.
%
%      TRACKBALL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKBALL.M with the given input arguments.
%
%      TRACKBALL('Property','Value',...) creates a new TRACKBALL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trackBall_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trackBall_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trackBall

% Last Modified by GUIDE v2.5 07-Jan-2018 17:02:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trackBall_OpeningFcn, ...
                   'gui_OutputFcn',  @trackBall_OutputFcn, ...
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


% --- Executes just before trackBall is made visible.
function trackBall_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trackBall (see VARARGIN)


handles.prevPoint = [0;0;0];
handles.quaternion = [0;0;0;0];
handles.Rotation = [1 0 0 ; 0 1 0 ; 0 0 1];

set(hObject,'WindowButtonDownFcn',{@my_MouseClickFcn,handles.axes1});
set(hObject,'WindowButtonUpFcn',{@my_MouseReleaseFcn,handles.axes1});
axes(handles.axes1);

handles.Cube=DrawCube(eye(3));

set(handles.axes1,'CameraPosition',...
    [0 0 5],'CameraTarget',...
    [0 0 -5],'CameraUpVector',...
    [0 1 0],'DataAspectRatio',...
    [1 1 1]);

set(handles.axes1,'xlim',[-3 3],'ylim',[-3 3],'visible','off','color','none');

% Choose default command line output for trackBall
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trackBall wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trackBall_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function my_MouseClickFcn(obj,event,hObject)

handles=guidata(obj);
xlim = get(handles.axes1,'xlim');
ylim = get(handles.axes1,'ylim');
mousepos=get(handles.axes1,'CurrentPoint');
xmouse = mousepos(1,1);
ymouse = mousepos(1,2);

if xmouse > xlim(1) && xmouse < xlim(2) && ymouse > ylim(1) && ymouse < ylim(2)

    set(handles.figure1,'WindowButtonMotionFcn',{@my_MouseMoveFcn,hObject});
end
guidata(hObject,handles)

function my_MouseReleaseFcn(obj,event,hObject)
handles=guidata(hObject);
set(handles.figure1,'WindowButtonMotionFcn','');
handles.prevPoint = [0;0;0]; 
guidata(hObject,handles);

function my_MouseMoveFcn(obj,event,hObject)

handles=guidata(obj);
xlim = get(handles.axes1,'xlim');
ylim = get(handles.axes1,'ylim');
mousepos=get(handles.axes1,'CurrentPoint');
xmouse = mousepos(1,1);
ymouse = mousepos(1,2);

% es la longitud del cub
cube_longitude= 2;
% dividim per 2 ja que nosaltres volem el radi
radi = sqrt(3)*cube_longitude / 2;
% així podem extreure la Z, i el punt de la superficie de la esfera
MousePoint = Calculate3Dpoint(xmouse, ymouse, radi);


copylast = handles.prevPoint;
if(norm(copylast)~= 0) 
% Quaternion
angle = acos((copylast'*MousePoint)/(norm(copylast)*norm(MousePoint)));
quaternion = [cos(angle/2);sin(angle/2)* (cross(copylast, MousePoint)/norm(cross(copylast, MousePoint)))];
quaternion = quaternion/norm(quaternion);

if (norm(handles.quaternion) ~= 0)
quaternion = quaternionproduct(quaternion, handles.quaternion);
end

handles.quaternion = quaternion;   
Rotation = Quat2RotMat(quaternion);

% Això es la matriu de mostra que no es modificable
set(handles.RotationMatrix1x1,'String',sprintf('%.3f',Rotation(1,1)));
set(handles.RotationMatrix1x2,'String',sprintf('%.3f',Rotation(1,2)));
set(handles.RotationMatrix1x3,'String',sprintf('%.3f',Rotation(1,3)));
set(handles.RotationMatrix2x1,'String',sprintf('%.3f',Rotation(2,1)));
set(handles.RotationMatrix2x2,'String',sprintf('%.3f',Rotation(2,2)));
set(handles.RotationMatrix2x3,'String',sprintf('%.3f',Rotation(2,3)));
set(handles.RotationMatrix3x1,'String',sprintf('%.3f',Rotation(3,1)));
set(handles.RotationMatrix3x2,'String',sprintf('%.3f',Rotation(3,2)));
set(handles.RotationMatrix3x3,'String',sprintf('%.3f',Rotation(3,3)));


% Això és el quaternion per rotar
set(handles.q0,'String',sprintf('%.3f',quaternion(1)));
set(handles.q1,'String',sprintf('%.3f',quaternion(2)));
set(handles.q2,'String',sprintf('%.3f',quaternion(3)));
set(handles.q3,'String',sprintf('%.3f',quaternion(4)));

% Euler angle & axis
[u,angle] = rotMat2Eaa(Rotation);
set(handles.xEAA,'String',sprintf('%.3f', u(1)));
set(handles.yEAA,'String',sprintf('%.3f', u(2)));
set(handles.zEAA,'String',sprintf('%.3f', u(3)));
set(handles.angleEAA,'String',sprintf('%.3f', rad2deg(angle)));

% Euler angle
[alpha, beta, gamma] = rotM2eAngles(Rotation);
set(handles.alphaEA,'String',sprintf('%.3f', rad2deg(alpha)));
set(handles.betaEA,'String',sprintf('%.3f', rad2deg(beta)));
set(handles.gammaEA,'String',sprintf('%.3f', rad2deg(gamma)));

% Vector de Rotacio
r = u*angle;
set(handles.vec1,'String',sprintf('%.3f', r(1)));
set(handles.vec2,'String',sprintf('%.3f', r(2)));
set(handles.vec3,'String',sprintf('%.3f', r(3)));

[handles.Cube] = RedrawCube(Rotation,handles.Cube);

handles.Rotation = Rotation;
end

handles.prevPoint = MousePoint;
guidata(hObject,handles);

 handles.Cube = RedrawCube(handles.Rotation,handles.Cube);

guidata(hObject,handles);

function h = DrawCube(Rotation)

M0 = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]; %Node 8

M = (Rotation*M0')';


x = M(:,1);
y = M(:,2);
z = M(:,3);


con = [1 2 3 4;
    5 6 7 8;
    4 3 7 8;
    1 2 6 5;
    1 4 8 5;
    2 3 7 6]';

x = reshape(x(con(:)),[4,6]);
y = reshape(y(con(:)),[4,6]);
z = reshape(z(con(:)),[4,6]);

c = 1/255*[255 248 88;
    0 0 0;
    57 183 225;
    57 183 0;
    255 178 0;
    255 0 0];

h = fill3(x,y,z, 1:6);

for q = 1:length(c)
    h(q).FaceColor = c(q,:);
end

function h = RedrawCube(Rotation,hin)

h = hin;
c = 1/255*[255 248 88;
    0 0 0;
    57 183 225;
    57 183 0;
    255 178 0;
    255 0 0];

M0 = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]; %Node 8

M = (Rotation*M0')';


x = M(:,1);
y = M(:,2);
z = M(:,3);


con = [1 2 3 4;
    5 6 7 8;
    4 3 7 8;
    1 2 6 5;
    1 4 8 5;
    2 3 7 6]';

x = reshape(x(con(:)),[4,6]);
y = reshape(y(con(:)),[4,6]);
z = reshape(z(con(:)),[4,6]);

for q = 1:6
    h(q).Vertices = [x(:,q) y(:,q) z(:,q)];
    h(q).FaceColor = c(q,:);
end


function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.prevPoint = [0;0;0];
handles.quaternion = [0;0;0;0];
handles.Rotation = [0 0 0 ; 0 0 0 ; 0 0 0];
Rotation = handles.Rotation;

set(handles.RotationMatrix1x1,'String',sprintf('%.3f',Rotation(1,1)));
set(handles.RotationMatrix1x2,'String',sprintf('%.3f',Rotation(1,2)));
set(handles.RotationMatrix1x3,'String',sprintf('%.3f',Rotation(1,3)));
set(handles.RotationMatrix2x1,'String',sprintf('%.3f',Rotation(2,1)));
set(handles.RotationMatrix2x2,'String',sprintf('%.3f',Rotation(2,2)));
set(handles.RotationMatrix2x3,'String',sprintf('%.3f',Rotation(2,3)));
set(handles.RotationMatrix3x1,'String',sprintf('%.3f',Rotation(3,1)));
set(handles.RotationMatrix3x2,'String',sprintf('%.3f',Rotation(3,2)));
set(handles.RotationMatrix3x3,'String',sprintf('%.3f',Rotation(3,3)));

set(handles.q0,'String',sprintf('%.3f',0));
set(handles.q1,'String',sprintf('%.3f',0));
set(handles.q2,'String',sprintf('%.3f',0));
set(handles.q3,'String',sprintf('%.3f',0));

set(handles.xEAA,'String',sprintf('%.3f', 0));
set(handles.yEAA,'String',sprintf('%.3f', 0));
set(handles.zEAA,'String',sprintf('%.3f', 0));

set(handles.angleEAA,'String',sprintf('%.3f', 0));
set(handles.alphaEA,'String',sprintf('%.3f', 0));
set(handles.betaEA,'String',sprintf('%.3f', 0));
set(handles.gammaEA,'String',sprintf('%.3f', 0));

set(handles.vec1,'String',sprintf('%.3f', 0));
set(handles.vec2,'String',sprintf('%.3f', 0));
set(handles.vec3,'String',sprintf('%.3f', 0));

handles.Rotation = [1 0 0 ; 0 1 0 ; 0 0 1];
handles.Cube = RedrawCube(handles.Rotation,handles.Cube);

function vec1_Callback(hObject, eventdata, handles)
% hObject    handle to vec1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vec1 as text
%        str2double(get(hObject,'String')) returns contents of vec1 as a double


% --- Executes during object creation, after setting all properties.
function vec1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vec1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vec2_Callback(hObject, eventdata, handles)
% hObject    handle to vec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vec2 as text
%        str2double(get(hObject,'String')) returns contents of vec2 as a double


% --- Executes during object creation, after setting all properties.
function vec2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vec3_Callback(hObject, eventdata, handles)
% hObject    handle to vec3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vec3 as text
%        str2double(get(hObject,'String')) returns contents of vec3 as a double


% --- Executes during object creation, after setting all properties.
function vec3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vec3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rotVecButton.
function rotVecButton_Callback(hObject, eventdata, handles)
% hObject    handle to rotVecButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = str2double(get(handles.vec1,'String'));
y = str2double(get(handles.vec2,'String'));
z = str2double(get(handles.vec3,'String'));

Rot = [ x; y; z ];

if ( norm(Rot) ~= 0)
alpha = norm(Rot);
u = Rot/alpha;

Rotation = Eaa2rotMat(u,alpha);
[handles.Cube] = RedrawCube(Rotation,handles.Cube);

% Això es la matriu de mostra que no es modificable
set(handles.RotationMatrix1x1,'String',sprintf('%.3f',Rotation(1,1)));
set(handles.RotationMatrix1x2,'String',sprintf('%.3f',Rotation(1,2)));
set(handles.RotationMatrix1x3,'String',sprintf('%.3f',Rotation(1,3)));
set(handles.RotationMatrix2x1,'String',sprintf('%.3f',Rotation(2,1)));
set(handles.RotationMatrix2x2,'String',sprintf('%.3f',Rotation(2,2)));
set(handles.RotationMatrix2x3,'String',sprintf('%.3f',Rotation(2,3)));
set(handles.RotationMatrix3x1,'String',sprintf('%.3f',Rotation(3,1)));
set(handles.RotationMatrix3x2,'String',sprintf('%.3f',Rotation(3,2)));
set(handles.RotationMatrix3x3,'String',sprintf('%.3f',Rotation(3,3)));

quaternion = Eaa2Quat(alpha,u);
handles.quaternion = quaternion;
% Això és el quaternion per rotar
set(handles.q0,'String',sprintf('%.3f',quaternion(1)));
set(handles.q1,'String',sprintf('%.3f',quaternion(2)));
set(handles.q2,'String',sprintf('%.3f',quaternion(3)));
set(handles.q3,'String',sprintf('%.3f',quaternion(4)));

% Euler angle & axis
[u,angle] = rotMat2Eaa(Rotation);
set(handles.xEAA,'String',sprintf('%.3f', u(1)));
set(handles.yEAA,'String',sprintf('%.3f', u(2)));
set(handles.zEAA,'String',sprintf('%.3f', u(3)));
set(handles.angleEAA,'String',sprintf('%.3f', rad2deg(angle)));

% Euler angle
[alpha, beta, gamma] = rotM2eAngles(Rotation);
set(handles.alphaEA,'String',sprintf('%.3f', rad2deg(alpha)));
set(handles.betaEA,'String',sprintf('%.3f', rad2deg(beta)));
set(handles.gammaEA,'String',sprintf('%.3f', rad2deg(gamma)));

% Vector de Rotacio
r = u*angle;
set(handles.vec1,'String',sprintf('%.3f', r(1)));
set(handles.vec2,'String',sprintf('%.3f', r(2)));
set(handles.vec3,'String',sprintf('%.3f', r(3)));

end


function alphaEA_Callback(hObject, eventdata, handles)
% hObject    handle to alphaEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaEA as text
%        str2double(get(hObject,'String')) returns contents of alphaEA as a double


% --- Executes during object creation, after setting all properties.
function alphaEA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function betaEA_Callback(hObject, eventdata, handles)
% hObject    handle to betaEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of betaEA as text
%        str2double(get(hObject,'String')) returns contents of betaEA as a double


% --- Executes during object creation, after setting all properties.
function betaEA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betaEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gammaEA_Callback(hObject, eventdata, handles)
% hObject    handle to gammaEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gammaEA as text
%        str2double(get(hObject,'String')) returns contents of gammaEA as a double


% --- Executes during object creation, after setting all properties.
function gammaEA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gammaEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EulerAngle_Button.
function EulerAngle_Button_Callback(hObject, eventdata, handles)
% hObject    handle to EulerAngle_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

alpha = str2double(get(handles.alphaEA,'String'));
alpha = deg2rad(alpha);
beta = str2double(get(handles.betaEA,'String'));
beta = deg2rad(beta);
gamma = str2double(get(handles.gammaEA,'String'));
gamma = deg2rad(gamma);

Rotation = eAngles2rotM(alpha, beta, gamma);
[handles.Cube] = RedrawCube(Rotation,handles.Cube);

% Això es la matriu de mostra que no es modificable
set(handles.RotationMatrix1x1,'String',sprintf('%.3f',Rotation(1,1)));
set(handles.RotationMatrix1x2,'String',sprintf('%.3f',Rotation(1,2)));
set(handles.RotationMatrix1x3,'String',sprintf('%.3f',Rotation(1,3)));
set(handles.RotationMatrix2x1,'String',sprintf('%.3f',Rotation(2,1)));
set(handles.RotationMatrix2x2,'String',sprintf('%.3f',Rotation(2,2)));
set(handles.RotationMatrix2x3,'String',sprintf('%.3f',Rotation(2,3)));
set(handles.RotationMatrix3x1,'String',sprintf('%.3f',Rotation(3,1)));
set(handles.RotationMatrix3x2,'String',sprintf('%.3f',Rotation(3,2)));
set(handles.RotationMatrix3x3,'String',sprintf('%.3f',Rotation(3,3)));

quaternion = rotMat2Quat(Rotation);
handles.quaternion = quaternion;
% Això és el quaternion per rotar
set(handles.q0,'String',sprintf('%.3f',quaternion(1)));
set(handles.q1,'String',sprintf('%.3f',quaternion(2)));
set(handles.q2,'String',sprintf('%.3f',quaternion(3)));
set(handles.q3,'String',sprintf('%.3f',quaternion(4)));

% Euler angle & axis
[u,angle] = rotMat2Eaa(Rotation);
set(handles.xEAA,'String',sprintf('%.3f', u(1)));
set(handles.yEAA,'String',sprintf('%.3f', u(2)));
set(handles.zEAA,'String',sprintf('%.3f', u(3)));
set(handles.angleEAA,'String',sprintf('%.3f', rad2deg(angle)));

% Euler angle
[alpha, beta, gamma] = rotM2eAngles(Rotation);
set(handles.alphaEA,'String',sprintf('%.3f', rad2deg(alpha)));
set(handles.betaEA,'String',sprintf('%.3f', rad2deg(beta)));
set(handles.gammaEA,'String',sprintf('%.3f', rad2deg(gamma)));

% Vector de Rotacio
r = u*angle;
set(handles.vec1,'String',sprintf('%.3f', r(1)));
set(handles.vec2,'String',sprintf('%.3f', r(2)));
set(handles.vec3,'String',sprintf('%.3f', r(3)));




function angleEAA_Callback(hObject, eventdata, handles)
% hObject    handle to angleEAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angleEAA as text
%        str2double(get(hObject,'String')) returns contents of angleEAA as a double


% --- Executes during object creation, after setting all properties.
function angleEAA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angleEAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xEAA_Callback(hObject, eventdata, handles)
% hObject    handle to xEAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xEAA as text
%        str2double(get(hObject,'String')) returns contents of xEAA as a double


% --- Executes during object creation, after setting all properties.
function xEAA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xEAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yEAA_Callback(hObject, eventdata, handles)
% hObject    handle to yEAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yEAA as text
%        str2double(get(hObject,'String')) returns contents of yEAA as a double


% --- Executes during object creation, after setting all properties.
function yEAA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yEAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zEAA_Callback(hObject, eventdata, handles)
% hObject    handle to zEAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zEAA as text
%        str2double(get(hObject,'String')) returns contents of zEAA as a double


% --- Executes during object creation, after setting all properties.
function zEAA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zEAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EulerAngleAxis_Button.
function EulerAngleAxis_Button_Callback(hObject, eventdata, handles)
% hObject    handle to EulerAngleAxis_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.xEAA,'String'));
y = str2double(get(handles.yEAA,'String'));
z = str2double(get(handles.zEAA,'String'));
vec = [x,y,z]';

alpha = str2double(get(handles.angleEAA,'String'));
alpha = deg2rad(alpha);

if(norm(vec) ~= 0);
   
    Rotation = Eaa2rotMat(vec, alpha);
    
    % Això es la matriu de mostra que no es modificable
    set(handles.RotationMatrix1x1,'String',sprintf('%.3f',Rotation(1,1)));
    set(handles.RotationMatrix1x2,'String',sprintf('%.3f',Rotation(1,2)));
    set(handles.RotationMatrix1x3,'String',sprintf('%.3f',Rotation(1,3)));
    set(handles.RotationMatrix2x1,'String',sprintf('%.3f',Rotation(2,1)));
    set(handles.RotationMatrix2x2,'String',sprintf('%.3f',Rotation(2,2)));
    set(handles.RotationMatrix2x3,'String',sprintf('%.3f',Rotation(2,3)));
    set(handles.RotationMatrix3x1,'String',sprintf('%.3f',Rotation(3,1)));
    set(handles.RotationMatrix3x2,'String',sprintf('%.3f',Rotation(3,2)));
    set(handles.RotationMatrix3x3,'String',sprintf('%.3f',Rotation(3,3)));

    quaternion = Eaa2Quat(alpha,vec);
    % Això és el quaternion per rotar
    set(handles.q0,'String',sprintf('%.3f',quaternion(1)));
    set(handles.q1,'String',sprintf('%.3f',quaternion(2)));
    set(handles.q2,'String',sprintf('%.3f',quaternion(3)));
    set(handles.q3,'String',sprintf('%.3f',quaternion(4)));

    % Euler angle & axis
    [u,angle] = rotMat2Eaa(Rotation);
    set(handles.xEAA,'String',sprintf('%.3f', u(1)));
    set(handles.yEAA,'String',sprintf('%.3f', u(2)));
    set(handles.zEAA,'String',sprintf('%.3f', u(3)));
    set(handles.angleEAA,'String',sprintf('%.3f', rad2deg(angle)));

    % Euler angle
    [alpha, beta, gamma] = rotM2eAngles(Rotation);
    set(handles.alphaEA,'String',sprintf('%.3f', rad2deg(alpha)));
    set(handles.betaEA,'String',sprintf('%.3f', rad2deg(beta)));
    set(handles.gammaEA,'String',sprintf('%.3f', rad2deg(gamma)));

    % Vector de Rotacio
    r = u*angle;
    set(handles.vec1,'String',sprintf('%.3f', r(1)));
    set(handles.vec2,'String',sprintf('%.3f', r(2)));
    set(handles.vec3,'String',sprintf('%.3f', r(3)));

    [handles.Cube] = RedrawCube(Rotation,handles.Cube);

    
end

function q0_Callback(hObject, eventdata, handles)
% hObject    handle to q0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q0 as text
%        str2double(get(hObject,'String')) returns contents of q0 as a double


% --- Executes during object creation, after setting all properties.
function q0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q1_Callback(hObject, eventdata, handles)
% hObject    handle to q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q1 as text
%        str2double(get(hObject,'String')) returns contents of q1 as a double


% --- Executes during object creation, after setting all properties.
function q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q2_Callback(hObject, eventdata, handles)
% hObject    handle to q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q2 as text
%        str2double(get(hObject,'String')) returns contents of q2 as a double


% --- Executes during object creation, after setting all properties.
function q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q3_Callback(hObject, eventdata, handles)
% hObject    handle to q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q3 as text
%        str2double(get(hObject,'String')) returns contents of q3 as a double


% --- Executes during object creation, after setting all properties.
function q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Quaternion_Button.
function Quaternion_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Quaternion_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q0 = str2double(get(handles.q0,'String'));
q1 = str2double(get(handles.q1,'String'));
q2 = str2double(get(handles.q2,'String'));
q3 = str2double(get(handles.q3,'String'));

quat = [q0; q1; q2; q3];

if norm(quat(2:4)) ~= 0
quat = quat/norm(quat);


    Rotation = Quat2RotMat(quat);
    
    % Això es la matriu de mostra que no es modificable
    set(handles.RotationMatrix1x1,'String',sprintf('%.3f',Rotation(1,1)));
    set(handles.RotationMatrix1x2,'String',sprintf('%.3f',Rotation(1,2)));
    set(handles.RotationMatrix1x3,'String',sprintf('%.3f',Rotation(1,3)));
    set(handles.RotationMatrix2x1,'String',sprintf('%.3f',Rotation(2,1)));
    set(handles.RotationMatrix2x2,'String',sprintf('%.3f',Rotation(2,2)));
    set(handles.RotationMatrix2x3,'String',sprintf('%.3f',Rotation(2,3)));
    set(handles.RotationMatrix3x1,'String',sprintf('%.3f',Rotation(3,1)));
    set(handles.RotationMatrix3x2,'String',sprintf('%.3f',Rotation(3,2)));
    set(handles.RotationMatrix3x3,'String',sprintf('%.3f',Rotation(3,3)));

    quaternion = quat;
    % Això és el quaternion per rotar
    set(handles.q0,'String',sprintf('%.3f',quaternion(1)));
    set(handles.q1,'String',sprintf('%.3f',quaternion(2)));
    set(handles.q2,'String',sprintf('%.3f',quaternion(3)));
    set(handles.q3,'String',sprintf('%.3f',quaternion(4)));

    % Euler angle & axis
    [u,angle] = rotMat2Eaa(Rotation);
    set(handles.xEAA,'String',sprintf('%.3f', u(1)));
    set(handles.yEAA,'String',sprintf('%.3f', u(2)));
    set(handles.zEAA,'String',sprintf('%.3f', u(3)));
    set(handles.angleEAA,'String',sprintf('%.3f', rad2deg(angle)));

    % Euler angle
    [alpha, beta, gamma] = rotM2eAngles(Rotation);
    set(handles.alphaEA,'String',sprintf('%.3f', rad2deg(alpha)));
    set(handles.betaEA,'String',sprintf('%.3f', rad2deg(beta)));
    set(handles.gammaEA,'String',sprintf('%.3f', rad2deg(gamma)));

    % Vector de Rotacio
    r = u*angle;
    set(handles.vec1,'String',sprintf('%.3f', r(1)));
    set(handles.vec2,'String',sprintf('%.3f', r(2)));
    set(handles.vec3,'String',sprintf('%.3f', r(3)));

    [handles.Cube] = RedrawCube(Rotation,handles.Cube);
    
end
