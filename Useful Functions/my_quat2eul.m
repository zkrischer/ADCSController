% AMME5520 Assignments 2023
%
% Function to convert quaternions to Euler angles.
%
% INPUTS:
%   - quat:     (4x1) array of quaternion elements
%
% OUTPUTS:
%   - euls:     (3x1) array of Euler angles (roll,pitch,yaw) about (x,y,z)
%
% Author: Nicholas Barbara
% Email:  nicholas.barbara@sydney.edu.au
% 
% euls = my_quat2eul(quats)

function euls = my_quat2eul(quat)
    
    % Split into each quaternion components
    q0 = quat(1);
    q1 = quat(2);
    q2 = quat(3);
    q3 = quat(4);

    % Compute the components
    phi   = atan2((q2*q3 + q0*q1), (q0^2 + q3^2 - 0.5));
    theta = atan2((q0*q2 - q1*q3), sqrt((q0^2 + q1^2 - 0.5)^2 + (q1*q2 + q0*q3)^2));
    psi   = atan2((q1*q2 + q0*q3), (q0^2 + q1^2 - 0.5));

    % Return angles
    euls = [phi; theta; psi];
end