clc
clear all

%Load ventilator input signal in cmH2O
load('Tvent.mat','Tvent');
load('Pvent.mat','Pvent');

%Ventilator input signal 
Input = [Tvent{2}',Pvent{2}'];

%Create time vector for plots
total_time=14.5;
step=0.01;
time = (0:step:total_time);

%Peep value for patient 1 defined in the input signal ventilator [cmH20]
PEEP_v1=5;

%Peep value for patient 2 [cmH20]
PEEP_v2=7;

%Patient 1 and 2 resistance and compliances 
R1=5; %[cmH20/L/s]
C1=35/1000; %[L/cmH20]
R2=7; %[cmH20/L/s]
C2=32/1000; %[L/cmH20]

%Pinch valve pressure loss coeficient (calibrate this values for the specific valve)
Kv1=30;
Kv2=40;

%Oneway valve pressure loss coeficient (calibrate this values for the specific valve)
K_ow=20;

%Peep valve pressure loss coeficient (calibrate this values for the specific valve)
K_peep=25;

%Ventilator linear resistance [cmH20 / L/s] 
R_vent=1.5;

%% Run simulink 
sim('Simulink_AcraV3');

%% Monitor Plot 

figure(1)

font=12;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.15 0.05 0.65 0.95]);
t0=0;
tf=14;

subplot(3,2,1);
hold on
plot(time,Paw_1_num,...
    'LineWidth',1.5);
set(gca,'TickLabelInterpreter','latex')
ylabel('$P_{aw1}$[cmH2O]','Interpreter','latex','Fontsize',font);
xlabel('t[s]','Interpreter','latex','Fontsize',font);
xlim([t0 tf])
title('Patient 1','Interpreter','latex','Fontsize',font);
grid on

subplot(3,2,2);
hold on
plot(time,Paw_2_num,...
    'LineWidth',1.5);
set(gca,'TickLabelInterpreter','latex')
ylabel('$P_{aw2}$[cmH2O]','Interpreter','latex','Fontsize',font);
xlabel('t[s]','Interpreter','latex','Fontsize',font);
xlim([t0 tf])
title('Patient 2','Interpreter','latex','Fontsize',font);
grid on

subplot(3,2,3);
hold on
plot(time,flow_1_num,...
    'LineWidth',1.5);
set(gca,'TickLabelInterpreter','latex')
ylabel('$q_{1}$[L/min]','Interpreter','latex','Fontsize',font);
xlabel('t[s]','Interpreter','latex','Fontsize',font);
xlim([t0 tf])
title('Patient 1','Interpreter','latex','Fontsize',font);
grid on

subplot(3,2,4);
hold on
plot(time,flow_2_num,...
    'LineWidth',1.5);
set(gca,'TickLabelInterpreter','latex')
ylabel('$q_{2}$[L/min]','Interpreter','latex','Fontsize',font);
xlabel('t[s]','Interpreter','latex','Fontsize',font);
xlim([t0 tf])
title('Patient 2','Interpreter','latex','Fontsize',font);
grid on

subplot(3,2,5);
hold on
plot(time,vol_1_num,...
    'LineWidth',1.5);
set(gca,'TickLabelInterpreter','latex')
ylabel('$Vol_{1}$[L]','Interpreter','latex','Fontsize',font);
xlabel('t[s]','Interpreter','latex','Fontsize',font);
xlim([t0 tf])
title('Patient 1','Interpreter','latex','Fontsize',font);
grid on

subplot(3,2,6);
hold on
plot(time,vol_2_num,...
    'LineWidth',1.5);
set(gca,'TickLabelInterpreter','latex')
ylabel('$Vol_{2}$[L]','Interpreter','latex','Fontsize',font);
xlabel('t[s]','Interpreter','latex','Fontsize',font);
xlim([t0 tf])
title('Patient 2','Interpreter','latex','Fontsize',font);
grid on
