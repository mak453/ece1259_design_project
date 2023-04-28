classdef spherical < capacitor
    properties
       B_dist
    end
    
    methods
        function obj = spherical(material, area, radius_A, radius_B)          
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
            % C=(4πϵ0*A*B)/(B−A)            
            obj.capacitance = (4*pi*obj.e0*obj.dielectric.er*obj.A_dist*obj.B_dist)/abs(obj.B_dist - obj.A_dist);
            obj.conductance = 2*pi*60*obj.capacitance;
        end
    end
end