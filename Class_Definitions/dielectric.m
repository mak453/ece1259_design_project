classdef dielectric
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        er
        Ebr
        sigma
    end
    
    methods
        function obj = dielectric(a,b,c,d)
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = a;
            obj.er = b;
            obj.Ebr = c;
            obj.sigma = d;
        end
    end
end

