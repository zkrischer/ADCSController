% Moment of Inertia of Satellite
Jx =  0.01026573;
Jy = Jx;
Jz = 0.00334000;
J = [Jx,0,0;0,Jy,0;0,0,Jz];

% Sate Vector Definition
syms q0 q1 q2 q3 wx wy wz

q = [q0,q1,q2,q3]';
w = [wx,wy,wz]';
x = [q;w];

omega = [0, -wx, -wy, -wz;
         wx, 0,  wz,  -wy;
         wy, -wz, 0,   wx;
         wz, wy,  -wx,  0];

epsilon = [-q1, -q2, -q3;
            q0, -q3,  q2;
            q3,  q0, -q1;
           -q2,  q1,  q0];

wdot = inv(J)*(cross(w,J*w));