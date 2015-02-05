/datum/disease/gbs
	name = "GBS"
	max_stages = 5
	spread_text = "Blood"
	spread_flags = BLOOD
	cure_text = "Synaptizine & Sulfur"
	cures = list("synaptizine","sulfur")
	cure_chance = 15//higher chance to cure, since two reagents are required
	agent = "Gravitokinetic Bipotential SADS+"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CAN_CARRY|CAN_RESIST
	permeability_mod = 1
	stage_prob = 2
	desc = "If left untreated the subject will explode violently."
//	severity = "Major"
	severity = "BIOHAZARD THREAT!"

/datum/disease/gbs/stage_act()
	..()
	switch(stage)
		if(2)
			if(prob(1))
				affected_mob.emote("sneeze")
		if(3)
			if(prob(5))
				affected_mob.emote("cough")
			else if(prob(5))
				affected_mob.emote("gasp")
			if(prob(10))
				affected_mob << "<span class='danger'>You're starting to feel very weak...</span>"
		if(4)
			if(prob(10))
				affected_mob.emote("cough")
		if(5)
			if(prob(50))
				affected_mob << "<span class='danger'>Your body feels as if it's trying to rip itself open...</span>"
			else if(prob(50))
				affected_mob.gib()
		else
			return