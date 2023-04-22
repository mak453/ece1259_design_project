all_fig = findall(0, 'type', 'figure');
close(all_fig); clear; clc;
addpath('Class_Definitions')
[bank_names, bank] = material_bank;
freq = 0:1:10e6;

GUI(bank_names, bank, freq)

function GUI(bank_names, bank, freq)
    figGUI = uifigure('Name','Capacitor Design Tool','NumberTitle','off','WindowState', 'maximized');
    fig = uigridlayout(figGUI, [7,8]);
    
    cap_shape = uibuttongroup(fig);
    cap_shape.Layout.Row = 1;
    cap_shape.Layout.Column = [1 3];
           
    start = uiradiobutton(cap_shape, 'FontSize', 24,'Text', 'None', 'Visible', 'off');
    uiradiobutton(cap_shape, 'FontSize', 24,'Text', 'Parallel Plate', 'Value', 0,'Position', [10 25 200 100]);
    uiradiobutton(cap_shape, 'FontSize', 24,'Text', 'Spherical', 'Value', 0,'Position', [210 25 200 100]);
    uiradiobutton(cap_shape, 'FontSize', 24,'Text', 'Cylindrical', 'Value', 0,'Position', [410 25 200 100]);
    
    uilabel(cap_shape, 'Text', 'Capacitor Shape', 'Position', [185 75 200 100], 'FontSize', 24);
      
    cap = uieditfield(fig,'numeric','Tag','capacitor');
    cap.Layout.Row = 2;
    cap.Layout.Column = [2 3];
    cap.FontSize = 24;

    cap_label = uilabel(fig);
    cap_label.Text = 'Capacitance (F)';
    cap_label.Layout.Row = 2;
    cap_label.Layout.Column = 1;
    cap_label.FontSize = 24;

    area = uieditfield(fig,'numeric','Tag','area');
    area.Layout.Row = 3;
    area.Layout.Column = [2 3];
    area.FontSize = 24;

    area_label = uilabel(fig, 'Text', 'Area (m<sup>2</sup>)', 'Interpreter', 'html');
    area_label.Layout.Row = 3;
    area_label.Layout.Column = 1;
    area_label.FontSize = 24;
    
    A_label = uilabel(fig);
    A_label.Text = 'Distance (m)';
    A_label.Layout.Row = 4;
    A_label.Layout.Column = 1; 
    A_label.FontSize = 24;

    A_field = uieditfield(fig, 'numeric','Tag','capacitor');
    A_field.Layout.Row = 4;
    A_field.Layout.Column = [2 3];
    A_field.FontSize = 24;
    
    B_label = uilabel(fig);    
    B_label.Text = 'B (m)';
    B_label.Layout.Row = 5;
    B_label.Layout.Column = 1; 
    B_label.FontSize = 24;    

    B_field = uieditfield(fig,'numeric','Tag','capacitor');
    B_field.Value = 0;
    B_field.Layout.Row = 5;
    B_field.Layout.Column = [2 3];
    B_field.FontSize = 24;
    
    dd = uidropdown(fig, 'Items', bank_names, 'ItemsData', bank, 'FontSize', 24);
    dd.Layout.Row = 6;
    dd.Layout.Column = [2 3];

    dd_label = uilabel(fig);
    dd_label.Text = 'Dielectric Material';
    dd_label.Layout.Row = 6;
    dd_label.Layout.Column = 1;
    dd_label.FontSize = 24;
        
    default = struct;
    default.OldValue = start;
    default.NewValue = start;
    default.Source = start;
    default.EventName = 'SelectionChanged';
    
    fig.RowHeight{5} = 0;
    A_label.Text = 'Distance (m)';
    
    shape_SelectionChangedFcn(cap_shape, default);
    set(cap_shape, 'SelectionChangedFcn', @shape_SelectionChangedFcn);
               
    data = struct;
    data.fig = fig;
    
    custom =  uibutton(fig, 'Text', 'Plot Bode', 'FontSize', 24, 'Visible', 'off'); 
    set(custom, 'ButtonPushedFcn', @bode_cap);
    custom.Layout.Row = 7;
    custom.Layout.Column = [4 8];    
    custom.UserData = data;
    
    calc =  uibutton(fig, 'Text', 'Calculate', 'FontSize', 32, 'Visible', 'off'); 
    calc.UserData = [dd, cap, area, A_field, B_field, custom];
    calc.Layout.Row = 7;
    calc.Layout.Column = [1 3]; 
    
    function bode_cap(hObject, button)
        capacitance = hObject.UserData.capacitance;
        
        H = 1j*2*pi*freq*capacitance;
        magnitude = mag2db(abs(H));
        phase = toDegrees('radians', angle(H));
        
        mag_p = uipanel(fig);
        mag_p.Layout.Row = [1 3];
        mag_p.Layout.Column = [4 8];
        mag_axes = uiaxes(mag_p, 'OuterPosition', [5 5 955 475]);

        ang_p = uipanel(fig);
        ang_p.Layout.Row = [4 6];
        ang_p.Layout.Column = [4 8];
        ang_axes = uiaxes(ang_p, 'OuterPosition', [5 5 955 300]);

        semilogx(mag_axes, freq, magnitude, 'LineWidth', 2);
        xlabel(mag_axes, 'Frequency (Hz)');
        ylabel(mag_axes, 'Gain (dB)');
        title(mag_axes, 'Magnitude');
        grid(mag_axes, 'on')

        semilogx(ang_axes, freq, phase, 'LineWidth', 2);
        xlabel(ang_axes, 'Frequency (Hz)');
        ylabel(ang_axes, 'Angle (Degrees)');
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
                fig.RowHeight{5} = 130;
                A_label.Text = 'A (m)';
                
            case 'Cylindrical'  
%                 fig.RowHeight{5} = 130;
%                 A_label.Text = 'A (m)';
%                 sphereGUI(fig, fields)
                
            case 'Parallel Plate'
                custom.Visible = 'off';
                calc.Visible = 'on';
                set(calc, 'ButtonPushedFcn', @create_capacitor);
                fig.RowHeight{5} = 0;
                A_label.Text = 'Distance (m)';
                
            otherwise
                
        end
    end
end
