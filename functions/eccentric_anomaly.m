
# Solves Kepler equation for Eccentric Anomaly iteratively
# e   =orbit eccentricity
# M   =Mean Anomaly [rad]
function E = eccentric_anomaly(e, M)
    E0=M;
    iterations=100;
   for i=1:iterations
     E = M +e*sin(E0);
     E0 = E;
  end
end
