%% Initialize
clear
clc
close all

rng('default');

% Parameter Intialisation
addpath 'aerospace-main/igrf/'
nextMagUpdate = 1;
lastMagUpdate = 0;

%%%Get Planet Parameters
planet




%% Simulate Measurements
% Simulates the Gyroscope
params = gyroparams;
N = 2000;
Fs = 10;
Fc = 0.25;
dt = 1/Fs;
t = (0:dt:((N-1)/Fs)).';
acc = zeros(N, 3);
angvel = zeros(N, 3);
angvel(:,1) = sin(2*pi*Fc*t);
angvel(:,2) = sin(2*pi*Fc*t + pi/4);
angvel(:,3) = -0.2;

imu = imuSensor('SampleRate', Fs, 'Gyroscope', params);
imu.Gyroscope.NoiseDensity = 0.0125;
[~, y] = imu(acc, angvel);

v(:,1) = 7.5*sin(2*pi*Fc*t) + 7.5;
v(:,2) = 7.5*sin(2*pi*Fc*t - pi/4) + 7.5;
v(:,3) = 7.5*sin(2*pi*Fc*t + pi/4) + 7.5;

for i=1:length(y)
    y(i,4) = atan2(v(i,1),v(i,2));
    y(i,5) = atan2(v(i,3),sqrt(v(i,1)^2 + v(i,2)^2));
end

%%%Get mass and inertia properties
syms q0 qx qy qz wx wy wz Tx Ty Tz
syms Vx Vy Vz 

X = [q0;qx;qy;qz;wx;wy;wz];
U = [Tx;Ty;Tz];
V = [Vx;Vy;Vz];
% Initialise Covariance Matrix
P = eye(7)*1e-3;

% Get the Symbolic Jacobian
fx = dynamics(X,dt);
JA = jacobian(fx,X);
%gx = g(U,dt);

cx = observe(X,V);
JC = jacobian(cx,X);


% Initialise Error Matrices
sigmaModel = 0.01;
Q = eye(7)*sigmaModel;

sigmaGyro = 0.01;
sigmaSun = 0.5;
R = eye(3);
R(1,1) = sigmaGyro;
R(2,2) = sigmaGyro;
R(3,3) = sigmaGyro;
R(4,4) = sigmaSun;
R(5,5) = sigmaSun;



%% Dynamics Test
q1 = 0.6853;
q2 = 0.6853;
q3 = 0.1531;
q4 = 0.1531;
wx = .2e-1;
wy = .44e-1;
wz = .05e-1;
xRef = [q1;q2;q3;q4;wx;wy;wz];
u = [0;0;0];
[tout,xout] = ode15s(@v,t,xRef);

plot(tout,xout(:,1:3))
figure
plot(tout,xout(:,4))
figure
plot(tout,xout(:,5:7))

% The simulated data is the measurement input to the state.
% We assume the Longitude and Latitude is constant in order to simulate
% appropriate sun sensor input to the system. Another reason why the sim
% time is small
% Also use this time to calculate the magnetic field
lon = 151;
lat = -33.86;
sun = sunSensor(lon,lat);
[BN,BE,BD] = igrf('01-Jan-2020',lat,lon,375e3,'geocentric');
BNED = [BN;BE;BD];
BI = TIB(sun(1),sun(2),sun(3))*BNED;

%% EKF
q0 = 1;
qx = 0;
qy = 0;
qz = 0;
wx = 0;
wy = 0;
wz = .01;
x0 = [q0;qx;qy;qz;wx;wy;wz];
xfin(:,1) = x0;

for i=1:length(t)-1
    x = xfin(:,i);
    xk = dynamics(x,dt) + g(u,dt);

    % Calculate the A jacobian
    A = double(vpa(simplify(subs(JA,X,x))));

    % Calculate the new prediction covariance matrix
    Pk = A*P*A' + Q;
 
    % Now I need to obtain both the C matrix and c(x)
    C = double(vpa(simplify(subs(JC,[X;V],[x;sun(1:3)']))));
    cx = observe(x,sun(1:3)');
    
    %disp([xout(i,5:7),y(i,4:5)]' - cx')
    %disp([xout(i,5:7)] - cx)
    disp(rank(obsv(A,C)))
    % Calculate the Kalman Gain
    Lk = Pk*C'*inv(C*Pk*C' + R);
    
    xk = xk + Lk*([xout(i,5:7),sun(4:5)]' - cx');
    %xk = xk + Lk*([xout(i,5:7)]' - cx');
    P = (eye(7) - Lk*C)*Pk;
    xfin(:,i+1) = xk;

    % Calculate Bdot input
    BB = TIBquat(xk(1:4))'*BI;
    
    % Convert to Tesla
    BB = BB*1e-9;

    % Need to decide whether to do bdot or not
    % If within bounds of our target pointing, do pointing
    % Else do bdot
    
    

end


%% Plotting
xfin = xfin';
figure
plot(t,xfin(:,1:3))
figure
plot(t,xfin(:,4))
figure
plot(t,xfin(:,5:7))


%% Now is the control part of the flow chart
% The
