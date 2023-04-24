%% Initialize
clear
clc
close all

% Parameter Intialisation
addpath 'aerospace-main/igrf/'
nextMagUpdate = 1;
lastMagUpdate = 0;

%%%Get Planet Parameters
planet

%%%Get mass and inertia properties
syms Ix Iy Iz q0 q1 q2 q3 wx wy wz deltaT
% Ix = 0.01026573;
% Iy = 0.01026573;
% Iz = 0.00334000;

I = [Ix,0,0;0,Iy,0;0,0,Iz];
J = [Ix,Iy,Iz]';
% % Initial Conditions for Attitude and Angular Velocity
% phi0 = 0;
% theta0 = 0;
% psi0 = 0;
% euler0 = [phi0;theta0;psi0];
% quat0 = EulerAngles2Quaternions(euler0);
% wx = 0;
% wy = 0;
% wz = 0;

x = [q0;q1;q2;q3;wx;wy;wz];
fx = dynamics(x,deltaT,J);

A = jacobian(fx,x);

syms Tx Ty Tz
u = [Tx;Ty;Tz];
gu = g(u,deltaT,J);

%
qinit = [0.6853, 0.6953, 0.1531, 0.1531]';
winit = [2, 4, 0.5]' * 1e-2;
x = [qinit;winit];
odefunc(x,u)

%% Simulation Setup
tfinal = 400;
timeStep = 1.0;
tout = 0:timeStep:tfinal;


