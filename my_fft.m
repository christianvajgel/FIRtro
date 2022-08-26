

function [S,frequency] = my_fft (s, fs)

#quantidade de amostras
normal = length(s);

# auxiliar que pega variacao
aux = 0:normal-1;

# referencia entre tempo e amostras
T = normal/fs;

# variacao da frequencia do sinal
frequency = aux/T;

# calculo da FFT
S = fftn(s)/normal;

# frequencia central
fc = ceil (normal/2);

# mudando o eixo x
S = S(1:fc);

# plotando o resultado da analise espectral
figure();
plot(frequency(1:fc), abs(S));
title('Analisador de Espectro','FontSize', 20);
xlabel('Frequência (Hz)','FontSize', 20);
ylabel('Amplitude','FontSize', 20);

endfunction

