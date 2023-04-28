function cx = observe(X,V)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % Take the angular velocities

    cx(1) = X(5);
    cx(2) = X(6);
    cx(3) = X(7);

    dcm = my_quat2dcm(X(1:4));
    
    % Get sun vector
    V = V/15;
    sun_b = dcm*V;

    cx(4) = atan2(sun_b(1),sun_b(2));
    cx(5) = atan2(sun_b(3),sqrt(sun_b(1)^2 + sun_b(2)^2));


end