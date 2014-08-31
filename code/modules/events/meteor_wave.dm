/datum/round_event_control/meteor_wave
	name = "Meteor Wave"
	typepath = /datum/round_event/meteor_wave
	weight = 5
	max_occurrences = 1

/datum/round_event/meteor_wave
	startWhen		= 6
	endWhen			= 40 //SHINE nerfed to 40 from 55
	announceWhen	= 1

/datum/round_event/meteor_wave/announce()
	priority_announce("Meteors have been detected on collision course with the station.", "Meteor Alert", 'sound/AI/meteors.ogg')


/datum/round_event/meteor_wave/tick()
	if(IsMultiple(activeFor, 3))
		spawn_meteors(5, meteorsA) //meteor list types defined in gamemode/meteor/meteors.dm
