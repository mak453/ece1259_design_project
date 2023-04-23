function create_capacitor(obj, eventData)
    data = get(obj, 'UserData');
        
    material = data(1);
    cap = data(2);
    area = data(3);
    dist = data(4);
    bode = data(6);
    cond = data(7);
    leak = data(8);
        
    new_cap = capacitor(material.Value, area.Value, dist.Value);
    new_cap.solve(new_cap);
    
    bode.Visible = 'on';
    bode.UserData = new_cap;     
      
    cap.Value = new_cap.capacitance;      
    cond.Value = new_cap.conductance;
    leak.Value = new_cap.leakage_curr;
        
end