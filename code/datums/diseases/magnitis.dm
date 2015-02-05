/datum/disease/magnitis
	name = "Magnitis"
	max_stages = 4
	spread_text = "Airborne"
	cure_text = "Iron"
	cures = list("iron")
	cure_chance = 5
	agent = "ICP-JJ virus"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CAN_CARRY|CAN_RESIST
	permeability_mod = 0.75
	desc = "No one is quite sure how this virus works."
	severity = "Minor"

/datum/disease/magnitis/stage_act()
	..()
	switch(stage)
		if(2)
			if(prob(2))
				affected_mob << "<span class='danger'>You feel a slight shock course through your body.</span>"
			if(prob(5))
				for(var/obj/M in orange(2,affected_mob))
					if(!M.anchored && (M.flags & CONDUCT))
						step_towards(M,affected_mob)
				for(var/mob/living/silicon/S in orange(2,affected_mob))
					if(istype(S, /mob/living/silicon/ai)) continue
					step_towards(S,affected_mob)
						/*
						if(M.x > affected_mob.x)
							M.x--
						else if(M.x < affected_mob.x)
							M.x++
						if(M.y > affected_mob.y)
							M.y--
						else if(M.y < affected_mob.y)
							M.y++
						*/
		if(3)
			if(prob(1))
				affected_mob << "<span class='danger'>You feel a strong shock course through your body.</span>"
				affected_mob.Stun(5)
				playsound(affected_mob.loc, "sparks", 75, 1, -1)
			if(prob(10))
				for(var/obj/M in orange(4,affected_mob))
					if(!M.anchored && (M.flags & CONDUCT))
						var/i
						var/iter = rand(1,2)
						for(i=0,i<iter,i++)
							step_towards(M,affected_mob)
				for(var/mob/living/silicon/S in orange(4,affected_mob))
					if(istype(S, /mob/living/silicon/ai)) continue
					var/i
					var/iter = rand(1,2)
					for(i=0,i<iter,i++)
						step_towards(S,affected_mob)
						/*
						if(M.x > affected_mob.x)
							M.x-=rand(1,min(3,M.x-affected_mob.x))
						else if(M.x < affected_mob.x)
							M.x+=rand(1,min(3,affected_mob.x-M.x))
						if(M.y > affected_mob.y)
							M.y-=rand(1,min(3,M.y-affected_mob.y))
						else if(M.y < affected_mob.y)
							M.y+=rand(1,min(3,affected_mob.y-M.y))
						*/
		if(4)
			if(prob(2))
				affected_mob << "<span class='danger'>You feel a powerful shock course through your body.</span>"
				affected_mob.Stun(10)
				playsound(affected_mob.loc, "sparks", 75, 1, -1)
			if(prob(3))
				affected_mob << "<span class='danger'>You query upon the nature of miracles.</span>"
			if(prob(20))
				for(var/obj/M in orange(6,affected_mob))
					if(!M.anchored && (M.flags & CONDUCT))
						var/i
						var/iter = rand(1,3)
						for(i=0,i<iter,i++)
							step_towards(M,affected_mob)
				for(var/mob/living/silicon/S in orange(6,affected_mob))
					if(istype(S, /mob/living/silicon/ai)) continue
					var/i
					var/iter = rand(1,3)
					for(i=0,i<iter,i++)
						step_towards(S,affected_mob)
						/*
						if(M.x > affected_mob.x)
							M.x-=rand(1,min(5,M.x-affected_mob.x))
						else if(M.x < affected_mob.x)
							M.x+=rand(1,min(5,affected_mob.x-M.x))
						if(M.y > affected_mob.y)
							M.y-=rand(1,min(5,M.y-affected_mob.y))
						else if(M.y < affected_mob.y)
							M.y+=rand(1,min(5,affected_mob.y-M.y))
						*/
	return
