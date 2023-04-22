function create_capacitor(obj, eventData)
    data = get(obj, 'UserData');
        
    material = data(1);
    cap = data(2);
    area = data(3);
    dist = data(4);
    bode = data(6);
        
    new_cap = capacitor(material.Value, cap.Value, area.Value, dist.Value);
    
    bode.Visible = 'on';
    bode.UserData = new_cap;     
      
    if cap.Value == 0 && area.Value > 0 && dist.Value > 0
        cap.Value = new_cap.capacitance;      
    elseif cap.Value > 0 && area.Value == 0 && dist.Value > 0
        area.Value = new_cap.area; 
    elseif cap.Value > 0 && area.Value > 0 && dist.Value == 0
        dist.Value = new_cap.A_dist;
    end     
    
end