import numpy as np
import sys
from PyQt6.QtWidgets import QApplication, QLabel, QWidget


class dielectric:
    name = ''
    er = 0
    Ebr = 0
    sigma = 0

    def __init__(self, name, er, Ebr, sigma):
        self.name = name
        self.er = er
        self.Ebr = Ebr
        self.sigma = sigma


class capacitor:
    area = 0
    capacitance = 0
    max_voltage = 0
    plate_distance = 0
    dielectric = None
    valid = [False, False, False, False]

    def __init__(self, bank, dielectric=None, area=0.0, capacitance=0.0, plate_distance=0.0):
        self.dielectric = dielectric
        self.area = area
        self.capacitance = capacitance
        self.plate_distance = plate_distance
        self.verify()

    def verify(self):
        if self.valid.contains(False):
            print(np.where(self.valid == False)[0])

        # self.design()

    def design(self, case):
        if self.capacitance == 0.0:
            self.solve_cap()

        if self.dielectric == None:
            self.solve_dielectric()

        self.solve_area()
        self.solve_plate_dist()


air = dielectric('air', 1.005, 3e6, 0)
alumina = dielectric('alumina', 9.9, None, None)
barium_titanate = dielectric('barium titanate', 7.5e6, None, None)
glass = dielectric('glass', 10,  30e6, 1e-12)
mica = dielectric('mica', 5.4, 200e6, 1e-15)
polyethylene = dielectric('polyethylene', 2.26, 47e6, 1e-15)
polystryrene = dielectric('polystryrene', 2.56, 20e6, 1e-17)
quartz = dielectric('quartz', 3.8, 30e6, 1e-17)
teflon = dielectric('teflon', 2.1, 60e6, 1e-15)

material_bank = [air, alumina, barium_titanate, glass, mica, polyethylene, polystryrene, quartz, teflon]
capacitor_bank = []

while True:
    print('You\'ve made ' + str(len(capacitor_bank)) + ' capacitor(s)')

    if option == 'ADD':

        name = input("Enter the Dielectric Name: ")
        permitivity = input("Enter " + name + "'s permitivity value (er): ")
        strength = input("Enter " + name + "'s dielectric strength (Ebr): ")
        sigma = input("Enter " + name + "'s sigma value (sigma): ")

        material_bank.append(dielectric(
            name.lower(), permitivity, strength, sigma))
    elif "?":

        for material in material_bank:
            if material.name == user:
                new_cap = capacitor(material_bank, material)

        if new_cap.valid.contains(False):
            print('No capacitor could be made with the desired properties')
        else:
            capacitor_bank.append(new_cap)
