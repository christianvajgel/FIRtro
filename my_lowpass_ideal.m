

function hd = my_lowpass_ideal (wc,M)

alpha = (M-1)/2;
n = [0:M-1];
m = n - alpha + eps;

# aplicacao do filtro e geracao do efeito ripple
hd = sin(wc*m)./(pi*m);

#figure();
#plot (hd);
#title('Low Pass Ideal');
#xlabel('x label');
#ylabel('y label');

endfunction

