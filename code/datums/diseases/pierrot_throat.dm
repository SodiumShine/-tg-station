/datum/disease/pierrot_throat
	name = "Pierrot's Throat"
	max_stages = 4
	spread = "Airborne"
	cure = "Banana products"
	cure_id = "banana"
	cure_chance = 10
	agent = "HONK"
	affected_species = list("Human")
	permeability_mod = 0.75
	desc = "HONK"
	severity = "HONK"
	longevity = 400

/datum/disease/pierrot_throat/stage_act()
	..()
	switch(stage)
		if(1)
			if(prob(3))
				affected_mob << "\red You feel a little silly."
		if(2)
			if(prob(1))
				affected_mob << "\red You start seeing rainbows."
				affected_mob.druggy = max(affected_mob.druggy, 5)
		if(3)
			if(prob(1))
				affected_mob << "\red Your vision is clouded by rainbows!"
				affected_mob.druggy = max(affected_mob.druggy, 10)
			if(prob(3))
				affected_mob << "\red Your thoughts are interrupted by a loud <b>HONK!</b>"
		if(4)
			if(prob(5))
				affected_mob.say( pick( list("HONK!", "Honk!", "Honk.", "Honk?", "Honk!!", "Honk?!", "Honk...") ) )
			if(prob(2))
				affected_mob << "\red Rainbows~"
				affected_mob.druggy = max(affected_mob.druggy, 10)
			if(prob(5))
				affected_mob << "\red <b>HONK!</b>"


//M.druggy = max(M.druggy, 35)