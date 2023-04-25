function A = aJacobian(x,J)
%AJACOBIAN Summary of this function goes here
%   Detailed explanation goes here
    
    Ix = 0.01026573;
    Iy = 0.01026573;
    Iz = 0.00334000;

    dt = .1;

    syms q0 qx qy qz wx wy qz

    A = eye(7);
    
    % First Row
    A(1,:) = [1 -wx*dt/2 -wy*dt/2 -wz*dt/2 -qx*dt/2 -qy]
end

