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
    
    shape_SelectionChangedFcn(cap_shape, default);
    set(cap_shape, 'SelectionChangedFcn', @shape_SelectionChangedFcn);
            
    reactance_b =  uibutton(fig, 'Text', 'Plot Reactance', 'FontSize', 32, 'Visible', 'off'); 
    set(reactance_b, 'ButtonPushedFcn', @reactance_bode);
    reactance_b.Layout.Row = 7;
    reactance_b.Layout.Column = [4 6];  
    
    num = uieditfield(fig,'Tag','num', 'Visible', 'off');
    num.Value = 'Enter numerator';
    num.Layout.Row = 6;
    num.Layout.Column = [7 8];
    num.FontSize = 24;
    
    denom = uieditfield(fig,'Tag','denom', 'Visible', 'off');
    denom.Value = 'Enter denomenator';
    denom.Layout.Row = 7;
    denom.Layout.Column = [7 8];
    denom.FontSize = 24;
    
    data = struct;
    data.fig = fig;
    
    custom =  uibutton(fig, 'Text', 'Plot Transfer Function', 'FontSize', 24, 'Visible', 'off'); 
    set(custom, 'ButtonPushedFcn', @bode_cap);
    custom.Layout.Row = 6;
    custom.Layout.Column = [4 6];    
    custom.UserData = data;
    
    calc =  uibutton(fig, 'Text', 'Calculate', 'FontSize', 32, 'Visible', 'off'); 
    calc.UserData = [dd, cap, area, A_field, B_field, custom, reactance_b, num, denom];
    calc.Layout.Row = 7;
    calc.Layout.Column = [1 3]; 
    
    function bode_cap(obj, button)
        num.Editable = 'on';
        denom.Editable = 'on';
        num.Visible = 'on';
        denom.Visible = 'on';
        
        set(num, 'ValueChangedFcn', @setNum);
        set(denom, 'ValueChangedFcn', @setDenom);        
                       
        data.num = num.Value;
        data.denom = denom.Value;
        bode_tf(data)
        
        function setNum(obj, eventData)
            data.num = obj.Value;
        end
        
        function setDenom(obj, eventData)
            data.denom = obj.Value;
        end             
    end
    function reactance_bode(obj, button)
        num.Value = "1";
        denom.Value = "s";
        num.Editable = 'off';
        denom.Editable = 'off';
        num.Visible = 'on';
        denom.Visible = 'on';
        data.num = num.Value;
        data.denom = denom.Value;
        bode_tf(data)
        num.Editable = 'on';
        denom.Editable = 'on';
    end
    
    function shape_SelectionChangedFcn(hObject, button) 
        switch get(button.NewValue, 'Text')
            case 'Spherical'
                num.Visible = 'off';
                denom.Visible = 'off';
                custom.Visible = 'off';
                reactance_b.Visible = 'off';
                calc.Visible = 'on';
                set(calc, 'ButtonPushedFcn', @create_sphere);
                fig.RowHeight{5} = 130;
                A_label.Text = 'A (m)';
                
            case 'Cylindrical'  
%                 fig.RowHeight{5} = 130;
%                 A_label.Text = 'A (m)';
%                 sphereGUI(fig, fields)
                
            case 'Parallel Plate'
                num.Visible = 'off';
                denom.Visible = 'off';
                custom.Visible = 'off';
                reactance_b.Visible = 'off';
                calc.Visible = 'on';
                set(calc, 'ButtonPushedFcn', @create_capacitor);
                fig.RowHeight{5} = 0;
                A_label.Text = 'Distance (m)';
                
            otherwise
                
        end
    end
end
