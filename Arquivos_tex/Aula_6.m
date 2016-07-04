%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            AULA 12P           %

%Exercício 1

%Considere um sistema em malha fechada com PID
%T(z) sendo: Utilize simulações computacionais (Simulink®) para projetar ganhos
%para o controlador PID considerando a entrada um degrau unitário.

%Exercício 2

%Obtenha a função de transferência do PID de tempo
%discreto utilizando o método de discretização Forward
%para a parcela integral e considere Kp, Ki, e Kd como
%ganhos paralelos do controlador PID.

%Exercício 3

%Considerando o sistema descrito no exercício 2, desenvolva um script
%em Matlab para implementar o PID com os seguintes parâmetros:

clc;
clear;
close all;

PeriodoOndaQuadrada = 0.01;
AmplitudeOndaQuadrada = 40;
T = 0.0002;
tfinal = 10;
NumeroDePeriodosDeQuadrada = tfinal/PeriodoOndaQuadrada;
TempoDePeriodoDeQuadrada = tfinal/T/NumeroDePeriodosDeQuadrada;

U = zeros(tfinal/T,1);
PID = zeros(tfinal/T,1);
Planta = zeros(tfinal/T,1);
Erro = zeros(tfinal/T,1);
Realimentacao = zeros(tfinal/T,1);
Up = zeros(tfinal/T,1);
Ui = zeros(tfinal/T,1);
Ud = zeros(tfinal/T,1);

s=tf('s');
G = 4*10^6/(s^2 + 3200*s + 4*10^6);
S = 4*pi*10^3/(s+4*pi*10^3);

Gz = c2d(G,T);
Sz = c2d(S,T);

K = 3.16529*0.6;
Ti = 0.000875;
Td = 0.0005;

Kp = K - K*T/(2*Ti);
Ki = K*T/Ti;
Kd = K*Td/T;


for k = 0:(NumeroDePeriodosDeQuadrada-1)
   for i=1:TempoDePeriodoDeQuadrada
       if(i<=TempoDePeriodoDeQuadrada/2) 
           U(i+TempoDePeriodoDeQuadrada*k) = AmplitudeOndaQuadrada;
       else
         U(i+TempoDePeriodoDeQuadrada*k) = -1*AmplitudeOndaQuadrada;
       end
   end
end

for k = 3:(tfinal/T -1)
    Erro(k) = U(k) - Realimentacao(k);
    Up(k) = Kp*Erro(k);
    Ui(k) = Ki*Erro(k) + Ui(k-1);
    Ud(k) = Kd*(Erro(k)-Erro(k-1));
    PID(k) = Up(k) + Ui(k) + Ud(i);
    Planta(k) = 0.06452*PID(k-1) + 0.0521*PID(k-2) + 1.411*Planta(k-1) - 0.5273*Planta(k-2);
    Realimentacao(k+1) = 0.912*Planta(k)+0.081*Realimentacao(k);
end

figure(1);
stem([0:T:tfinal-T],U,'blue');
hold on;
stem([0:T:tfinal-T],Planta,'red');