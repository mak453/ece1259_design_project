function plateGUI(fig, fields)
    dd = fields(1);
    cap = fields(2);
    area = fields(3);
    A_field = fields(4);
    new_obj = capacitor(dd.Value, cap.Value, area.Value, A_field.Value);
    
    b =  uibutton(fig, 'Text', 'Calculate', 'FontSize', 32); 
    set(b, 'ButtonPushedFcn', @create_capacitor);
    b.Layout.Row = 7;
    b.Layout.Column = [1 3];   
      
    bode =  uibutton(fig, 'Text', 'Plot Bode', 'FontSize', 32); 
    set(bode, 'ButtonPushedFcn', @bode_cap);
    bode.Layout.Row = 7;
    bode.Layout.Column = [5 8];
    
    function create_capacitor(obj, eventData)
                
        cap_obj = capacitor(dd.Value, cap.Value, area.Value, A_field.Value);
                
        if cap.Value == 0 && area.Value > 0 && A_field.Value > 0
            cap.Value = cap_obj.capacitance;      
        elseif cap.Value > 0 && area.Value == 0 && A_field.Value > 0
            area.Value = cap_obj.area; 
        elseif cap.Value > 0 && area.Value > 0 && A_field.Value == 0
            A_field.Value = cap_obj.A_dist;
        end     
          
        new_obj = cap_obj;
    end

    function bode_cap(cap)  %input capacitor object, returns bode plot
        C = cap.capacitance;    %get capacitance
        sys = tf([1], [C 0]);  %create transfer function (reactance)
        p = uipanel(fig);
        p.Layout.Row = [5 8];
        p.Layout.Column = [5 8];
        bodeplot(p, sys);      %get bode plot (frequency vs reactance)  
    end
 
end