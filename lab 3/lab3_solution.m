% Step 1: Determine sampling frequency
Fs = 11025; % Sampling frequency in Hz
Ts = 1 / Fs; % Sampling period in seconds

% Step 2: Load note data and determine frequencies
load('bach_fugue.mat'); % Load the data file
voices = theVoices; % Extract the voices structure
bpm = 120; % Define tempo in beats per minute
beats_per_second = bpm / 60;
seconds_per_beat = 1 / beats_per_second;
seconds_per_pulse = seconds_per_beat / 4;


% Step 3: Synthesize waveform for all notes
% Pre-allocate a large array for the entire piece
total_duration = 30; % Assume a maximum duration of 30 seconds for the piece
y = zeros(1, round(total_duration * Fs));

% Loop through each voice (melody)
for i = 1:length(voices)
    noteNumbers = voices(i).noteNumbers;
    startPulses = voices(i).startPulses;
    durations = voices(i).durations;
    
    % Loop through each note in the voice
    for j = 1:length(noteNumbers)
        keyNumber = noteNumbers(j);
        startPulse = startPulses(j);
        durationPulse = durations(j);
        
        % Calculate the frequency of the note
        f = 440 * 2^((keyNumber - 49) / 12);
        
        % Calculate the start time and duration in seconds
        startTime = startPulse * seconds_per_pulse;
        durationTime = durationPulse * seconds_per_pulse;
        
        % Generate the time vector for this note
        t = 0:Ts:durationTime - Ts; % Adjusted to ensure correct length
        
        % Synthesize the note as a sinusoid
        note = sin(2 * pi * f * t);
        
        % Apply envelope (ADSR)
        A = 0.01; % Attack time in seconds
        D = 0.05; % Decay time in seconds
        S = 0.7; % Sustain level (amplitude)
        R = 0.2; % Release time in seconds
        % Ensure the lengths of envelope and note match
        len_A = round(A * Fs);
        len_D = round(D * Fs);
        len_R = round(R * Fs);
        len_S = length(note) - len_A - len_D - len_R;
        
        if len_S < 0
            len_S = 0;
            len_R = length(note) - len_A - len_D;
            if len_R < 0
                len_D = length(note) - len_A;
                len_R = 0;
                if len_D < 0
                    len_A = length(note);
                    len_D = 0;
                    len_R = 0;
                end
            end
        end
        
        E = [linspace(0, 1, len_A), ...
             linspace(1, S, len_D), ...
             S * ones(1, len_S), ...
             linspace(S, 0, len_R)];
        
        % Ensure the envelope matches the length of the note
        E = E(1:length(note));
        
        note_enveloped = note .* E;
        
        % Determine the start index in the output array
        startIndex = round(startTime * Fs) + 1;
        endIndex = startIndex + length(note_enveloped) - 1;
        
        % Add the synthesized note to the output array
        y(startIndex:endIndex) = y(startIndex:endIndex) + note_enveloped;
    end
end

% Normalize the output
y = y / max(abs(y));

% Play the synthesized music
soundsc(y, Fs);

% Write the audio to a WAV file
filename ='synthesized_music.wav';
audiowrite(filename, y, Fs);

% Plot a few periods of the first note for illustration
figure;
plot(t(1:500), note_enveloped(1:500)); % Plot a few periods of the note
title('Sinusoid for Note A4 with Envelope');
xlabel('Time (s)');
ylabel('Amplitude');

% Spectrogram of the synthesized music
figure;
spectrogram(y, 512, [], [], Fs, 'yaxis');
title('Spectrogram of Synthesized Music');
zoom on;



% Plotting four different notes on separate pages
noteIndices = [1, 10, 20, 30]; % Example indices for four different notes
figureTitles = {'First Note', 'Second Note', 'Third Note', 'Fourth Note'};

for i = 1:4
    % Re-synthesize the individual note for plotting
    keyNumber = voices(1).noteNumbers(noteIndices(i));
    startPulse = voices(1).startPulses(noteIndices(i));
    durationPulse = voices(1).durations(noteIndices(i));
    
    f = 440 * 2^((keyNumber - 49) / 12);
    startTime = startPulse * seconds_per_pulse;
    durationTime = durationPulse * seconds_per_pulse;
    t = 0:Ts:durationTime - Ts;
    note = sin(2 * pi * f * t);
    
    A = 0.01; D = 0.05; S = 0.7; R = 0.2;
    len_A = round(A * Fs);
    len_D = round(D * Fs);
    len_R = round(R * Fs);
    len_S = length(note) - len_A - len_D - len_R;
    if len_S < 0
        len_S = 0;
        len_R = length(note) - len_A - len_D;
        if len_R < 0
            len_D = length(note) - len_A;
            len_R = 0;
            if len_D < 0
                len_A = length(note);
                len_D = 0;
                len_R = 0;
            end
        end
    end
    E = [linspace(0, 1, len_A), ...
         linspace(1, S, len_D), ...
         S * ones(1, len_S), ...
         linspace(S, 0, len_R)];
    E = E(1:length(note));
    
    note_enveloped = note .* E;
    
    % Create a new figure for each note
    figure;
    plot(t(1:500), note_enveloped(1:500));
    title(sprintf('Sinusoid for Note %d with Envelope', keyNumber));
    xlabel('Time (s)');
    ylabel('Amplitude');
end
