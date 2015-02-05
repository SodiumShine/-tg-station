/datum/round_event_control/disease_outbreak_major
	name = "Disease Outbreak"
	typepath = /datum/round_event/disease_outbreak_major
	max_occurrences = 3 // SHINE 1 to 3
	weight = 5

/datum/round_event/disease_outbreak_major
	announceWhen	= 15

	var/virus_type
	var/successSpawn = 0

/datum/round_event/disease_outbreak_major/kill()
	if(!successSpawn && control)
		message_admins("Major outbreak failed")
		control.occurrences--
	return ..()

/datum/round_event/disease_outbreak_major/announce()
	if(successSpawn)
		priority_announce("Confirmed outbreak of level 7 viral biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", 'sound/AI/outbreak7.ogg')

/datum/round_event/disease_outbreak_major/setup()
	announceWhen = rand(15, 30)

/datum/round_event/disease_outbreak_major/start()
	if(!virus_type)
		virus_type = pick(/datum/disease/dnaspread, /datum/disease/brainrot,
							/datum/disease/fluspanish, /datum/disease/gbs, /datum/disease/rhumba_beat, /datum/disease/fake_gbs)

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
//			if(!H.dna || (H.sdisabilities & BLIND))	//A blindness disease would be the worst. // SHINE HAHA BLIND WOULD BE HILARIOUS
			if(!H.dna)
				continue
			D = new virus_type()
			var/datum/disease/dnaspread/DS = D
			DS.strain_data["name"] = H.real_name
			DS.strain_data["UI"] = H.dna.uni_identity
			DS.strain_data["SE"] = H.dna.struc_enzymes
			D.carrier = 1
		else
			D = new virus_type()
//		D.carrier = 1 // SHINE removed so original infectee can feel the damn thing too
		D.holder = H
		D.affected_mob = H
		H.viruses += D
		message_admins("Majour outbreak infected [H]")
		successSpawn = 1
		break