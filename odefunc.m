function xdot = odefunc(x,u)
%ODEFUNC Summary of this function goes here
%   Detailed explanation goes here
    
    q0 = x(1);
    q1 = x(2);
    q2 = x(3);
    q3 = x(4);
    wx = x(5);
    wy = x(6);
    wz = x(7);

    t = q0 * eye(3);
    tes = [0, -q3, q2;
           q3, 0, -q1;
           -q2, q1, 0];

    qes = [t + tes;
            q1,q2,q3];
    
    worb = [0,-2*pi/5.8012e+03,0]';

    
end

