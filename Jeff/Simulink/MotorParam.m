%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializes variables for the Simulink model of an electric motor %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Start with a clean slate
clear all;

Nominal_Voltage = 18; %V
No_Load_Speed = 6110; %rpm
No_Load_Current = 12.8; %mA
Terminal_resistance = 8.75; %ohms
Terminal_inductance = .535; %mH
Torque_constant = 28; %mNm/A
Speed_constant = 1/342; %V/rpm
SpeedTorque_gradient = 107; %rpm/mNm
Rotor_inertia = 5.44E-8*9.81; %Nms^2


% Motor parameters
% Electrical
R  = Terminal_resistance;       % Armature resistance
L  = Terminal_inductance*1E-3;       % Armature inductance
INL = No_Load_Current*1E-3;     % No load current

% Bridge
Km = Torque_constant*1E-3;       % Motor constant
Kb = (Speed_constant)/(.10472);       % Back-EMF constant


% Mechanical
J  = Rotor_inertia;       % Armature inertia
w  = No_Load_Speed*(.10472); % No load speed
B  = (Km*INL)/w;       % Armature damping

% Display some results
G  = tf(Km, [L*J (L*B + R*J) R*B]);
H  = tf(Kb, 1);
TF = feedback(G,H)
