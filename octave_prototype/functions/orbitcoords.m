# orbitcoords.m
# Computes cartesian coordinates of satellite within the orbital plane
# v =true anomaly (rad)
# w =argument of perigee (rad)
# a =semi-major axis (m)
# e =orbit eccentricity
# E =eccentric anomaly (rad)
function[xp,yp] =orbitcoords(v,w,a,e,E)

# distance from the Earth center to the satellite
    r =a*(1-e*cos(E));
    # Argument of latitude
    u =v+w;
    
    # Cartesian coordinates
    xp= r*cos(u);
    yp= r*sin(u);
end
