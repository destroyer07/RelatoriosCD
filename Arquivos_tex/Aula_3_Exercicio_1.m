%% ------------------
%   Universidade Tecnologica Federal do Parana
%   Engenharia Eletrica
%   Controle Digital
%   
%   Aluno: Victor Emanuel Soares Barbosa
%   
%   Aula 3: Transformada Z
%   Exercicio 1: 
%   Determine a saida do sistema com
%   resposta ao impulso h[n] e para um sinal de entrada
%   x[n]:
%   C) convolucao utilizando ferramenta
%   computacional: script Matlab
% ------------------
%% Inicializacao do programa
clc;
clear all;
close all;

%% Variaveis gerais
numero_pontos = 8; % Numero de pontos simulados
h = [1 1 1 zeros(1,numero_pontos-3)]; % resposta ao impulso
x = [1 1 1 1 zeros(1,numero_pontos-4)]; % sinal de entrada
y = [zeros(1,numero_pontos)]; % resposta do sistema a entrada x
amostras = zeros(1,numero_pontos); % vator de amostras

%% Letra c)

% Execucao
for n=0:(numero_pontos-1)
   for k = 0:3
        if (n-k)>0
           y(n+1) = y(n+1) + x(k+1)*h(n-k);
        end
   end
   amostras(n+1) = n-1;
end

% Graficos
figure
stem(amostras,y)
title('Aula 2 - Exercicio 2 - Letra c');
legend('Sinal y[n]');
ylabel('Amplitude');
xlabel('n');