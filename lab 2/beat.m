% File: beat.m
function [xx, tt] = beat(A, B, fc, delf, fsamp, dur)
% BEAT compute samples of the sum of two cosine waves
% Usage:
% [xx, tt] = beat(A, B, fc, delf, fsamp, dur)
%
% A = amplitude of lower frequency cosine
% B = amplitude of higher frequency cosine
% fc = center frequency
% delf = frequency difference
% fsamp = sampling rate
% dur = total time duration in seconds
% xx = output vector of samples
% tt = time vector corresponding to xx

tt = 0:1/fsamp:dur; % time vector
xx = A * cos(2*pi*(fc - delf)*tt) + B * cos(2*pi*(fc + delf)*tt); % signal
end
