function [A,ip1] = objetomasgrande(V,K)

A=500; %minima cantidad de pixeles que cumplan con el color
ip1=[];
for i=1:K
    ip=find(V==i);
    Ap=length(ip);
    if Ap>A
       A=Ap;
       ip1=ip;
    end;       
end;    

%     F=zeros(M,N);
%     F(ip2)=255;
%     [x,y]=find(F==255);
%     X=I(min(x):max(x),min(y):max(y));
%     figure(2)
%     imshow(uint8(X));
%     impixelinfo;
%     
%     Z=Z-F;





