clear; clc;
addpath('Class_Definitions')
[bank_names, bank] = material_bank;

GUI(bank_names, bank)

function GUI(bank_names, bank)
    figGUI = uifigure('Name','Capacitor Design Tool','NumberTitle','off');
    fig = uigridlayout(figGUI, [6,3]);
    
    cap_shape = uibuttongroup(fig);
    cap_shape.Layout.Row = 1;
    cap_shape.Layout.Column = [1 3];

    p = uiradiobutton(cap_shape, "Text", "Parallel Plate", "Position", [150 10 91 22], "Value", 1, "Tag", "plate");
    s = uiradiobutton(cap_shape, "Text", "Spherical", "Position", [300 10 91 22], "Value", 0, "Tag", "sphere");
    c = uiradiobutton(cap_shape, "Text", "Cylindrical", "Position", [450 10 91 22], "Value", 0, "Tag", "cylinder");
    
    defaultData = struct;
    defaultData.OldValue=p;
    defaultData.NewValue=p;
    defaultData.Source=cap_shape;
    defaultData.EventName='SelectionChanged';
    
    shape_SelectionChangedFcn(cap_shape, defaultData);
    
    set(cap_shape, 'SelectionChangedFcn', @shape_SelectionChangedFcn);

    function shape_SelectionChangedFcn(hObject, eventData)
        switch get(eventData.NewValue,'Tag') % Get Tag of selected object.
            case 'plate'
                
                plateGUI(fig, bank_names, bank)
                
            case 'sphere'
                
                sphereGUI(fig, bank_names, bank)
                
            case 'cylinder'
                
                cylinderGUI(fig, bank_names, bank) 
                
            otherwise
                
                plateGUI(fig, bank_names, bank)
                
        end
    end
end
