function J = Loss(theta, data)
    % Simulate the model with this theta
    opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
    [~, x_sim] = ode45(@(t,x) myModel(t, x, theta, data), ...
                        data.t, data.x0, opts);

    y_hat = x_sim(:, 1);
    residuals = data.y - y_hat;
    J = sum(residuals .^ 2); 
end