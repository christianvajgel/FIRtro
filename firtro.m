% ENTREGA DE PROJETO
% Projeto de Bloco: Processamento Digital de Sinais
% Instituto Infnet - ESTI - Engenharia da Computação

% Christian Rocha
% Prof. Mario Cesar Francisco Pego

% FIRtro


# limpando janelas e console anteriores
clear all;
close all;
clc

# lendo o sinal inicial
[signal,fa] = audioread('audio_150_500_1000_hz.wav');

# construindo o player de audio
player_before = audioplayer(signal,fa);
# reproduzindo o arquivo WAV original
play(player_before);

# lendo cada sinal individualmente
[signal_150,fa] = audioread('audio_150_hz.wav');
[signal_500,fa] = audioread('audio_500_hz.wav');
[signal_1000,fa] = audioread('audio_1000_hz.wav');

# configurando o texto, cabecalho e legenda e plotando os sinais sobrepostos
f = figure();
ax = axes();
plot(signal_150, 'r');
hold on;
plot(signal_500, 'g');
hold on;
plot(signal_1000, 'b');

title('Sinal completo - Dominio do Tempo - Antes da filtragem','FontSize', 20,'color', 'k');
xlabel('Número de amostras','FontSize', 20,'color', 'k');
ylabel('Amplitude','FontSize', 20,'color', 'k');

header = legend ('150 Hz', '500 Hz', '1000 Hz');
legend(header, "location", "northeastoutside");

set(ax, 'color', 'w', 'linewidth', 0.50);
set (header, "fontsize", 20);

# mostrando FFT antes de aplicar o filtro
# analisador de espectro - amplitude X frequencia Hz (dominio da frequencia)
signal_fft_before = my_fft(signal,fa);

fa; # frequencia de amostragem

# aplicando o filtro passa baixas FIR
fsamp = fa;
s1 = signal;

fp = 100; # frequencia de passagem
fs = 200; # frequencia de corte

# normalizacao das frequencias
wp = (fp/(fsamp/2))*pi;
ws = (fs/(fsamp/2))*pi;

# frequencia de transicao
wt = ws - wp;

# ordem do filtro
M = ceil ((6.6*pi/wt)) + 1;

# frequencia de corte intermediaria
wc = (ws + wp)/2;

# funcao sinc para passa baixas ideal
hd = my_lowpass_ideal(wc,M);

# calculo da janela de hamming
w_hamm = hamming(M)';

# multiplicacao de vetores
h = hd.* w_hamm;

# convolucao dos sinais
s1_filtrado = conv (h,s1);

# mostrando FFT depois de aplicar o filtro
# analisador de espectro - amplitude X frequencia Hz (dominio da frequencia)
signal_fft_after = my_fft(s1_filtrado, fsamp);

# construindo o player de audio
player_after = audioplayer(s1_filtrado,fsamp);
# reproduzindo o arquivo WAV resultado
play(player_after);

# plot do sinal filtrado no dominio do tempo
# a ondulacao no sinal e referente as frequencias filtradas entre 100 e 200 Hz
figure();
sin1 = sin(s1_filtrado);
plot(sin1);
title('Sinal completo - Dominio do Tempo - Depois da filtragem','FontSize', 20,'color', 'k');
xlabel('Número de amostras','FontSize', 20,'color', 'k');
ylabel('Amplitude','FontSize', 20,'color', 'k');

# gerando o arquivo de audio com o resultado
audiowrite('audio-filtered.wav',s1_filtrado,fsamp);

