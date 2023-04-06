function plateGUI(fig, bank_names, bank)
       
    dd = uidropdown(fig, "Items", bank_names, "ItemsData", bank);
    dd.Layout.Row = 5;
    dd.Layout.Column = 2;

    dd_label = uilabel(fig);
    dd_label.Text = "Dielectric Material";
    dd_label.Layout.Row = 5;
    dd_label.Layout.Column = 1;

    cap = uieditfield(fig,'numeric');
    cap.Value = 0;
    cap.Layout.Row = 2;
    cap.Layout.Column = 2;

    cap_label = uilabel(fig);
    cap_label.Text = "Capacitance Value (F)";
    cap_label.Layout.Row = 2;
    cap_label.Layout.Column = 1;

    area = uieditfield(fig,'numeric');
    area.Value = 0;
    area.Layout.Row = 3;
    area.Layout.Column = 2;

    area_label = uilabel(fig);
    area_label.Text = 'Surface Area (m^2)';
    area_label.Layout.Row = 3;
    area_label.Layout.Column = 1;
    
    A_label = uilabel(fig);
    A_label.Text = 'Distance (m)';
    A_label.Layout.Row = 4;
    A_label.Layout.Column = 1; 

    A_field = uieditfield(fig,'numeric');
    A_field.Value = 0;
    A_field.Layout.Row = 4;
    A_field.Layout.Column = 2;

    b =  uibutton(fig, "Text","Calculate");   
    set(b, "ButtonPushedFcn", @(src,event)create_capacitor(dd, cap, area, dist));
    b.Layout.Row = 6;
    
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