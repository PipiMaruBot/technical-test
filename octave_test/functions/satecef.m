# satecef.m
# satellite ECEF coordinates
# Oe =Earth rotation angular velocity
# Oo =longitude of Ascending Node at ToA
# dO =Rate of Right Ascension of AN
# dt =seconds elapsed after ToA
# io =orbit inclination
# xp, yp = current cartesian orbital coordinates
function ecef = satecef(Oe, Oo, dO, dt, io, xp, yp)

    Oo_corrected =Oo +dO*dt;
    O =Oo_corrected -Oe*dt;

    # TRANSFORMATION TO ECEF
    x =xp*cos(O)-yp*cos(io)*sin(O);
    y =xp*sin(O)+yp*cos(io)*cos(O);
    z =yp*sin(io);


    ecef=[x,y,z];
end
