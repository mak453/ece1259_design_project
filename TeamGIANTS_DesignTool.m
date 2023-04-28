all_fig = findall(0, 'type', 'figure');
close(all_fig); clear; clc;
addpath('Class_Definitions')
[bank_names, bank] = material_bank;
freq = 0:100:10e6;

GUI(bank_names, bank, freq)

function GUI(bank_names, bank, freq)
    figGUI = uifigure('Name','Capacitor Design Tool','NumberTitle','off','WindowState', 'maximized');
    fig = uigridlayout(figGUI, [20,30]);
    
    cap_shape = uibuttongroup(fig);
    cap_shape.Layout.Row = [1 2];
    cap_shape.Layout.Column = [1 10];
           
    start = uiradiobutton(cap_shape, 'FontSize', 16,'Text', 'None', 'Visible', 'off');
    uiradiobutton(cap_shape, 'FontSize', 16,'Text', 'Parallel Plate', 'Value', 0,'Position', [10 -25 200 100]);
    uiradiobutton(cap_shape, 'FontSize', 16,'Text', 'Spherical', 'Value', 0,'Position', [210 -25 200 100]);
    uiradiobutton(cap_shape, 'FontSize', 16,'Text', 'Cylindrical', 'Value', 0,'Position', [410 -25 200 100]);
    
    uilabel(cap_shape, 'Text', 'Capacitor Shape', 'Position', [185 25 200 100], 'FontSize', 24);
      
    cap = uieditfield(fig,'numeric','Tag','capacitor', 'Editable', 'off', 'ValueDisplayFormat','%d Farads');
    cap.Layout.Row = 10;
    cap.Layout.Column = [6 10];
    cap.FontSize = 24;
    cap_label = uilabel(fig);
    cap_label.Text = 'Capacitance';
    cap_label.Layout.Row = 10;
    cap_label.Layout.Column = [1 5];
    cap_label.FontSize = 24;

    cond = uieditfield(fig,'numeric','Tag','conductance', 'Editable', 'off', 'ValueDisplayFormat','%d Siemens');
    cond.Layout.Row = 11;
    cond.Layout.Column = [6 10];
    cond.FontSize = 24;
    cond_label = uilabel(fig);
    cond_label.Text = 'Conductance [60Hz]';
    cond_label.Layout.Row = 11;
    cond_label.Layout.Column = [1 5];
    cond_label.FontSize = 24;
        
    area = uieditfield(fig,'numeric','Tag','area');
    area.Layout.Row = 4;
    area.Layout.Column = [6 10];
    area.FontSize = 24;
    area_label = uilabel(fig, 'Text', 'Area (m<sup>2</sup>)', 'Interpreter', 'html');
    area_label.Layout.Row = 4;
    area_label.Layout.Column = [1 5];
    area_label.FontSize = 24;
    
    A_label = uilabel(fig);
    A_label.Text = 'Distance (m)';
    A_label.Layout.Row = 5;
    A_label.Layout.Column = [1 5]; 
    A_label.FontSize = 24;
    A_field = uieditfield(fig, 'numeric','Tag','capacitor');
    A_field.Layout.Row = 5;
    A_field.Layout.Column = [6 10];
    A_field.FontSize = 24;
    
    B_label = uilabel(fig, 'Visible', 'off');    
    B_label.Text = 'B (m)';
    B_label.Layout.Row = 6;
    B_label.Layout.Column = [1 5]; 
    B_label.FontSize = 24;
    B_field = uieditfield(fig,'numeric','Tag','capacitor', 'Editable', 'off', 'Enable', 'off');
    B_field.Value = 0;
    B_field.Layout.Row = 6;
    B_field.Layout.Column = [6 10];
    B_field.FontSize = 24;
    
    dd = uidropdown(fig, 'Items', bank_names, 'ItemsData', bank, 'FontSize', 24);
    dd.Layout.Row = 7;
    dd.Layout.Column = [6 10];
    dd_label = uilabel(fig);
    dd_label.Text = 'Dielectric Material';
    dd_label.Layout.Row = 7;
    dd_label.Layout.Column = [1 5];
    dd_label.FontSize = 24;
        
    default = struct;
    default.OldValue = start;
    default.NewValue = start;
    default.Source = start;
    default.EventName = 'SelectionChanged';
    
    A_label.Text = 'Distance (m)';
    
    shape_SelectionChangedFcn(cap_shape, default);
    set(cap_shape, 'SelectionChangedFcn', @shape_SelectionChangedFcn);
               
    data = struct;
    data.fig = fig;
    
    custom =  uibutton(fig, 'Text', 'Plot Bode', 'FontSize', 24, 'Visible', 'off'); 
    set(custom, 'ButtonPushedFcn', @bode_cap);
    custom.Layout.Row = [19 20];
    custom.Layout.Column = [1 10];    
    custom.UserData = data;
    
    calc =  uibutton(fig, 'Text', 'Calculate', 'FontSize', 32, 'Visible', 'off'); 
    calc.UserData = [dd, cap, area, A_field, B_field, custom, cond];
    calc.Layout.Row = [15 16];
    calc.Layout.Column = [2 4];
    
    reset =  uibutton(fig, 'Text', 'Reset', 'FontSize', 24); 
    set(reset, 'ButtonPushedFcn', @reset_gui);
    reset.Layout.Row = [15 16];
    reset.Layout.Column = [7 9];    
    reset.UserData = data;
    
    mag_p = uipanel(fig, 'Visible', 'off');
    mag_p.Layout.Row = [1 10];
    mag_p.Layout.Column = [11 30];
    mag_axes = uiaxes(mag_p, 'OuterPosition', [5 5 925 450]);

    ang_p = uipanel(fig, 'Visible', 'off');
    ang_p.Layout.Row = [11 20];
    ang_p.Layout.Column = [11 30];
    ang_axes = uiaxes(ang_p, 'OuterPosition', [5 5 925 450]);
        
    function reset_gui(hOject, button)
       area.Value = 0;
       A_field.Value = 0;
       B_field.Value = 0;
       dd.Value = bank(1);
       cap_shape.SelectedObject = start;
       B_label.Visible = 'off';
       B_field.Editable = 'off';
       B_field.Enable = 'off';
       mag_p.Visible = 'off';
       ang_p.Visible = 'off';
       cap.Value = 0;
       cond.Value = 0;
    end
    
    function bode_cap(hObject, button)
        capacitance = hObject.UserData.capacitance;
        
        mag_p.Visible = 'on';
        ang_p.Visible = 'on';
        
        H = abs(1j*2*pi*freq*capacitance);
        magnitude = mag2db(abs(H));
        phase = toDegrees('radians', angle(H));
        
        semilogx(mag_axes, freq, magnitude, 'LineWidth', 2);
        xlabel(mag_axes, 'Frequency (Hz)');
        ylabel(mag_axes, 'Gain (dB)');
        title(mag_axes, 'Magnitude');
        grid(mag_axes, 'on')

        semilogx(ang_axes, freq, phase, 'LineWidth', 2);
        xlabel(ang_axes, 'Frequency (Hz)');
        ylabel(ang_axes, 'Angle (Radians)');
        title(ang_axes, 'Phase');
        ang_axes.YLim = [-180 180];
        ang_axes.YTick = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
        ang_axes.YTickLabel = {'-\pi', '-3\pi/4', '-\pi/2', '-\pi/4', '0', '\pi/4', '\pi/2', '3\pi/4', '\pi'};
        grid(ang_axes, 'on')
    end

    function shape_SelectionChangedFcn(hObject, button) 
        switch get(button.NewValue, 'Text')
            case 'Spherical'
                custom.Visible = 'off';
                calc.Visible = 'on';
                set(calc, 'ButtonPushedFcn', @create_sphere);
                A_label.Text = 'A (m)';
                B_label.Visible = 'on';
                B_field.Editable = 'on';
                B_field.Enable = 'on';
                
            case 'Cylindrical'  
                custom.Visible = 'off';
                calc.Visible = 'on';
                set(calc, 'ButtonPushedFcn', @create_cylinder);
                A_label.Text = 'A (m)';
                B_label.Visible = 'on';
                B_field.Editable = 'on';
                B_field.Enable = 'on';
                
            case 'Parallel Plate'
                custom.Visible = 'off';
                calc.Visible = 'on';
                set(calc, 'ButtonPushedFcn', @create_capacitor);
                A_label.Text = 'Distance (m)';
                B_label.Visible = 'off';
                B_field.Editable = 'off';
                B_field.Enable = 'off';
                                
        end
    end
end
