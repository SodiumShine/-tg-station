/datum/disease/rhumba_beat
	name = "The Rhumba Beat"
	max_stages = 5
	spread_text = "On contact"
	spread_flags = CONTACT_GENERAL
	cure_text = "A tall glass of Bahama Mama"
	cures = list("bahama_mama")
	agent = "Cuban Pete"
	cure_chance = 75
	viable_mobtypes = list(/mob/living/carbon/human)
	permeability_mod = 1
	severity = BIOHAZARD
	desc = "Chick Chicky Boom!"
//	severity = "Major"
	stage_prob = 3

/datum/disease/rhumba_beat/stage_act()
	..()
	switch(stage)
		if(2)
			if(prob(1))
				affected_mob << "\red You feel strange..."
			else if(prob(5))
				affected_mob.emote("dance")
		if(3)
			if(prob(5))
				affected_mob << "\red You feel the urge to dance..."
			else if(prob(5))
				affected_mob.emote("dance")
			else if(prob(10))
				affected_mob << "\red You feel the need to chick chicky boom..."
		if(4)
			stage_prob = 2
			if(prob(10))
				affected_mob.emote("dance")
				affected_mob << "\red You feel a burning beat inside..."
			else if(prob(10))
				affected_mob << "\red You feel the need to chick chicky boom..."
		if(5)
			if(prob(50))
				affected_mob << "\red Your body is unable to contain the Rhumba Beat!"
				affected_mob.emote("dance")
			else if(prob(10))
				affected_mob.gib()
				playsound(affected_mob.loc, 'sound/misc/ChickBoom.ogg', 20, 0)
		else
			return