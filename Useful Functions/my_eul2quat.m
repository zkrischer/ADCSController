% AMME5520 Assignments 2023
%
% Converts from Euler Angles to Quaternions
%
% INPUTS:
%   - Phi:      (3x1 array) Euler Angles in order roll, pitch, yaw (x,y,z)
%
% OUTPUTS:
%   - quat:     (4x1 array) quaternion array
%
% Author: Nicholas Barbara
% Email:  nicholas.barbara@sydney.edu.au
%
% quat = Euler2Quat(Phi)

function quat = my_eul2quat(Phi)

    phi2 = Phi(1,:)/2;      % Roll / 2
    theta2 = Phi(2,:)/2;    % Pitch / 2
    psi2 = Phi(3,:)/2;      % Yaw /2
    
    q0 =  cos(psi2)*cos(theta2)*cos(phi2) + sin(psi2)*sin(theta2)*sin(phi2);
    q1 =  cos(psi2)*cos(theta2)*sin(phi2) - sin(psi2)*sin(theta2)*cos(phi2);
    q2 =  cos(psi2)*sin(theta2)*cos(phi2) + sin(psi2)*cos(theta2)*sin(phi2);
    q3 = -cos(psi2)*sin(theta2)*sin(phi2) + sin(psi2)*cos(theta2)*cos(phi2);
    
    quat = [q0; q1; q2; q3];
    
    % Normalise the quaternion
    quat = quat/sqrt(sum(quat.^2));
end