classdef cylindrical < capacitor
    properties
       B_dist
    end
    
    methods
        function obj = cylindrical(material, area, radius_A, radius_B)          
            arguments 
                material dielectric
                area
                radius_A
                radius_B
            end
                
            obj@capacitor(material, area, radius_A);
            obj.B_dist = radius_B;
         
        end
    end
        
    methods (Static)
        function obj = solve(obj) 
            
            obj.capacitance = (2*pi*obj.e0*obj.dielectric.er)/abs(log(obj.B_dist) - log(obj.A_dist));
            obj.conductance = 2*pi*60*obj.capacitance;
        end
    end
end