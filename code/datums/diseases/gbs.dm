/datum/disease/gbs
	name = "GBS"
	max_stages = 5
	spread = "Blood"
	spread_type = BLOOD
	cure = "Synaptizine & Sulfur"
	cure_id = list("synaptizine","sulfur")
	cure_chance = 15//higher chance to cure, since two reagents are required
	agent = "Gravitokinetic Bipotential SADS+"
	affected_species = list("Human","Monkey")
	curable = 0
	permeability_mod = 1
	stage_prob = 3
	desc = "If left untreated the subject will explode violently."
	severity = "Major"

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
				affected_mob << "\red You're starting to feel very weak..."
		if(4)
			if(prob(10))
				affected_mob.emote("cough")
		if(5)
			affected_mob << "\red Your body feels as if it's trying to rip itself open!"
			if(prob(50))
				affected_mob.gib()
		else
			return