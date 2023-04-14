function b = bode_cap(cap)  %input capacitor object, returns bode plot
    C = cap.capacitance;    %get capacitance
    sys = tf([1], [C, 0]);  %create transfer function (reactance)
    b = bodeplot(sys);      %get bode plot (frequency vs reactance)
end