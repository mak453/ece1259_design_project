classdef spherical_cap < capacitor
    properties
       B 
    end
    
    methods
        function obj = spherical(material, cap, area, radius_A, radius_B)          
            arguments 
                material dielectric
                cap=0
                area=0
                radius_A=0
                radius_B=0
            end
                
            obj.dielectric = material;
            obj.material = material.name;
            obj.capacitance = cap;
            obj.area = area;
            obj.plate_distance = radius_A;
            obj.B = radius_B;
            
            obj.solve();
        end

        function obj = solve(obj) 
            % C=(4πϵ0*A*B)/(B−A)            
            if obj.capacitance == 0 && obj.area > 0 && obj.plate_distance > 0 && obj.B > 0
                obj.capacitance = (4*pi*obj.e0*obj.dielectric.er*obj.plate_distance*obj.B)/(obj.B - obj.plate_distance);
            elseif obj.capacitance > 0 && obj.area = 0 && obj.plate_distance > 0 && obj.B > 0
                
            elseif obj.capacitance > 0 && obj.area > 0 && obj.plate_distance == 0 && obj.B > 0
                
            elseif obj.capacitance > 0 && obj.area > 0 && obj.plate_distance > 0 && obj.B == 0
                
            else
                ME = MException('GUI:InvalidInputs','Too many missing inputs. Cannot solve.');
                throw(ME)
            end
        end
    end
end