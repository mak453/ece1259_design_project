classdef capacitor < handle
    properties (Constant, Access = private)
      e0 = 8.854e-12
      valid = false
    end
    
    properties (Access = private)
        dielectric
    end
    
    properties
        area
        capacitance
        max_voltage
        max_charge
        plate_distance
        material
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
            obj.material = material.name;
            obj.capacitance = cap;
            obj.area = area;
            obj.plate_distance = dist;
            
            obj.solve();
        end

        function obj = solve(obj) 
            % C = (e0*er*A)/d            
            if obj.capacitance == 0 && obj.area > 0 && obj.plate_distance > 0
                obj.capacitance = (obj.dielectric.er*obj.e0* obj.area)/obj.plate_distance; 
            elseif obj.capacitance > 0 && obj.area == 0 && obj.plate_distance > 0
                obj.area = (obj.capacitance*obj.plate_distance)/(obj.e0*obj.dielectric.er);
            elseif obj.capacitance > 0 && obj.area > 0 && obj.plate_distance == 0
                obj.plate_distance = (obj.e0*obj.dielectric.er*obj.area)/obj.capacitance;
            else
                ME = MException('GUI:InvalidInputs','Too many missing inputs. Cannot solve.');
                throw(ME)
            end
        end
    end
end

