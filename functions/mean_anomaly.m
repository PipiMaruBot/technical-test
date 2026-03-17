# mean_anomaly.m
# Computes the Mean Anomaly at a specific time
function M = mean_anomaly(G, Me, a, Mo, dt)
    mu = G * Me;
    n = sqrt(mu / a^3);
    M = Mo + n * dt;
end
