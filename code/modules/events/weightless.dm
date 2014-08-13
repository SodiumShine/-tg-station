/datum/round_event_control/weightless
	name = "Gravity Systems Failure"
	typepath = /datum/round_event/weightless
	max_occurrences = 2
	weight = 10

/datum/round_event/weightless
	startWhen = 1
	announceWhen = 10
	var/list/area/gravityAreas = list()


/datum/round_event/weightless/setup()

	for(var/area/engine/A in world)
		if(istype(A, /area/engine/gravity_generator))
			gravityAreas += A


/datum/round_event/weightless/announce()
	if(gravityAreas && gravityAreas.len > 0)
		priority_announce("Warning: We have detected an issue with the Gravity Generator on [station_name()]. Nanotrasen wishes to remind you that the unauthorised misuse of graviton fields within Nanotrasen facilities is strictly prohibited by health and safety regulation [rand(99,9999)][pick("a","b","c")]:subclause[rand(1,20)][pick("a","b","c")].")

	else
		world.log << "ERROR: Could not initate weightless. Unable find gravity generator area."
		kill()


/datum/round_event/weightless/start()
	for(var/area/A in gravityAreas)
		for(var/obj/machinery/light/L in A)
			L.flicker(10)
		for(var/obj/machinery/gravity_generator/main/gg in A)
			gg.set_broken()
/*
/datum/round_event_control/weightless
	name = "Gravity Systems Failure"
	typepath = /datum/round_event/weightless
	weight = 15

/datum/round_event/weightless
	startWhen = 5
	endWhen = 65
	var/obj/machinery/gravity_generator/main/gravMachine

/datum/round_event/weightless/setup()
	startWhen = rand(0,10)
	endWhen = rand(40,80)
	gravMachine = world/obj/machinery/gravity_generator/main

/datum/round_event/weightless/announce()
	command_alert("Warning: Failsafes for the station's artificial gravity arrays have been triggered. Please be aware that if this problem recurs it may result in formation of gravitational anomalies. Nanotrasen wishes to remind you that the unauthorised formation of anomalies within Nanotrasen facilities is strictly prohibited by health and safety regulation [rand(99,9999)][pick("a","b","c")]:subclause[rand(1,20)][pick("a","b","c")].")

/datum/round_event/weightless/start()
	gravMachine.on = 0

	for(var/area/A in world)
		A.gravitychange(0)

	if(control)
		control.weight *= 2

/datum/round_event/weightless/end()
	for(var/area/A in world)
		A.gravitychange(1)

	if(announceWhen >= 0)
		command_alert("Artificial gravity arrays are now functioning within normal parameters. Please report any irregularities to your respective head of staff.")
*/