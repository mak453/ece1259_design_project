function b = bode_tf(data)   % input numerator and denomenator as strings, returns bode plot
    % convert string to symbolic expression
    num = str2sym(string(data.num));
    den = str2sym(string(data.denom));
    
    % check for inappropriate variables
%     if ~isequal(symvar(num), symvar(den))
%         ME = MException('TransferFx:DifferentVar', 'Different variables used in numerator and denomenator. Cannot solve.');
%         throw(ME);
%     end
%     if length(symvar(num)>1)
%         ME = MException('TransferFx:TooManyVar', 'Too many variables. Cannot solve.');
%         throw(ME);
%     end
%     if isempty(symvar(num))
%         ME = MException('TransferFx:NoVar', 'No variables detected.');
%         throw(ME);
%     end
    
    %get coefficients and create transfer function
    sys = tf(sym2poly(num), sym2poly(den));
   
    %create bode plot
    panel = uipanel(data.fig);
    panel.Layout.Row = [1 5];
    panel.Layout.Column = [4 8];
    axes = uiaxes(panel, 'OuterPosition', [5 15 230 205]);
    opts = bodeoptions;
    opts.Title.String = '';
    opts.Grid = 'on';    
    bodeplot(axes, sys, opts);
       
end