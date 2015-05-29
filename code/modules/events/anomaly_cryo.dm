/datum/round_event_control/anomaly/anomaly_cryo
	name = "Anomaly: Cryogenic"
	typepath = /datum/round_event/anomaly/anomaly_cryo
	max_occurrences = 5
	weight = 20

/datum/round_event/anomaly/anomaly_cryo
	startWhen = 10
	announceWhen = 3
	endWhen = 85


/datum/round_event/anomaly/anomaly_cryo/announce()
	priority_announce("Cryogenic anomaly detected on long range scanners. Expected location: [impact_area.name].", "Anomaly Alert")

/datum/round_event/anomaly/anomaly_cryo/start()
	var/turf/T = pick(get_area_turfs(impact_area))
	if(T)
		newAnomaly = new /obj/effect/anomaly/cryo(T.loc)

/datum/round_event/anomaly/anomaly_cryo/tick()
	if(!newAnomaly)
		kill()
		return
	if(IsMultiple(activeFor, 5))
		newAnomaly.anomalyEffect()