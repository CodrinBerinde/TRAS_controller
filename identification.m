%load('dwell_input_tras_tiny.mat')

sampling_time = 0.01;
stop_time = dwell_input.Time(end);
stop_time = 60;

%%
set_param('TRAS_identification', 'SimulationCommand', 'start');

%%
t_meas = simout.time;
y_meas = simout.signals.values;

plot(t_meas, y_meas(:,1), t_meas, y_meas(:,2), t_meas, y_meas(:,3), t_meas, y_meas(:,4));
legend('u_v', 'u_h', '\alpha_v', '\alpha_h');