# 0 far left wing
# 1 middile left wing
# 2 close left wing
# 3 bay1
# 4 bay2
# 5 bay3

# other side

# 6 bay4
# 7 bay5
# 8 bay6
# 9 close  right wing
#10 middile right wing
#11 far right wing


var saa = func {
setprop("sim/weight[0]/selected", "none");
setprop("sim/weight[1]/selected", "none");
setprop("sim/weight[2]/selected", "none");
setprop("sim/weight[3]/selected", "Aim-120");
setprop("sim/weight[4]/selected", "Aim-120");
setprop("sim/weight[5]/selected", "Aim-120");
setprop("sim/weight[6]/selected", "Aim-120");
setprop("sim/weight[7]/selected", "Aim-120");
setprop("sim/weight[8]/selected", "Aim-120");
setprop("sim/weight[9]/selected", "none");
setprop("sim/weight[10]/selected", "none");
setprop("sim/weight[11]/selected", "none");
setprop("controls/armament/station[0]/release", "true");
setprop("controls/armament/station[1]/release", "true");
setprop("controls/armament/station[2]/release", "true");
setprop("controls/armament/station[3]/release", "false");
setprop("controls/armament/station[4]/release", "false");
setprop("controls/armament/station[5]/release", "false");
setprop("controls/armament/station[6]/release", "false");
setprop("controls/armament/station[7]/release", "false");
setprop("controls/armament/station[8]/release", "false");
setprop("controls/armament/station[9]/release", "true");
setprop("controls/armament/station[10]/release", "true");
setprop("controls/armament/station[11]/release", "true");
}


var none = func {
setprop("sim/weight[0]/selected", "none");
setprop("sim/weight[1]/selected", "none");
setprop("sim/weight[2]/selected", "none");
setprop("sim/weight[3]/selected", "none");
setprop("sim/weight[4]/selected", "none");
setprop("sim/weight[5]/selected", "none");
setprop("sim/weight[6]/selected", "none");
setprop("sim/weight[7]/selected", "none");
setprop("sim/weight[8]/selected", "none");
setprop("sim/weight[9]/selected", "none");
setprop("sim/weight[10]/selected", "none");
setprop("sim/weight[11]/selected", "none");
setprop("controls/armament/station[0]/release", "true");
setprop("controls/armament/station[1]/release", "true");
setprop("controls/armament/station[2]/release", "true");
setprop("controls/armament/station[3]/release", "true");
setprop("controls/armament/station[4]/release", "true");
setprop("controls/armament/station[5]/release", "true");
setprop("controls/armament/station[6]/release", "true");
setprop("controls/armament/station[7]/release", "true");
setprop("controls/armament/station[8]/release", "true");
setprop("controls/armament/station[9]/release", "true");
setprop("controls/armament/station[10]/release", "true");
setprop("controls/armament/station[11]/release", "true");
}

var saa9x = func {
setprop("sim/weight[0]/selected", "Aim-9x");
setprop("sim/weight[1]/selected", "none");
setprop("sim/weight[2]/selected", "none");
setprop("sim/weight[3]/selected", "Aim-120");
setprop("sim/weight[4]/selected", "Aim-120");
setprop("sim/weight[5]/selected", "Aim-120");
setprop("sim/weight[6]/selected", "Aim-120");
setprop("sim/weight[7]/selected", "Aim-120");
setprop("sim/weight[8]/selected", "Aim-120");
setprop("sim/weight[9]/selected", "none");
setprop("sim/weight[10]/selected", "none");
setprop("sim/weight[11]/selected", "Aim-9x");
setprop("controls/armament/station[0]/release", "false");
setprop("controls/armament/station[1]/release", "true");
setprop("controls/armament/station[2]/release", "true");
setprop("controls/armament/station[3]/release", "false");
setprop("controls/armament/station[4]/release", "false");
setprop("controls/armament/station[5]/release", "false");
setprop("controls/armament/station[6]/release", "false");
setprop("controls/armament/station[7]/release", "false");
setprop("controls/armament/station[8]/release", "false");
setprop("controls/armament/station[9]/release", "true");
setprop("controls/armament/station[10]/release", "true");
setprop("controls/armament/station[11]/release", "false");
}


var saa2 = func {
setprop("sim/weight[0]/selected", "Aim-9x");
setprop("sim/weight[1]/selected", "Aim-120");
setprop("sim/weight[2]/selected", "Aim-120");
setprop("sim/weight[3]/selected", "Aim-120");
setprop("sim/weight[4]/selected", "Aim-120");
setprop("sim/weight[5]/selected", "Aim-120");
setprop("sim/weight[6]/selected", "Aim-120");
setprop("sim/weight[7]/selected", "Aim-120");
setprop("sim/weight[8]/selected", "Aim-120");
setprop("sim/weight[9]/selected", "Aim-120");
setprop("sim/weight[10]/selected", "Aim-120");
setprop("sim/weight[11]/selected", "Aim-9x");
setprop("controls/armament/station[0]/release", "false");
setprop("controls/armament/station[1]/release", "false");
setprop("controls/armament/station[2]/release", "false");
setprop("controls/armament/station[3]/release", "false");
setprop("controls/armament/station[4]/release", "false");
setprop("controls/armament/station[5]/release", "false");
setprop("controls/armament/station[6]/release", "false");
setprop("controls/armament/station[7]/release", "false");
setprop("controls/armament/station[8]/release", "false");
setprop("controls/armament/station[9]/release", "false");
setprop("controls/armament/station[10]/release", "false");
setprop("controls/armament/station[11]/release", "false");
}

var agm154 = func {
setprop("sim/weight[0]/selected", "Aim-9x");
setprop("sim/weight[1]/selected", "AGM-154");
setprop("sim/weight[2]/selected", "AGM-154");
setprop("sim/weight[3]/selected", "Aim-120");
setprop("sim/weight[4]/selected", "Aim-120");
setprop("sim/weight[5]/selected", "Aim-120");
setprop("sim/weight[6]/selected", "Aim-120");
setprop("sim/weight[7]/selected", "Aim-120");
setprop("sim/weight[8]/selected", "Aim-120");
setprop("sim/weight[9]/selected", "AGM-154");
setprop("sim/weight[10]/selected", "AGM-154");
setprop("sim/weight[11]/selected", "Aim-9x");
setprop("controls/armament/station[0]/release", "false");
setprop("controls/armament/station[1]/release", "false");
setprop("controls/armament/station[2]/release", "false");
setprop("controls/armament/station[3]/release", "false");
setprop("controls/armament/station[4]/release", "false");
setprop("controls/armament/station[5]/release", "false");
setprop("controls/armament/station[6]/release", "false");
setprop("controls/armament/station[7]/release", "false");
setprop("controls/armament/station[8]/release", "false");
setprop("controls/armament/station[9]/release", "false");
setprop("controls/armament/station[10]/release", "false");
setprop("controls/armament/station[11]/release", "false");
}