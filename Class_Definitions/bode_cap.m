function bode_cap(obj, eventData)  %input capacitor object, returns bode plot
    data = get(obj, 'UserData');
    cap = data(1);
    C = cap.capacitance;
    disp(data)
    panel = uipanel(obj.Parent);
    panel.Layout.Row = [1 6];
    panel.Layout.Column = [4 8];
    
    axes = uiaxes(panel, 'OuterPosition', [5 15 230 205]);
   
    %if (num.Value == '' || num.Value == 'Numerator') && (denom.Value == '' || denom.Value == 'Denomenator')
    sys = tf(1, [C 0]);  %create transfer function (reactance)
    disp(sys)    
        %get capacitance
        
    opts = bodeoptions;
    opts.Title.String = '';
    opts.Grid = 'on';
    
    bodeplot(axes, sys, opts);
    
end