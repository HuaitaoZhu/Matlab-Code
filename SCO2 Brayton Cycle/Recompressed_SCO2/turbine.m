
%%    Isentropic turbine model
%     [parameter values after expansion,work of expansion]=compressor_(Parameter values before expansion,turbine oulet(only pressure),Isentropic efficiency of a turbine,fluid typre)
%     [tur2,wt]=turbine(tur1,tur2,eta_t,fluid)
%
%     eta_t=0.90; %Isentropic efficiency of turbine
%     fluid='co2'; %fluid typre
%     tur1=[823.15,25e3]; %Parameter values before expansion(Temperature and Pressure)
%     [tur1(3),tur1(4)]=refpropm('HS','T',tur1(1),'P',tur1(2),fluid); %Parameter values before expansion(Enthalpy and Entropy)
%     tur2=zeros(1,4);  %The input must be one row and four columns
%     tur2(2)=7.6e3; %Compressed parameter values(only pressure)
%     [tur2,wt]=turbine(tur1,tur2,eta_t,fluid) %Calculation of functions
%%
function [tur2,wt]=turbine(tur1,tur2,eta_t,fluid)
tur(1,:)=tur1;
tur(2,:)=tur2;
[~,h2i]=refpropm('TH','P',tur(2,2),'S',tur(1,4),fluid);
wt=(tur(1,3)-h2i)*eta_t;
tur(2,3)=tur(1,3)-wt;
[tur(2,1),tur(2,4),tur(2,5)]=refpropm('TSD','P',tur(2,2),'H',tur(2,3),fluid);
tur2=tur(2,:);
end