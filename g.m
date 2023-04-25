function gu = g(u,dt)
%G Summary of this function goes here
%   Detailed explanation goes here

    J = [0.01026573;0.01026573;0.00334000];
    gu = [0;0;0;0;
          u(1)/J(1) *dt;
          u(2)/J(2) *dt;
          u(3)/J(3) *dt];
    
end

