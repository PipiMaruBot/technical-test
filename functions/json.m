txt = fileread("case_prn1_week351_inputs.json");
inp = jsondecode(txt);

c = inp.constants_SI;
e = inp.elements;
tg = inp.time_grid;

N = tg.i_max - tg.i_min + 1;
out = repmat(struct("dt_s",0,"lat_deg",0,"lon_deg",0,"alt_m",NaN), N, 1);

k = 1;
for i = tg.i_min:tg.i_max
  dt = i * tg.dt_step_s;
  [lon, lat] = subsatellite(c.Oe_rad_s, c.G_m3_kg_s2, c.Me_kg, e.a_m, e.m_anomaly_rad, dt, e.e, c.tol, e.perigee_arg_rad, e.Oo_rad, e.d_right_ascen_rad_s, e.orb_inc_rad);

  out(k).dt_s = dt;
  out(k).lat_deg = lat;
  out(k).lon_deg = lon;
  k = k + 1;
end

fid = fopen("case_prn1_week351_expected.json","w");
fprintf(fid, "%s", jsonencode(out));
fclose(fid);
