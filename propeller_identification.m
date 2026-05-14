%% --- Main script ---

% load('experiment_data.mat'); % provides t_meas, y_meas, u_meas
% in any case, get them somehow.
data.t    = t_meas;
data.y    = y_meas;
data.u    = u_meas;
data.x0   = [628; 2; 0.38; 1.2e-4];

% Wrap Loss as a function of theta only
costFcn = @(theta) Loss(theta, data);
problem = createOptimProblem('fmincon', ...
    'objective', costFcn, ...
    'x0',        data.x0, ...
    'lb',        [0; 0; 0; 0], ...   % lower bounds on theta
    'ub',        [3e3; 1e3; 1e3; 10]);    % upper bounds on theta
gs = GlobalSearch('Display', 'iter');
[theta_opt, J_opt] = run(gs, problem);