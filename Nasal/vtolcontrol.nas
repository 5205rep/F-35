# Phoenix VTOL Pitch controller (So human error doesnt cause it to flip)

setprop("/controls/flight/VTOLelevator",0.001);
setprop("/controls/flight/VTOLelevator",0);
setprop("/autopilot/internal/vtolpitch",0.001);
setprop("/autopilot/internal/vtolpitch",0);

var dothing = func {
    if (getprop("controls/engines/engine/mixture[0]") < 0.21) {

        if (getprop("autopilot/locks/altitude") != "VTOL") {
        setprop("autopilot/locks/altitude","VTOL"); # Only once
        }

        if (getprop("controls/flight/elevator") > 0.3 or getprop("controls/flight/elevator") < -0.3) {
        # MEGA IF STATEMENT
            if (getprop("controls/flight/elevator") > 0.3) {
                if (getprop("position/altitude-agl-ft") < 400){
                setprop("/autopilot/settings/vtolpitch", -18);
                } else {
                setprop("/autopilot/settings/vtolpitch", -35);
                }

            }
            if (getprop("controls/flight/elevator") < -0.3) {
                setprop("/autopilot/settings/vtolpitch", 18);
            }
        } else {
            setprop("/autopilot/settings/vtolpitch", 0);
        }
        print("HELICOPTER! HELICOPTER~!");
    } else {
        if (getprop("autopilot/locks/altitude") == "VTOL") {
            setprop("autopilot/locks/altitude","");
        }
    }



}

fbwtimer = maketimer(0,dothing);
fbwtimer.start();