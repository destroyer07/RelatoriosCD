%% ------------------
%   Universidade Tecnologica Federal do Parana
%   Engenharia Eletrica
%   Controle Digital
%   
%   Aluno: Victor Emanuel Soares Barbosa
%   
%   Aula 5: Transformada Z Inversa
%   Exercicio 2: 
%   Considere o diagrama de controle em tempo discreto.
%   Determinar o grafico da saida considerando:
% ------------------
%% Inicializacao do programa
clc;
clear all;
close all;

%% Variaveis gerais
ciclos = 4; % Quantidade de ciclos da onda de entrada
T_entrada = 10; % Periodo da onda de entrada
Ta = 0.1; % Periodo de amostragem
total_pontos = T_entrada/Ta*ciclos; % Total de pontos de simulacao
A_entrada = 5; % Amplitude de entrada
x = zeros(1,total_pontos); % Vetor da entrada
y = zeros(1,total_pontos); % Vetor de saida
tempo = zeros(1,total_pontos); % Vetor de tempo
cont = 0; % contador para auxiliar

for n = 1:total_pontos
    if cont < ((T_entrada/Ta)/2)
        x(n) = A_entrada*(1+0.02*rand);
    else
        x(n) = 0.02*rand*A_entrada;
    end
    
    if n > 3
        y(n) = 0.27*x(n-1) - 0.216*x(n-2) + 1.7*y(n-1) - 0.854*y(n-2) + 0.1*y(n-3);
    end
    
    tempo(n) = n*Ta;
    cont = cont + 1;
    
    if cont > T_entrada/Ta
        cont = 0;
    end
end

% Grafico
figure
stem(tempo,y)
hold
stem(tempo,x)
title('Aula 5 - Exercicio 2');
legend('Saida y[n]','Entrada x[n]');
ylabel('Amplitude');
xlabel('Amostras');

