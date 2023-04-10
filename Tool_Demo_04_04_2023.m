all_fig = findall(0, 'type', 'figure');
close(all_fig); clear; clc;
addpath('Class_Definitions')
[bank_names, bank] = material_bank;

GUI(bank_names, bank)

function GUI(bank_names, bank)
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
    
    data = [dd, cap, area, A_field, B_field];
    shape_SelectionChangedFcn(cap_shape, default);
    set(cap_shape, 'SelectionChangedFcn', @shape_SelectionChangedFcn);
    
    calc =  uibutton(fig, 'Text', 'Calculate', 'FontSize', 32, 'Visible', 'off'); 
    calc.Layout.Row = 7;
    calc.Layout.Column = [1 3];   
      
    bode =  uibutton(fig, 'Text', 'Plot Bode', 'FontSize', 32, 'Visible', 'off'); 
    set(bode, 'ButtonPushedFcn', @bode_cap);
    bode.Layout.Row = 7;
    bode.Layout.Column = [5 8];
    
    function shape_SelectionChangedFcn(hObject, button) 
        switch get(button.NewValue, 'Text')
            case 'Spherical'
                calc.Visible = 'on';
                set(calc, 'ButtonPushedFcn', @create_sphere);
                fig.RowHeight{5} = 130;
                A_label.Text = 'A (m)';
                
            case 'Cylindrical'  
%                 fig.RowHeight{5} = 130;
%                 A_label.Text = 'A (m)';
%                 sphereGUI(fig, fields)
                
            case 'Parallel Plate'
                calc.Visible = 'on';
                set(calc, 'ButtonPushedFcn', @create_capacitor);
                fig.RowHeight{5} = 0;
                A_label.Text = 'Distance (m)';
                
            otherwise
                
        end
    end

    function bode_cap(cap)  %input capacitor object, returns bode plot
        C = cap.capacitance;    %get capacitance
        sys = tf([1], [C 0]);  %create transfer function (reactance)
        p = uipanel(fig);
        p.Layout.Row = [5 8];
        p.Layout.Column = [5 8];
        bodeplot(p, sys);      %get bode plot (frequency vs reactance)  
    end
end

