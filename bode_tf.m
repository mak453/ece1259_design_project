function b = bode_tf(num_str, den_str)   % input numerator and denomenator as strings, returns bode plot
    % convert string to symbolic expression
    num = str2sym(num_str);
    den = str2sym(den_str);
    
    % check for inappropriate variables
    if ~isequal(symvar(num), symvar(den))
        ME = MException('TransferFx:DifferentVar', 'Different variables used in numerator and denomenator. Cannot solve.');
        throw(ME);
    end
    if length(symvar(num)>1)
        ME = MException('TransferFx:TooManyVar', 'Too many variables. Cannot solve.');
        throw(ME);
    end
    if isempty(symvar(num))
        ME = MException('TransferFx:NoVar', 'No variables detected.');
        throw(ME);
    end
    
    %get coefficients and create transfer function
    sys = tf(sym2poly(num), sym2poly(den));
    
    %create bode plot
    b = bodeplot(sys);
end