bps = 16; # bits por amostras
sps = 48000; # taxa de amostragem [amostras/s]
freq = 150; # frequencia em Hertz (Hz) do tom
nsecs = 5; # duracao em segundos da faixa

# total de amostras - 240.000
nsamples = sps * nsecs;

# definindo o tempo
time = linspace(0, nsecs, nsamples);
# criando a onda senoidal
wave = sin(time*2*pi*freq)';

# criando a janela de amplitude (cria o efeito de fading in e fading out quando multiplicado pela onda senoidal)
a = b = floor(.3*nsamples);
window = [linspace(0,1,a), ones(1,nsamples-a-b), linspace(1,0,b)]';

# salvando o sinal de audio gerado
audiowrite('audio_150_hz.wav',wave.*window, sps);
