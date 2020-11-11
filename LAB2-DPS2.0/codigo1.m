function varargout = codigo1(varargin)
% CODIGO1 MATLAB code for codigo1.fig
%      CODIGO1, by itself, creates a new CODIGO1 or raises the existing
%      singleton*.
%
%      H = CODIGO1 returns the handle to a new CODIGO1 or the handle to
%      the existing singleton*.
%
%      CODIGO1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CODIGO1.M with the given input arguments.
%
%      CODIGO1('Property','Value',...) creates a new CODIGO1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before codigo1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to codigo1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help codigo1

% Last Modified by GUIDE v2.5 07-Nov-2020 19:37:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @codigo1_OpeningFcn, ...
                   'gui_OutputFcn',  @codigo1_OutputFcn, ...
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


% --- Executes just before codigo1 is made visible.
function codigo1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to codigo1 (see VARARGIN)

% Choose default command line output for codigo1
handles.output = hObject;
handles.Ind=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes codigo1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = codigo1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Capturar.
function Capturar_Callback(hObject, eventdata, handles)
    I=getsnapshot(handles.Vid);                                %CAPTURA DE IMAGEN
    imshow(uint8(I),'Parent', handles.captura);      %LA MUESTRA UNA VEZ EN AXES2
    impixelinfo;
    handles.imag=I;
guidata(hObject,handles);

% --- Executes on button press in procesar.
function procesar_Callback(hObject, eventdata, handles)

I=handles.imag;

cant_imag=0;
imag1=[];
imag2=[];
imag3=[];
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

figure()
imshow(uint8(I));
impixelinfo;

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
%ip_marron=find(S>50 & S<175 & V>75 & V<135 & H<25 & R>90); %marron
ip_marron=find(S>50 & S<175 & V>54 & V<135 & H<25 ); %marron
Z=zeros(M,N);
Z(ip_marron)=255;
[V1,K1]=bwlabel(Z,8);
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>3000 & length(ip2)<6000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=R(min(x):max(x),min(y):max(y));
    figure()
    cant_imag=cant_imag+1
    imshow(uint8(X));
%     imshow(uint8(X),'Parent', handles.prop1);
    impixelinfo;
            
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<80); %ip2=find(X>175); %usando X=S(...
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.15
        carta= [carta; "Marron: Avenida Mediterraneo"]
    else
        carta= [carta; "Marron: Avenida Baltica"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    imag1=X;
    imshow(uint8(imag1),'Parent', handles.prop1);
    if length(ip2)>3000 & length(ip2)<6000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=I(min(x):max(x),min(y):max(y));
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<80);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.15
            carta= [carta; "Marron: Avenida Mediterraneo"]
        else
            carta= [carta; "Marron: Avenida Baltica"]
        end
        
    end
end

if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end
%-------------
ip_amarillo=find(S>150 & H>35 & H<50 & V>100); %amarillo
Z=zeros(M,N);
Z(ip_amarillo)=255;
[V1,K1]=bwlabel(Z,8);
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>3000 & length(ip2)<6000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=V(min(x):max(x),min(y):max(y));
    cant_imag=cant_imag+1
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<100);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.128
        carta= [carta; "Amarillo: Avenida Atlantico"]
    elseif length(ip1)/length(ip2)<0.12
        carta= [carta; "Amarillo: Avenida Ventnor"]
    else
        carta= [carta; "Amarillo: Jardines Marvin"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if cant_imag==3
        imag3=X;
        imshow(uint8(imag3),'Parent', handles.prop3);
    else
        if cant_imag==2
            imag2=X;
            imshow(uint8(imag2),'Parent', handles.prop2);
        elseif cant_imag==1
            imag1=X;
            imshow(uint8(imag1),'Parent', handles.prop1);
        end
    end
    
    if length(ip2)>3000 & length(ip2)<6000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=V(min(x):max(x),min(y):max(y));
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<100);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.128
            carta= [carta; "Amarillo: Avenida Atlantico"]
        elseif length(ip1)/length(ip2)<0.12
            carta= [carta; "Amarillo: Avenida Ventnor"]
        else
            carta= [carta; "Amarillo: Jardines Marvin"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end
        
        if length(ip2)>3000 & length(ip2)<6000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=V(min(x):max(x),min(y):max(y));
            cant_imag=cant_imag+1
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X<100);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.128
                carta= [carta; "Amarillo: Avenida Atlantico"]
            elseif length(ip1)/length(ip2)<0.12
                carta= [carta; "Amarillo: Avenida Ventnor"]
            else
                carta= [carta; "Amarillo: Jardines Marvin"]
            end
        end
    end
end
if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end
%-------------
ip_celeste=find(V>125 & V<235 & S>25 & S<115 & H>120 & H<160); %   celeste
Z=zeros(M,N);
Z(ip_celeste)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>3000 & length(ip2)<6000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=S(min(x):max(x),min(y):max(y));
    cant_imag=cant_imag+1
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X>75);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.11
        carta= [carta; "Celeste: Avenida Oriental"]
    elseif length(ip1)/length(ip2)<0.1
        carta= [carta; "Celeste: Avenida Vermont"]
    else
        carta= [carta; "Celeste: Avenida Connecticut"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    if cant_imag==3
        imag3=X;
        imshow(uint8(imag3),'Parent', handles.prop3);
    else
        if cant_imag==2
            imag2=X;
            imshow(uint8(imag2),'Parent', handles.prop2);
        elseif cant_imag==1
            imag1=X;
            imshow(uint8(imag1),'Parent', handles.prop1);
        end
    end
    if length(ip2)>3000 & length(ip2)<6000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=S(min(x):max(x),min(y):max(y));
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;

        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X>75);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        
        if length(ip1)/length(ip2)>0.11
            carta= [carta; "Celeste: Avenida Oriental"]
        elseif length(ip1)/length(ip2)<0.1
            carta= [carta; "Celeste: Avenida Vermont"]
        else
            carta= [carta; "Celeste: Avenida Connecticut"]
        end

        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
        
        
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end
        if length(ip2)>3000 & length(ip2)<6000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=S(min(x):max(x),min(y):max(y));
            cant_imag=cant_imag+1
            figure()
            imshow(uint8(X));
            impixelinfo;

            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X>75);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            
            if length(ip1)/length(ip2)>0.11
                carta= [carta; "Celeste: Avenida Oriental"]
            elseif length(ip1)/length(ip2)<0.1
                carta= [carta; "Celeste: Avenida Vermont"]
            else
                carta= [carta; "Celeste: Avenida Connecticut"]
            end

        end
    end
end
if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end
%-------------
ip_verde=find(S>75 & S<180 & H>65 & H<105); %verda
Z=zeros(M,N);
Z(ip_verde)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>3000 & length(ip2)<6000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=G(min(x):max(x),min(y):max(y));
    cant_imag=cant_imag+1
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<85);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.1435
        carta= [carta; "Verde: Avenida Carolina del Norte"]
    elseif length(ip1)/length(ip2)<0.125
        carta= [carta; "Verde: Avenida Pacifico"]
    else
        carta= [carta; "Verde: Avenida Pennsylvania"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if cant_imag==3
        imag3=X;
        imshow(uint8(imag3),'Parent', handles.prop3);
    else
        if cant_imag==2
            imag2=X;
            imshow(uint8(imag2),'Parent', handles.prop2);
        elseif cant_imag==1
            imag1=X;
            imshow(uint8(imag1),'Parent', handles.prop1);
        end
    end
    
    if length(ip2)>3000 & length(ip2)<6000
        
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=G(min(x):max(x),min(y):max(y));
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<85);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.1435
            carta= [carta; "Verde: Avenida Carolina del Norte"]
        elseif length(ip1)/length(ip2)<0.125
            carta= [carta; "Verde: Avenida Pacifico"]
        else
            carta= [carta; "Verde: Avenida Pennsylvania"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end
        
        if length(ip2)>3000 & length(ip2)<6000
            
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=G(min(x):max(x),min(y):max(y));
            cant_imag=cant_imag+1
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X<85);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.1435
                carta= [carta; "Verde: Avenida Carolina del Norte"]
            elseif length(ip1)/length(ip2)<0.125
                carta= [carta; "Verde: Avenida Pacifico"]
            else
                carta= [carta; "Verde: Avenida Pennsylvania"]
            end
        end
    end
end
if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end
%-------------
ip_rosa=find(S>130 & S<200 & H>225 & H<245);% (rosa)
Z=zeros(M,N);
Z(ip_rosa)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>3000 & length(ip2)<6000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=S(min(x):max(x),min(y):max(y));
    cant_imag=cant_imag+1
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X>195);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.128
        carta= [carta; "Rosado: Avenida Estados"]
    elseif length(ip1)/length(ip2)<0.115
        carta= [carta; "Rosado: Avenida San Carlos"]
    else
        carta= [carta; "Rosado: Avenida Virginia"]
    end
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if cant_imag==3
        imag3=X;
        imshow(uint8(imag3),'Parent', handles.prop3);
    else
        if cant_imag==2
            imag2=X;
            imshow(uint8(imag2),'Parent', handles.prop2);
        elseif cant_imag==1
            imag1=X;
            imshow(uint8(imag1),'Parent', handles.prop1);
        end
    end
    
    if length(ip2)>3000 & length(ip2)<6000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=S(min(x):max(x),min(y):max(y));
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X>195);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.128
            carta= [carta; "Rosado: Avenida Estados"]
        elseif length(ip1)/length(ip2)<0.115
            carta= [carta; "Rosado: Avenida San Carlos"]
        else
            carta= [carta; "Rosado: Avenida Virginia"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
         
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end
        
        if length(ip2)>3000 & length(ip2)<6000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=S(min(x):max(x),min(y):max(y));
            cant_imag=cant_imag+1
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X>195);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.128
                carta= [carta; "Rosado: Avenida Estados"]
            elseif length(ip1)/length(ip2)<0.115
                carta= [carta; "Rosado: Avenida San Carlos"]
            else
                carta= [carta; "Rosado: Avenida Virginia"]
            end
        end
    end
end
if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end
%-------------
ip_rojo=find(S>140 & S<230 & R>100 & (H>240 | H<15)); %rojo
Z=zeros(M,N);
Z(ip_rojo)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>3000 & length(ip2)<6000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=S(min(x):max(x),min(y):max(y));
    cant_imag=cant_imag+1
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X>225); 
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.12
        carta= [carta; "Rojo: Avenida Kentucky"]
    elseif length(ip1)/length(ip2)<0.1145
        carta= [carta; "Rojo: Avenida Indiana"]
    else
        carta= [carta; "Rojo: Avenida Illinois"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if cant_imag==3
        imag3=X;
        imshow(uint8(imag3),'Parent', handles.prop3);
    else
        if cant_imag==2
            imag2=X;
            imshow(uint8(imag2),'Parent', handles.prop2);
        elseif cant_imag==1
            imag1=X;
            imshow(uint8(imag1),'Parent', handles.prop1);
        end
    end
    
    if length(ip2)>3000 & length(ip2)<6000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=S(min(x):max(x),min(y):max(y));
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X>225);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.12
            carta= [carta; "Rojo: Avenida Kentucky"]
        elseif length(ip1)/length(ip2)<0.1145
            carta= [carta; "Rojo: Avenida Indiana"]
        else
            carta= [carta; "Rojo: Avenida Illinois"]
        end
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end

        if length(ip2)>3000 & length(ip2)<6000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=S(min(x):max(x),min(y):max(y));
            cant_imag=cant_imag+1
            figure()
            imshow(uint8(X));
            impixelinfo;
            
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X>220);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.12
                carta= [carta; "Rojo: Avenida Kentucky"]
            elseif length(ip1)/length(ip2)<0.1145
                carta= [carta; "Rojo: Avenida Indiana"]
            else
                carta= [carta; "Rojo: Avenida Illinois"]
            end
        end
    end
end
if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end
%-------------
ip_naranja=find(S>100 & S<220 & V>150 & V<225 & H<25 & R>150); %naranja
Z=zeros(M,N);
Z(ip_naranja)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>3000 & length(ip2)<6000
    
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=I(min(x):max(x),min(y):max(y));
    cant_imag=cant_imag+1
    figure()
    imshow(uint8(X));
    impixelinfo;
    
    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<125);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.09 %1
        carta= [carta; "Naranja: Plaza Nueva York"]
    elseif length(ip1)/length(ip2)<0.073
        carta= [carta; "Naranja: Avenida ST. James"]
    else
        carta= [carta; "Naranja: Avenida Tennessee"]
    end
    %-------
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if cant_imag==3
        imag3=X;
        imshow(uint8(imag3),'Parent', handles.prop3);
    else
        if cant_imag==2
            imag2=X;
            imshow(uint8(imag2),'Parent', handles.prop2);
        elseif cant_imag==1
            imag1=X;
            imshow(uint8(imag1),'Parent', handles.prop1);
        end
    end
    
    if length(ip2)>3000 & length(ip2)<6000
        
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=I(min(x):max(x),min(y):max(y));
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        %-------
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<125);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.09 %1
            carta= [carta; "Naranja: Plaza Nueva York"]
        elseif length(ip1)/length(ip2)<0.073
            carta= [carta; "Naranja: Avenida ST. James"]
        else
            carta= [carta; "Naranja: Avenida Tennessee"]
        end
        %-------
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end
        
        if length(ip2)>3000 & length(ip2)<6000
            
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=I(min(x):max(x),min(y):max(y));
            cant_imag=cant_imag+1
            figure()
            imshow(uint8(X));
            impixelinfo;
            %-------
            [M1,N1,P1]=size(X);
            Z1=zeros(M1,N1);
            ip1=[];
            ip1=find(X<125);
            Z1(ip1)=255;
            length(ip1)/length(ip2)
            if length(ip1)/length(ip2)>0.09 %1
                carta= [carta; "Naranja: Plaza Nueva York"]
            elseif length(ip1)/length(ip2)<0.073
                carta= [carta; "Naranja: Avenida ST. James"]
            else
                carta= [carta; "Naranja: Avenida Tennessee"]
            end
            %-------
        end
    end
end
if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end
%-------------
ip_azul=find(V>100 & V<200 & S>125 & S<220 & H>140 & H<160); %azul
Z=zeros(M,N);
Z(ip_azul)=255;
[V1,K1]=bwlabel(Z,8);
%ip2=[];
[A,ip2]=objetomasgrande(V1,K1);
if length(ip2)>3000 & length(ip2)<6000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=G(min(x):max(x),min(y):max(y));
    cant_imag=cant_imag+1
    figure()
    imshow(uint8(X));
    impixelinfo;

    [M1,N1,P1]=size(X);
    Z1=zeros(M1,N1);
    ip1=[];
    ip1=find(X<65);
    Z1(ip1)=255;
    length(ip1)/length(ip2)
    if length(ip1)/length(ip2)>0.0875
        carta= [carta; "Azul: El Muelle"]
    else
        carta= [carta; "Azul: Plaza Park"]
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if cant_imag==3
        imag3=X;
        imshow(uint8(imag3),'Parent', handles.prop3);
    else
        if cant_imag==2
            imag2=X;
            imshow(uint8(imag2),'Parent', handles.prop2);
        elseif cant_imag==1
            imag1=X;
            imshow(uint8(imag1),'Parent', handles.prop1);
        end
    end
    
    if length(ip2)>3000 & length(ip2)<6000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=G(min(x):max(x),min(y):max(y));
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        [M1,N1,P1]=size(X);
        Z1=zeros(M1,N1);
        ip1=[];
        ip1=find(X<65);
        Z1(ip1)=255;
        length(ip1)/length(ip2)
        if length(ip1)/length(ip2)>0.0875
            carta= [carta; "Azul: El Muelle"]
        else
            carta= [carta; "Azul: Plaza Park"]
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end
        
        if length(ip2)>3000 & length(ip2)<6000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=G(min(x):max(x),min(y):max(y));
            cant_imag=cant_imag+1
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
if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end
%-----------------------

ip_ferro=find(V<75 & S<100 & V>20); %ferro 
Z=zeros(M,N);
Z(ip_ferro)=255;
[V1,K1]=bwlabel(Z,8);
[A,ip2]=objetomasgrande(V1,K1);
    
if length(ip2)>1250 & length(ip2)<2000
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=V(min(x):max(x)+50,min(y)-10:max(y)+10);
    cant_imag=cant_imag+1
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
    if length(ip1)/length(ip2)>0.3
        carta= [carta; "Ferrocarril: Pennsylvania"]
    else
        if length(ip1)/length(ip2)>0.27
            carta= [carta; "Ferrocarril: Via Rapida"]
        elseif length(ip1)/length(ip2)<0.245
            carta= [carta; "Ferrocarril: B & O"]
        else
            carta= [carta; "Ferrocarril: Reading"]
        end
    end
    
    Z=Z-F;
    [V1,K1]=bwlabel(Z,8);
    [A,ip2]=objetomasgrande(V1,K1);
    
    if cant_imag==3
        imag3=X;
        imshow(uint8(imag3),'Parent', handles.prop3);
    else
        if cant_imag==2
            imag2=X;
            imshow(uint8(imag2),'Parent', handles.prop2);
        elseif cant_imag==1
            imag1=X;
            imshow(uint8(imag1),'Parent', handles.prop1);
        end
    end 

    if length(ip2)>1250 & length(ip2)<2000
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=V(min(x):max(x)+50,min(y)-10:max(y)+10);
        cant_imag=cant_imag+1
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
        if length(ip1)/length(ip2)>0.3
            carta= [carta; "Ferrocarril: Pennsylvania"]
        else
            if length(ip1)/length(ip2)>0.27
                carta= [carta; "Ferrocarril: Via Rapida"]
            elseif length(ip1)/length(ip2)<0.245
                carta= [carta; "Ferrocarril: B & O"]
            else
                carta= [carta; "Ferrocarril: Reading"]
            end
        end
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        [A,ip2]=objetomasgrande(V1,K1);
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end 
        
        if length(ip2)>1250 & length(ip2)<2000
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=V(min(x):max(x)+50,min(y)-10:max(y)+10);
            cant_imag=cant_imag+1
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
            if length(ip1)/length(ip2)>0.3
                carta= [carta; "Ferrocarril: Pennsylvania"]
            else
                if length(ip1)/length(ip2)>0.27
                    carta= [carta; "Ferrocarril: Via Rapida"]
                elseif length(ip1)/length(ip2)<0.245
                    carta= [carta; "Ferrocarril: B & O"]
                else
                    carta= [carta; "Ferrocarril: Reading"]
                end
            end
            
            Z=Z-F;
            [V1,K1]=bwlabel(Z,8);
            [A,ip2]=objetomasgrande(V1,K1);
            
            if cant_imag==3
                imag3=X;
                imshow(uint8(imag3),'Parent', handles.prop3);
            else
                if cant_imag==2
                    imag2=X;
                    imshow(uint8(imag2),'Parent', handles.prop2);
                elseif cant_imag==1
                    imag1=X;
                    imshow(uint8(imag1),'Parent', handles.prop1);
                end
            end 
            
            if length(ip2)>1250 & length(ip2)<2000
                F=zeros(M,N);
                F(ip2)=255;
                [x,y]=find(F==255);
                X=V(min(x):max(x)+50,min(y)-10:max(y)+10);
                cant_imag=cant_imag+1
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
                if length(ip1)/length(ip2)>0.3
                    carta= [carta; "Ferrocarril: Pennsylvania"]
                else
                    if length(ip1)/length(ip2)>0.27
                        carta= [carta; "Ferrocarril: Via Rapida"]
                    elseif length(ip1)/length(ip2)<0.245
                        carta= [carta; "Ferrocarril: B & O"]
                    else
                        carta= [carta; "Ferrocarril: Reading"]
                    end
                end
            end
        end
    end
end

if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
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
A=150; %minima cantidad de pixeles que cumplan con el color
ip2=[];
for i=1:K1
    ip=find(V1==i);
    Ap=length(ip);
    if Ap>A & Ap<1200
       A=Ap;
       ip2=ip;
    end
end

if length(ip2)>200 & length(ip2)<480
%     ip_luz=find(S>80 & H>25 & H<50 & V>175 & V<240); %foco
%     Z1=zeros(M,N);
%     Z1(ip_luz)=255;
%     [V1,K1]=bwlabel(Z1,8);
%     [A,ip]=objetomasgrande(V1,K1);
    F=zeros(M,N);
    F(ip2)=255;
    [x,y]=find(F==255);
    X=S(min(x)-50:max(x)+50,min(y)-50:max(y)+50);
    ip_luz=find(X>80 & X>200);
    Z1=zeros(M,N);
    Z1(ip_luz)=255;
    [V1,K1]=bwlabel(Z1,8);
    [A,ip]=objetomasgrande(V1,K1);

    if length(ip)>100 & length(ip)<500
        carta= [carta; "Luz"]
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=I(min(x):max(x)+45,min(y)-30:max(y)+30);
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;

        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end
        
        A=200; %minima cantidad de pixeles que cumplan con el color
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
    if length(ip2)>200 & length(ip2)<500
        carta= [carta; "Agua"]
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=I(min(x)-15:max(x)+40,min(y)-10:max(y)+10);
        cant_imag=cant_imag+1
        figure()
        imshow(uint8(X));
        impixelinfo;
        
        Z=Z-F;
        [V1,K1]=bwlabel(Z,8);
        
        if cant_imag==3
            imag3=X;
            imshow(uint8(imag3),'Parent', handles.prop3);
        else
            if cant_imag==2
                imag2=X;
                imshow(uint8(imag2),'Parent', handles.prop2);
            elseif cant_imag==1
                imag1=X;
                imshow(uint8(imag1),'Parent', handles.prop1);
            end
        end
        
        A=150; %minima cantidad de pixeles que cumplan con el color
        ip2=[];
        for i=1:K1
            ip=find(V1==i);
            Ap=length(ip);
            if Ap>A & Ap<1200
               A=Ap;
               ip2=ip;
            end
        end
        F=zeros(M,N);
        F(ip2)=255;
        [x,y]=find(F==255);
        X=S(min(x)-50:max(x)+50,min(y)-50:max(y)+50);
       
        if length(X)>150 & length(X)<500
            carta= [carta; "Luz"]
            F=zeros(M,N);
            F(ip2)=255;
            [x,y]=find(F==255);
            X=I(min(x):max(x)+45,min(y)-30:max(y)+30);
            cant_imag=cant_imag+1
            figure()
            imshow(uint8(X));
            impixelinfo;
        end
    end
end

if cant_imag==3
    imag3=X;
    imshow(uint8(imag3),'Parent', handles.prop3);
else
    if cant_imag==2
        imag2=X;
        imshow(uint8(imag2),'Parent', handles.prop2);
    elseif cant_imag==1
        imag1=X;
        imshow(uint8(imag1),'Parent', handles.prop1);
    end
end

if length(carta)==3
    color1=split(carta(1));
    color2=split(carta(2));
    color3=split(carta(3));
    c1=erase(color1(1),":");
    c2=erase(color2(1),":");
    c3=erase(color3(1),":");
    set(handles.Name_prop1,'String',carta(1));
    set(handles.Name_prop2,'String',carta(2));
    set(handles.Name_prop3,'String',carta(3));
    set(handles.Color_prop1,'String',c1);
    set(handles.Color_prop2,'String',c2);
    set(handles.Color_prop3,'String',c3);

elseif length(carta)==2
    color1=split(carta(1));
    color2=split(carta(2));
    c1=erase(color1(1),":");
    c2=erase(color2(1),":");
    set(handles.Name_prop1,'String',carta(1));
    set(handles.Name_prop2,'String',carta(2)); 
    set(handles.Color_prop1,'String',c1);
    set(handles.Color_prop2,'String',c2);
elseif length(carta)==1
    color1=split(carta(1));
    c1=erase(color1(1),":");
    set(handles.Name_prop1,'String',carta(1));
    set(handles.Color_prop1,'String',c1); 
else
    color1=split(carta(1));
    color2=split(carta(2));
    color3=split(carta(3));
    c1=erase(color1(1),":");
    c2=erase(color2(1),":");
    c3=erase(color3(1),":");
    set(handles.Name_prop1,'String',carta(1));
    set(handles.Name_prop2,'String',carta(2));
    set(handles.Name_prop3,'String',carta(3));
    set(handles.Color_prop1,'String',c1);
    set(handles.Color_prop2,'String',c2);
    set(handles.Color_prop3,'String',c3);
end 

% --- Executes on button press in Bjugar.
function Bjugar_Callback(hObject, eventdata, handles)
Juego();

% --- Executes on button press in Bopen.
function Bopen_Callback(hObject, eventdata, handles)
    [archiv direc]=uigetfile({'*.jpg';'*.bmp';'*.png';'*.*';'*.jpeg'},'Abrir Imagen');
    if archiv==0
        return
    end
    I  = imread(archiv);                            %CARGA IMAGEN DESDE PC
    imshow(uint8(I),'Parent', handles.captura);       %MUESTRA EN AXES2    
    impixelinfo;
    handles.imag=I;
guidata(hObject,handles);


% --- Executes on button press in Bsave.
function Bsave_Callback(hObject, eventdata, handles)
% hObject    handle to Bsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    folder = 'C:\Users\jorge\Desktop\8vo ciclo\Procesamiento Avanzado de Señales e Imágenes\Lab 2\LAB2-DPS2.0';
    name = strcat('Cartitas(', int2str(handles.Ind), ').jpg');
    imwrite(handles.imag, fullfile(folder,name))
    handles.Ind = handles.Ind + 1;
guidata(hObject,handles);


% --- Executes on button press in Bcamara.
function Bcamara_Callback(hObject, eventdata, handles)
    closepreview;
    handles.Vid = videoinput('winvideo', 2,'RGB24_640x480');
    vidInfo = imaqhwinfo(handles.Vid);
    vidRes = handles.Vid.VideoResolution;
    imWidth = vidRes(1);
    imHeight = vidRes(2);
    numBands = handles.Vid.NumberOfBands;
    
    hImage = image(handles.camara, zeros(imHeight, imWidth, numBands, vidInfo.NativeDataType));
    preview(handles.Vid, hImage);
guidata(hObject,handles);

    