<<<<<<< Updated upstream
classdef capacitor
    properties (Constant, Access = private)
=======
classdef capacitor < handle
    properties (Constant, Access = protected)
>>>>>>> Stashed changes
      e0 = 8.854e-12
      valid = false
    end
      
    properties
        area
        capacitance
        max_voltage
        max_charge
        A_dist
        dielectric
        reactance
    end
    
    methods
        function obj = capacitor(material, cap, area, dist)          
            arguments 
                material dielectric
                cap=0
                area=0
                dist=0
            end
                
            obj.dielectric = material;
            obj.capacitance = cap;
            obj.area = area;
<<<<<<< Updated upstream
            obj.plate_distance = dist;
            
            obj.solve(obj)
        end
    end  
    
    methods(Static)
        function obj = solve(obj) 
            % C = (e0*er*A)/d            
            if obj.capacitance == 0 && obj.area > 0 && obj.plate_distance > 0
                obj.capacitance = (obj.dielectric.er * obj.area)/obj.plate_distance; 
            elseif obj.capacitance > 0 && obj.area == 0 && obj.plate_distance > 0
                obj.area = (obj.capacitance*obj.plate_distance)/(e0*obj.dielectric.er);
            elseif obj.capacitance > 0 && obj.area > 0 && obj.plate_distance == 0
                obj.plate_distance = (e0*obj.dielectric.er*obj.area)/obj.capacitance;
=======
            obj.A_dist = dist;
            disp(obj)
            obj.solve(obj);
        end
    end
    
    methods (Static)
        function obj = solve(obj) 
            % C = (e0*er*A)/d            
            if obj.capacitance == 0 && obj.area > 0 && obj.A_dist > 0
                obj.capacitance = (obj.dielectric.er*obj.e0* obj.area)/obj.A_dist; 
            elseif obj.capacitance > 0 && obj.area == 0 && obj.A_dist > 0
                obj.area = (obj.capacitance*obj.A_dist)/(obj.e0*obj.dielectric.er);
            elseif obj.capacitance > 0 && obj.area > 0 && obj.A_dist == 0
                obj.A_dist = (obj.e0*obj.dielectric.er*obj.area)/obj.capacitance;
>>>>>>> Stashed changes
            else
                % error
            end
        end
    end
end

