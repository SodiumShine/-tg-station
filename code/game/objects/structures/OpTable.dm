/obj/structure/optable
	name = "operating table"
	desc = "Used for advanced medical procedures."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "optable"
	density = 1
	anchored = 1
	var/mob/living/carbon/human/patient = null
	var/obj/machinery/computer/operating/computer = null


/obj/structure/optable/New()
	for(var/dir in cardinal)
		computer = locate(/obj/machinery/computer/operating, get_step(src, dir))
		if(computer)
			computer.table = src
			break


/obj/structure/optable/proc/check_patient()
	var/mob/M = locate(/mob/living/carbon/human, loc)
	if(M)
		if(M.resting)
			patient = M
			return 1
	else
		patient = null
		return 0


/obj/structure/optable/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/grab))
		var/obj/item/weapon/grab/G = W
		if(!G.confirm())
			return
		if(ismob(G.affecting))
			var/mob/M = G.affecting
			M.resting = 1
			M.loc = loc
			visible_message("<span class='notice'>[user] has laid [M] on [src].</span>")
			patient = M
			check_patient()
			qdel(W)
			return

/obj/structure/optable/attack_hand(mob/user)
	if(user.buckled)
		user << "<span class='notice'>You're buckled to a chair! You can't climb like that.</span>"
		return
	else if(user.a_intent == "grab")
		visible_message("<span class='danger'>[user] is trying to climb onto the operating table.</span>")
		if(do_after(user, 10))
			user.loc = src.loc
			user.resting = 1
			patient = user
			check_patient()
			visible_message("<span class='notice'>[user] climbed onto the operating table.</span>")
	else
		user << "You need to get a better hold of the table to climb it. (Use grab intent)"
		return
	..()
