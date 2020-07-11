clc;
clear all;
close all;
[y, fs] = audioread('baby.wav');
player1 = audioplayer(y, fs);
play(player1);