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
Ix = 0.01026573;
Iy = 0.01026573;
Iz = 0.00334000;

I = [Ix,0,0;0,Iy,0;0,0,Iz];
J = [Ix,Iy,Iz]';
%% Initial Conditions for Attitude and Angular Velocity
phi0 = 0;
theta0 = 0;
psi0 = 0;
euler0 = [phi0;theta0;psi0];
quat0 = EulerAngles2Quaternions(euler0);
wx = 0;
wy = 0;
wz = 0;

x0 = [quat0;wx;wy;wz];

%% Simulation Setup
tfinal = 400;
timeStep = 1.0;
tout = 0:timeste:tfinal;


