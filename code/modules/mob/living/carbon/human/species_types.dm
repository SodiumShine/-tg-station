/*
 HUMANS
*/

/datum/species/human
	name = "Human"
	id = "human"
	roundstart = 1
	specflags = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
	use_skintones = 1
	desc = {"The bulk of Nanotrasen, superiour to all other races. At least they are in their own eyes.
	</br> Only Humans are allowed to hold Command positions, and are the only ones protected by most silicon laws."}
/datum/species/human/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "mutationtoxin")
		H << "<span class='danger'>Your flesh rapidly mutates!</span>"
		hardset_dna(H, null, null, null, null, /datum/species/slime)
		H.regenerate_icons()
		H.reagents.del_reagent(chem.type)
		H.faction |= "slime"
		return 1

/*
 LIZARDPEOPLE
*/

/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "Reptilian"
	id = "lizard"
	say_mod = "hisses"
	default_color = "00FF00"
	roundstart = 1
	specflags = list(MUTCOLORS,EYECOLOR,LIPS)
	mutant_bodyparts = list("tail", "snout")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/lizard
	desc = {"A race of lizard like beings who were enslaved to Nanotrasen for generations.
	They only recently gained a semblance of basic rights, but are still considered to be second class citizens.
	Naturally they resent this a little bit. </br>Very common on stations due to being cheap labour."}

/datum/species/lizard/handle_speech(message)
	// jesus christ why
	if(copytext(message, 1, 2) != "*")
		message = replacetext(message, "s", "sss")

	return message

/*
 PLANTPEOPLE
*/

/datum/species/plant
	// Creatures made of leaves and plant matter.
	name = "Folia"
	id = "plant"
	default_color = "59CE00"
	specflags = list(MUTCOLORS,EYECOLOR)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	burnmod = 1.25
	heatmod = 1.5
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/plant
	roundstart = 1 // SHINE
	death_cry = "goes stiff with a quiet creaking, leaves withering and falling to the ground..."
	diet = 1
	desc = {"The Foliat are a race of plant-like beings, currently allied with Nanotrasen.
	Often mistaken for actual plants, Foliat are more a cross between fauna and flora, including not only meat and bones, but bark skin and leafy/flowery heads.
	Weed killer and fire can cause serious damage and/or illness.
	</br> Not often seen on Station's due to their complete lack vegetation and natural soil."}

/datum/species/plant/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "plantbgone")
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.id, REAGENTS_METABOLISM)
		return 1

/datum/species/plant/on_hit(proj_type, mob/living/carbon/human/H)
	switch(proj_type)
		if(/obj/item/projectile/energy/floramut)
			if(prob(15))
				H.irradiate(rand(30,80))
				H.Weaken(5)
				H.visible_message("<span class='warning'>[H] writhes in pain as \his vacuoles boil.</span>", "<span class='userdanger'>You writhe in pain as your vacuoles boil!</span>", "<span class='italics'>You hear the crunching of leaves.</span>")
				if(prob(80))
					randmutb(H)
					domutcheck(H,null)
				else
					randmutg(H)
					domutcheck(H,null)
			else
				H.adjustFireLoss(rand(5,15))
				H.show_message("<span class='userdanger'>The radiation beam singes you!</span>")
		if(/obj/item/projectile/energy/florayield)
			H.nutrition = min(H.nutrition+30, NUTRITION_LEVEL_FULL)
	return

/*
 PODPEOPLE
*/

/datum/species/plant/pod
	// A mutation caused by a human being ressurected in a revival pod. These regain health in light, and begin to wither in darkness.
	name = "Podperson"
	id = "pod"
	specflags = list(MUTCOLORS,EYECOLOR)
	roundstart = 0 // SHINE

/datum/species/plant/pod/spec_life(mob/living/carbon/human/H)
	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		var/area/A = T.loc
		if(A)
			if(A.lighting_use_dynamic)	light_amount = min(10,T.lighting_lumcount) - 5
			else						light_amount =  5
		H.nutrition += light_amount
		if(H.nutrition > NUTRITION_LEVEL_FULL)
			H.nutrition = NUTRITION_LEVEL_FULL
		if(light_amount > 2) //if there's enough light, heal
			H.heal_overall_damage(1,1)
			H.adjustToxLoss(-1)
			H.adjustOxyLoss(-1)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.take_overall_damage(2,0)

/*
 SHADOWPEOPLE
*/

/datum/species/shadow
	name = "Edge"
	id = "shadow"
	darksight = 8
	sexes = 0
	ignored_by = list(/mob/living/simple_animal/hostile/faithless)
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/shadow
	specflags = list(NOBLOOD,HAIR,FACEHAIR,COLDRES)
	roundstart = 1 // SHINE
	armor = -10 //shine
	death_cry = "writhes and twists before seizing up, collapsing into a loose, dark organic mess..."
	hair_color = "000000"
	hair_alpha = 150
	desc = "The Edge are an interesting race from a distant star system that have recently been cleared to work on Nanotrasen Stations.\
			Though they may appear to be single entities, they are actually thousands if not millions of tiny insect-like organisms congregated\
			and organized into a single working unit. \
			Due to evolving on a planet orbiting around the gravity well of a black hole, the get most of their energy from geo-thermal heat and\
			internal processes, their exteriors consisting of units resistant to sub-zero temperatures.  Thus, the stations environments are enough\
			to support a healthy internal environment, however, they still need to absorb oxygen and take in nutrients in order to survive and\
			exposure to excess electromagnetic radiation (i.e. light) will severely damage the tiny creatures that make up their bodies.\
			Due to being from the edge of the known systems, they are officially called \"The Edge\" but are more commonly\
			known as \"Edgelings\" by humans, though many of the Nanotrasen higher-ups have taken to calling them \"Edgelords\" for reasons\
			currently undisclosed.\
			<BR><b>Important note:</b> All shadowpeople are supplied with special clothes that will protect them from light. These can be found in your backpack."

/datum/species/shadow/after_equip_job(var/datum/job/J, var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/bio_suit/plaguedoctorsuit/shadow(H), slot_in_backpack)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/plaguedoctorhat/shadow(H), slot_in_backpack)



/datum/species/shadow/spec_life(mob/living/carbon/human/H)
	var/light_amount
	var/L
	var/C
	var/PR
	if(isturf(H.loc))
		var/turf/T = H.loc
		var/area/A = T.loc
		if(A)
			if(A.lighting_use_dynamic)
				light_amount = T.lighting_lumcount
			else
				light_amount =  10

		if(istype(H.r_hand, /obj/item/weapon/umbrella) || istype(H.l_hand, /obj/item/weapon/umbrella))
//			world << "Yup it's covered"
			PR = 1
		if(!istype(H.r_hand, /obj/item/weapon/umbrella) && !istype(H.l_hand, /obj/item/weapon/umbrella))
//			world << "Nope, not covered"
			PR = 0

		if(!(H.stat == DEAD)) // Dont bother doing any burn stuff if they're dead!
			if(!istype(H.wear_suit, /obj/item/clothing/suit/bio_suit/plaguedoctorsuit) || !istype(H.head, /obj/item/clothing/head/plaguedoctorhat)) //Also dont if suited

				if(light_amount > 3) //if there's enough light, start dying
					L = light_amount / 2
					if(PR == 1)
						L = 0
					H.take_overall_damage(0,L)
					if(prob(25))
						H << "<span class='userdanger'>The light burns us!</span>"
					playsound(H.loc, 'sound/weapons/sear.ogg', 25, 1, -2)

				else if(light_amount < 3 && light_amount > 2) // Not too dark, not too bright

				else if (light_amount < 2) //heal in the dark
					L = light_amount
					C = 2 - L
					H.heal_overall_damage(0,C)
		//			world << "Heal [C]"

/*
 SLIMEPEOPLE
*/

/datum/species/slime
	// Humans mutated by slime mutagen, produced from green slimes. They are not targetted by slimes.
	name = "Slimeperson"
	id = "slime"
	default_color = "00FFFF"
	darksight = 3
	invis_sight = SEE_INVISIBLE_LEVEL_ONE
	specflags = list(MUTCOLORS,EYECOLOR,HAIR,FACEHAIR,NOBLOOD)
	hair_color = "mutcolor"
	hair_alpha = 150
	ignored_by = list(/mob/living/simple_animal/slime)
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/slime
	exotic_blood = /datum/reagent/toxin/slimejelly
	death_cry = "rapidly loses control of shape and form, oozing into a motionlesss, humanoid blob..."
	var/recently_changed = 1
	desc = {"Not actually a race, but the result of mutated Human staff. Xenobiology accidents are common,
	and can sometimes lead to scientists turning into translucent gelatin like substance.
	</br> The transformation leaves their body and blood toxic for other species, thankfully only dangerous by ingestion.
	However, this also means anti-toxins are dangerous for Slimepeople. Ordinary Slimes like the one's found in Xenobiology labs, tend to get along better with Slimepeople than other races.
	</br> Fairly common on stations, not only due to the rate of Xenobiology accidents, but due to the rate at which Slimepeople procreate. Scientists are still not sure why this is."}
	roundstart = 1
	coldmod = 2

/datum/species/slime/spec_life(mob/living/carbon/human/H)
	if(!H.reagents.get_reagent_amount("slimejelly"))
		if(recently_changed)
			H.reagents.add_reagent("slimejelly", 80)
			recently_changed = 0
		else
			H.reagents.add_reagent("slimejelly", 5)
			H.adjustBruteLoss(5)
			H << "<span class='danger'>You feel empty!</span>"

	for(var/datum/reagent/toxin/slimejelly/S in H.reagents.reagent_list)
		if(S.volume < 100)
			if(H.nutrition >= NUTRITION_LEVEL_STARVING)
				H.reagents.add_reagent("slimejelly", 0.5)
				H.nutrition -= 5
		if(S.volume < 50)
			if(prob(5))
				H << "<span class='danger'>You feel drained!</span>"
		if(S.volume < 10)
			H.losebreath++

/datum/species/slime/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "slimejelly")
		return 1
/*
 JELLYPEOPLE
*/

/datum/species/jelly
	// Entirely alien beings that seem to be made entirely out of gel. They have three eyes and a skeleton visible within them.
	name = "Xenobiological Jelly Entity"
	id = "jelly"
	default_color = "00FF90"
	say_mod = "chirps"
	eyes = "jelleyes"
	specflags = list(MUTCOLORS,EYECOLOR,NOBLOOD)
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/slime
	exotic_blood = /datum/reagent/toxin/slimejelly
	var/recently_changed = 1

/datum/species/jelly/spec_life(mob/living/carbon/human/H)
	if(!H.reagents.get_reagent_amount("slimejelly"))
		if(recently_changed)
			H.reagents.add_reagent("slimejelly", 80)
			recently_changed = 0
		else
			H.reagents.add_reagent("slimejelly", 5)
			H.adjustBruteLoss(5)
			H << "<span class='danger'>You feel empty!</span>"

	for(var/datum/reagent/toxin/slimejelly/S in H.reagents.reagent_list)
		if(S.volume < 100)
			if(H.nutrition >= NUTRITION_LEVEL_STARVING)
				H.reagents.add_reagent("slimejelly", 0.5)
				H.nutrition -= 5
			else if(prob(5))
				H << "<span class='danger'>You feel drained!</span>"
		if(S.volume < 10)
			H.losebreath++

/datum/species/jelly/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "slimejelly")
		return 1
/*
 GOLEMS
*/

/datum/species/golem
	// Animated beings of stone. They have increased defenses, and do not need to breathe. They're also slow as fuuuck.
	name = "Golem"
	id = "golem"
	specflags = list(NOBREATH,HEATRES,COLDRES,NOGUNS,NOBLOOD,RADIMMUNE,VIRUSIMMUNE,HARDFEET)
	speedmod = 3
	armor = 35 // SHINE nerfed 55 to 35
	punchmod = 5
	no_equip = list(slot_wear_mask, slot_wear_suit, slot_gloves, slot_shoes, slot_head, slot_w_uniform) // slot_wear_mask SHINE letting them have masks on
	nojumpsuit = 1 // SHINE not letting them have magic skin pockets anymore
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/golem
	roundstart = 0 // SHINE
//	magicIDslot = 1 // SHINE everyone must have ID

/*
 ADAMANTINE GOLEMS
*/

/datum/species/golem/adamantine
	name = "Adamantine Golem"
	id = "adamantine"
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/golem/adamantine
	roundstart = 0
	specflags = list(NOBREATH,HEATRES,COLDRES,NOGUNS,NOBLOOD,RADIMMUNE)
	armor = 55
	nojumpsuit = 1
	no_equip = list(slot_wear_mask, slot_wear_suit, slot_gloves, slot_shoes, slot_head, slot_w_uniform)
/*
 FLIES
*/

/datum/species/fly
	// Humans turned into fly-like abominations in teleporter accidents.
	name = "Flyperson" // SHINE changed Human? to Flyperson
	id = "fly"
	say_mod = "buzzes"
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/fly
	roundstart = 1 // SHINE
	desc = {"The result of horrible accidents involving teleporters. Very disliked amongst crew, Flypeople are considered disgusting and abominations.
	</br>Very rare on stations, as teleporter accidents are not overly common, and Flypeople tend not to have very good lifespans or survival rates."}
/datum/species/fly/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "pestkiller")
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.id, REAGENTS_METABOLISM)
		return 1

/datum/species/fly/handle_speech(message)
	return replacetext(message, "z", stutter("zz"))

/*
 SKELETONS
*/

/datum/species/skeleton
	// 2spooky
	name = "Spooky Scary Skeleton"
	id = "skeleton"
	say_mod = "rattles"
	sexes = 0
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/skeleton
	specflags = list(NOBREATH,HEATRES,COLDRES,NOBLOOD,RADIMMUNE,VIRUSIMMUNE,HARDFEET)
/*
 ZOMBIES
*/

/datum/species/zombie
	// 1spooky
	name = "Recycled Human"
	id = "zombie"
	say_mod = "moans"
	sexes = 0
	speedmod = 2
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	specflags = list(NOBREATH,NOBLOOD,RADIMMUNE,NOGUNS,HAIR,FACEHAIR,EYECOLOR)
	burnmod = 1.25
	roundstart = 1
	armor = -10
	death_cry = "might be dead. It's really hard to tell..."
	desc = {"The first Recycled Human was the result of an accident during cloning experiemtns, and ever since Nanotrasen has been experimenting with cheaper more maintainable staff.
	</br> Recycled Humans are created when a body cannot be cloned properly, resulting in a still-dead-yet-alive again crew member. They are often called Zombies by other crew,
	although Nanotrasen Officials insist on refering to them by a more marketable name.
	</br> They tend to <b>move slowly</b> due to stiff movements, but strangely enough are not as brainless as one might expect, fully capable of jobs they performed while alive.
	While they have a overwhelming hunger for the contents of skulls, they do not actually need these to survive and are capable of processing other foods.
	</br> Not overly common on stations, but their numbers increase by the day."}

/datum/species/zombie/handle_speech(message)
	var/list/message_list = text2list(message, " ")
	var/maxchanges = max(round(message_list.len / 1.5), 2)

	for(var/i = rand(maxchanges / 2, maxchanges), i > 0, i--)
		var/insertpos = rand(1, message_list.len - 1)
		var/inserttext = message_list[insertpos]

		if(!(copytext(inserttext, length(inserttext) - 2) == "..."))
			message_list[insertpos] = inserttext + "..."

		if(prob(20) && message_list.len > 3)
			message_list.Insert(insertpos, "[pick("BRAINS", "Brains", "Braaaiinnnsss", "BRAAAIIINNSSS", "guhhhh")]...")

	return list2text(message_list, " ")



/datum/species/cosmetic_zombie
	name = "Human"
	id = "czombie"
	sexes = 0
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/zombie

/*
ABDUCTORS
*/

/datum/species/abductor
	name = "Abductor"
	id = "abductor"
	darksight = 3
	say_mod = "gibbers"
	sexes = 0
	invis_sight = SEE_INVISIBLE_LEVEL_ONE
	specflags = list(NOBLOOD,NOBREATH,VIRUSIMMUNE,HARDFEET)
	var/scientist = 0 // vars to not pollute spieces list with castes
	var/agent = 0
	var/team = 1

/datum/species/abductor/handle_speech(message)
	//Hacks
	var/mob/living/carbon/human/user = usr
	for(var/mob/living/carbon/human/H in mob_list)
		if(H.dna.species.id != "abductor")
			continue
		else
			var/datum/species/abductor/target_spec = H.dna.species
			if(target_spec.team == team)
				H << "<i><font color=#800080><b>[user.name]:</b> [message]</font></i>"
				//return - technically you can add more aliens to a team
	for(var/mob/M in dead_mob_list)
		M << "<i><font color=#800080><b>[user.name]:</b> [message]</font></i>"
	return ""

/*
PLASMAMEN
*/

var/global/image/plasmaman_on_fire = image("icon"='icons/mob/OnFire.dmi', "icon_state"="plasmaman")

/datum/species/plasmaman
	name = "Plasbone"
	id = "plasmaman"
	say_mod = "rattles"
	sexes = 0
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/skeleton
	specflags = list(NOBLOOD,RADIMMUNE)
	safe_oxygen_min = 0 //We don't breath this
	safe_toxins_min = 16 //We breath THIS!
	safe_toxins_max = 0
	var/skin = 0

/datum/species/plasmaman/skin
	name = "Skinbone"
	skin = 1

/datum/species/plasmaman/update_base_icon_state(var/mob/living/carbon/human/H)
	var/base = ..()
	if(base == id)
		base = "[base][skin]"
	return base

/datum/species/plasmaman/spec_life(var/mob/living/carbon/human/H)
	var/datum/gas_mixture/environment = H.loc.return_air()

	if(!istype(H.wear_suit, /obj/item/clothing/suit/space/eva/plasmaman) || !istype(H.head, /obj/item/clothing/head/helmet/space/hardsuit/plasmaman))
		if(environment)
			if((environment.oxygen /environment.total_moles()) >= 0.01)
				if(!H.on_fire)
					H.visible_message("<span class='danger'>[H]'s body reacts with the atmosphere and bursts into flames!</span>","<span class='userdanger'>Your body reacts with the atmosphere and bursts into flame!</span>")
				H.adjust_fire_stacks(0.5)
				H.IgniteMob()
	else
		if(H.fire_stacks)
			var/obj/item/clothing/suit/space/eva/plasmaman/P = H.wear_suit
			if(istype(P))
				P.Extinguish(H)
	H.update_fire()

//Heal from plasma
/datum/species/plasmaman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "plasma")
		H.adjustBruteLoss(-5)
		H.adjustFireLoss(-5)
		H.reagents.remove_reagent(chem.id, REAGENTS_METABOLISM)
		return 1






///////////////////////////////////////////////////////////////////////////////
///SHINE SPECIES///
///////////////////////////////////////////////////////////////////////////////

/*
GAMOIDS
*/

/datum/species/gamoid
	name = "Gamoid"
	id = "gamoid"
	say_mod = "states"
	sexes = 1
	specflags = list(COLDRES,NOBLOOD,NOBREATH,EYECOLOR,HAIR,FACEHAIR,LIPS,RADIMMUNE,VIRUSIMMUNE,ABIOTIC,HARDFEET)
	exotic_blood = /datum/reagent/oil
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/synthmeat
	roundstart = 1
	armor = 10
	default_color = "FFFFFF"
	death_cry = "shuts down with a critical error, eyes flickering closed..."
	desc = {"Gamoids are one of Nanotrasen's latest ways of cutting the costs of staff. Most gamoids are originally commercial or recreational service robots, refitted to work on Stations.
	</br> As one might expect, Gamoids are completely inorganic, and therefore do not require things such as air or food, are immunte to radiation and disease, and are fully resistent to the cold harshness of space.
	</br> Howerver, Gamoids are somewhat easily damaged internally if liquids or other matter are to enter their delicate internal systems. Their external chassis is not as fragile though.
	</br> Like most robots they require charging via powercells in order to continue operating, and may need to be occasionally repaired using a welding tool.
	 However they are not capable of maintaining themselves and will need another crewmember to do so."}


/datum/species/gamoid/after_equip_job(var/datum/job/J, var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/weapon/stock_parts/cell/crap(H), slot_in_backpack)
	return

// Can't eat or drink
/datum/species/gamoid/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
//	if(chem.id == "")
	H.adjustFireLoss(1)
	H.reagents.remove_reagent(chem.id, REAGENTS_METABOLISM)
	if(prob(33))
		H << "<span class='danger'>WARNING: Foreign contaminant detected internally. Systems damaged.</span>"
	return 1


///Repairs and recharging///
/mob/living/carbon/human/attackby(obj/item/weapon/W as obj, mob/user as mob, params)
	if(src.dna.species.id == "gamoid")

		if (istype(W, /obj/item/weapon/screwdriver) && user.a_intent == "help")
			if(src == user)
				user << "<span class='warning'>You lack the reach to open yourself.</span>"
				return 1
			if(src.dna.species.open_panel == 0)
				src.dna.species.open_panel = 1
				visible_message("<span class='notice'>[user] unscrews and opens the maintainance panel on [src].</span>")
				playsound(loc, 'sound/items/Screwdriver.ogg', 20, 1, -1)
				return 0
			else
				src.dna.species.open_panel = 0
				visible_message("<span class='notice'>[user] closes and secures the maintainance panel on [src].</span>")
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1, -1)
				return 0
		if (istype(W, /obj/item/weapon/weldingtool) && user.a_intent == "help")
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/weapon/weldingtool/WT = W
			if (src == user)
				user << "<span class='warning'>You lack the reach to repair yourself.</span>"
				return 1
			if (src.health >= src.maxHealth)
				user << "<span class='warning'>[src] does not need repairs.</span>"
				return 1
			if (WT.remove_fuel(0, user))
				adjustBruteLoss(-20)
				updatehealth()
				add_fingerprint(user)
				visible_message("<span class='notice'>[user] has made some repairs to [src].</span>")
				playsound(loc, 'sound/items/Welder.ogg', 25, 1, -1)
				return 0
			else
				user << "<span class='warning'>The welder must be on for this task.</span>"
				return 1

		else if(istype(W, /obj/item/stack/cable_coil) && user.a_intent == "help")
			var/obj/item/stack/cable_coil/coil = W
			if (src == user)
				user << "<span class='warning'>You lack the reach to repair yourself.</span>"
				return 1
			if(!src.dna.species.open_panel)
				user << "<span class='warning'>You will need to open [src]'s maintainence panel first.</span>"
				return 1
			if (src.health < src.maxHealth)
				if (coil.use(1))
					adjustFireLoss(-15)
					adjustToxLoss(-15)
					updatehealth()
					user.visible_message("[user] has replaced some of the wires in [src].", "<span class='notice'>You replace some of the wires in [src].</span>")
					playsound(loc, 'sound/effects/sparks4.ogg', 25, 1, -1)
					return 0
				else
					user << "<span class='warning'>You need more cable to repair [src]!</span>"
					return 1
			else
				user << "<span class='warning'>The wires seem fine, there's no need to fix them.</span>"
				return 1

		else if (istype(W, /obj/item/weapon/stock_parts/cell) && user.a_intent == "help")
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/weapon/stock_parts/cell/C = W
			if (src == user)
				user << "<span class='warning'>You cannot reach your own powercell interface port.</span>"
				return 1

			if (src.nutrition >= NUTRITION_LEVEL_FULL || src.nutrition >= (NUTRITION_LEVEL_FULL - 10))
				user << "<span class='warning'>Gamoid unit already at maximum charge capacity.</span>"
				return 1
			if (C.charge > 0)
				user << "<span class='notice'>You insert the powercell into [src.name].</span>"
				var/powergap = 0
				powergap = (NUTRITION_LEVEL_FULL - src.nutrition)
//				world << "DEBUG [powergap]"

				src.nutrition += C.charge
				C.charge -= powergap
				if (C.charge < 0)
					C.charge = 0
				if (src.nutrition >= NUTRITION_LEVEL_FULL)
					src.nutrition = NUTRITION_LEVEL_FULL
				src << "<span class='notice'>GAMOID SYSTEM: Internal power storage has finished charging.</span>"
				return 0
			if (C.charge < 3)
				user << "<span class='warning'>The powercell is empty!</span>"
				return 1

		else if (istype(W, /obj/item/borg/upgrade/restart))
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/borg/upgrade/restart/R = W
			if (src == user)
				user << "<span class='warning'>You cannot reach your own maintainence interface.</span>"
				return 1
			if(!src.dna.species.open_panel)
				user << "<span class='warning'>You will need to open [src]'s maintainence panel first.</span>"
				return 1
			if (src.stat < 2)
				user << "<span class='warning'>This gamoid unit isn't in need of a restart module.</span>"
				return 1
			if (src.stat == 2)
				if (src.health < 50)
					user << "<span class='warning'>The chassis is too damaged! Make some repairs first.</span>"
					return 1
				else
					user <<"<span class='notice'>You insert the module and the gamoid begins a factory restart.</span>"
					del R
					src.stat = 0
					src.SetWeakened(100)
					src << "<span class='danger'>GAMOID SYSTEM: Factory reset initialized...</span>"
					sleep(50)
					src << "<span class='danger'>GAMOID SYSTEM: Memory corrupted... retrieving from backup...</span>"
					sleep(50)
					src << "<span class='danger'>GAMOID SYSTEM: Configuring to default settings...</span>"
					sleep(50)
					src << "<span class='danger'>GAMOID SYSTEM: Factory reset complete.</span>"
					src.SetWeakened(0)
					return 0
			else return


/*
		if (istype(w, /obj/item/weapon/card/id) && user.a_intent == "help")
			user.changeNext_move(CLICK_CD_MELEE)
			var/obj/item/weapon/card/id/ID = W
			if (src == user)
				user << "<span class='warning'>Your programming disallows this action.</span>"
				return 1
			if(src.nutrition < NUTRITION_LEVEL_STARVING)
				user << "<span class='warning'>[src.name] is currently in Emergency Sleep Mode and cannot be powered on.</span>"
				return 1
			if (29 in ID.access)
				if (!src.sleeping)
				src.sleeping =

*/
		return ..()
	return ..()

/mob/living/carbon/human/say(var/message)
	if(ABIOTIC in src.dna.species.specflags)
		return ..(message, "R")
	..()


/datum/species/gamoid/spec_life(mob/living/carbon/human/H)
//	if(H.viruses.len > 0) 									// SHINE robots dont get sick // SHINE have virusimmune now
//		for(var/datum/disease/D in H.viruses)
//			D.cure()
//			world << "DEBUG: viruses removed from gamoid, cured [D.name]"

//	var/powerwarned
//	if((H.nutrition+50) > NUTRITION_LEVEL_STARVING)
//		powerwarned = 0
//	if((H.nutrition+50) < NUTRITION_LEVEL_STARVING && powerwarned == 0) // SHINE robots run out of power and shutdown
//		H << "<span class='warning'>WARNING: Power levels low. System will enter Sleep Mode if power is not recharged soon.</span>"
//		powerwarned = 1
	if(H.nutrition < NUTRITION_LEVEL_STARVING)
		if(!H.sleeping)
			H << "<span class='warning'>GAMOID SYSTEM: Low power. Entering Emergency Sleep Mode...</span>"
		H.sleeping = 10


/*
SKRELL
*/

/datum/species/skrell
	id = "skrell"
	name = "Skrell"
	roundstart = 1
	mutant_bodyparts = list("head")
	default_color = "#8CD7A3"
	eyes = "skrelleyes"
	sexes = 1
	say_mod = "warbles"
	diet = 2
	specflags = list(LIPS,MUTCOLORS,EYECOLOR)
	desc = "An amphibious species, Skrell come from the star system known as Qerr'Vallis, which translates to 'Star of \
	the royals' or 'Light of the Crown'.<br/><br/>Skrell are a highly advanced and logical race who live under the rule \
	of the Qerr'Katish, a caste within their society which keeps the empire of the Skrell running smoothly. Skrell are \
	herbivores on the whole and tend to be co-operative with the other species of the galaxy, although they rarely reveal \
	the secrets of their empire to their allies."

/datum/species/skrell/spec_life(mob/living/carbon/human/H)
	handle_mutant_bodyparts(H)

/datum/species/skrell/handle_mutant_bodyparts(mob/living/carbon/human/H)
	..()
	var/list/bodyparts_to_add = mutant_bodyparts.Copy()
	var/list/relevent_layers = list(HAIR_LAYER)
	var/list/standing	= list()

	H.remove_overlay(HAIR_LAYER)

	if(!mutant_bodyparts)
		return

	if("head" in mutant_bodyparts) // for skrell
		if(H.head && (H.head.flags & BLOCKHAIR))
			bodyparts_to_add -= "head"

	if(!bodyparts_to_add)
		return

	var/icon_state_string = "[id]_"
	var/g = (H.gender == FEMALE) ? "f" : "m"
	var/image/I

	if(sexes)
		icon_state_string += "[g]_s"
	else
		icon_state_string += "_s"

	for(var/layer in relevent_layers)
		for(var/bodypart in bodyparts_to_add)
			I = image("icon" = 'icons/mob/mutant_bodyparts.dmi', "icon_state" = "[icon_state_string]_[bodypart]_[layer]", "layer" =- layer)
			if(!(H.disabilities & HUSK))
				I.color = "#[H.dna.mutant_color]"
			standing += I
		H.overlays_standing[layer] = standing.Copy()
		standing = list()

	H.apply_overlay(HAIR_LAYER)

/datum/species/skrell/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "mushroomhallucinogen")
		H.reagents.remove_reagent(chem.id, REAGENTS_METABOLISM)
		return 1


/*
Tajara
*/

/datum/species/tajaran
	id = "tajaran"
	name = "Tajaran"
	darksight = 8
	roundstart = 1
	default_color = "#AFA59E"
	hair_color = "mutcolor"
	no_equip = list(slot_shoes)
	mutant_bodyparts = list("tail","ears")
	attack_verb = "scratch"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	burnmod = 1.25
	coldmod = 0.50
	armor = -10
	specflags = list(HAIR,MUTCOLORS,EYECOLOR,FACEHAIR,LIPS)

	desc = "The Tajaran race is a species of feline-like bipeds hailing from the planet of Ahdomai in the \
	S'randarr system. They have been brought up into the space age by the Humans and Skrell, and have been \
	influenced heavily by their long history of Slavemaster rule. They have a structured, clan-influenced way \
	of family and politics. They prefer colder environments, and speak a variety of languages, mostly Siik'Maas, \
	using unique inflections their mouths form."

/datum/species/tajaran/spec_life(mob/living/carbon/human/H)
	handle_mutant_bodyparts(H)