/datum/disease/pierrot_throat
	name = "Pierrot's Throat"
	max_stages = 4
	spread_text = "Airborne"
	cure_text = "Concentrated Banana and Spaceacillin"
	cures = list("banana","spaceacillin")
	cure_chance = 25
	agent = "HONK"
	viable_mobtypes = list(/mob/living/carbon/human)
	permeability_mod = 0.75
	desc = "HONK"
	severity = "HONK"
	longevity = 400

/datum/disease/pierrot_throat/stage_act()
	..()
	switch(stage)
		if(1)
			if(prob(3))
				affected_mob << "<span class='danger'> You feel a little silly.</span>"
		if(2)
			if(prob(1))
				affected_mob << "<span class='danger'> You start seeing rainbows.</span>"
				affected_mob.druggy = max(affected_mob.druggy, 5)
		if(3)
			if(prob(1))
				affected_mob << "<span class='danger'> Your vision is clouded by rainbows!</span>"
				affected_mob.druggy = max(affected_mob.druggy, 10)
			if(prob(3))
				affected_mob << "<span class='danger'> Your thoughts are interrupted by a loud <b>HONK!</b></span>"
		if(4)
			if(prob(5))
				affected_mob.say( pick( list("HONK!", "Honk!", "Honk.", "Honk?", "Honk!!", "Honk?!", "Honk...") ) )
			if(prob(2))
				affected_mob << "<span class='danger'> Rainbows~</span>"
				affected_mob.druggy = max(affected_mob.druggy, 10)
			if(prob(5))
				affected_mob << "<span class='danger'> <b>HONK!</b></span>"


//M.druggy = max(M.druggy, 35)