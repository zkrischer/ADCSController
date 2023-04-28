function xdot = odefuncTweet(t,x)
%ODEFUNC Summary of this function goes here
%   Detailed explanation goes here
    
    u = [0;0;0];
    dt = 0.1;
    xdot = simDynamics(x,dt) + g(u,dt);
end

