function sphereGUI(fig, data)
       
    b =  uibutton(fig, 'Text','Calculate', 'FontSize', 32);   
    set(b, 'ButtonPushedFcn', @(src,event)create_capacitor(data.dd, data.capacitace, data.area, data.A_dist));
    b.Layout.Row = 7;
    b.Layout.Column = [1 3];
    
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
<<<<<<< HEAD
end
=======
end
>>>>>>> main
