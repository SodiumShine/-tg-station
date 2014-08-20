var/const/CYBORG_AFK_BRACKET = 450

/datum/round_event_control/cyborg_delivery
	name = "Cyborg Delivery"
	typepath = /datum/round_event/cyborg_delivery
	weight = 10
	max_occurrences = 10

/datum/round_event/cyborg_delivery
	announceWhen	= 10

	var/list/area/shuttleAreas = list()
	var/spawncount = 1
	var/successSpawn = 0	//So we don't make a command report if nothing gets spawned.


/datum/round_event/cyborg_delivery/setup()
	for(var/area/shuttle/arrival/station/A in world)
		if(istype(A, /area/shuttle/arrival/station))
			shuttleAreas += A
			message_admins("Shuttle area finished [shuttleAreas] [A]")


/datum/round_event/cyborg_delivery/kill()
	if(!successSpawn && control)
		message_admins("Cyborg delivery failed")
		control.occurrences--
	return ..()

/datum/round_event/cyborg_delivery/announce()
	if(successSpawn)
		priority_announce("We've sent a cyborg to [station_name()] to assist the crew. They're uh, cheaper than human staff.")


/datum/round_event/cyborg_delivery/start()
	message_admins("Starting...")
	var/list/chairs = list()
	for(var/area/A in shuttleAreas)
		for(var/obj/effect/landmark/temp_seat in A)
//			message_admins("Found temp_seat in A")
			if(temp_seat.loc.z == 1)
				chairs += temp_seat
//				message_admins("Found chairs [chairs] [temp_seat]")

	var/list/candidates = get_candidates(BE_CYBORG, CYBORG_AFK_BRACKET)

	message_admins("Cyborg Delivery: Spawn count:[spawncount], chairs len: [chairs.len], candidates [candidates.len]")
	while(spawncount > 0 && chairs.len && candidates.len)
//		message_admins("last bit happening")
		var/obj/chair = pick_n_take(chairs)
		var/client/C = pick_n_take(candidates)

		var/mob/living/silicon/robot/new_robot = new(chair.loc)
		new_robot.key = C.key
		new_robot << "<span class='notice'><b>You are now a cyborg, sent directly from Central Command to [station_name()] to assist the crew.</b></span>"
		spawncount--
		successSpawn = 1