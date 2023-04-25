function [xdot] = dynamics(x,dt)
%DYNAMICS Summary of this function goes here
%   Detailed explanation goes here

    J = [0.01026573;0.01026573;0.00334000];
    q0 = x(1);
    qx = x(2);
    qy = x(3);
    qz = x(4);
    wx = x(5);
    wy = x(6);
    wz = x(7);

    xdot = [q0 - dt/2 * (qx*wx + qy*wy + qz*wz);
            qx + dt/2 * (q0*wx - qz*wy + qy*wz);
            qy + dt/2 * (qz*wx + q0*wy - qx*wz);
            qz + dt/2 * (-qy*wx + qx*wy +q0*wz);
            wx + dt*((J(2)-J(3))/J(1) * wy*wz);
            wy + dt*((J(3)-J(1))/J(2) * wz*wx);
            wz + dt*((J(1)-J(2))/J(3) * wx*wy)];

    
end

