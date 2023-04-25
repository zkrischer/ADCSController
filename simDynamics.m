function xdot = odefunc(x,u)
%ODEFUNC Summary of this function goes here
%   Detailed explanation goes here
    
    q1 = x(1);
    q2 = x(2);
    q3 = x(3);
    q4 = x(4);
    wx = x(5);
    wy = x(6);
    wz = x(7);

    Ix = 0.01026573;
    Iy = 0.01026573;
    Iz = 0.00334000;

    I = [Ix,0,0;0,Iy,0;0,0,Iz];
    
    q = [q1;q2;q3];
    w = [wx,wy,wz]';
    qi = q4 * eye(3);
    qCross = [0, -q3, q2;
           q3, 0, -q1;
           -q2, q1, 0];

    qes = [qi + qCross;
            -q1,-q2,-q3];

    omegaCross = [0, -wz, wy;
                  wz, 0, -wx;
                   -wy, wx, 0];
    
    worb = [0,-2*pi/5.8012e+03,0]';
    
    Tbo = (q4^2 - q*q')*eye(3) - 2*q*q' -2*q4*qCross;

    wr = w - Tbo*worb;

    qdot = 0.5 * qes*wr;
    
    wdot = inv(I)*(-omegaCross*I*w + u);

    xdot = [qdot;wdot];
    

    
end

