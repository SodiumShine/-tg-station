/datum/round_event_control/disease_outbreak_minor
	name = "Minor Disease Outbreak"
	typepath = /datum/round_event/disease_outbreak_minor
	max_occurrences = 10
	weight = 15
	earliest_start = 600

/datum/round_event/disease_outbreak_minor

	var/virus_type
	var/successSpawn = 0

///datum/round_event/disease_outbreak_minor/announce()
//	priority_announce("Confirmed outbreak of level 6 viral biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", 'sound/AI/outbreak7.ogg')

/datum/round_event/disease_outbreak_minor/kill()
	if(!successSpawn && control)
		message_admins("Minor outbreak failed")
		control.occurrences--
	return ..()

/datum/round_event/disease_outbreak_minor/start()
	if(!virus_type)
		virus_type = pick(/datum/disease/flu, /datum/disease/cold, /datum/disease/advance/rash, /datum/disease/advance/migraine, /datum/disease/advance/dorf, /datum/disease/pierrot_throat,
							/datum/disease/magnitis, /datum/disease/cold9, /datum/disease/dna_retrovirus, /datum/disease/wizarditis, /datum/disease/anxiety,/datum/disease/beesease)

	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		var/turf/T = get_turf(H)
		if(!T)
			continue
		if(T.z != 1)
			continue
		var/foundAlready = 0	// don't infect someone that already has the virus
		for(var/datum/disease/D in H.viruses)
			foundAlready = 1
			break
		if(H.stat == DEAD || foundAlready)
			continue

		var/datum/disease/D
		if(virus_type == /datum/disease/dnaspread)		//Dnaspread needs strain_data set to work.
			if(!H.dna || (H.disabilities & BLIND))	//A blindness disease would be the worst.
				continue
			D = new virus_type()
			var/datum/disease/dnaspread/DS = D
			DS.strain_data["name"] = H.real_name
			DS.strain_data["UI"] = H.dna.uni_identity
			DS.strain_data["SE"] = H.dna.struc_enzymes
		else
			D = new virus_type()
		D.carrier = 0
		D.holder = H
		D.affected_mob = H
		H.viruses += D
		message_admins("Minor outbreak infected [H]")
		successSpawn = 1
		break