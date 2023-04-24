function gu = g(u,deltaT,J)
%G Summary of this function goes here
%   Detailed explanation goes here
    gu = [0;0;0;0;
          u(1)/J(1) * deltaT;
          u(2)/J(2) * deltaT;
          u(3)/J(3) * deltaT];
    
end

