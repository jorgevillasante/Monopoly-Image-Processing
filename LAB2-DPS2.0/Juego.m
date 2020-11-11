function varargout = Juego(varargin)
% JUEGO MATLAB code for Juego.fig
%      JUEGO, by itself, creates a new JUEGO or raises the existing
%      singleton*.
%
%      H = JUEGO returns the handle to a new JUEGO or the handle to
%      the existing singleton*.
%
%      JUEGO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JUEGO.M with the given input arguments.
%
%      JUEGO('Property','Value',...) creates a new JUEGO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Juego_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Juego_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Juego

% Last Modified by GUIDE v2.5 09-Nov-2020 16:15:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Juego_OpeningFcn, ...
                   'gui_OutputFcn',  @Juego_OutputFcn, ...
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


% --- Executes just before Juego is made visible.
function Juego_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Juego (see VARARGIN)

% Choose default command line output for Juego
handles.output = hObject;
global C;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Juego wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Juego_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Bacepta.
function Bacepta_Callback(hObject, eventdata, handles)
set(handles.Mensajes,'String', "Cambio de tarjeta");
pause(2)
for s= 1:1:5
    set(handles.Mensajes,'String', "Desea seleccionar la tarjeta mostrada?");
    disp(s)
    pause(1);
    if s==1
        set(handles.Reloj,'String','01');
    elseif s==2
        set(handles.Reloj,'String','02');
    elseif s==3
        set(handles.Reloj,'String','03');
    elseif s==4
        set(handles.Reloj,'String','04');
    else
        set(handles.Reloj,'String','05');
    end    
end

%CAPTURA Y LO PONE EN EL AXES2, AXES6, AXES7, AXES8 O AXES9.

I=getsnapshot(handles.Vid);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

global C

[M,N,P]=size(I);

Z=zeros(M,N);
carta=[];

%-------------
ip_fondo=find(R<100 & G<100 & B<100); %125 fondo
Z=zeros(M,N);
Z(ip_fondo)=255;
[V1,K1]=bwlabel(Z,8);
[A,ip2]=objetomasgrande(V1,K1);

R(ip2)=0;
G(ip2)=0;
B(ip2)=0;
I(:,:,1)=R;
I(:,:,2)=G;
I(:,:,3)=B;

figure()
imshow(uint8(I));
impixelinfo;

[HSV]=rgb2hsv(I);

H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);

H=round(255*H);
S=round(255*S);
V=round(255*V);
%-------------
ip_marron=find(S>50 & S<175 & V>75 & V<135 & H<25 & R>90); %brown
Z=zeros(M,N);
Z(ip_marron)=255;
[V1,K1]=bwlabel(Z,8);
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>5000 & length(ip2)<10000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=R(min(x):max(x),min(y):max(y));
    figure()
    imshow(uint8(X));
%     imshow(uint8(X),'Parent', handles.prop1);
    impixelinfo;
            
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<80); %ip2=find(X>175); %usando X=S(...
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.2
        carta= [carta; "Marron: Avenida Mediterraneo"]
    else
        carta= [carta; "Marron: Avenida Baltica"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if length(ip2)>5000 & length(ip2)<10000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=I(min(x):max(x),min(y):max(y));
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<80);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.2
            carta= [carta; "Marron: Avenida Mediterraneo"]
        else
            carta= [carta; "Marron: Avenida Baltica"]
        end
    end
end

%-------------
ip_amarillo=find(S>175 & H>36 & H<46 & V>120); %amarillo
Z=zeros(M,N);
Z(ip_amarillo)=255;
[V1,K1]=bwlabel(Z,8);
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>5000 & length(ip2)<10000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=V(min(x):max(x),min(y):max(y));
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<100);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.13
        carta= [carta; "Amarillo: Avenida Atlantico"]
    elseif length(ip1)/length(ip2)<0.11
        carta= [carta; "Amarillo: Avenida Ventnor"]
    else
        carta= [carta; "Amarillo: Jardines Marvin"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if length(ip2)>5000 & length(ip2)<10000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=V(min(x):max(x),min(y):max(y));
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<100);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.13
            carta= [carta; "Amarillo: Avenida Atlantico"]
        elseif length(ip1)/length(ip2)<0.11
            carta= [carta; "Amarillo: Avenida Ventnor"]
        else
            carta= [carta; "Amarillo: Jardines Marvin"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
         
        if length(ip2)>5000 & length(ip2)<10000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=V(min(x):max(x),min(y):max(y));
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X<100);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.13
                carta= [carta; "Amarillo: Avenida Atlantico"]
            elseif length(ip1)/length(ip2)<0.11
                carta= [carta; "Amarillo: Avenida Ventnor"]
            else
                carta= [carta; "Amarillo: Jardines Marvin"]
            end
        end
    end
end
%-------------
ip_celeste=find(V>125 & V<225 & S>30 & S<115 & H>135 & H<155); %   celeste
Z=zeros(M,N);
Z(ip_celeste)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>5000 & length(ip2)<10000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=S(min(x):max(x),min(y):max(y));
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X>150);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.0576
        carta= [carta; "Celeste: Avenida Connecticut"]
    elseif length(ip1)/length(ip2)<0.056
        carta= [carta; "Celeste: Avenida Oriental"]
    else
        carta= [carta; "Celeste: Avenida Vermont"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if length(ip2)>5000 & length(ip2)<10000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=S(min(x):max(x),min(y):max(y));
        figure()
        imshow(uint8(X));
        impixelinfo;

        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X>150);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.0576
            carta= [carta; "Celeste: Avenida Connecticut"]
        elseif length(ip1)/length(ip2)<0.056
            carta= [carta; "Celeste: Avenida Oriental"]
        else
            carta= [carta; "Celeste: Avenida Vermont"]
        end

        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
         
        if length(ip2)>5000 & length(ip2)<10000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=S(min(x):max(x),min(y):max(y));
            figure()
            imshow(uint8(X));
            impixelinfo;

            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X>150);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.0576
                carta= [carta; "Celeste: Avenida Connecticut"]
            elseif length(ip1)/length(ip2)<0.056
                carta= [carta; "Celeste: Avenida Oriental"]
            else
                carta= [carta; "Celeste: Avenida Vermont"]
            end

        end
    end
end
%-------------
ip_verde=find(S>75 & S<180 & H>65 & H<105); %green
Z=zeros(M,N);
Z(ip_verde)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>5000 & length(ip2)<10000
    carta= [carta ;"verde"]
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=G(min(x):max(x),min(y):max(y));
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<85);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.19
        carta= [carta; "Amarillo: Avenida Pennsylvania"]
    elseif length(ip1)/length(ip2)<0.145
        carta= [carta; "Amarillo: Avenida Pacifico"]
    else
        carta= [carta; "Amarillo: Avenida Carolina del Norte"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if length(ip2)>5000 & length(ip2)<10000
        carta= [carta ;"verde"]
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=G(min(x):max(x),min(y):max(y));
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<85);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.19
            carta= [carta; "Amarillo: Avenida Pennsylvania"]
        elseif length(ip1)/length(ip2)<0.145
            carta= [carta; "Amarillo: Avenida Pacifico"]
        else
            carta= [carta; "Amarillo: Avenida Carolina del Norte"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
         
        if length(ip2)>5000 & length(ip2)<10000
            carta= [carta ;"verde"]
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=G(min(x):max(x),min(y):max(y));
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X<85);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.19
                carta= [carta; "Amarillo: Avenida Pennsylvania"]
            elseif length(ip1)/length(ip2)<0.145
                carta= [carta; "Amarillo: Avenida Pacifico"]
            else
                carta= [carta; "Amarillo: Avenida Carolina del Norte"]
            end
        end
    end
end
%-------------
ip_rosa=find(S>130 & S<190 & H>225 & H<245);% (rosa)
Z=zeros(M,N);
Z(ip_rosa)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>5000 & length(ip2)<10000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=S(min(x):max(x),min(y):max(y));
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X>195);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.088
        carta= [carta; "Rosado: Avenida Estados"]
    elseif length(ip1)/length(ip2)<0.085
        carta= [carta; "Rosado: Avenida Virginia"]
    else
        carta= [carta; "Rosado: Avenida San Carlos"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if length(ip2)>5000 & length(ip2)<10000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=S(min(x):max(x),min(y):max(y));
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X>195);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.088
            carta= [carta; "Rosado: Avenida Estados"]
        elseif length(ip1)/length(ip2)<0.085
            carta= [carta; "Rosado: Avenida Virginia"]
        else
            carta= [carta; "Rosado: Avenida San Carlos"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
         
        if length(ip2)>5000 & length(ip2)<10000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=S(min(x):max(x),min(y):max(y));
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X>195);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.088
                carta= [carta; "Rosado: Avenida Estados"]
            elseif length(ip1)/length(ip2)<0.085
                carta= [carta; "Rosado: Avenida Virginia"]
            else
                carta= [carta; "Rosado: Avenida San Carlos"]
            end
        end
    end
end
%-------------
ip_rojo=find(S>140 & (H>240 | H<15)); %rojo
Z=zeros(M,N);
Z(ip_rojo)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>5000 & length(ip2)<10000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=S(min(x):max(x),min(y):max(y));
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X>220); 
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.075
        carta= [carta; "Rojo: Avenida Indiana"]
    elseif length(ip1)/length(ip2)<0.0575
        carta= [carta; "Rojo: Avenida Kentucky"]
    else
        carta= [carta; "Rojo: Avenida Illinois"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if length(ip2)>5000 & length(ip2)<10000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=S(min(x):max(x),min(y):max(y));
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X>220);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.075
            carta= [carta; "Rojo: Avenida Indiana"]
        elseif length(ip1)/length(ip2)<0.0575
            carta= [carta; "Rojo: Avenida Kentucky"]
        else
            carta= [carta; "Rojo: Avenida Illinois"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
         
        if length(ip2)>5000 & length(ip2)<10000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=S(min(x):max(x),min(y):max(y));
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X>220);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.075
                carta= [carta; "Rojo: Avenida Indiana"]
            elseif length(ip1)/length(ip2)<0.0575
                carta= [carta; "Rojo: Avenida Kentucky"]
            else
                carta= [carta; "Rojo: Avenida Illinois"]
            end
        end
    end
end
%-------------
ip_naranja=find(R>130 & R<175 & G>80 & G<115 & B>15 & B<85); %naranja
Z=zeros(M,N);
Z(ip_naranja)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>5000 & length(ip2)<10000
    carta= [carta ;"naranja"]
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=I(min(x):max(x),min(y):max(y));
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if length(ip2)>5000 & length(ip2)<10000
        carta= [carta ;"naranja"]
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=I(min(x):max(x),min(y):max(y));
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
         
        if length(ip2)>5000 & length(ip2)<10000
            carta= [carta ;"naranja"]
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=I(min(x):max(x),min(y):max(y));
            figure()
            imshow(uint8(X));
            impixelinfo;
        end
    end
end
%-------------
ip_azul=find(V>120 & V<200 & S>135 & S<220 & H>140 & H<160); %azul
Z=zeros(M,N);
Z(ip_azul)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>5000 & length(ip2)<10000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=G(min(x):max(x),min(y):max(y));
    figure()
    imshow(uint8(X));
    impixelinfo;

    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<65);
    Z1(ip1)=255;
    if length(ip1)/length(ip2)>0.125
        carta= [carta; "Azul: El Muelle"]
    else
        carta= [carta; "Azul: Plaza Park"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if length(ip2)>5000 & length(ip2)<10000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=G(min(x):max(x),min(y):max(y));
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<65);
        Z1(ip1)=255;
        if length(ip1)/length(ip2)>0.125
            carta= [carta; "Azul: El Muelle"]
        else
            carta= [carta; "Azul: Plaza Park"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
         
        if length(ip2)>5000 & length(ip2)<10000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=G(min(x):max(x),min(y):max(y));
            figure()
            imshow(uint8(X));
            impixelinfo;

            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X<65);
            Z1(ip1)=255;
            if length(ip1)/length(ip2)>0.125
                carta= [carta; "Azul: El Muelle"]
            else
                carta= [carta; "Azul: Plaza Park"]
            end
        end
    end
end
%-----------------------
ip_ferro=find(V<75 & S<100 & V>20); %ferro 
Z=zeros(M,N);
Z(ip_ferro)=255;
[V1,K1]=bwlabel(Z,8);
[A,ip2]=objetomasgrande(V1,K1);
    
if length(ip2)>3000 & length(ip2)<5000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=V(min(x):max(x)+60,min(y)-10:max(y)+10);
    figure()
    imshow(uint8(X));
    impixelinfo;

    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<125);
    Z1(ip1)=255;
    [V1,K1]=bwlabel(Z1,8);
    [A,ip1]=objetomasgrande(V1,K1);
    F1=zeros(M1,N1);
    F1(ip1)=255;
    Z1=Z1-F1;
    ip1=find(Z1);
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.25
        carta= [carta; "Ferrocarril Pennsylvania"]
    else
        if length(ip1)/length(ip2)>0.2175
            carta= [carta; "Ferrocarril Via Rapida"]
        elseif length(ip1)/length(ip2)<0.2085
            carta= [carta; "Ferrocarril B & O"]
        else
            carta= [carta; "Ferrocarril Reading"]
        end
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);

    if length(ip2)>2500 & length(ip2)<5000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=V(min(x):max(x)+60,min(y)-10:max(y)+10);
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<125);
        Z1(ip1)=255;
        [V1,K1]=bwlabel(Z1,8);
        [A,ip1]=objetomasgrande(V1,K1);
        F1=zeros(M1,N1);
        F1(ip1)=255;
        Z1=Z1-F1;
        ip1=find(Z1);
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.25
            carta= [carta; "Ferrocarril Pennsylvania"]
        else
            if length(ip1)/length(ip2)>0.2175
                carta= [carta; "Ferrocarril Via Rapida"]
            elseif length(ip1)/length(ip2)<0.2085
                carta= [carta; "Ferrocarril B & O"]
            else
                carta= [carta; "Ferrocarril Reading"]
            end
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
        if length(ip2)>2500 & length(ip2)<5000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=V(min(x):max(x)+60,min(y)-10:max(y)+10);
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X<125);
            Z1(ip1)=255;
            [V1,K1]=bwlabel(Z1,8);
            [A,ip1]=objetomasgrande(V1,K1);
            F1=zeros(M1,N1);
            F1(ip1)=255;
            Z1=Z1-F1;
            ip1=find(Z1);
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.25
                carta= [carta; "Ferrocarril Pennsylvania"]
            else
                if length(ip1)/length(ip2)>0.2175
                    carta= [carta; "Ferrocarril Via Rapida"]
                elseif length(ip1)/length(ip2)<0.2085
                    carta= [carta; "Ferrocarril B & O"]
                else
                    carta= [carta; "Ferrocarril Reading"]
                end
            end
        end
    end
end
%-----------------------
% ip_luz=find(S>80 & H>25 & H<50 & V>130 & V<170); %foco
% Z=zeros(M,N);
% Z(ip_luz)=255;
% [V1,K1]=bwlabel(Z,8);
% [A,ip2]=objetomasgrande(V1,K1);
%     
% if length(ip2)>500 & length(ip2)<1500
%     carta= [carta; "Luz"]
%     F=zeros(M,N);
%     F(ip2)=255;
%     [x,y]=find(F==255);
%     X=I(min(x)-50:max(x)+50,min(y)-50:max(y)+50);
%     figure()
%     imshow(uint8(X));
%     impixelinfo;
% end
%-----------------------
ip_servicios=find(V<60 & V>0); %servicios
Z=zeros(M,N);
Z(ip_servicios)=255;
[V1,K1]=bwlabel(Z,8);
A=500; %minima cantidad de pixeles que cumplan con el color
ip2=[];
for i=1:K1
    ip=find(V1==i);
    Ap=length(ip);
    if Ap>A & Ap<1200
       A=Ap;
       ip2=ip;
    end
end

    
if length(ip2)>500 & length(ip2)<1200
    ip_luz=find(S>80 & H>25 & H<50 & V>130 & V<170); %foco
    Z1=zeros(M,N);
    Z1(ip_luz)=255;
    [V1,K1]=bwlabel(Z1,8);
    [A,ip]=objetomasgrande(V1,K1);

    if length(ip)>500 & length(ip)<1500
        carta= [carta; "Luz"]
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=I(min(x)-50:max(x)+50,min(y)-50:max(y)+50);
        figure()
        imshow(uint8(X));
        impixelinfo;

        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        A=500; %minima cantidad de pixeles que cumplan con el color
        ip2=[];
        for i=1:K1
            ip=find(V1==i);
            Ap=length(ip);
            if Ap>A & Ap<1200
               A=Ap;
               ip2=ip;
            end
        end
    end
    if length(ip2)>500 & length(ip2)<1200
        carta= [carta; "Agua"]
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=I(min(x)-50:max(x)+50,min(y)-50:max(y)+50);
        figure()
        imshow(uint8(X));
        impixelinfo;
    end
end

if  carta(1)== "Marron: Avenida Mediterraneo" %Marron
   C= C+72.5;
elseif carta(1)=="Marron: Avenida Baltica" %Marron
   C=C+145;
elseif carta(1)=="Celeste: Avenida Connecticut" %Celeste
   C=C+890;
elseif cartta(1)=="Celeste: Avenida Vermont" %Celeste
   C=C+198;
elseif cartta(1)=="Celeste: Avenida Oriental" %Celeste
   C=C+198;
elseif cartta(1)=="Azul: Plaza Park" %Azul
   C=C+769;
elseif cartta(1)=="Azul: El Muelle" %Azul
   C=C+975;
elseif cartta(1)=="Rosado: Avenida San Carlos" %Fucsia
   C=C+319;
elseif cartta(1)=="Rosado: Avenida Estados" %Fucsia
   C=C+319;
elseif cartta(1)=="Rosado: Avenida Virginia" %Fucsia
   C=C+360;
elseif cartta(1)=="Amarillo: Avenida Ventnor" %Amarillo
   C=C+554;
elseif cartta(1)=="Amarillo: Avenida Atlantico" %Amarillo
   C=C+554;
elseif cartta(1)=="Amarillo: Jardines Marvin" %Amarillo
   C=C+589;
elseif cartta(1)=="Rojo: Avenida Kentucky" %Rojo
   C=C+479;
elseif cartta(1)=="Rojo: Avenida Illinois" %Rojo
   C=C+519;
elseif cartta(1)=="Rojo: Avenida Indiana" %Rojo
   C=C+479;
elseif cartta(1)=="Verde: Avenida Carolina del Norte" %Verde
   C=C+630;
elseif cartta(1)=="Verde: Avenida Pacifico" %Verde
   C=C+630;
elseif cartta(1)=="Verde: Avenida Pennsylvania" %Verde
   C=C+700;
elseif cartta(1)=="Ferrocarril: Reading" %Ferrocarril
   C=C+94
elseif cartta(1)=="Ferrocarril: Via Rapida" %Ferrocarril
   C=C+94;
elseif cartta(1)=="Ferrocarril: B & O" %Ferrocarril
   C=C+94;
elseif cartta(1)=="Ferrocarril: Pennsylvania" %Ferrocarril
   C=C+94;
elseif cartta(1)=="Agua" %Agua
   dado=0;
   get(handles.Dado, 'Value', dado);
   C=C+(10*dado);
elseif cartta(1)=="Luz" %Electricidad
   %Presiona el boton para generar un numero random y multiplica por 10
   dado=0;
   get(handles.Dado, 'Value', dado);
   C=C+(10*dado);
else 
   set(handles.Mensajes,'String', "Esa no es una carta valida");
   C=C+0
end


guidata(hObject,handles);

% --- Executes on button press in Bnoacepta.
function Bnoacepta_Callback(hObject, eventdata, handles)
set(handles.Mensajes,'String', "Cambio de tarjeta");
pause(2); %tiempo para cambiar la tarjeta
for s= 1:1:5
    set(handles.Mensajes,'String', "Desea seleccionar la tarjeta mostrada?");
    disp(s)
    pause(1);
    if s==1
        set(handles.Reloj,'String','01');
    elseif s==2
        set(handles.Reloj,'String','02');
    elseif s==3
        set(handles.Reloj,'String','03');
    elseif s==4
        set(handles.Reloj,'String','04');
    else
        set(handles.Reloj,'String','05');
    end    
end
 %Y MOSTRAR LA CAMARA EN TIEMPO REAL 
    closepreview;
    handles.Vid = videoinput('winvideo', 2,'RGB24_640x480');
    vidInfo = imaqhwinfo(handles.Vid);
    vidRes = handles.Vid.VideoResolution;
    imWidth = vidRes(1);
    imHeight = vidRes(2);
    numBands = handles.Vid.NumberOfBands;

    hAxes = axes(handles.camara);
    hImage = image(hAxes, zeros(imHeight, imWidth, numBands, vidInfo.NativeDataType));
    preview(handles.Vid, hImage);
guidata(hObject, handles);

% --- Executes on button press in Binicio.
function Binicio_Callback(hObject, eventdata, handles)
closepreview;
handles.Vid = videoinput('winvideo', 2,'RGB24_640x480');
vidInfo = imaqhwinfo(handles.Vid);
vidRes = handles.Vid.VideoResolution;
imWidth = vidRes(1);
imHeight = vidRes(2);
numBands = handles.Vid.NumberOfBands;

hImage = image(handles.axes1, zeros(imHeight, imWidth, numBands, vidInfo.NativeDataType));
preview(handles.Vid, hImage);

set(handles.Mensajes,'String', "Desea seleccionar la tarjeta mostrada?");
set(handles.Result,'String',' ');
set(handles.Total,'String',' ');
pause(1);
for s= 1:1:5
    disp(s)
    pause(1);
    if s==1
        set(handles.Reloj,'String','01');
    elseif s==2
        set(handles.Reloj,'String','02');
    elseif s==3
        set(handles.Reloj,'String','03');
    elseif s==4
        set(handles.Reloj,'String','04');
    else
        set(handles.Reloj,'String','05');
    end    
end
guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles) %DADO
x=randi(6);
if round(x)== 1
    set(handles.dado,'String', '1');
elseif round(x)== 2
    set(handles.dado,'String', '2');
elseif round(x)== 3
    set(handles.dado,'String', '3');
elseif round(x)== 4
    set(handles.dado,'String', '4');
elseif round(x)== 5
    set(handles.dado,'String', '1');
else
    set(handles.dado,'String', '1');
end
guidata(hObject, handles);


% --- Executes on button press in Bterminar.
function Bterminar_Callback(hObject, eventdata, handles)
global C
suma=int2str(C);
set(handles.Total,'String',suma);
if C<=1500
    set(handles.Result,'String','Felicidades, usted gano!');
    set(handles.Mensajes,'String', "Revise los resualtados en el panel");
else
    set(handles.Result,'String','Intentelo nuevamente');
    set(handles.Mensajes,'String', "Revise los resualtados en el panel");
end
guidata(hObject, handles);
