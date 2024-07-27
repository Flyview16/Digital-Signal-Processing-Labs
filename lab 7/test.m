fs = 8000; % Sampling rate
tk = ['A', 'B', 'C', 'D', '*', '#', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
xx = dtmfdial(tk, fs);
soundsc(xx, fs)

L = 80; % Choose appropriate filter length
decoded_keys = dtmfrun(xx, L, fs);
specgram(xx, 2048, fs)s


disp(decoded_keys); % Should print 'ABCD*#0123456789'



