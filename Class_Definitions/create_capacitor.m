function new_cap = create_capacitor(obj, eventData)
    disp(obj)
    disp(eventData)
    new_cap = capacitor();
                
    if cap.Value == 0 && area.Value > 0 && A_field.Value > 0
        cap.Value = new_cap.capacitance;      
    elseif cap.Value > 0 && area.Value == 0 && A_field.Value > 0
        area.Value = new_cap.area; 
    elseif cap.Value > 0 && area.Value > 0 && A_field.Value == 0
        A_field.Value = new_cap.A_dist;
    end     
          
end