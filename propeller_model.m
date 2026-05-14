function dxdt = propeller_model(t, x, theta, data) % x = omega
    % Unpack parameters
    p1 = theta(1);
    p2 = theta(2);
    p3 = theta(3);
    p4 = theta(4);

    % Interpolate input signal at current integration time
    u = interp1(data.t, data.u, t, 'linear', 'extrap');
    E = 12; % volts
    dxdt = u*E*p1 - x*(p2*abs(u) + p3) - p4 * x * abs(x);
end