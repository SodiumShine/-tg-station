/datum/disease/cold9
	name = "The Cold"
	max_stages = 4
	spread = "On contact"
	spread_type = CONTACT_GENERAL
	cure = "Spaceacillin & Leporazine"
	cure_id = list("spaceacillin","leporazine") // SHINE if possible spaceacillin and leporazine
	cure_chance = 13
	agent = "ICE9-rhinovirus"
	affected_species = list("Human")
	desc = "If left untreated the subject will slow, as if partly frozen."
	severity = "Medium"

/datum/disease/cold9/stage_act()
	..()
	switch(stage)
		if(2)
			affected_mob.bodytemperature -= 10
//			if(prob(1) && prob(10))
//				affected_mob << "<span class='notice'>You feel better.</span>"
//				cure()
//				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "<span class='danger'>Your throat feels sore.</span>"
			if(prob(5))
				affected_mob << "<span class='danger'>You feel stiff.</span>"
		if(3)
			affected_mob.bodytemperature -= 15
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "\red Your throat feels sore."
			if(prob(7))
				affected_mob << "\red You feel stiff."
		if(4)
			affected_mob.bodytemperature -= 20
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "<span class='danger'>Your throat feels sore.</span>"
			if(prob(10))
				affected_mob << "<span class='danger'>You feel stiff.</span>"