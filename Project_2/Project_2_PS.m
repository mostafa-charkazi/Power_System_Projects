% پروژه ۲ - تحلیل سیستم انرژی ۱
clear; clc; close all;

disp('Voroodi parametr haye khat enteghal:');
D = input('fasele bein phase ha (m) = D = ');
r = input('shoa har hadi (m) = r = ');
d = input('fasele hadi haye daroon bundle (m) = d = ');
n = input('tedad hadi ha dar har bundle = n = ');

GMR_single = 0.7788 * r; % GMR هادی تکی

if n == 2
    GMR_bundle = sqrt(GMR_single * d);
elseif n == 3
    GMR_bundle = (GMR_single * d^2)^(1/3);
elseif n == 4
    GMR_bundle = 1.09 * (GMR_single * d^3)^(1/4);
else
    error('Tedad hadi haye bandel bayad 2,3 ya 4 bashad');
end

GMD = D; % اگر فاز ها متقارن باشند

L = 2e-7 * log(GMD / GMR_bundle); % H/m

if n == 1
    r_eq = r;
else
    r_eq = (n * r * d^(n-1))^(1/n);
end

epsilon0 = 8.854e-12;
C = (2 * pi * epsilon0) / log(GMD / r_eq); % F/m

disp(' ');
disp('========== Natayej mohasebat ==========');
fprintf('GMR Bundle: %g m\n', GMR_bundle);
fprintf('GMD beyn phase ha: %g m\n', GMD);
fprintf('inductance har phase: %g H/m\n', L);
fprintf('zarfiyat khazeni har phase be nol: %g F/m\n', C);
fprintf('                                   %g nF/km\n', C*1e9*1e3);
disp('======================================');