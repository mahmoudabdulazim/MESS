function varargout = MESS(varargin)

    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @MESS_OpeningFcn, ...
                       'gui_OutputFcn',  @MESS_OutputFcn, ...
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
    
function MESS_OpeningFcn(hObject, eventdata, handles, varargin)

    handles.output = hObject;
    handles.Time   = 0;
    guidata(hObject, handles);

function varargout = MESS_OutputFcn(hObject, eventdata, handles) 

    varargout{1} = handles.output;


function Save_Callback(hObject, eventdata, handles)

function Exit_Callback(hObject, eventdata, handles)
    
function Reset_Callback(hObject, eventdata, handles)

function Start_Callback(hObject, eventdata, handles)
    
function Pause_Callback(hObject, eventdata, handles)

function RemoveSAT_Callback(hObject, eventdata, handles)

function SATList_Callback(hObject, eventdata, handles)

function DestinationMajorAxis_Callback(hObject, eventdata, handles)

function TransferTime_Callback(hObject, eventdata, handles)

function DestinationEccentricity_Callback(hObject, eventdata, handles)

function Transfer_Callback(hObject, eventdata, handles)

function AddSAT_Callback(hObject, eventdata, handles)

function Rx_Callback(hObject, eventdata, handles)

function Ry_Callback(hObject, eventdata, handles)

function Rz_Callback(hObject, eventdata, handles)

function Vx_Callback(hObject, eventdata, handles)

function Vy_Callback(hObject, eventdata, handles)

function Vz_Callback(hObject, eventdata, handles)

function t0_Callback(hObject, eventdata, handles)




function SATList_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function DestinationMajorAxis_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TransferTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TransferTime (see GCBO)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DestinationEccentricity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DestinationEccentricity (see GCBO)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Rx_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Ry_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Rz_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Vx_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Vy_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Vz_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function t0_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
