# true_anomaly.m
# Computes True Anomaly 
# e =orbit eccentricity
# E =Eccentric Anomaly [rad]
function v = true_anomaly(e,E)

    sin =sqrt(1-e^2)*sin(E)/(1-e*cos(E));
    cos =(cos(E)-e)/(1-e*cos(E));
    v =atan2(sin,cos);
    
end
