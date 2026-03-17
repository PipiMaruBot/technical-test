# Technical Test: Satellite Ground Track Implementation
#Sources usesd:
#   -https://celestrak.org/GPS/almanac/Yuma/2025/almanac.yuma.week0351.589824.txt
#   -Univertsity powers and documentation
# Author: Albert González Álvarez
# Date: 16/03/2026 - 17/03/2026
clear all;
close all;
clc;
# Gravitational constant
G =6.67384e-11;
# Earth Mass
Me =5.972e+24;
# Earth rotation angular velocity
Oe =7.2921151467e-5;
# Tolerance for convergence
tol =1e-8;

# Week 351 almanac
id =1;
#eccentricity
e =0.1305580139e-2;
#time of applicability in seconds
toa =589824.0;
#orbital inclination in rads
orb_inc =0.9583449099;
#Rate of right ascension
d_right_ascen =-0.8137481816e-8;
#a axis in meters
a =5153.586426^2;
#Right ascen at week
Lo =-2.021357493;
#Argument of perigee
perigee_arg =-0.049845762;
#mean anomaly in radians
m_anomaly =0.2014847812;

# Longitude of Ascending Node at toa
Oo =Lo-Oe*toa;

figure();
hold on;
grid on;
box on;
axis([-180 180 -90 90]);
xlabel('Longitude (degreees)');
ylabel('Latitude (degrees)');
title(['Ground Track Satellite ']);

T_orbital = 2*pi*sqrt(a^3/(G*Me));
steps = ceil(T_orbital / 60);
fprintf('Starting ground track calculation for PRN 4');
# orbital period with 60 secods steps--> the graph plots better
#Also due to some problems with coordinates of the plot and I had to use some AI for this part.

for i = 0:steps
    dt = i * 300;
    [long, lat] = subsatellite(Oe, G, Me, a, m_anomaly, dt, e, tol, perigee_arg, Oo, d_right_ascen, orb_inc);

    idx = i + 1;
    latitudes(idx) = lat;
    longitudes(idx) = long;

    long_plot = mod(long + 180, 360) - 180;

    plot(long_plot, lat, 'b.', 'MarkerSize', 5);
end

#Plot of the satellite position for instant T=0 seconds
dt0=0;
[long_start, lat_start] = subsatellite(Oe, G, Me, a, m_anomaly, dt0, e, tol, perigee_arg, Oo, d_right_ascen, orb_inc);
long_start_plot = mod(long_start + 180, 360) - 180;
plot(long_start_plot, lat_start, 'r*', 'MarkerSize', 5, 'LineWidth', 2);

#End use of AI, the problem was i was ploting long and lat and the draw was breaking,so i had to search for a solution in order to obtain
#line that surrounds the earth.

fprintf('Plot generated');
