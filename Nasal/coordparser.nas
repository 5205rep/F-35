# phoenix
# Custom datalink Coord parser
# has 9 slots to hold data. 
# can hold more but im too lazy. 
# suppose to connect to missile.nas for gps guided mutations. but havent figured that out yet. 
# send and recive points via datalink or get them straight from the radar. then save that to a "slot"
# and then read that slot and set the current weapon to it
setprop("controls/radar/currentslot", 1);
setprop("controls/radar/slots/lat", 1);
setprop("controls/radar/slots/lon", 1);
setprop("controls/radar/slots/alt", 1);
setprop("instrumentation/frontcontrols/digit1", 0); # slot choser


# Cool datalink stuff

var datapoint = {
	lon: 0,
	lat: 0,
	alt: 0,  # this is all not needed
	new: func {
		var n = {parents: [datapoint]};
		return n;
	},
};


var sending = nil;
var data = nil;


          setprop("instrumentation/datalink/data",1);  # stop reading untill all loops we want are running

var clearsend = func {
    print("stoped");
    sending = nil;
        timer_send.stop();
        clear_timer.stop();
}


var clearsendlong = func {
    print("stoped");
    sending = nil;
    data = nil;
    timer_send.stop();
    setprop("instrumentation/datalink/data",0); 
    clear_timer_long.stop();
}


var linksendpoint = func {

	datalink.send_data({"point": sending});

}


timer_send = maketimer(0.1, linksendpoint);
clear_timer = maketimer(7, clearsend);
clear_timer_long = maketimer(10, clearsendlong);
# Datalink functions
# some inspired by f-16



var coordclick = func() {
    var lat = getprop("sim/input/click/latitude-deg");
    var lon = getprop("sim/input/click/longitude-deg");
    var h = geo.elevation(getprop("sim/input/click/latitude-deg"),getprop("sim/input/click/longitude-deg"));
    send(coordsetup(lat,lon,h));
}

var coordsetup = func(lat,lon,alt) {
    var coord = geo.Coord.new();
    var gndelev = alt*FT2M;
    print("coord: lat:" ~ lat);
    print("coord: lon:" ~ lon);
    print("coord: alt:" ~ alt);
    if (gndelev <= 0) {
        gndelev = geo.elevation(lat, lon);
       if (gndelev != nil){
            print("gndelev: " ~ gndelev);
        }
       if (gndelev == nil){
            # oh no
            gndelev = 0;
        }
    }
    print(gndelev);
    coord.set_latlon(lat, lon, gndelev);
    return coord;
}

# Sender

var send = func(coord){ # Unless given, coord is nil
	if (coord != nil and sending == nil) {
        sending = coord;
        print("Sending");
        timer_send.start();
        clear_timer.start();
        print("Sent");
    }
}   



var data = nil;
var sending = nil;
var dlink_loop = func {
  if (getprop("instrumentation/datalink/data") != 0) return;
  total = misc.searchsize();
  for(var i = 0; i < total; i += 1) {
  var reccall = getprop("ai/models/multiplayer[" ~ i ~ "]/callsign");
# if these guys on dl...
    if (1 == 1) {
      data = datalink.get_data(reccall); # get our data
      if (data != nil  and data.on_link()) {
        var p = data.point();
        if (p != nil) {
          sending = nil;
          var lat = p.lat();
          var lon = p.lon();
          var alt = p.alt()*M2FT;
          setprop("controls/radar/datarec/lat", lat);   
          setprop("controls/radar/datarec/lon", lon);
          setprop("controls/radar/datarec/alt", alt);
          print("Datalink is being sent over to us from " ~ reccall);
          screen.log.write("Datalink Coordnites were sent over from " ~ reccall ~ "!",1,1,0);
          setprop("instrumentation/datalink/lastcallsign", reccall);
          setprop("instrumentation/datalink/data",1);          
          clear_timer_long.start();
          return;
        }
      }
    }
  }
}
setprop("instrumentation/datalink/lastcallsign", "No Data");
var dlnk_timer = maketimer(3.5, dlink_loop);
dlnk_timer.start();
setprop("instrumentation/datalink/data",0); # Now were good, Enable Recording   


# Slot features

# Record GPS from AESA
var readfromrad = func() { 
    var callsign = radar.tgts_list[radar.Target_Index].Callsign.getValue();
    var mpid = misc.smallsearch(callsign); # Misc.nas version 2.1
    var lat = getprop("ai/models/multiplayer[" ~ mpid ~ "]/position/latitude-deg");
    var lon = getprop("ai/models/multiplayer[" ~ mpid ~ "]/position/longitude-deg");
    var alt = getprop("ai/models/multiplayer[" ~ mpid ~ "]/position/altitude-ft");
    setprop("controls/radar/datarec/lat", lat);
    setprop("controls/radar/datarec/lon", lon);
    setprop("controls/radar/datarec/alt", alt);
}


# read from slot

var readslot = func() {
        if (getprop("instrumentation/frontcontrols/digit1") == 0) {
        print("Not ready!");
        screen.log.write("Enter a number on the keypad for your slot then tap this button to read it and set it to the weapon");
        return;
    }
    print("read it");
setprop("controls/radar/currentslot", getprop("instrumentation/frontcontrols/digit1"));
var slottype = getprop("controls/radar/currentslot");

    var lat = getprop("controls/radar/slot[" ~ slottype ~ "]/lat");
    var lon = getprop("controls/radar/slot[" ~ slottype ~ "]/lon"); 
    var alt = getprop("controls/radar/slot[" ~ slottype ~ "]/alt"); 
    setprop("controls/radar/slots/lat", lat); 
    setprop("controls/radar/slots/lon", lon); 
    setprop("controls/radar/slots/alt", alt); 
    screen.log.write("Successfully read data from slot "~ slottype);
}


var sendcurrentslotdl = func() {
    # send the currently selected slot over datalink to all our friends
    var lat = getprop("controls/radar/slots/lat");
    var lon = getprop("controls/radar/slots/lon");
    var alt = getprop("controls/radar/slots/alt");
    send(coordsetup(lat,lon,alt));
}


var saveslot = func() {
        print("Attempting to save coords to a slot");
    if (getprop("instrumentation/frontcontrols/digit1") == 0) {
        print("Not ready!");
        screen.log.write("Enter a number on the keypad to select a slot to save coord data too then press this button to write to that slot");
        return;
    }
    print("read it");
    var slottype = getprop("instrumentation/frontcontrols/digit1");
    var lat = getprop("controls/radar/datarec/lat");  # This is either from the datalink or the radar.  We only save slot from here. not read from here
    var lon = getprop("controls/radar/datarec/lon");   # This is either from the datalink or the radar.  We only save slot from here. not read from here
    var alt = getprop("controls/radar/datarec/alt");    # This is either from the datalink or the radar.  We only save slot from here. not read from here
    setprop("controls/radar/slot[" ~ slottype ~ "]/lat", lat); 
    setprop("controls/radar/slot[" ~ slottype ~ "]/lon", lon); 
    setprop("controls/radar/slot[" ~ slottype ~ "]/alt", alt); 
    screen.log.write("Successfully saved data to slot "~ slottype);
}
setprop("controls/screen/gps", 0); # enable property