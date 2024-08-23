function []=figure_user(co2,hot_co2_1,hot_co2_2,cold_co2_1,cold_co2_2)
%% T-S of re_co2

com=zeros(100,5);%compressor
hea=zeros(100,5);%heater
tur=zeros(100,5);%turbine

% pump
com(1,:)=co2(1,:);
dp=(co2(2,2)-co2(1,2))/100;
ds=(co2(2,4)-co2(1,4))/100;
% heater
hea(1,:)=co2(3,:);
hea(:,2)=co2(3,2);
dt=(co2(4,1)-co2(3,1))/100;
% turbine
tur(1,:)=co2(4,:);
ds2=(co2(5,4)-co2(4,4))/100;
dp2=(co2(4,2)-co2(5,2))/100;


%Calculation of entropy
for i=1:99
    com(i+1,2)=com(i,2)+dp;
    com(i+1,4)=com(i,4)+ds;
    [com(i+1,1),com(i+1,6)]=refpropm('TQ','P',com(i+1,2),'S',com(i+1,4),'CO2');
    hea(i+1,1)=hea(i,1)+dt;
    [hea(i+1,3),hea(i+1,4)]=refpropm('HS','T',hea(i+1,1),'P',hea(i+1,2),'CO2');
    tur(i+1,2)=tur(i,2)-dp2;
    tur(i+1,4)=tur(i,4)+ds2;
    [tur(i+1,1),tur(i+1,6)]=refpropm('TQ','P',tur(i+1,2),'S',tur(i+1,4),'CO2');
end

%Calculation of saturation line
for i=1:101
    T(i)=278.5+i*0.25;
    S1(i)=refpropm('S','T',T(i),'Q',0,'CO2');
    S2(i)=refpropm('S','T',T(i),'Q',1,'CO2');
end

%plot
plot(com(:,4),com(:,1));
hold on;
title('T-s of re-sco2');
plot(hot_co2_1(:,4),hot_co2_1(:,1));
plot(hot_co2_2(:,4),hot_co2_2(:,1));
% plot(hot_co2_3(:,4),hot_co2_3(:,1));
plot(cold_co2_1(:,4),cold_co2_1(:,1));
plot(cold_co2_2(:,4),cold_co2_2(:,1));
plot(hea(:,4),hea(:,1));
plot(tur(:,4),tur(:,1));
plot(S1,T);
plot(S2,T);
[TT,SS]=refpropm('TS','C',0,' ',0,'co2');
line([S1(end),SS,S2(end)],[T(end),TT,T(end)]);
hold off;
end