function create_capacitor(obj, eventData)
    data = get(obj, 'UserData');
        
    material = data(1);
    cap = data(2);
    area = data(3);
    dist = data(4);
    bode_b = data(6);
    reactance_b = data(7);
    num = data(8);
    denom = data(9);
        
    new_cap = capacitor(material.Value, cap.Value, area.Value, dist.Value);
    
    userData = struct;
    userData.bode = bode_b;
    userData.cap = new_cap;
    userData.num = num.Value;
    userData.denom = denom.Value;
    
    set(num, 'ValueChangedFcn', '');
    set(denom, 'ValueChangedFcn', ''); 
    num.Visible = 'on';
    denom.Visible = 'on';
    bode_b.Visible = 'on';
    reactance_b.Visible = 'on';
    bode_b.UserData = userData;     
      
    if cap.Value == 0 && area.Value > 0 && dist.Value > 0
        cap.Value = new_cap.capacitance;      
    elseif cap.Value > 0 && area.Value == 0 && dist.Value > 0
        area.Value = new_cap.area; 
    elseif cap.Value > 0 && area.Value > 0 && dist.Value == 0
        dist.Value = new_cap.A_dist;
    end     
    
end