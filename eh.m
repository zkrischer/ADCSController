% Define initial state vector
x0 = [0; 0; 0; 0; 0; 0; 1; 0; 0; 0];

% Define initial covariance matrix
P0 = eye(10);

% Define process noise covariance matrix
Q = eye(10);

% Define measurement noise covariance matrix
R = eye(6);

% Define time step
dt = 1;

% Define system model (assuming constant velocity)
A = [eye(3) dt*eye(3) zeros(3) zeros(3);     zeros(3) eye(3) zeros(3) zeros(3);     zeros(3) zeros(3) eye(3) dt*eye(3);     zeros(3) zeros(3) zeros(3) eye(3)];
B = zeros(10,3);
u = zeros(3,1);

% Define measurement model (assuming GPS and gyro measurements)
H = [eye(3) zeros(3) zeros(3) zeros(3);     zeros(3) zeros(3) eye(3) zeros(3)];
C = zeros(6,10);
z = zeros(6,1);

% Generate simulated data
t = 0:dt:100;
N = length(t);
x_true = zeros(10,N);
y_true = zeros(6,N);
y_meas = zeros(6,N);
for i=1:N
    x_true(:,i) = [sin(0.01*i); cos(0.01*i); 0; 0.01*cos(0.01*i); -0.01*sin(0.01*i); 0; 0; 0; sin(0.005*i); cos(0.005*i)];
    y_true(:,i) = H*x_true(:,i);
    y_meas(:,i) = y_true(:,i) + sqrt(R)*randn(6,1);
end

% Initialize EKF
x_hat = x0;
P_hat = P0;
x_est = zeros(10,N);

% EKF loop
for i=1:N-1
    % Prediction step
    x_hat = A*x_hat + B*u;
    P_hat = A*P_hat*A' + Q;
    
    % Update step
    y = y_meas(:,i+1);
    y_hat = H*x_hat;
    C = H*P_hat*H' + R;
    K = P_hat*H'*inv(C);
    x_hat = x_hat + K*(y - y_hat);
    P_hat = (eye(10) - K*H)*P_hat;
    
    x_est(:,i+1) = x_hat;
end

% Plot results
figure;
subplot(2,5,1); plot(t,x_true(1,:)); title('Position X true');
subplot(2,5,2); plot(t,x_true(2,:)); title('Position Y true');
subplot(2,5,3); plot(t,x_true(3,:)); title('Position Z true');
subplot(2,5,4); plot(t,x_true(4,:)); title('Velocity X true');
subplot(2,5,5); plot(t,x_true(5,:)); title('Velocity Y true');
subplot(2,5,6); plot(t,x_true(6,:)); title('Velocity Z true');
subplot(2,5,7); plot(t,x_true(7,:)); title('Quaternion W true');
subplot(2,5,8); plot(t,x_true(8,:)); title('Quaternion W true');
subplot(2,5,9); plot(t,x_true(9,:)); title('Quaternion X true');
subplot(2,5,10); plot(t,x_true(10,:)); title('Quaternion Y true');

figure;
subplot(2,5,1); plot(t,x_est(1,:)); title('Position X estimate');
subplot(2,5,2); plot(t,x_est(2,:)); title('Position Y estimate');
subplot(2,5,3); plot(t,x_est(3,:)); title('Position Z estimate');
subplot(2,5,4); plot(t,x_est(4,:)); title('Velocity X estimate');
subplot(2,5,5); plot(t,x_est(5,:)); title('Velocity Y estimate');
subplot(2,5,6); plot(t,x_est(6,:)); title('Velocity Z estimate');
subplot(2,5,7); plot(t,x_est(7,:)); title('Quaternion W estimate');
subplot(2,5,8); plot(t,x_est(8,:)); title('Quaternion X estimate');
subplot(2,5,9); plot(t,x_est(9,:)); title('Quaternion Y estimate');
subplot(2,5,10); plot(t,x_est(10,:)); title('Quaternion Z estimate');
