import math
import matplotlib.pyplot as plt

# math functions for the satellite
def mean_anomaly(G, Me, a, Mo, dt):
    mu = G * Me
    n = math.sqrt(mu / (a**3))
    return Mo + n * dt

def eccentric_anomaly(e, M):
    E = M
    for _ in range(100):
        E = M + e * math.sin(E)
    return E

def true_anomaly(e, E):
    s = math.sqrt(1.0 - e**2) * math.sin(E) / (1.0 - e * math.cos(E))
    c = (math.cos(E) - e) / (1.0 - e * math.cos(E))
    return math.atan2(s, c)

def orbitcoords(v, w, a, e, E):
    r = a * (1.0 - e * math.cos(E))
    u = v + w
    return r * math.cos(u), r * math.sin(u)

def satecef(Oe, Oo, dO, dt, io, xp, yp):
    O = (Oo + dO * dt) - (Oe * dt)
    x = xp * math.cos(O) - yp * math.cos(io) * math.sin(O)
    y = xp * math.sin(O) + yp * math.cos(io) * math.cos(O)
    z = yp * math.sin(io)
    return x, y, z

def ecef2lla(x, y, z):
    a = 6378137.0
    e2 = 0.00669437999014
    r = math.sqrt(x**2 + y**2)
    E2 = a**2 - (a**2 * (1.0 - e2))
    F = 54.0 * (a**2 * (1.0 - e2)) * z**2
    G = r**2 + (1.0 - e2) * z**2 - e2 * E2
    c = (e2**2 * F * r**2) / (G**3)
    s = (1.0 + c + math.sqrt(c**2 + 2.0 * c)) ** (1.0 / 3.0)
    P = F / (3.0 * (s + 1.0 / s + 1.0) ** 2 * G**2)
    Q = math.sqrt(1.0 + 2.0 * e2**2 * P)
    r0 = (-(P * e2 * r) / (1.0 + Q) + math.sqrt(0.5 * a**2 * (1.0 + 1.0 / Q) - P * (1.0 - e2) * z**2 / (Q * (1.0 + Q)) - 0.5 * P * r**2))
    U = math.sqrt((r - e2 * r0) ** 2 + z**2)
    V = math.sqrt((r - e2 * r0) ** 2 + (1.0 - e2) * z**2)
    z0 = (a**2 * z) / (a * V)
    lat = math.atan2((z + e2 * z0), r) * 180 / math.pi
    lon = math.atan2(y, x) * 180 / math.pi
    return lat, lon

def subsatellite(Oe, G, Me, a, Mo, dt, e, w, Oo, dO, io):
    M = mean_anomaly(G, Me, a, Mo, dt)
    E = eccentric_anomaly(e, M)
    v = true_anomaly(e, E)
    xp, yp = orbitcoords(v, w, a, e, E)
    x, y, z = satecef(Oe, Oo, dO, dt, io, xp, yp)
    return ecef2lla(x, y, z)


G = 6.67384e-11
Me = 5.972e+24
Oe = 7.2921151467e-5

# almanac 
e = 0.1305580139e-2
toa = 589824.0
orb_inc = 0.9583449099
d_right_ascen = -0.8137481816e-8
a = 5153.586426**2
Lo = -2.021357493
perigee_arg = -0.049845762
m_anomaly = 0.2014847812

Oo = Lo - Oe * toa

# vectors
latv = []
longv = []

T_orbital = 2*math.pi*math.sqrt(a**3 /(G * Me))

steps = int(math.ceil(T_orbital / 60))

for i in range(steps + 1):
    dt = i * 300
    # get coordinates
    lat, long = subsatellite(Oe, G, Me, a, m_anomaly, dt, e, perigee_arg, Oo, d_right_ascen, orb_inc)
    
    latv.append(lat)
    longv.append(long)
 
    long_plot = ((long + 180) % 360) - 180
    plt.plot(long_plot, lat, 'b.', markersize=2)

plt.axis([-180, 180, -90, 90])
plt.xlabel('Longitude (degrees)')
plt.ylabel('Latitude (degrees)')

dt0=0
lat_s, long_s = subsatellite(Oe, G, Me, a, m_anomaly, dt0, e, perigee_arg, Oo, d_right_ascen, orb_inc)
plt.plot(((long_s + 180) % 360) - 180, lat_s, 'r*', markersize=8)

plt.show()

print("\nComparative values with Octave:")
print("Index - Latitude - Longitude")
for k in range(718):
    print(k, latv[k], longv[k])
input("\nPress Enter to exit")