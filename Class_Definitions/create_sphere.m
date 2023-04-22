function create_sphere(obj, eventData)
    data = get(obj, 'UserData');
        
    material = data(1);
    cap = data(2);
    area = data(3);
    A_rad = data(4);
    B_rad = data(5);
    bode_b = data(6);
    new_cap = spherical_cap(material.Value, cap.Value, area.Value, A_rad.Value, B_rad.Value);
    
    userData = struct;
    userData.bode = bode_b;
    userData.cap = new_cap;
    
    bode_b.Visible = 'on';
    bode_b.UserData = userData;     
      
%     if cap.Value == 0 && area.Value > 0 && dist.Value > 0
%         cap.Value = new_cap.capacitance;      
%     elseif cap.Value > 0 && area.Value == 0 && dist.Value > 0
%         area.Value = new_cap.area; 
%     elseif cap.Value > 0 && area.Value > 0 && dist.Value == 0
%         dist.Value = new_cap.A_dist;
%     end   
        
end