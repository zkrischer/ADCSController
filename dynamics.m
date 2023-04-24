function dynX = dynamics(x,deltaT, J)
%DYNAMICS Summary of this function goes here
%   Detailed explanation goes here
    
    q0 = x(1);
    q1 = x(2);
    q2 = x(3);
    q3 = x(4);
    wx = x(5);
    wy = x(6);
    wz = x(7);

    dynX = [q0 - deltaT/2 * (q1*wx + q2*wy + q3*wz);
            q1 + deltaT/2 * (q0*wx - q3*wy + q2*wz);
            q2 + deltaT/2 * (q3*wx + q0*wy - q1*wz);
            q3 + deltaT/2 * (-q2*wx + q1*wy +q0*wz);
            wx + deltaT * ((J(2)-J(3))/J(1) * wy*wz);
            wy + deltaT * ((J(3)-J(1))/J(2) * wz*wx);
            wz + deltaT * ((J(1)-J(2))/J(3) * wx*wy)];
end

