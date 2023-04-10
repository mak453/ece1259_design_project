function plateGUI(fig)
        
    b =  uibutton(fig, 'Text', 'Calculate', 'FontSize', 32);   
    set(b, 'ButtonPushedFcn', @(src,event)create_capacitor(data.dielectric, data.capacitance, data.area, data.A_dist));
    b.Layout.Row = 7;
    b.Layout.Column = [1 3];   
        
    function create_capacitor(dd, cap, area, dist)
       
        cap_obj = capacitor(dd, cap, area, dist);
                
        if cap == 0 && area > 0 && dist > 0
            cap.Value = cap_obj.capacitance;      
        elseif cap > 0 && area.Value == 0 && dist.Value > 0
            area.Value = cap_obj.area; 
        elseif cap.Value > 0 && area.Value > 0 && dist.Value == 0
            dist.Value = cap_obj.plate_distance;
        end      
        
        bode = uibutton(fig, 'Text','Plot Bode', 'FontSize', 32);   
        set(b, 'ButtonPushedFcn', @(src,event)bode_cap(fig, cap_obj));
        bode.Layout.Row = 7;
        bode.Layout.Column = [6 8];
        
    end

end