function [turbine_2,w_t]=turbine_(turbine_1,turbine_2,eta_t,fluid)
    turbine_2_s(4)=turbine_1(4);
    turbine_2_s(2)=turbine_2(2);
    [turbine_2_s(3)]=refpropm('H','P',turbine_2_s(2),'S',turbine_2_s(4),fluid);
    w_t_s=turbine_1(3)-turbine_2_s(3);
    w_t=w_t_s*eta_t;
    turbine_2(3)=turbine_1(3)-w_t;
    [turbine_2(1),turbine_2(4)]=refpropm('TS','P',turbine_2(2),'H',turbine_2(3),fluid);
end