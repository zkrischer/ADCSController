% Initialise State Vector
x = [1;0;0;0;0;0;0];

% Initialise Covariance matrix
P = eye(7)*1e-3;

% Initialise inertia matrices
Ix = 0.01026573;
Iy = 0.01026573;
Iz = 0.00334000;

I = [Ix,0,0;0,Iy,0;0,0,Iz];
J = [Ix,Iy,Iz]';

% Measurement Noise Covariance Matrix
sigmaGyro = 0.25;
sigmaSun = 0.1;
R = diag([sigmaGyro, sigmaGyro, sigmaGyro, sigmaSun, sigmaSun]);

% Simulation parameters
dt = 1;
tfinal = 300;
t = 0:dt:tfinal;
N = length(t);

% Establish a True angular velocity
omega = [.1;.2;.3];

% Preallocate memory for state and measurement vectors
xhat = zeros(7,N);
z = zeros(5);

% Generate measurements
for i=1:N
    % Compute true orientation
    q_true = x(1:4);
    omega_true = omega;
    qdot = dynamics([q_true;omega_true],J)