close all; clear; clc;
addpath('Class_Definitions')
run("material_bank.m")

figGUI = uifigure("Name","Capacitor Designer Tool", "NumberTitle","off");
fig = uigridlayout(figGUI, [6 3]);

cap_shape = uibuttongroup(fig);
cap_shape.Layout.Row = 1;
cap_shape.Layout.Column = [1 3];

plate_b = uiradiobutton(cap_shape, "Text", "Parallel Plate", "Position", [150 10 91 22], "Value", 1, "Tag", "plate");
sphere_b = uiradiobutton(cap_shape, "Text", "Spherical", "Position", [300 10 91 22], "Value", 0, "Tag", "sphere");
cylinder_b = uiradiobutton(cap_shape, "Text", "Cylindrical", "Position", [450 10 91 22], "Value", 0, "Tag", "cylinder");

wrapper=struct;
wrapper.bank=bank_names;
wrapper.material_values=material_values;
wrapper.fig=cap_shape.Parent;
wrapper.group=cap_shape;

set(wrapper.group, 'SelectionChangedFcn', @shape_SelectionChangedFcn);



function shape_SelectionChangedFcn(hObject, eventData, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  structure with the following fields
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

disp(handles)

    switch get(eventData.NewValue,'Tag') % Get Tag of selected object.
        case 'plate'
            dd = uidropdown(hObject.Parent, "Items", handles.bank, "ItemsData", handles.material_values);
            dd.Layout.Row = 5;
            dd.Layout.Column = 2;
        case 'sphere'
            display('B');
        case 'cylinder'
            display('C');
    end
    
end

% function doMyStuff(hObject, event)
% 
%     try
%         h=guidata(hObject);
%     catch
%         h=guidata(event.AffectedObject.Parent);
%     end
% 
%     if h.sphere_b.Value == 1 
% 
%     elseif h.cylinder_b.Value == 1
% 
%     else
%         dd = uidropdown(fig, "Items", bank_names, "ItemsData",material_values);
%         dd.Layout.Row = 5;
%         dd.Layout.Column = 2;
% 
%         dd_label = uilabel(fig, "Text", "Dielectric Material");
%         dd_label.Layout.Row = 5;
%         dd_label.Layout.Column = 1;
% 
%         cap = uieditfield(fig,'numeric');
%         cap.Value = 0;
%         cap.Layout.Row = 2;
%         cap.Layout.Column = 2;
% 
%         cap_label = uilabel(fig, "Text", "Capacitance Value (F)");
%         cap_label.Layout.Row = 2;
%         cap_label.Layout.Column = 1;
% 
%         area = uieditfield(fig,'numeric');
%         area.Value = 0;
%         area.Layout.Row = 3;
%         area.Layout.Column = 2;
% 
%         area_label = uilabel(fig, "Text", "Surface Area (m^2)");
%         area_label.Layout.Row = 3;
%         area_label.Layout.Column = 1;
% 
%         dist = uieditfield(fig,'numeric');
%         dist.Value = 0;
%         dist.Layout.Row = 4;
%         dist.Layout.Column = 2;
% 
%         dist_label = uilabel(fig, "Text", "Distance between Plates (m)");
%         dist_label.Layout.Row = 4;
%         dist_label.Layout.Column = 1;
% 
%         b =  uibutton(fig, "Text","Calculate", "ButtonPushedFcn", @(src,event) create_capacitor());
%         b.Layout.Row = 6;
%         b.Layout.Column = 3;
%         drawnow
%     end
% end

function create_capacitor(bank, cap_val, area_val, dist_val) 
    cap_obj = capacitor(bank(1), cap_val, area_val, dist_val);
end