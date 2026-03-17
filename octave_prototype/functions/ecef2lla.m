# ecef2lla.m
function lla = ecef2lla(ecef)
    x = ecef(1);
    y = ecef(2);
    z = ecef(3);

    # WGS-84
    
    a=6378137.0; 
    e2=0.00669437999014; 
    
    # UNI FORMULAS, DIAPO48 ESTOY SIGUIENDO EL PROCEDIMIENTO DE CONVERSION DE CORDENADAS CARTESIANAS A GEODÉSICAS
    
    r =sqrt(x^2+y^2);
    
    E2 =a^2-(a^2*(1-e2)); 
    
    F =54*(a^2*(1-e2))*z^2;
    
    G =r^2+(1-e2)*z^2-e2*E2;
    
    c =(e2^2*F*r^2)/(G^3);
    
    s =(1+c+sqrt(c^2+2*c))^(1/3);
    
    P =F/(3*(s+1/s+1)^2*G^2);
    
    Q =sqrt(1+2*e2^2*P);
    
    r0 =-(P*e2*r)/(1+Q)+sqrt(0.5*a^2*(1+1/Q)-P*(1-e2)*z^2/(Q*(1+Q))-0.5*P*r^2);
    
    U =sqrt((r-e2*r0)^2+z^2);
    
    V =sqrt((r-e2*r0)^2+(1-e2)*z^2);
    
    z0 =(a^2*z)/(a*V);

    lat_rad = atan2((z+e2*z0),r);  
    long_rad = atan2(y,x);             
    alt =U*(1-(a^2 /V^2));   

    lat =lat_rad*180/pi;
    long =long_rad*180/pi;

    lla = [lat, long, alt];
end
