function [Fv, Fh, Fv_omega_grid, Fv_force_grid, Fh_omega_grid, Fh_force_grid, Thetav, Thetah] = thrustForcesDependencies()
%THRUSTFORCESDEPENDENCIES computation of the thrust input voltage - rpm and
%rpm - force dependencies

%the imput voltage - rpm dependencies
Thetav = [7844 0.51 0.195 4.35e-4];
Thetah = [33349 1.35 3.26 0];

%main thrust rpm - force dependency
Fv = 1.067*[-1.8*1e-18, -8.8*1e-16, 4.1*1e-11, 2.7*1e-8, 3.5*1e-5, 0];
Fv_omega_grid = linspace(-4000, 4000, 1e4);
Fv_force_grid = polyval(Fv, Fv_omega_grid);

%we have to make Fv strictly increasing
for i = length(Fv_force_grid) / 2:length(Fv_force_grid)
    if Fv_force_grid(i) <= Fv_force_grid(i - 1)
        Fv_force_grid(i) = Fv_force_grid(i-1) + 1e-15;
    end
end

for i = length(Fv_force_grid) / 2:-1:1
    if Fv_force_grid(i) >= Fv_force_grid(i + 1)
        Fv_force_grid(i) = Fv_force_grid(i + 1) - 1e-15;
    end
end

%tail thrust rpm - force dependency
Fh = 1.067*[-2.6*1e-20, 4.1*1e-17, 3.2*1e-12, -7.3*1e-9, 2.1*1e-5, 0];
Fh_omega_grid = linspace(-8000, 8000, 1e4);
Fh_force_grid = polyval(Fh, Fh_omega_grid);

%we have to make Fh strictly increasing
for i = length(Fh_force_grid) / 2:length(Fh_force_grid)
    if Fh_force_grid(i) <= Fh_force_grid(i - 1)
        Fh_force_grid(i) = Fh_force_grid(i-1) + 1e-15;
    end
end

for i = length(Fh_force_grid) / 2:-1:1
    if Fh_force_grid(i) >= Fh_force_grid(i + 1)
        Fh_force_grid(i) = Fh_force_grid(i + 1) - 1e-15;
    end
end

end