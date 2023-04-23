classdef capacitor < handle
    properties (Constant, Access = protected)
      e0 = 8.854e-12
      valid = false
    end
      
    properties
        area
        capacitance
        A_dist
        dielectric
        conductance
        leakage_curr
    end
    
    methods
        function obj = capacitor(material, area, dist)          
            arguments 
                material dielectric
                area
                dist=0
            end
                
            obj.dielectric = material;
            obj.area = area;
            obj.A_dist = dist;
        end
    end
    
    methods (Static)
        function obj = solve(obj) 
            % Cap = (e0*er*A)/d  
            obj.capacitance = (obj.dielectric.er*obj.e0* obj.area)/obj.A_dist;             
            obj.conductance = 2*pi*60*obj.capacitance;
            obj.leakage_curr = 0;
        end
    end
end

