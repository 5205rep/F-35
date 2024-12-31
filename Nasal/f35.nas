
setlistener("/sim/current-view/view-number", func(n) { setprop("/sim/hud/visibility[1]", n.getValue() == 0) },1);
var fire = func(v,a) {
# This controls the Bay doors automaticly
# Call this when you shoot a missile.
var dt = 0;
var time = getprop("/sim/time/elapsed-sec");
var weapon = getprop("/controls/armament/selected-weapon-digit");


# Open the bay doors
# Determine weapon

	if (weapon == 2) {
# aim-120
            if(time - dt > 1)
            {
                dt = time;
	            	setprop("/controls/baydoors/AIM120", 1);
                print("bay doors open");
                timer_baydoorsclose.start();
            }




	} elsif (weapon == 1) {
# aim-9X
            if(time - dt > 1)
            {
                dt = time;
	            	setprop("/controls/baydoors/AIM9X", 0);          # animations are inverted: todo fix the bay door animations
                print("9x doors open");
                timer_baydoorsclose.start();     
            }




  }
}


var closebays = func{
	            	setprop("/controls/baydoors/AIM120", 0);
	            	setprop("/controls/baydoors/AIM9X", 1);  # animations are inverted: todo fix the bay door animations
                print("closed");
                timer_baydoorsclose.stop();
}


var checkforext = func {
	var pylon1 = getprop("sim/weight[0]/selected");
  	var pylon12 = getprop("sim/weight[11]/selected");

	if (pylon1 != "none" or pylon12 != "none") {
		setprop("controls/armament/extpylons", 1);
	} else {
		setprop("controls/armament/extpylons", 0);

  }


}

var checkforext2 = func {
  	var pylon2 = getprop("sim/weight[1]/selected");
  	var pylon3 = getprop("sim/weight[2]/selected");

	var pylon10 = getprop("sim/weight[9]/selected");
  	var pylon11 = getprop("sim/weight[10]/selected");

	if ( pylon2 != "none" or pylon3 != "none" or pylon10 != "none" or pylon11 != "none" ) {
		setprop("controls/armament/extpylons1", 1);
	} else {
		setprop("controls/armament/extpylons1", 0);

  }


}


var flares = func{
  #flare();
	var flarerand = rand();
props.globals.getNode("/rotors/main/blade[3]/flap-deg",1).setValue(flarerand);
props.globals.getNode("/rotors/main/blade[3]/position-deg",1).setValue(flarerand);
settimer(func   {
    props.globals.getNode("/rotors/main/blade[3]/flap-deg").setValue(0);
    props.globals.getNode("/rotors/main/blade[3]/position-deg").setValue(0);
setprop("/ai/submodels/submodel/flare-release",0);
                },1);

}


var damagedetect = func{

var a = getprop("/sim/failure-manager/controls/flight/aileron/serviceable");
var b = getprop("/sim/failure-manager/controls/flight/elevator/serviceable");
var c = getprop("/sim/failure-manager/controls/flight/rudder/serviceable");
	if ( a == 0 ) {
            setprop("sim/multiplay/generic/bool[1]",1);
		if ( b == 0 ) {
              setprop("sim/multiplay/generic/bool[1]",1);
			if ( c == 0 ) {
        setprop("sim/multiplay/generic/bool[1]",1);
        }
    }
  }else{
            setprop("sim/multiplay/generic/bool[1]",0);
  }

}




# Phoenix's Lock helper for radar2

var tgtlock = func{
if (getprop("instrumentation/radar/lock") == 1){
var target1_x = radar.tgts_list[radar.Target_Index].TgtsFiles.getNode("h-offset",1).getValue();
var target1_z = radar.tgts_list[radar.Target_Index].TgtsFiles.getNode("v-offset",1).getValue();
setprop("instrumentation/radar2/lockmarker", target1_x / 10);
setprop("instrumentation/radar2/lockmarker", target1_x / 10);
setprop("instrumentation/radar/az-field", 161);
# setprop("instrumentation/radar/grid", 0);
print(target1_x / 10);
setprop("instrumentation/radar2/sweep-speed", 10);
  } elsif (getprop("instrumentation/radar/lock") == 0){

  
    if(getprop("instrumentation/radar/mode/main") == 1)
    {
        setprop("instrumentation/radar/az-field", 120);
        setprop("instrumentation/radar2/sweep-display-width", 0.0846);        
        setprop("instrumentation/radar2/sweep-speed", 1);   
      #  wcs_mode = "pulse-srch";
      #  AzField.setValue(120);
      #  swp_diplay_width = 0.0844;
    }
    elsif(getprop("instrumentation/radar/mode/main") == 0)
    {
        setprop("instrumentation/radar/az-field", 60);
        setprop("instrumentation/radar/mode/main", 0);
        #wcs_mode = "tws-auto";
        setprop("instrumentation/radar2/sweep-display-width", 0.0446);        
        setprop("instrumentation/radar2/sweep-speed", 2);   
        tgts_list = [];
    }
  }
}




## LIGHTS

beacon_switch = props.globals.getNode("controls/lighting/beacon", 1);
var beacon = aircraft.light.new( "/sim/model/lights/beacon", [0.05, 1.2,], "/controls/lighting/beacon" );

strobe_switch = props.globals.getNode("controls/switches/strobe", 1);
var strobe = aircraft.light.new( "/sim/model/lights/strobe", [0.05, 3,], "/controls/lighting/strobe" );


beacon_switch = props.globals.getNode("controls/lighting/nav-lights", 1);
var strobe = aircraft.light.new( "/sim/model/lights/nav-lights", [0.5, 1,], "/controls/lighting/nav-lights" );



# WING FOLD

var wing = aircraft.door.new("wings", 10);
var switch = props.globals.getNode("sim/model/F-35/controls/wings/wings-switch", 1);
var pos = props.globals.getNode("wings/position-norm", 1);

var wings_switch = func(v) {

	var p = pos.getValue();

	if (v == 2 ) {
		if ( p < 1 ) {
			v = 1;
		} elsif ( p >= 1 ) {
			v = -1;
		}
	}

	if (v < 0) {
		switch.setValue(1);
		wing.close();

	} elsif (v > 0) {
		switch.setValue(3);
		wing.open();

	}
}

# fixes cockpit when use of ac_state.nas #####
var cockpit_state = func {
	var switch = getprop("sim/model/F-35/controls/wings/wings-switch");
	if ( switch == 1 ) {
		setprop("wings/position-norm", 0);
	}
}

# used to the animation of the canopy switch and the canopy move
# toggle keystroke or 2 position switch

var cnpy = aircraft.door.new("canopy", 10);
var switch = props.globals.getNode("sim/model/F-35/controls/canopy/canopy-switch", 1);
var pos = props.globals.getNode("canopy/position-norm", 1);

var canopy_switch = func(v) {

	var p = pos.getValue();

	if (v == 2 ) {
		if ( p < 1 ) {
			v = 1;
		} elsif ( p >= 1 ) {
			v = -1;
		}
	}

	if (v < 0) {
		switch.setValue(1);
		cnpy.close();

	} elsif (v > 0) {
		switch.setValue(3);
		cnpy.open();

	}
}

# fixes cockpit when use of ac_state.nas #####
var cockpit_state = func {
	var switch = getprop("sim/model/35/controls/canopy/canopy-switch");
	if ( switch == 1 ) {
		setprop("canopy/position-norm", 0);
	}
}




# Loops!
timer_baydoorsclose = maketimer(1, closebays);

# Init the radar

	    myRadar = radar.Radar.new();
		myRadar.init();

		timer_extpylons = maketimer(0.25, checkforext);
		timer_extpylons2 = maketimer(0.25, checkforext2);
    timer_extpylons.start();
    timer_extpylons2.start();

	timer_damage = maketimer(0.5, damagedetect);
	        timer_damage.start();