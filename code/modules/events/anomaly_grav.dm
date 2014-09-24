/datum/round_event_control/anomaly/anomaly_grav
	name = "Gravitational Anomaly"
	typepath = /datum/round_event/anomaly/anomaly_grav
	max_occurrences = 3
	weight = 15

/datum/round_event/anomaly/anomaly_grav
	startWhen = 15
	announceWhen = 1
	endWhen = 100 // SHINE this one might as well last long to actually make it a problem


/datum/round_event/anomaly/anomaly_grav/announce()
	priority_announce("Gravitational anomaly detected on long range scanners. Expected location: [impact_area.name].", "Anomaly Alert")

/datum/round_event/anomaly/anomaly_grav/start()
	var/turf/T = pick(get_area_turfs(impact_area))
	if(T)
		newAnomaly = new /obj/effect/anomaly/grav(T.loc)