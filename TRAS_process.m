% constants definitions

[Fv, Fh, Fv_omega_grid, Fv_force_grid, Fh_omega_grid, Fh_force_grid, Thetav, Thetah] = thrustForcesDependencies();
[A, B, C, D, E, F, L, Jv, lm, lt] = momentsOfInertia();
g = 9.81;

%simulation parameters
stop_time = 10;
sampling_time = 1e-2;
samples = stop_time / sampling_time + 1;

%inputs definitions
uv = 0.25 * ones(1, samples);
uh = zeros(1, samples);

t = linspace(0, stop_time, samples);
uv_timeseries = timeseries(uv, t);
uh_timeseries = timeseries(uh, t);
%%
out = sim('TRAS_process_.slx');
simulation_results = out.data;
u1sim = simulation_results.Data(:, 1);
u2sim = simulation_results.Data(:, 2);
alphav = rad2deg(simulation_results.Data(:, 3));
alphah = rad2deg(simulation_results.Data(:, 4));
tsim = simulation_results.Time;

figure(1);clf
title('input signals');
subplot(211);
plot(tsim, u1sim);
xlabel('t[s]'); ylabel('u_1 [%]');

subplot(212);
plot(tsim, u2sim);
xlabel('t[s]'); ylabel('u_2 [%]');

figure(2);clf
title('output signals');
subplot(211);
plot(t, alphav);
xlabel('t[s]'); ylabel('\alpha_v [deg]');
subplot(212);
plot(t, alphah);
xlabel('t[s]'); ylabel('\alpha_h [deg]');