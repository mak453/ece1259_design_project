%% choosing dielectric
%fid = uifigure;

%dropdownobject = uidropdown(fig,'Dielectrics',{'D1','D2','D3','D4','D5'},dielectricChoice);

%disp(num2str(dielectricChoice));


choice = menu("What do you want to solve for",'Capacitance','Area','Distance between plates','Permitivity');

switch(1)
    case 1
        E = input("Enter Permitivity: ");
        d = input("Enter the distance between the plates: ");
        c = E*s/d;
        newline;
        disp(['Capacitance: ',num2str(c),' Farads']);
    case 2
        c = input("Enter the capacitance: ");
        E = input("Enter Permitivity: ");
        d = input("Enter the distance between the plates: ");
        s = c*d/E;
        newline;
        disp(['Area of Capacitor plates: ',num2str(s),' m^2']);
    case 3
        c = input("Enter the capacitance: ");
        E = input("Enter Permitivity: ");
        s = input("Enter the Area of the capacitor plates: ");
        d = E*s/c;
        newline;
        disp(['Distance between capacitor plates: ',num2str(d),' m']);
    case 4
        c = input("Enter the capacitance: ");
        d = input("Enter the distance between the plates: ");
        s = input("Enter the Area of the capacitor plates: ");
        E = c*d/s;
        newline;
        disp(['Permitivity: ',num2str(E),' (units)']);
end