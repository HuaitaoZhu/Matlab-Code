clc,clear
close all
%% parameter definition
para.m_co2=100;
para.eta_c1=0.89;
para.tmax=550+273.15;
para.pmax=25e3;
para.tm=32+273.15;
para.pm=7.6e3;
rs=0.6683;
%% initilization
co2(4,1)=para.tmax;
co2(2,2)=para.pmax;
co2(1,1)=para.tm;
co2(1,2)=para.pm;
%compressor inlet
[co2(1,3),co2(1,4),co2(1,5)]=refpropm('HSD','T',co2(1,1),'P',co2(1,2),'CO2');

%% cycle
% pressure
co2(7,2)=co2(2,2);
co2(8,2)=co2(7,2);
co2(9,2)=co2(7,2);
co2(3,2)=co2(9,2);
co2(4,2)=co2(3,2);
co2(6,2)=co2(1,2);
co2(10,2)=co2(6,2);
co2(5,2)=co2(10,2);

% turbine inlet 
[co2(4,3),co2(4,4),co2(4,5)]=refpropm('HSD','T',co2(4,1),'P',co2(4,2),'CO2');
% turbine
para.eta_t1=0.8097;
[co2(5,:),wt(1)]=turbine(co2(4,:),co2(5,:),para.eta_t1,'CO2');

% compressor
[co2(2,:),wc(1)]=compressor_(co2(1,:),co2(2,:),para.eta_c1,'CO2');

% LTR
co2(6,1)=co2(2,1)+5;
[co2(6,3),co2(6,4),co2(6,5)]=refpropm('HSD','T',co2(6,1),'P',co2(6,2),'CO2');

% re-compressor
[co2(8,:),wc(2)]=compressor_(co2(6,:),co2(8,:),para.eta_c1,'CO2');

% HTR and LTR
co2(3,3)=rs*co2(2,3)+(1-rs)*co2(8,3)+co2(5,3)-co2(6,3);
[co2(3,1),co2(3,4),co2(3,5)]=refpropm('TSD','P',co2(3,2),'H',co2(3,3),'CO2');

%% HEX
co2(7,:)=co2(8,:);
co2(9,:)=co2(8,:);
co2(10,3)=co2(5,3)-co2(3,3)+co2(9,3);
[co2(10,1),co2(10,4),co2(10,5)]=refpropm('TSD','P',co2(10,2),'H',co2(10,3),'CO2');

%% post
Wt_co2=para.m_co2*wt(1);
Wc_co2=rs*para.m_co2*wc(1)+(1-rs)*para.m_co2*wc(2);
Wc_co2_1=rs*para.m_co2*wc(1);
Wc_co2_2=(1-rs)*para.m_co2*wc(2);
Q_co2=para.m_co2*(co2(4,3)-co2(3,3));
n_co2=(Wt_co2-Wc_co2)/Q_co2;


%%
para.node1=100;%nodes number of PCHE of co2-co2
[dt_co2_1,hot_co2_1,cold_co2_1,Q_n_1]=segmented(co2(10,:),co2(6,:),para.m_co2,'CO2',co2(2,:),co2(7,:),rs*para.m_co2,'CO2',para.node1);
[dt_co2_2,hot_co2_2,cold_co2_2,Q_n_2]=segmented(co2(5,:),co2(10,:),para.m_co2,'CO2',co2(9,:),co2(3,:),para.m_co2,'CO2',para.node1);

figure_user(co2,hot_co2_1,hot_co2_2,cold_co2_1,cold_co2_2);
