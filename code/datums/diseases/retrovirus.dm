/datum/disease/dna_retrovirus
	name = "Retrovirus"
	max_stages = 4
	spread = "On Contact"
	spread_type = CONTACT_GENERAL
	cure = "Ryetalyn"
	cure_id = "ryetalyn"
	agent = "S4F1 retrovirus"
	affected_species = list("Human","Monkey")
	desc = "A DNA-altering retrovirus that scrambles the structural and unique enzymes of a host constantly."
	severity = "Moderate"
	permeability_mod = 0.4
	stage_prob = 2
	var/list/saved_dna = list()
//	var/SE
//	var/UI
	var/saved = 0
//	var/restcure = 0
/*	New() // SHINE note this how to do either or cures
		..()
		agent = "Virus class [pick("A","B","C","D","E","F")][pick("A","B","C","D","E","F")]-[rand(50,300)]"
		if(prob(40))
			cure_id = list("ryetalyn")
			cure_list = list("ryetalyn")
		else
			restcure = 1
*/
/datum/disease/dna_retrovirus/proc/savedna()
		saved_dna["UI"] = affected_mob.dna.uni_identity
		saved = 1


/datum/disease/dna_retrovirus/stage_act()
	..()
	switch(stage)
/*		if(1)
			if(restcure)
				if(affected_mob.sleeping && prob(30))  //removed until sleeping is fixed
					affected_mob << "\blue You feel better."
					cure()
					return

				if(affected_mob.lying && prob(30))  //changed FROM prob(20) until sleeping is fixed
					affected_mob << "\blue You feel better."
					cure()
					return
*/
		if(2)
/*			if(restcure)
				if(affected_mob.sleeping && prob(20))  //removed until sleeping is fixed
					affected_mob << "\blue You feel better."
					cure()
					return

				if(affected_mob.lying && prob(20))  //changed FROM prob(10) until sleeping is fixed
					affected_mob << "\blue You feel better."
					cure()
					return
*/
			if (prob(3))
				affected_mob << "\red Your skin feels loose."
			if (prob(5))
				affected_mob << "\red You feel very strange."
			if (prob(1))
				affected_mob << "\red You feel a stabbing pain in your head!"
				affected_mob.Paralyse(2)
			if (prob(3))
				affected_mob << "\red Your stomach churns."
		if(3)
			if (prob(5))
				affected_mob << "\red Your entire body vibrates."
/*
			if (prob(35))
				if(prob(50))	scramble_dna(affected_mob, 1, 0, rand(15,45))
				else			scramble_dna(affected_mob, 0, 1, rand(15,45))
*/
		if(4)
			if(saved == 0)
				savedna()
			if (prob(5))
				affected_mob <<"\red You feel very unstable."
				affected_mob.adjustCloneLoss(0.5)
				affected_mob.updatehealth()
			savedna()
			if (prob(25))
				scramble_dna(affected_mob, 1, 0, rand(50,75))

/datum/disease/dna_retrovirus/Del()
	if (saved_dna["UI"])
		if(affected_mob)
			affected_mob.dna.uni_identity = saved_dna["UI"]
			updateappearance(affected_mob)

			affected_mob << "\blue You feel more like yourself."
	..()