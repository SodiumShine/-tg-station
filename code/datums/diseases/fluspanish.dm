/datum/disease/fluspanish
	name = "Spanish Flu"
	max_stages = 4
	spread_text = "Airborne"
	cure_text = "Inacusiate"
	cures = list("inacusiate")
	cure_chance = 15
	agent = "Unexpected flu virion"
	viable_mobtypes = list(/mob/living/carbon/human)
	permeability_mod = 0.75
	desc = "Spanish Flu sets fire to the subject for being a heretic."
	severity = DANGEROUS
	stage_prob = 3

/datum/disease/fluspanish/stage_act()
	..()
	switch(stage)
		if(2)
			affected_mob.bodytemperature += 5
			if(prob(5))
				affected_mob.emote("sneeze")
			if(prob(5))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "<span class='danger'>Your skin feels hot!</span>"
//				affected_mob.take_organ_damage(0,3)
		if(3)
			affected_mob.bodytemperature += 10
			if(prob(5))
				affected_mob.emote("sneeze")
			if(prob(5))
				affected_mob.emote("cough")
			if(prob(1))
				affected_mob << "<span class='danger'> Your skin feels like it's burning!</span>"
		if(4)
			if(prob(10))
				affected_mob.adjust_fire_stacks(5)
				affected_mob.IgniteMob()
				affected_mob.bodytemperature += 15
//				affected_mob.take_organ_damage(0,5)
	return
