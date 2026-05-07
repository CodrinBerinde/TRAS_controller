function [A, B, C, D, E, F, L, Jv, lm, lt] = momentsOfInertia()
%MOMENTSOFINERTIA computation of the physical parameters that intervene in
%the moments of inertia of the TRAS. See documentation for their meaning
%   Detailed explanation goes here
lt = 0.216;
lm = 0.202;
lb = 0.15;
lcb = 0.15;
rms = 0.145;
rts = 0.1;

mtr = 0.154;
mmr = 0.199;
mcb = 0.024;
mt = 0.031;
mm = 0.029;
mb = 0.011;
mts = 0.061;
mms = 0.083;

A = (mt / 2 + mtr + mts) * lt;
B = (mm / 2 + mmr + mms) * lm;
C = mb / 2 * lb + mcb * lcb;
D = (mmr + mms + mm / 3) * lm^2 + (mtr + mts + mt / 3) * lt^2;
E = mcb * lcb^2 + mb * lb^2 / 3;
F = mms * rms^2 + mts * rts^2;
L = (mmr + mms + mm / 4) * lm^2 + (mtr + mts + mt / 4) * lt^2 - mcb * lcb^2 - mb / 4 * lb^2;
Jv = D + E + F;
end