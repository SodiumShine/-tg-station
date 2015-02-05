// A mob which only moves when it isn't being watched by living beings.

/mob/living/simple_animal/hostile/statue
	name = "statue" // matches the name of the statue with the flesh-to-stone spell
	desc = "An incredibly lifelike marble carving. Its eyes seems to follow you.." // same as an ordinary statue with the added "eye following you" description
	icon = 'icons/obj/statue.dmi'
	icon_state = "human_male"
	icon_living = "human_male"
	icon_dead = "human_male"
	gender = NEUTER
	a_intent = "harm"

	response_help = "touches"
	response_disarm = "pushes"

	speed = -2
	maxHealth = 5000
	health = 5000

	harm_intent_damage = 70
	melee_damage_lower = 68
	melee_damage_upper = 83
	attacktext = "claws"
	attack_sound = 'sound/hallucinations/growl1.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	faction = list("statue")
	move_to_delay = 0 // Very fast

	animate_movement = NO_STEPS // Do not animate movement, you jump around as you're a scary statue.

	see_in_dark = 13
	vision_range = 12
	aggro_vision_range = 12
	idle_vision_range = 12

	search_objects = 1 // So that it can see through walls

	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS
	anchored = 1
	status_flags = GODMODE // Cannot push also

	var/cannot_be_seen = 0
	var/mob/living/creator = null

	var/light_hate = 1 // chance to magically turn off lights in the area

// No movement while seen code.

/mob/living/simple_animal/hostile/statue/New(loc, var/mob/living/creator)
	..()
	// Give spells
	mob_spell_list += new /obj/effect/proc_holder/spell/aoe_turf/flicker_lights(src)
	mob_spell_list += new /obj/effect/proc_holder/spell/aoe_turf/blindness(src)
	mob_spell_list += new /obj/effect/proc_holder/spell/targeted/night_vision(src)

	// Give nightvision
	see_invisible = SEE_INVISIBLE_OBSERVER_NOLIGHTING

	// Set creator
	if(creator)
		src.creator = creator

/mob/living/simple_animal/hostile/statue/Move(var/turf/NewLoc)
	if(can_be_seen(NewLoc))
		if(client)
			src << "<span class='warning'>You cannot move, there are eyes on you!</span>"
		return 0
	if(!client)
		BreakLights()
	return ..()

/mob/living/simple_animal/hostile/statue/Life()
	..()
	if(!client && target) // If we have a target and we're AI controlled
		var/mob/watching = can_be_seen()
		// If they're not our target
		if(watching && watching != target)
			// This one is closer.
			if(get_dist(watching, src) > get_dist(target, src))
				LoseTarget()
				GiveTarget(watching)

	if(prob(light_hate) && !client)
		FlickerLights()

/mob/living/simple_animal/hostile/statue/proc/FlickerLights() // flickers lights and turns off sources from a distance

	var/obj/item/device/flashlight/FL
	var/obj/item/device/pda/P
	var/obj/machinery/light/L
	var/obj/item/clothing/head/hardhat/H
	var/obj/item/clothing/head/helmet/space/hardsuit/S

	for(L in view(12,src)) 					// lights
//		message_admins("[L] found to flicker")
		L.flicker(20)

	for(FL in view(12,src)) 				// flash lights
		if(FL.on == 1)
			FL.on = 0
			FL.update_brightness()
	for(P in view(12,src)) 					// pda
		if(P.fon == 1)
			P.fon = 0
			P.AddLuminosity(-P.f_lum)
	for(H in view(12,src)) 					// hardhats
		if(H.on == 1)
			H.on = 0
			H.AddLuminosity(-H.brightness_on)
			H.icon_state = "hardhat[H.on]_[H.item_color]"
			H.item_state = "hardhat[H.on]_[H.item_color]"
	for(S in view(12,src))					//space suit helmets
		if(S.on == 1)
			S.on = 0
			S.icon_state = "hardsuit[S.on]-[S.item_color]"
			S.item_state = "hardsuit[S.on]_[S.item_color]"
			S.AddLuminosity(-S.brightness_on)

///stuff on mobs///
	for(var/mob/M in view(12,src))
		for(FL in M.contents) // flash lights on mobs
			if(FL.on == 1)
				FL.on = 0
				FL.update_brightness(M)
		for(P in M.contents) // pda lights on mobs
			if(P.fon == 1)
				P.fon = 0
				M.AddLuminosity(-P.f_lum)
		for(H in M.contents)
			if(H.on == 1)
				H.on = 0
				M.AddLuminosity(-H.brightness_on)
				H.icon_state = "hardhat[H.on]_[H.item_color]"
				H.item_state = "hardhat[H.on]_[H.item_color]"
				M.update_inv_head()
		for(S in M.contents)
			if(S.on == 1)
				S.on = 0
				S.icon_state = "hardsuit[S.on]-[S.item_color]"
				S.item_state = "hardsuit[S.on]_[S.item_color]"
				M.AddLuminosity(-S.brightness_on)
				M.update_inv_head()
	return

/mob/living/simple_animal/hostile/statue/proc/BreakLights() // breaks lights and turns off stuff while moving past

	var/obj/item/device/flashlight/FL
	var/obj/item/device/pda/P
	var/obj/machinery/light/L
	var/obj/item/clothing/head/hardhat/H
	var/obj/item/clothing/head/helmet/space/hardsuit/S

	var/obj/machinery/bot/B
	var/obj/machinery/door/D

	for(L in view(2,src)) 							// lights
		L.broken()
	for(FL in view(2,src)) 							// flashlights
		if(FL.on ==1)
			FL.on = 0
			FL.update_brightness(FL)
	for(P in view(2,src)					)		// pda
		if(P.fon == 1)
			P.fon = 0
			P.AddLuminosity(-P.f_lum)
	for(H in view(2,src)) 							// hardhat
		if(H.on == 1)
			H.on = 0
			H.AddLuminosity(-H.brightness_on)
			H.icon_state = "hardhat[H.on]_[H.item_color]"
			H.item_state = "hardhat[H.on]_[H.item_color]"
	for(S in view(2,src)) 							// hardsuit helmet
		if(S.on == 1)
			S.on = 0
			S.AddLuminosity(-S.brightness_on)
			S.icon_state = "hardsuit[S.on]-[S.item_color]"
			S.item_state = "hardsuit[S.on]_[S.item_color]"

	for(B in view(1,src))
		B.explode()
	for(D in range(1,src)) 							// doors
		D.open()
	return

/mob/living/simple_animal/hostile/statue/AttackingTarget()
	if(can_be_seen())
		if(client)
			src << "<span class='warning'>You cannot attack, there are eyes on you!</span>"
			return
	else
		..()

/mob/living/simple_animal/hostile/statue/DestroySurroundings()
	if(!can_be_seen())
		..()

/mob/living/simple_animal/hostile/statue/face_atom()
	if(!can_be_seen())
		..()

/mob/living/simple_animal/hostile/statue/proc/can_be_seen(var/turf/destination)
	if(cannot_be_seen)
		return null
	// Check for darkness
	var/turf/T = get_turf(loc)
	if(T)// && destination)
/*
		// Don't check it twice if our destination is the tile we are on or we can't even get to our destination
		if(T == destination)
			destination = null
*/
		if(!T.lighting_lumcount)// && !destination.lighting_lumcount) // No one can see us in the darkness, right?
			return null

	// We aren't in darkness, loop for viewers.
	var/list/check_list = list(src)
	if(destination)
		check_list += destination

	// This loop will, at most, loop twice.
	for(var/atom/check in check_list)
		for(var/mob/living/M in viewers(world.view + 1, check) - src)
			if(M.client && CanAttack(M) && !issilicon(M))
				if(!M.eye_blind)
					return M
	return null

// Cannot talk

/mob/living/simple_animal/hostile/statue/say()
	return 0

// Turn to dust when gibbed

/mob/living/simple_animal/hostile/statue/gib(var/animation = 0)
	dust(animation)


// Stop attacking clientless mobs

/mob/living/simple_animal/hostile/statue/CanAttack(var/atom/the_target)
	if(isliving(the_target))
		var/mob/living/L = the_target
		if(!L.client && !L.ckey)
			return 0
	return ..()

// Don't attack your creator if there is one

/mob/living/simple_animal/hostile/statue/ListTargets()
	. = ..()
	return . - creator

// Statue powers

// Flicker lights
/obj/effect/proc_holder/spell/aoe_turf/flicker_lights
	name = "Flicker Lights"
	desc = "You will trigger a large amount of lights around you to flicker."

	charge_max = 300
	clothes_req = 0
	range = 14

/obj/effect/proc_holder/spell/aoe_turf/flicker_lights/cast(list/targets)
	for(var/turf/T in targets)
		for(var/obj/machinery/light/L in T)
			L.flicker()
	return

//Blind AOE
/obj/effect/proc_holder/spell/aoe_turf/blindness
	name = "Blindness"
	desc = "Your prey will be momentarily blind for you to advance on them."

	message = "<span class='notice'>You glare your eyes.</span>"
	charge_max = 600
	clothes_req = 0
	range = 10

/obj/effect/proc_holder/spell/aoe_turf/blindness/cast(list/targets)
	for(var/mob/living/L in living_mob_list)
		var/turf/T = get_turf(L.loc)
		if(T && T in targets)
			L.eye_blind = max(L.eye_blind, 4)
	return

//Toggle Night Vision
/obj/effect/proc_holder/spell/targeted/night_vision
	name = "Toggle Nightvision \[ON\]"
	desc = "Toggle your nightvision mode."

	charge_max = 10
	clothes_req = 0

	message = "<span class='notice'>You toggle your night vision!</span>"
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/night_vision/cast(list/targets)
	for(var/mob/living/target in targets)
		if(target.see_invisible == SEE_INVISIBLE_LIVING)
			target.see_invisible = SEE_INVISIBLE_OBSERVER_NOLIGHTING
			name = "Toggle Nightvision \[ON\]"
		else
			target.see_invisible = SEE_INVISIBLE_LIVING
			name = "Toggle Nightvision \[OFF\]"
	return