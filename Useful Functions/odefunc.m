function xdot = odefunc(t,x)
%ODEFUNC Summary of this function goes here
%   Detailed explanation goes here
    
    u = [0;0;0];

    xdot = simDynamics(x,u);
end

