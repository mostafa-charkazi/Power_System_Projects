clear; clc; close all;

% برای اجرای سریع تر کد تعداد نقاط را میتوانیم کمتر در نظر بگیریم
n = 100; % تعداد نقاط
k_vec = logspace(log10(0.01), log10(20), n);

V_line = zeros(length(k_vec), 1);
P_actual = zeros(length(k_vec), 1);

model = 'power_system_model_B';
load_system(model);

% حلقه تغییر بار
for i = 1:length(k_vec)
    clc;
    fprintf("Processing i=%d\n", i)
    % Changing k will effect on the load block on simulink file (.slx)
    k = k_vec(i);

    % شبیه سازی
    sim_time = 0.5;  % ثانیه
    set_param(model, 'StopTime', num2str(sim_time));
    
    out = sim(model);
    Vabc = out.Vabc;   % ماتریس ولتاژ سه‌فاز
    Iabc = out.Iabc;   % ماتریس جریان سه‌فاز
    tout = out.tout;   % بردار زمان
    
    V_rms_phase = rms(Vabc);  % هر فاز
    V_line(i) = mean(V_rms_phase) * sqrt(3);   % تبدیل به ولتاژ خط
    
    % محاسبه توان لحظه‌ای هر فاز و سپس توان متوسط
    P_inst = Vabc .* Iabc; % V*I
    P_phase = mean(P_inst, 1);  % میانگین توان هر فاز
    P_actual(i) = sum(P_phase); % توان کل سه‌فاز
end

close_system(model, 0);

figure;
plot(P_actual/1e3, V_line, 'LineWidth', 1.5);
xlabel('Active Power (kW)');
ylabel('Voltage (V)');
title('P-V (Load varied from 0.01 to 20 times Zload=0.9-j0.2)');