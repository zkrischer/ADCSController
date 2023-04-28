function sunBearing = sunSensor(longitude,latitude)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    t = (juliandate(datetime('now')) - 2451545.0) *86400;
    
    sigma = 4.8908198 + 1.9910638e-7 * t;
    
    sELL = [cos(sigma);sin(sigma);0];
    
    eps = 0.409049;
    rEllEci = [1,0,0;0,cos(eps),-sin(eps);0,sin(eps),cos(eps)];

    sECI = rEllEci*sELL;

    longECI = longitude + 1.7447674 + 7.292115e-5 * t;

    RlongECILLF = [-sin(longECI), cos(longECI), 0;
                   -cos(longECI),-sin(longECI), 0;
                   0,0,1];

    RlatECILLF = [1,0,0;
                  0, sin(latitude), cos(latitude);
                  0,-cos(latitude), sin(latitude)];

    sLLF = RlatECILLF*RlongECILLF*sECI;
    sunBearing(1:3) = sLLF;
    sunBearing(4) = atan2(sLLF(1),sLLF(2));
    sunBearing(5) = atan2(sLLF(3),sqrt(sLLF(1)^2 + sLLF(2)^2));
end