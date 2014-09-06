/*
 HUMANS
*/

/datum/species/human
	name = "Human"
	id = "human"
	roundstart = 1
	specflags = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
	use_skintones = 1

/datum/species/human/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "mutationtoxin")
		H << "<span class='danger'>Your flesh rapidly mutates!</span>"
		H.dna.species = new /datum/species/slime()
		H.regenerate_icons()
		H.reagents.del_reagent(chem.type)
		return 1

/*
 LIZARDPEOPLE
*/

/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "Reptile"
	id = "lizard"
	say_mod = "hisses"
	default_color = "00FF00"
	roundstart = 1
	specflags = list(MUTCOLORS,EYECOLOR,LIPS)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/lizard

/datum/species/lizard/handle_speech(message)
	// jesus christ why
	if(copytext(message, 1, 2) != "*")
		message = replacetext(message, "s", "ss")

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
	attack_verb = "slice"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	burnmod = 1.25
	heatmod = 1.5
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/plant
	roundstart = 1 // SHINE

/datum/species/plant/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "plantbgone")
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.id, REAGENTS_METABOLISM)
		return 1

/datum/species/plant/on_hit(proj_type, mob/living/carbon/human/H)
	switch(proj_type)
		if(/obj/item/projectile/energy/floramut)
			if(prob(15))
				H.apply_effect((rand(30,80)),IRRADIATE)
				H.Weaken(5)
				for (var/mob/V in viewers(H))
					V.show_message("<span class='danger'>[H] writhes in pain as \his vacuoles boil.</span>", 3, "<span class='danger'>You hear the crunching of leaves.</span>", 2)
				if(prob(80))
					randmutb(H)
					domutcheck(H,null)
				else
					randmutg(H)
					domutcheck(H,null)
			else
				H.adjustFireLoss(rand(5,15))
				H.show_message("<span class='danger'>The radiation beam singes you!</span>")
		if(/obj/item/projectile/energy/florayield)
			H.nutrition = min(H.nutrition+30, 500)
	return

/*
 PODPEOPLE
*/

/datum/species/plant/pod
	// A mutation caused by a human being ressurected in a revival pod. These regain health in light, and begin to wither in darkness.
	name = "Podperson"
	id = "pod"
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
		if(H.nutrition > 500)
			H.nutrition = 500
		if(light_amount > 2) //if there's enough light, heal
			H.heal_overall_damage(1,1)
			H.adjustToxLoss(-1)
			H.adjustOxyLoss(-1)

	if(H.nutrition < 200)
		H.take_overall_damage(2,0)

/*
 SHADOWPEOPLE
*/

/datum/species/shadow
	// Humans cursed to stay in the darkness, lest their life forces drain. They regain health in shadow and die in light.
	name = "Shadowling" // SHINE changed ??? to Shadow
	id = "shadow"
	darksight = 8
	sexes = 0
	ignored_by = list(/mob/living/simple_animal/hostile/faithless)
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/shadow
	roundstart = 1 // SHINE
	armor = -10 //shine

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

		if(light_amount > 3) //if there's enough light, start dying
			L = light_amount / 2
			if(PR == 1)
				L = 0
			H.take_overall_damage(0,L)
//			world << "Take [L] damage"
		else if(light_amount < 3 && light_amount > 2)
//			world << "No light stuff"
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
	name = "Slime"
	id = "slime"
	default_color = "00FFFF"
	darksight = 3
	invis_sight = SEE_INVISIBLE_LEVEL_ONE
	specflags = list(MUTCOLORS,EYECOLOR,HAIR,FACEHAIR)
	hair_color = "mutcolor"
	hair_alpha = 150
	ignored_by = list(/mob/living/carbon/slime)
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/slime

	roundstart = 1 // SHINE ADD
	coldmod = 2
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
	specflags = list(MUTCOLORS,EYECOLOR)
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/slime

/*
 GOLEMS
*/

/datum/species/golem
	// Animated beings of stone. They have increased defenses, and do not need to breathe. They're also slow as fuuuck.
	name = "Golem"
	id = "golem"
	specflags = list(HEATRES,COLDRES,NOGUNS,NOBLOOD,RADIMMUNE) // SHINE removed NOBREATH
	speedmod = 3
	armor = 35 // SHINE nerfed 55 to 35
	punchmod = 5
	no_equip = list(slot_wear_suit, slot_gloves, slot_shoes, slot_head, slot_w_uniform) // slot_wear_mask SHINE letting them have masks on
	nojumpsuit = 0 // SHINE not letting them have magic skin pockets anymore
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/golem
	roundstart = 1 // SHINE
	magicIDslot = 1 // SHINE everyone must have ID

/*
 ADAMANTINE GOLEMS
*/

/datum/species/golem/adamantine
	name = "Adamantine Golem"
	id = "adamantine"
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/golem/adamantine
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
	name = "Human?" // SHINE changed Human? to Flyperson
	id = "fly"
	say_mod = "buzzes"
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/fly
	roundstart = 0 // SHINE

/datum/species/fly/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "pestkiller")
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.id, REAGENTS_METABOLISM)
		return 1

/datum/species/fly/handle_speech(message)
	if(copytext(message, 1, 2) != "*")
		message = replacetext(message, "z", stutter("zz"))

	return message

/*
 SKELETONS
*/

/datum/species/skeleton
	// 2spooky
	name = "Spooky Scary Skeleton"
	id = "skeleton"
	sexes = 0
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/human/mutant/skeleton
