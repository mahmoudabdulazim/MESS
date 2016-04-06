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
    handles.tgroup = uitabgroup('Parent', handles.SATInitializationPanel,'TabLocation', 'top');
    handles.RVCOE  = uitab('Parent', handles.tgroup, 'Title', 'R and V');
    handles.COERV  = uitab('Parent', handles.tgroup, 'Title', 'Orbit Design');
    handles.RTRT   = uitab('Parent', handles.tgroup, 'Title', 'Two Positions Observation ');
    set(handles.InitialConditions,'Parent',handles.RVCOE);
    set(handles.AddSAT,'Parent',handles.RVCOE);
    set(handles.SATName,'Parent',handles.RVCOE);
    set(handles.SAT_Name,'Parent',handles.RVCOE);
    handles.output      = hObject;
    handles.Time        =  0;
    handles.MaxSatNum   =  3;
    handles.Satellites  = [];
    handles.Index       = get(handles.SATList,'Value');
    
    guidata(hObject, handles);

function varargout = MESS_OutputFcn(hObject, eventdata, handles) 

    varargout{1} = handles.output;
    varargout{2} = handles;

function Save_Callback(hObject, eventdata, handles)

function Exit_Callback(hObject, eventdata, handles)
    
function Reset_Callback(hObject, eventdata, handles)

function Start_Callback(hObject, eventdata, handles)
    
function Pause_Callback(hObject, eventdata, handles)

function RemoveSAT_Callback(hObject, eventdata, handles)
    
    if isempty(handles.Satellites)
        set(handles.SATList,'Enable','off');
    else
        index = get(handles.SATList,'Value');
        if (index > 0)
            handles.Satellites(index) = [];
            RemovefromListbox(handles.SATList,index);    
        end
    end
    guidata(hObject,handles);

function SATList_Callback(hObject, eventdata, handles)
    
    handles.Index = get(hObject,'Value');
    guidata(hObject,handles);
    
function DestinationMajorAxis_Callback(hObject, eventdata, handles)

function TransferTime_Callback(hObject, eventdata, handles)

function DestinationEccentricity_Callback(hObject, eventdata, handles)

function Transfer_Callback(hObject, eventdata, handles)

function AddSAT_Callback(hObject, eventdata, handles)
   % Initialization Data from Initial Conditions Panel
    R0                 = [str2double(get(handles.Rx,'String'));str2double(get(handles.Ry,'String'));str2double(get(handles.Rz,'String'))];
    V0                 = [str2double(get(handles.Vx,'String'));str2double(get(handles.Vy,'String'));str2double(get(handles.Vz,'String'))];
    Date               = get(handles.t0,'String');    t = datetime(Date,'InputFormat','dd-MMM-yyyy HH:mm:ss');    T0 = juliandate(t)*24*3600;
    Name               = get(handles.SATName,'String');
    handles.Satellites = [handles.Satellites Satellite];
    handles.Index      = length(handles.Satellites);

    if isempty(Name)
       Name = sprintf('Untitled Sat %d',handles.Index);
    end

    handles.Satellites(handles.Index).RVCOE(R0,V0,T0,Name);
    AddtoListbox(handles.SATList,handles.Satellites(handles.Index).Name);
    drawOrbit(handles.Satellites(handles.Index),handles.Space3DScene);
    guidata(hObject,handles);
    
function Rx_Callback(hObject, eventdata, handles)

function Ry_Callback(hObject, eventdata, handles)

function Rz_Callback(hObject, eventdata, handles)

function Vx_Callback(hObject, eventdata, handles)

function Vy_Callback(hObject, eventdata, handles)

function Vz_Callback(hObject, eventdata, handles)

function t0_Callback(hObject, eventdata, handles)

function SATName_Callback(hObject, eventdata, handles)

function SpaceSim_Callback(hObject, eventdata, handles)


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


function SATName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end