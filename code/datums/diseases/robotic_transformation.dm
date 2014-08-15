//Nanomachines!

/datum/disease/robotic_transformation
	name = "Robotic Transformation"
	max_stages = 5
	spread = "Syringe"
	spread_type = SPECIAL
	cure = "An injection of copper."
	cure_id = list("copper")
	cure_chance = 5
	agent = "R2D2 Nanomachines"
	affected_species = list("Human")
	desc = "This disease, actually acute nanomachine infection, converts the victim into a cyborg."
	severity = "Major"
	var/gibbed = 0

/datum/disease/robotic_transformation/stage_act()
	..()
	switch(stage)
		if(2)
			if (prob(1))
				affected_mob << "Your joints feel stiff."
			if (prob(1))
				affected_mob << "\red Beep...boop.."
			if (prob(1))
				affected_mob << "\red Bop...beeep..."
		if(3)
			if (prob(3))
				affected_mob << "\red Your joints feel very stiff."
			if (prob(5))
				affected_mob.say(pick("Beep, boop", "beep, beep!", "Boop...bop"))
			if (prob(3))
				affected_mob << "Your skin feels loose."
			if (prob(3))
				affected_mob << "\red You feel a stabbing pain in your head."
				affected_mob.Paralyse(2)
			if (prob(3))
				affected_mob << "\red You can feel something move...inside."
			if (prob(3))
				playsound(affected_mob.loc, "sparks", 75, 1, -1)
		if(4)
			if (prob(5))
				affected_mob << "\red Your skin feels very loose."
			if (prob(10))
				affected_mob.say(pick("beep, beep!", "Boop bop boop beep.", "How may I serve you?", "Error!"))
			if (prob(5))
				affected_mob << "\red You can feel... something...inside you."
			if (prob(5))
				playsound(affected_mob.loc, "sparks", 75, 1, -1)
		if(5)
			affected_mob <<"\red Your skin feels as if it's about to burst off!"
			if(prob(40)) //So everyone can feel like robot Seth Brundle
				if(src.gibbed != 0) return 0
				var/turf/T = affected_mob.loc
				gibs(T)
				gibbed = 1
				var/mob/living/carbon/human/H = affected_mob
				if(istype(H) && !jobban_isbanned(affected_mob, "Cyborg"))
					H.Robotize()
				else
					affected_mob.death(1)

