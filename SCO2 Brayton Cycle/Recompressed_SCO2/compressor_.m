
%%     Isentropic compressor model
%     Pay attention to the underscore after this function, as MATLAB already has a 'compressor' function. 
%     Therefore, we need to add an underscore to distinguish it.
%
%     [Compressed parameter values,work of compression]=compressor_(Parameter values before compression,Compressed parameter values(only pressure),Isentropic efficiency of a compressor or pump,fluid typre)
%     [comp2,wc]=compressor_(comp1,comp2,eta_c,fluid)
%
%     eta_c=0.90; %Isentropic efficiency of compressor or pump
%     fluid='co2'; %fluid typre
%     comp1=[305.15,7.6e3]; %Parameter values before compression(Temperature and Pressure)
%     [comp1(3),comp1(4)]=refpropm('HS','T',comp1(1),'P',comp1(2),fluid); %Parameter values before compression(Enthalpy and Entropy)
%     comp2=zeros(1,4);  %The input must be one row and four columns
%     comp2(2)=25e3; %Compressed parameter values(only pressure)
%     [comp2,wc]=compressor_(comp1,comp2,eta_c,fluid) %Calculation of functions
%%
function [comp2,wc]=compressor_(comp1,comp2,eta_c,fluid)
comp(1,:)=comp1;
comp(2,:)=comp2;
[t2i,h2i]=refpropm('TH','P',comp(2,2),'S',comp(1,4),fluid);
wc=(h2i-comp(1,3))/eta_c;
comp(2,3)=comp(1,3)+wc;
[comp(2,1),comp(2,4),comp(2,5)]=refpropm('TSD','P',comp(2,2),'H',comp(2,3),fluid);
comp2=comp(2,:);
wc;
end