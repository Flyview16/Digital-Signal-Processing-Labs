function hh = dtmfdesign(fb, L, fs)
    % DTMFDESIGN
    % hh = dtmfdesign(fb, L, fs)
    % returns a matrix (L by length(fb)) where each column contains
    % the impulse response of a BPF, one for each frequency in fb
    % fb = vector of center frequencies
    % L = length of FIR bandpass filters
    % fs = sampling freq

    N = length(fb);  % number of bandpass filters
    hh = zeros(L, N);  % pre-allocate filter matrix
    
    for k = 1:N
        n = 0:L-1;
        hh(:, k) = cos(2*pi*fb(k)*n/fs);
        % Scale so that the maximum value of the frequency response is 1
        H = freqz(hh(:, k), 1, 1024, fs);
        hh(:, k) = hh(:, k) / max(abs(H));
    end
end
