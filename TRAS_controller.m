%constants definitions

[Fv_of_u1, Fh_of_u2] = thrustForcesDependencies();
[A, B, C, D, E, F, L, Jv, lm, lt] = momentsOfInertia();
g = 9.81;

x_grid = linspace(-1, 1, 1e5);
y_grid_v = polyval(Fv_of_u1, x_grid);

%we have to make Fv_of_u1 strictly increasing
for i = length(y_grid_v) / 2:length(y_grid_v)
    if y_grid_v(i) <= y_grid_v(i - 1)
        y_grid_v(i) = y_grid_v(i-1) + 1e-15;
    end
end

for i = length(y_grid_v) / 2:-1:1
    if y_grid_v(i) >= y_grid_v(i + 1)
        y_grid_v(i) = y_grid_v(i + 1) - 1e-15;
    end
end

%and exactly the same procedure for Fh
y_grid_h = polyval(Fh_of_u2, x_grid);
for i = length(y_grid_h) / 2:length(y_grid_h)
    if y_grid_h(i) <= y_grid_h(i - 1)
        y_grid_h(i) = y_grid_h(i-1) + 1e-15;
    end
end

for i = length(y_grid_h) / 2:-1:1
    if y_grid_h(i) >= y_grid_h(i + 1)
        y_grid_h(i) = y_grid_h(i + 1) - 1e-15;
    end
end

%simulation parameters
stop_time = 10;
sampling_time = 1e-3;
samples = stop_time / sampling_time + 1;

%inputs definitions
t = linspace(0, stop_time, samples);

alpha_v_ref = deg2rad([20 * ones(1, 3000) 20 * ones(1, samples - 3000)]);
alpha_h_ref = deg2rad(15*sin(2*pi*0.3*t));
%alpha_h_ref = deg2rad(zeros(1, samples));

alpha_v_ref_to_simulink = timeseries(alpha_v_ref, t);
alpha_h_ref_to_simulink = timeseries(alpha_h_ref, t);

%controller parameters
kp = 4;
kd = 4;

%%
out = sim('TRAS_controller_.slx');
simulation_results = out.data;
alpha_v_ref_sim = rad2deg(simulation_results.Data(:, 1));
alpha_h_ref_sim = rad2deg(simulation_results.Data(:, 2));
alpha_v_sim = rad2deg(simulation_results.Data(:, 3));
alpha_h_sim = rad2deg(simulation_results.Data(:, 4));
u1_sim = simulation_results.Data(:, 5);
u2_sim = simulation_results.Data(:, 6);
tsim = simulation_results.Time;

figure(1);clf
plot(tsim, u1_sim, tsim, u2_sim);
legend('u_1 (vertical)', 'u_2 (horizontal)');grid on;
title('Control signals');
xlabel('u[%]');
ylabel('t[s]');

figure(2);clf
subplot(211);
plot(tsim, alpha_v_ref_sim, tsim, alpha_v_sim);grid on;
xlabel('t[s]'); ylabel('[deg]');
legend('\alpha_{v, ref}', '\alpha_{v, out}');
title('vertical (pitch) angle \alpha_v');

subplot(212);
plot(tsim, alpha_h_ref_sim, tsim, alpha_h_sim);grid on;
xlabel('t[s]'); ylabel('[deg]');
legend('\alpha_{h, ref}', '\alpha_{h, out}');
title('horizontal (azimuth) angle \alpha_h');