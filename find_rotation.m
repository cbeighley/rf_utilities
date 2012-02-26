clear all;
close all;
addpath('./toolbox')
z0 = 50
fc = 1.57542e9

meas_imp = [164.5+1j*10,2.45+1j*2.67,2.68-1j*5.2]
norm_meas_imp = meas_imp/z0

%Plot measured impedances
scCreate("figure",1);
title('Normalized measured impedances');
for i = 1:length(meas_imp)
 scAddPoint(norm_meas_imp(i));
end

%Create matrix of normalized measured impedances rotated in a circle of constant reflection coefficient
rot_const_refl_rect = zeros(length(meas_imp),360);
gamma_mags_meas = zeros(length(meas_imp),1);
gamma_angs_meas = zeros(length(meas_imp),1);
for i = 1:length(meas_imp)
  [gamma_mags_meas(i),gamma_angs_meas(i)] = ztog(norm_meas_imp(i));
  for angle = 0:359
    rot_const_refl_rect(i,angle+1) = gtoz(gamma_mags_meas(i), ...
                                     gamma_angs_meas(i) + angle, 1);
  end
end

%Plot rotated impedances
scCreate("figure",2);
title('Measured Impedances Rotated 360 Degrees');
for i = 1:length(meas_imp)
  for k = 1:360
    scAddPoint(rot_const_refl_rect(i,k));
  end
end

%Find point in rotated impedances where real impedances of each point
%are closest to being the same
best_real_dist = inf;
best_angle = -1;
avg_real_dist = 0;
for i = 1:360
  current_real_dist = 0;
  for k = 1:(length(meas_imp)-1)
    real_dist_add = abs(real(rot_const_refl_rect(k,i))-real(rot_const_refl_rect(k+1,i)));
    current_real_dist = current_real_dist + real_dist_add;
    avg_real_dist = avg_real_dist + real_dist_add;
  end
  if (current_real_dist < best_real_dist)
    best_real_dist = current_real_dist;
    best_angle = i;
  end
end
avg_real_dist = avg_real_dist/360
best_real_dist = best_real_dist
best_angle = best_angle

%Plot best fit points
scCreate('figure',3);
for i = 1:length(meas_imp)
  scAddPoint(rot_const_refl_rect(i,best_angle));
end
title('Best rotation');
