# Phoenix: Custom Simple Warning System
# for failure detection and acknoloedgement  ahhhhhh i cant spell!! lol
# general idea, if a system fails. will engage a warning then if the user clears this warning, store that in data to not show warning again, unless failure was fixed and failed again...
# use this code in any of your flightgear projects
# code remains licesesesesenend under its current aircraft



# This needs props:
# controls/screen/caution-accepted
# controls/screen/warning-accepted

var warning_page = getprop("controls/screen/menu2");
var buffer = 0;

# Our "data"

var failed1 = 0;   # elevator
var failed2 = 0;   # aileron
var failed3 = 0;   # engine
var failed4 = 0;   # rudder
var failed5 = 0;   # electrical
var failed6 = 0;   # avion
var failed7 = 0;   # flcs

# Warning variables

# var caution = 0;
# var warning = 0;


var warning_loop = func {

    # Warnings
    var elevator = getprop("sim/failure-manager/controls/flight/elevator/serviceable");
    var aileron = getprop("sim/failure-manager/controls/flight/aileron/serviceable");
    var engine = getprop("sim/failure-manager/engines/engine/serviceable");
    var rudder = getprop("sim/failure-manager/controls/flight/rudder/serviceable");
    var electrical = getprop("sim/failure-manager/systems/electrical/serviceable");

    # Cautions
    var avion = getprop("sim/failure-manager/systems/static/serviceable"); # if this goes out, advanced features like icaws functions improperly
    var flcs = getprop("sim/failure-manager/systems/pitot/serviceable"); # used for air data via fdm, if this goes out. airplane is hard to control

    # if the elevator dies
    # set failed1 to 1 and brodcast failure
    if (failed1 == 0){
        if (elevator == 0){
            failed1 = 1;
            warning(); # callwarning and start flashing
        }
    }
    if (failed2 == 0){
        if (aileron == 0){
            failed2 = 1;
            warning(); # callwarning and start flashing
        }
    }
    if (failed3 == 0){
        if (engine == 0){   # thats bad lol
            failed3 = 1;
            warning(); # callwarning and start flashing
        }
    }
    if (failed4 == 0){
        if (rudder == 0){
            failed4 = 1;
            warning(); # callwarning and start flashing
        }
    }
    if (failed5 == 0){
        if (electrical == 0){
            failed5 = 1;
            # electricsaredead();
            warning(); # callwarning and start flashing
        }
    }

    # Cautions
    
    if (failed6 == 0){
        if (avion == 0){
            failed6 = 1;
            caution(); # callcaution
        }
    }
    if (failed7 == 0){
        if (flcs == 0){
            failed7 = 1;
            caution(); # callcaution
        }
    }

    # If all else repair damage and reset data

    if (elevator == 1){
        failed1 = 0;
    }
        if (aileron == 1){
        failed2 = 0;
    }
        if (engine == 1){
        failed3 = 0;
    }
        if (rudder == 1){
        failed4 = 0;
    }
        if (electrical == 1){
        failed5 = 0;
    }
        if (avion == 1){
        failed6 = 0;
    }
        if (flcs == 1){
        failed7 = 0;
    }
        # Simple but it works
}

var warning = func() {
    setprop("controls/screen/warning", 1);
  #  startflash();    
    print("warning started");
    buffer = getprop("controls/screen/menu2");
    setprop("controls/screen/menu2", 1); # Show the user the failures page. 
}
var caution = func() {
    setprop("controls/screen/caution", 1);
    print("caution started");
    # no need for failure page when its just a caution
}
var clearwarning = func() {
    setprop("controls/screen/warning", 0);
   # stopflash();
    print("Stop warning");
    setprop("controls/screen/menu2", buffer); # if they didnt open the failure page. close it when they clear the warning
}
var clearcaution = func() {
    setprop("controls/screen/caution", 0);
    print("Stop Caution");
}

var loop = maketimer(0.5, warning_loop);
loop.start();