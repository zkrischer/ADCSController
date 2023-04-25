% AMME5520 Assignments 2023
%
% Compute direction cosine matrix from quaternion.
%
% INPUTS:
%   - q:        (4x1 array) quaternion array
%
% OUTPUTS:
%   - mat:      (3x3 array) direction cosine (rotation) matrix 
%
% Author: Nicholas Barbara
% Email:  nicholas.barbara@sydney.edu.au
%
% mat = my_quat2dcm(quat)

function mat = my_quat2dcm(q)

    % Compute each element of DCM
    if isnumeric(q), mat = NaN(3,3); else, mat = sym(zeros(3,3)); end
    mat(1,1) = q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2;
    mat(1,2) = 2 * (q(2)*q(3) + q(1)*q(4));
    mat(1,3) = 2 * (q(2)*q(4) - q(1)*q(3));
    mat(2,1) = 2 * (q(2)*q(3) - q(1)*q(4));
    mat(2,2) = q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2;
    mat(2,3) = 2 * (q(3)*q(4) + q(1)*q(2));
    mat(3,1) = 2 * (q(1)*q(3) + q(2)*q(4));
    mat(3,2) = 2 * (q(3)*q(4) - q(1)*q(2));
    mat(3,3) = q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2;
end