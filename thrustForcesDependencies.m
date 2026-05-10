function [Fv_of_u1, Fh_of_u2, Fv, Fh, Tv, Th, Kv, Kh] = thrustForcesDependencies()
%THRUSTFORCESDEPENDENCIES computation of the thrust force dependency on the input voltage
%   the input voltage is not in volts, but it is a coefficient between -1
%   and 1
Fv = [-1.8*1e-18, -8.8*1e-16, 4.1*1e-11, 2.7*1e-8, 3.5*1e-5, -0.014];
Fv = [-1.8*1e-18, -8.8*1e-16, 4.1*1e-11, 2.7*1e-8, 3.5*1e-5, 0];
wv = [-5.2*1e3, -1.1*1e2, 1.1*1e4, 1.3*1e2, -9.2*1e3, -31, 6.1*1e3, -4.5];
wv = [-5.2*1e3, -1.1*1e2, 1.1*1e4, 1.3*1e2, -9.2*1e3, -31, 6.1*1e3, 0];

%composing the two polynomials

Fv_of_u1 = 0;
wv_power = 1;
for i = length(Fv):-1:1
    term = Fv(i) * wv_power;
    len = max(length(Fv_of_u1), length(term));
    Fv_of_u1 = [zeros(1, len - length(Fv_of_u1)), Fv_of_u1] + [zeros(1, len - length(term)), term];
    if i > 1
        wv_power = conv(wv_power, wv);
    end
end

Fh = [-2.6*1e-20, 4.1*1e-17, 3.2*1e-12, -7.3*1e-9, 2.1*1e-5, 0.0091];
Fh = [-2.6*1e-20, 4.1*1e-17, 3.2*1e-12, -7.3*1e-9, 2.1*1e-5, 0];
wh = [2.2*1e3, -1.7*1e2, -4.5*1e3, 3*1e2, 9.8*1e3, -9.2];
wh = [2.2*1e3, -1.7*1e2, -4.5*1e3, 3*1e2, 9.8*1e3, 0];

%composing the two polynomials

Fh_of_u2 = 0;
wh_power = 1;
for i = length(Fh):-1:1
    term = Fh(i) * wh_power;
    len = max(length(Fh_of_u2), length(term));
    Fh_of_u2 = [zeros(1, len - length(Fh_of_u2)), Fh_of_u2] + [zeros(1, len - length(term)), term];
    if i > 1
        wh_power = conv(wh_power, wh);
    end
end
Tpeak = 0.1;
Tdecline = 0.05;
Kpeak = 6000;
Kdecline = 3500;
Tv = [-Tdecline / 4000^2, 0, Tpeak];
Th = [-Tdecline / 4000^2, 0, Tpeak];
Kv = [-Kdecline / 4000^2, 0, Kpeak];
Kh = [-Kdecline / 4000^2, 0, Kpeak];

end