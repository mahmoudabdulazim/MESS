%% Main file for testing and demonstrating Class Satellite
clc,clear, close all force;
R0 = input('Enter R0 for the satellite: ');
V0 = input('Enter V0 for the satellite: ');

Sat = Satellite;
Sat.Initialize(R0,V0,0);

for t = 0:60:100000
    Sat.update(t,0) 
end