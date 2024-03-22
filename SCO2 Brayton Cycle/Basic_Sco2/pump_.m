function [pump_2,w_p]=pump_(pump_1,pump_2,eta_p,fluid)
    pump_2_s(4)=pump_1(4);
    pump_2_s(2)=pump_2(2);
    [pump_2_s(3)]=refpropm('H','P',pump_2_s(2),'S',pump_2_s(4),fluid);
    w_p_s=pump_2_s(3)-pump_1(3);
    w_p=w_p_s/eta_p;
    pump_2(3)=pump_1(3)+w_p;
    [pump_2(1),pump_2(4)]=refpropm('TS','P',pump_2(2),'H',pump_2(3),fluid);
end