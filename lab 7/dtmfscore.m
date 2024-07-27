function sc = dtmfscore(xx, hh)
    % DTMFSCORE
    % sc = dtmfscore(xx, hh)
    % returns a score based on the max amplitude of the filtered output
    % xx = input DTMF tone
    % hh = impulse response of ONE bandpass filter
    % The signal detection is done by filtering xx with a length-L
    % BPF, hh, and then finding the maximum amplitude of the output.
    % The score is either 1 or 0.
    % sc = 1 if max(|y[n]|) is greater than, or equal to, 0.59
    % sc = 0 if max(|y[n]|) is less than 0.59

    persistent plot_counter
    if isempty(plot_counter)
        plot_counter = 0;
    end

    xx = xx * (2 / max(abs(xx))); % Scale the input x[n] to the range [-2, +2]
    y = conv(xx, hh);

    % Debugging: Plot the first 200-500 points of the filtered output
     % Plot only for the first few calls
    if plot_counter < 5
        figure;
        plot(y(1:500));
        title(['Filtered Output for Plot ' num2str(plot_counter + 1)]);
        xlabel('Sample Index');
        ylabel('Amplitude');
        grid on;
        plot_counter = plot_counter + 1;
    end

    if max(abs(y)) >= 0.59
        sc = 1;
    else
        sc = 0;
    end
end
