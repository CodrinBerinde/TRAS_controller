%process parameters

[Fv, Fh, Fv_omega_grid, Fv_force_grid, Fh_omega_grid, Fh_force_grid, Thetav, Thetah] = thrustForcesDependencies();
[A, B, C, D, E, F, L, Jv, lm, lt] = momentsOfInertia();
g = 9.81;

%simulation parameters
stop_time = 30;
sampling_time = 1e-2;
samples = stop_time / sampling_time + 1;
derivative_pole_tc = 10 * sampling_time; %the time constant of the pole of the filtered derivatives throughout the entire project

%inputs definitions
t = linspace(0, stop_time, samples);

%alpha_v_ref = deg2rad([20 * ones(1, round(0.6 * samples)) -25 * ones(1, samples - round(0.6 * samples))]);
%alpha_h_ref = deg2rad([20 * ones(1, round(0.3 * samples)) -20 * ones(1, samples - round(0.3 * samples))]);
%alpha_v_ref = deg2rad(30*sin(2*pi*0.12*t));
%alpha_h_ref = deg2rad(30*cos(2*pi*0.12*t));
%alpha_h_ref = deg2rad(15*sin(2*pi*0.2*t+0.2));
alpha_h_ref = zeros(1, samples);
alpha_v_ref = zeros(1, samples);
%alpha_v_ref = 0.25*ones(1, samples);

alpha_v_ref_timeseries = timeseries(alpha_v_ref, t);
alpha_h_ref_timeseries = timeseries(alpha_h_ref, t);

%controller parameters

%the characteristic equation of the error is
% (s + pole) * (s^2 + 2*zeta*wn*s + wn^2) = 0
%a real negative pole was chosen, and a pair of complex conjugates

%vertical controller
zetav = 1.15;
trv = 3.5; %settling time
wnv = 4 / zetav / trv; %natural oscillations frequency
polev = 3.5 * wnv; %big enough (in absolute value s.t. it does not dictate the dynamics)

kdv = 2 * zetav * wnv + polev;
kpv = wnv^2 + 2 * zetav * wnv * polev;
kiv = polev * wnv^2;

%horizontal_controller
zetah = 1.3;
trh = 3.7; %settling time
wnh = 4 / zetah / trh; %natural oscillations frequency
poleh = 3.5 * wnh; %big enough (in absolute value s.t. it does not dictate the dynamics)

kdh = 2 * zetah * wnh + poleh;
kph = wnh^2 + 2 * zetah * wnh * poleh;
kih = poleh * wnh^2;

%inner controller parameters
zeta_inner = 0.9;
tr_inner = 1;
wn_inner = 4 / zeta_inner / tr_inner;
ki_inner = wn_inner^2;
kp_inner = 2 * zeta_inner * wn_inner;

%%
out = sim('TRAS_closed_loop_.slx');
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