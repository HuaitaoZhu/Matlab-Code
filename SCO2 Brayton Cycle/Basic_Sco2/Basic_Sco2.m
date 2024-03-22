clc,clear
close all;
% 1:Temperature 2:Pressure 3:Enthalpy 4:Entropy
%% initialization
% 1
co2(1,1)=32+273.15;
co2(1,2)=7.6e3;
[co2(1,3),co2(1,4)]=refpropm('HS','T',co2(1,1),'P',co2(1,2),'CO2');
%
co2(2,2)=25e3;
% 4
co2(4,1)=550+273.15;
co2(4,2)=co2(2,2)*(1-0.01)^2;
[co2(4,3),co2(4,4)]=refpropm('HS','T',co2(4,1),'P',co2(4,2),'CO2');

%% compressor
eta_c=0.89;
[co2(2,:),w_c]=pump_(co2(1,:),co2(2,:),eta_c,'CO2');

%% turbine
eta_t=0.7887;
co2(5,2)=co2(1,2)/(1-0.01)^2;
[co2(5,:),w_t]=turbine_(co2(4,:),co2(5,:),eta_t,'CO2');

%% pche
co2(6,1)=co2(2,1)+5;
co2(6,2)=co2(1,2)/(1-0.01);
[co2(6,3),co2(6,4)]=refpropm('HS','T',co2(6,1),'P',co2(6,2),'CO2');
co2(3,3)=co2(2,3)+co2(5,3)-co2(6,3);
co2(3,2)=co2(2,2)*(1-0.01);
[co2(3,1),co2(3,4)]=refpropm('TS','P',co2(3,2),'H',co2(3,3),'CO2');

%% efficiency
q=co2(4,3)-co2(3,3);
eta_n=(w_t-w_c)/q;
eta_pche=(co2(5,1)-co2(6,1))/(co2(5,1)-co2(2,1));

%% plot
plot([co2(:,4);co2(1,4)],[co2(:,1);co2(1,1)]);

