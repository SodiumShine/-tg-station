/datum/disease/fluspanish
	name = "Spanish Inquisition Flu"
	max_stages = 4
	spread_text = "Airborne"
	cure_text = "Holy Water"
	cures = list("holywater")
	cure_chance = 10
	agent = "Unexpected flu virion"
	viable_mobtypes = list(/mob/living/carbon/human)
	permeability_mod = 0.75
	desc = "Often unexpected, the Spanish Inquisition Flu sets fire to the subject for being a heretic."
	severity = "Major"

/datum/disease/fluspanish/stage_act()
	..()
	switch(stage)
		if(2)
			affected_mob.bodytemperature += 10
			if(prob(5))
				affected_mob.emote("sneeze")
			if(prob(5))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "<span class='danger'>Your skin feels hot!</span>"
//				affected_mob.take_organ_damage(0,3)
		if(3)
			affected_mob.bodytemperature += 15
			if(prob(5))
				affected_mob.emote("sneeze")
			if(prob(5))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "<span class='danger'> Your skin feels like it's burning!</span>"
		if(4)
			if(prob(25))
				affected_mob.on_fire = 1
				affected_mob.AddLuminosity(3)
				affected_mob.update_fire()
				affected_mob.bodytemperature += 20
//				affected_mob.take_organ_damage(0,5)
	return