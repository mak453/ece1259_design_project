def diel_prop(dielectric):
    dielectric = dielectric.lower();    #normalizes input
    
    diel_dict = {
        "air" : [1.0005, 3*10^6, 0],
        "glass" : [10,  30*10^6, 10^-12],
        "mica" : [5.4, 200*10^6, 10^-15],
        "polyethylene" : [2.26, 47*10^6, 10^-15],
        "polystryrene" : [2.56, 20*10^6, 10^-17],
        "quartz" : [3.8, 30*10^6, 10^-17],
        "teflon" : [2.1, 60*10^6, 10^-15]
    }
    
    if not (dielectric in diel_dict):
        dielectric = "air"
    
    return diel_dict[dielectric]