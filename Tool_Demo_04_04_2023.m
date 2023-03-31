clear; clc;
addpath('Class_Definitions')

air = dielectric('air', 1.005, 3e6, 0);
alumina = dielectric('alumina', 9.9, -1, -1);
barium_titanate = dielectric('barium titanate', 7.5e6, -1, -1);

material_bank = [air, alumina, barium_titanate];

one = capacitor(air);

one.solve_1()
