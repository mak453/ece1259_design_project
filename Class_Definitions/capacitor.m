classdef capacitor
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    properties (Constant, Access = private)
      e0 = 8.854e-12
      valid = false
    end
    
    properties
        area = -1
        capacitance = -1
        max_voltage = -1
        max_charge = -1
        plate_distance = -1
        dielectric = -1        
    end
    
    methods
        function obj = capacitor(material)
            %UNTITLED8 Construct an instance of this class
            %   Detailed explanation goes here
            arguments 
                material dielectric
            end
                
            obj.dielectric = material;
        end
        
        function outputArg = solve_1(obj, prop_1, prop_2, prop_3)
            % C = (e0*er)*A/d
            % 1       2   3 4
            
            
            
            switch inputArg
                case 1 
                    outputArg = (obj.e0*obj.dielectric.er*obj.A)/obj.d;                   
            end
        end
    end
end

