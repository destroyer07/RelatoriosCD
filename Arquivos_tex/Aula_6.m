%Exerc�cio 3

%Considerando o sistema descrito no exerc�cio 2, desenvolva um script
%em Matlab para implementar o PID com os seguintes par�metros:

clc;
clear;
close all;

PeriodoOndaQuadrada = 0.01;
AmplitudeOndaQuadrada = 40;
T = 0.0002; % Referente a amostragem em 5 kHz
tfinal = 10; %Tempo Total de Simula��o
NumeroDePeriodosDeQuadrada = tfinal/PeriodoOndaQuadrada;
TempoDePeriodoDeQuadrada = tfinal/T/NumeroDePeriodosDeQuadrada;
ResolucaoPWM = 2^8;
ResolucaoADC = 2^10;
Vcc = 40;
VccADC = 5;

%Defini��o dos Vetores a serem usados
U = zeros(tfinal/T,1);
PID = zeros(tfinal/T,1);
Planta = zeros(tfinal/T,1);
Erro = zeros(tfinal/T,1);
Realimentacao = zeros(tfinal/T,1);
Up = zeros(tfinal/T,1);
Ui = zeros(tfinal/T,1);
Ud = zeros(tfinal/T,1);
PWM = zeros(tfinal/T,1);
ADC = zeros(tfinal/T,1);

%Planta e Filtro Continuos
s=tf('s');
G = 4*10^6/(s^2 + 3200*s + 4*10^6);
S = 4*pi*10^3/(s+4*pi*10^3);

%Discretiza��o por C2D, da Planta e Filtro
Gz = c2d(G,T);
Sz = c2d(S,T);

%Ganhos do PID, determinado pelo metodo Ziegler-Nichols - Procedimento 2
K = 6.7*0.6;
Ti = 0.0007;
Td = 0.0006;

%Ganhos do PID discretizado
Kp = K - K*T/(2*Ti);
Ki = K*T/Ti;
Kd = K*Td/T;


% Gera��o da Onde de Refer�ncia
for k = 0:(NumeroDePeriodosDeQuadrada-1)
   for i=1:TempoDePeriodoDeQuadrada
       if(i<=TempoDePeriodoDeQuadrada/2) 
           U(i+TempoDePeriodoDeQuadrada*k) = AmplitudeOndaQuadrada;
       else
         U(i+TempoDePeriodoDeQuadrada*k) = -1*AmplitudeOndaQuadrada;
       end
   end
end

%Simula��o da A��o de Controle

for k = 3:(tfinal/T -1)
    Erro(k) = U(k) - ADC(k)/ResolucaoADC*Vcc; %Calculo do Erro
    Up(k) = Kp*Erro(k); % Parcela Proposcional
    Ui(k) = Ki*Erro(k) + Ui(k-1); %Parcela Integral
    Ud(k) = Kd*(Erro(k)-Erro(k-1)); %Parcela Derivativa
    PID(k) = Up(k) + Ui(k) + Ud(i); %Conjunto PID
    if(PID(k) > 0.98*Vcc) % Saturador
       PID(k) = 0.98*Vcc;
    elseif(PID(k) < -0.98*Vcc)
            PID(k) = -0.98*Vcc;
    end 
    PWM(k) = PID(k)/Vcc*ResolucaoPWM;
    Planta(k) = 0.06452*(PWM(k-1)/ResolucaoPWM*Vcc) + 0.0521*(PWM(k-2)/ResolucaoPWM*Vcc) + 1.411*Planta(k-1) - 0.5273*Planta(k-2); %Simula��o da a��o da planta mediante o efeito do PWM
    Realimentacao(k) = 0.912*(Planta(k)*(1+0.02*(rand - rand)))+0.081*Realimentacao(k-1); %Simula��o do Filtro
    ADC(k+1) = Realimentacao(k)/Vcc*ResolucaoADC; % Calculo da realimenta��o pelo ADC
end

figure(1);
stem([0:T:tfinal-T],U,'blue');
hold on;
stem([0:T:tfinal-T],Planta,'red');