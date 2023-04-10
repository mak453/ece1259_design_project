function b = bode_cap(fig, cap)  %input capacitor object, returns bode plot
    C = cap.capacitance;    %get capacitance
    sys = tf([1], [C 0]);  %create transfer function (reactance)
    p = uipanel(fig);
    p.Layout.Row = [5 8];
    p.Layout.Column = [5 8];
    b = bodeplot(p, sys);      %get bode plot (frequency vs reactance)  
end