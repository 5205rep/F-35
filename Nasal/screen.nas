# Phoenix's touch screen for the F-35
# Pilot taps target on screen, Locks shows info
# Up to 19 targets at once

var lock = func(mpid) {
    var tgtcs = getprop("ai/models/multiplayer[" ~ mpid ~ "]/callsign");
    var radcs = radar.tgts_list[radar.Target_Index].Callsign.getValue();
    screen.log.write(tgtcs);
    radar.next_Target_Index();
    while (tgtcs != radcs){
        if (tgtcs == radcs){
            print("locked");
            break;
        } else {
            radar.next_Target_Index();
        }
    }
}

radar.next_Target_Index();