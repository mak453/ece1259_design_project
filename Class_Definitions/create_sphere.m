function create_sphere(obj, eventData)
    data = get(obj, 'UserData');
        
    material = data(1);
    cap = data(2);
    area = data(3);
    A_rad = data(4);
    B_rad = data(5);
    bode = data(6);
    cond = data(7);
    
    new_cap = spherical(material.Value, area.Value, A_rad.Value, B_rad.Value);
    new_cap.solve(new_cap);
    
    bode.Visible = 'on';
    bode.UserData = new_cap;     
      
    cap.Value = new_cap.capacitance;      
    cond.Value = new_cap.conductance;    
      
end