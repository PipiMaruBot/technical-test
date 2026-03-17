# main.m
# Technical Test: Satellite Ground Track Implementation
# Author: Albert González Álvarez
# Date: 17/03/2026

clear all; close all; clc;

# --- 1. CONSTANTS (Team 1 Physical Model) ---
G = 6.67384e-11;      # Gravitational constant [cite: 81]
Me = 5.972e+24;       # Earth Mass [cite: 82]
Oe = 7.2921151467e-5; # Earth rotation angular velocity (rad/s) [cite: 83]
tol = 1e-8;           # Tolerance for convergence [cite: 84]

# --- 2. SATELLITE ALMANAC DATA (Example: PRN-04) ---
# Data source: Week 336 almanac [cite: 93]
id = 4;
e = 0.3467082977e-2;          # Orbit eccentricity [cite: 121]
toa = 405504.0;               # Time of Applicability [cite: 122]
orb_inc = 0.9686693196;       # Orbit inclination [rad] [cite: 122]
d_right_ascen = -0.8000333246e-8; # Rate of Right Ascension [rad/s] [cite: 123]
a = 5153.535645^2;            # Semi-major axis [m] (sqrt(A)^2) [cite: 124]
Lo = 1.915700073;             # Longitude of AN at week epoch [rad] [cite: 125]
perigee_arg = -2.951546441;   # Argument of perigee [rad] [cite: 126]
m_anomaly = 1.843168547;      # Mean Anomaly at ToA [rad] [cite: 127]

# --- 3. INITIAL CALCULATIONS ---
# Longitude of Ascending Node at ToA [cite: 158]
Oo = Lo - Oe * toa; 

# --- 4. GRAPHICAL SETUP (Independent of plotworld) ---
figure(1);
hold on; grid on; box on;
axis([-180 180 -90 90]);
xlabel('Longitude (degrees)');
ylabel('Latitude (degrees)');
title(['Ground Track - Satellite PRN-', num2str(id)]);

# --- 5. ORBITAL LOOP (Step 9) ---
# Calculate orbital period: T = 2*pi*sqrt(a^3/mu) [cite: 132]
T_orbital = 2 * pi * sqrt(a^3 / (G * Me));   
steps = ceil(T_orbital / 300); # 5-minute steps (300 seconds) [cite: 342]

fprintf('Starting ground track calculation for PRN-%d...\n', id);

for i = 0:steps
    dt = i * 300; # Time increment [cite: 342]
    
    # Call the master function that orchestrates the calculation [cite: 334, 340]
    [long, lat] = subsatellite(Oe, G, Me, a, m_anomaly, dt, e, tol, perigee_arg, Oo, d_right_ascen, orb_inc);
    
    # Longitude wrapping to maintain plot within [-180, 180] [cite: 132]
    long_plot = mod(long + 180, 360) - 180;
    
    # Plotting the ground track points [cite: 342]
    plot(long_plot, lat, 'b.', 'MarkerSize', 5);
end

# --- 6. MARK STARTING POSITION (Step 7) ---
[long_start, lat_start] = subsatellite(Oe, G, Me, a, m_anomaly, 0, e, tol, perigee_arg, Oo, d_right_ascen, orb_inc);
long_start_plot = mod(long_start + 180, 360) - 180;

plot(long_start_plot, lat_start, 'r*', 'MarkerSize', 12, 'LineWidth', 2);
text(long_start_plot + 3, lat_start + 2, ['Start (PRN-', num2str(id), ')'], 'Color', 'red', 'FontWeight', 'bold');

fprintf('Calculation finished. Plot generated successfully.\n');
