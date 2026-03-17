# subsatellite.m
# Computes (lat, long) [degrees] of sub-satellite point
function [long, lat] = subsatellite(Oe, G, Me, a, Mo, dt, e, tol, w, Oo, dO, io)
    M = mean_anomaly(G, Me, a, Mo, dt);
    E = eccentric_anomaly(e, M);
    v = true_anomaly(e, E);
    [xp, yp] = orbitcoords(v, w, a, e, E);
    ecef = satecef(Oe, Oo, dO, dt, io, xp, yp);
    lla =ecef2lla(ecef);
    lat =lla(1);
    long =lla(2);
end
