clear; clc;
addpath('Class_Definitions')
[bank_names, bank] = material_bank;

GUI(bank_names, bank)

function GUI(bank_names, bank)
    figGUI = uifigure('Name','Capacitor Design Tool','NumberTitle','off');
    fig = uigridlayout(figGUI, [5,3]);
    dd = uidropdown(fig, "Items", bank_names, "ItemsData", bank);
    dd.Layout.Row = 4;
    dd.Layout.Column = 2;

    dd_label = uilabel(fig);
    dd_label.Text = "Dielectric Material";
    dd_label.Layout.Row = 4;
    dd_label.Layout.Column = 1;

    cap = uieditfield(fig,'numeric');
    cap.Value = 0;
    cap.Layout.Row = 1;
    cap.Layout.Column = 2;

    cap_label = uilabel(fig);
    cap_label.Text = "Capacitance Value (F)";
    cap_label.Layout.Row = 1;
    cap_label.Layout.Column = 1;

    area = uieditfield(fig,'numeric');
    area.Value = 0;
    area.Layout.Row = 2;
    area.Layout.Column = 2;

    area_label = uilabel(fig);
    area_label.Text = 'Surface Area (m^2)';
    area_label.Layout.Row = 2;
    area_label.Layout.Column = 1;

    dist = uieditfield(fig,'numeric');
    dist.Value = 0;
    dist.Layout.Row = 3;
    dist.Layout.Column = 2;

    dist_label = uilabel(fig);
    dist_label.Text = 'Distance between Plates (m)';
    dist_label.Layout.Row = 3;
    dist_label.Layout.Column = 1;

    b =  uibutton(fig, "Text","Calculate");   
    set(b, "ButtonPushedFcn", @(src,event)create_capacitor(dd, cap, area, dist));
    b.Layout.Row = 5;
    b.Layout.Column = 3;
    
    function create_capacitor(dd, cap, area, dist)
        cap_obj = capacitor(dd.Value, cap.Value, area.Value, dist.Value);
                
        if cap.Value == 0 && area.Value > 0 && dist.Value > 0
            cap.Value = cap_obj.capacitance;      
        elseif cap.Value > 0 && area.Value == 0 && dist.Value > 0
            area.Value = cap_obj.area; 
        elseif cap.Value > 0 && area.Value > 0 && dist.Value == 0
            dist.Value = cap_obj.plate_distance;
        end
        
    end
end
