%% 1:Temperature 2:Pressure 3:Enthalpy 4:Entropy 5:Dryness
clc,clear
close all
%% saturation
% 1&6
orc(1,1)=291.15;
orc(1,5)=0;
[orc(1,2),orc(1,3),orc(1,4)]=refpropm('PHS','T',orc(1,1),'Q',orc(1,5),'R32');
orc(6,1)=orc(1,1);
orc(6,5)=1;
[orc(6,2),orc(6,3),orc(6,4)]=refpropm('PHS','T',orc(6,1),'Q',orc(6,5),'R32');
% 3&4
orc(3,1)=302.15;
orc(3,5)=0;
[orc(3,2),orc(3,3),orc(3,4)]=refpropm('PHS','T',orc(3,1),'Q',orc(3,5),'R32');
orc(4,1)=orc(3,1);
orc(4,5)=1;
[orc(4,2),orc(4,3),orc(4,4)]=refpropm('PHS','T',orc(4,1),'Q',orc(4,5),'R32');

%% overheat
orc(7,1)=348.15;
orc(7,2)=orc(4,2);
[orc(7,3),orc(7,4),orc(7,5)]=refpropm('HSQ','T',orc(7,1),'P',orc(7,2),'R32');

%% pump
eta_p=0.85;
orc(2,2)=orc(3,2);
[orc(2,:),w_p]=pump_orc(orc(1,:),orc(2,:),eta_p,'R32');

%% turbine
eta_t=0.85;
orc(5,2)=orc(6,2);
[orc(5,:),w_t]=turbine_orc(orc(7,:),orc(5,:),eta_t,'R32');

%% efficiency
q=orc(7,3)-orc(2,3);
eta_n=100*(w_t-w_p)/q;

%% plot T_S
plot([orc(1:4,4);orc(7,4);orc(5:6,4);orc(1,4)],[orc(1:4,1);orc(7,1);orc(5:6,1);orc(1,1)],'-*');
