%% ------------------
%   Universidade Tecnologica Federal do Parana
%   Engenharia Eletrica
%   Controle Digital
%   
%   Aluno: Victor Emanuel Soares Barbosa
%   
%   Aula 3: Transformada Z
%   Exercicio 2: 
%   Considere um sistema que possui resposta
%   ao impulso h[n]=2-nT e o sinal de entrada he uma onda
%   retangular (razao ciclica 40%, D=0,4) com periodo
%   10s e amplitude 3,3V.
%   A) Determine a resposta (sinal de saida) do sistema para
%   3 periodos do sinal de entrada considerando que o
%   periodo de amostragem he T=0.2s.
%   B) Considere um ruido de 10% no sinal de entrada e
%   repita o item A.
%   C) Considere um sinal de entrada senoidal com mesmo
%   periodo, amplitude e ruido dados acima.
% ------------------
%% Inicializacao do programa
clc;
clear all;
close all;

%% Variaveis gerais
periodos = 3; % Quantidade de periodos
R = 0.1; % Nivel de ruido
T = 0.2; % Periodo de amostragem
T_entrada = 10; % Periodo do sinal de entrada
A_entrada = 3.3; % Amplitude do sinal de entrada
D = 0.4; % Razao ciclica do sinal de entrada
total_pontos = periodos*T_entrada/T; % Total de pontos simulados
pontos_periodo = T_entrada/T; % Total de pontos por periodo
amostras = zeros(1,total_pontos); % Vetor de pontos de simulacao
h = zeros(1,total_pontos); % vetor da resposta ao impulso
x = zeros(1,total_pontos); % Vetor do sinal de entrada
y = zeros(1,total_pontos); % Vetor do sinal de saida
cont  = 0;

%% Letra a)

% Execucao
for n = 0:total_pontos-1
    
    if cont < (pontos_periodo*D)
         x(n+1) = A_entrada;
    else
        x(n+1) = 0;
    end
    
    if cont == pontos_periodo
        cont = 0;
    end
        
    cont = cont + 1;
    
    for k = 0:pontos_periodo*3  
        h(n+1) = 2^(-n*T);
            
        if (n-k)> 0
            y(n+1) = y(n+1) + x(k+1)*h(n-k)*T;
        end
    end

    amostras(n+1) = (n)*T;
end

% Graficos
figure
stem(amostras,y)
hold
stem(amostras,x)
stem(amostras,h)
title('Aula 2 - Exercicio 2 - Letra a');
legend('Sinal y[n]', 'Sinal x[n]', 'Sinal h[n]');
ylabel('Amplitude');
xlabel('Tempo (s)');

%% Letra b)

% Execucao
for n = 0:total_pontos-1
    
    if cont < (pontos_periodo*D)
         x(n+1) = A_entrada*(1+0.1*rand);
    else
        x(n+1) = 0.1*rand;
    end
    
    if cont == pontos_periodo
        cont = 0;
    end
        
    cont = cont + 1;
    
    for k = 0:pontos_periodo*3  
        h(n+1) = 2^(-n*T);
            
        if (n-k)> 0
            y(n+1) = y(n+1) + x(k+1)*h(n-k)*T;
        end
    end

    amostras(n+1) = (n)*T;
end

% Graficos
figure
stem(amostras,y)
hold
stem(amostras,x)
stem(amostras,h)
title('Aula 2 - Exercicio 2 - Letra b');
legend('Sinal y[n]', 'Sinal x[n]', 'Sinal h[n]');
ylabel('Amplitude');
xlabel('Tempo (s)');

%% Letra c)

% Execucao
for n = 0:total_pontos-1
    
    x(n+1) = A_entrada*sin(2*pi*n/(T_entrada/T))*(1+0.1*rand);
    
    if cont == pontos_periodo
        cont = 0;
    end
        
    cont = cont + 1;
    
    for k = 0:pontos_periodo*3  
        h(n+1) = 2^(-n*T);
            
        if (n-k)> 0
            y(n+1) = y(n+1) + x(k+1)*h(n-k)*T;
        end
    end

    amostras(n+1) = (n)*T;
end

% Graficos
figure
stem(amostras,y)
hold
stem(amostras,x)
stem(amostras,h)
title('Aula 2 - Exercicio 2 - Letra c');
legend('Sinal y[n]', 'Sinal x[n]', 'Sinal h[n]');
ylabel('Amplitude');
xlabel('Tempo (s)');