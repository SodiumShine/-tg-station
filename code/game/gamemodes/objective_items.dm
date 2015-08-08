//Contains the target item datums for Steal objectives.

/datum/objective_item
	var/name = "A silly bike horn! Honk!"
	var/targetitem = /obj/item/weapon/bikehorn		//typepath of the objective item
	var/difficulty = 9001							//vaguely how hard it is to do this objective
	var/list/excludefromjob = list()				//If you don't want a job to get a certain objective (no captain stealing his own medal, etcetc)
	var/list/altitems = list()				//Items which can serve as an alternative to the objective (darn you blueprints)
	var/list/special_equipment = list()

/datum/proc/check_special_completion() //for objectives with special checks (is that slime extract unused? does that intellicard have an ai in it? etcetc)
	return 1

/datum/objective_item/steal/caplaser
	name = "the captain's antique laser gun"
	targetitem = /obj/item/weapon/gun/energy/laser/captain
	difficulty = 5
	excludefromjob = list("Captain")

/* SHINE ministation reasons
datum/objective_item/steal/hoslaser
/datum/objective_item/steal/hoslaser
	name = "the head of security's personal laser gun"
	targetitem = /obj/item/weapon/gun/energy/gun/hos
	difficulty = 10
	excludefromjob = list("Head Of Security")
*/
/*
/datum/objective_item/steal/handtele
	name = "a hand teleporter"
	targetitem = /obj/item/weapon/hand_tele
	difficulty = 5
	excludefromjob = list("Captain")
*/


/*
datum/objective_item/steal/magboots // SHINE changed from advanced to normal boots
	name = "a pair of magboots"
	targetitem =  /obj/item/clothing/shoes/magboots
*/


/*
/datum/objective_item/steal/capmedal
	name = "the medal of captaincy"
	targetitem = /obj/item/clothing/tie/medal/gold/captain
	difficulty = 5
	excludefromjob = list("Captain")
*/
/*
/datum/objective_item/steal/hypo
	name = "the hypospray. Intel suggests it's stored in the Medbay"
	targetitem = /obj/item/weapon/reagent_containers/hypospray/CMO
	difficulty = 5
	excludefromjob = list("Chief Medical Officer", "Medical Doctor", "Chemist") //SHINE added medical doctor and chemist
*/
/*
/datum/objective_item/steal/nukedisc
	name = "the nuclear authentication disk"
	targetitem = /obj/item/weapon/disk/nuclear
	difficulty = 5
	excludefromjob = list("Captain")
*/
/* SHINE removed, too hard to hide
/datum/objective_item/steal/ablative
	name = "an ablative armor vest"
	targetitem = /obj/item/clothing/suit/armor/laserproof
	difficulty = 3
	excludefromjob = list("Head of Security", "Warden")

/datum/objective_item/steal/reactive
	name = "the reactive teleport armor"
	targetitem = /obj/item/clothing/suit/armor/reactive
	difficulty = 5
	excludefromjob = list("Research Director")
*/
/*
/datum/objective_item/steal/documents
	name = "a set of secret documents"
	targetitem = /obj/item/documents //Any set of secret documents. Doesn't have to be NT's
	difficulty = 5
*/
/datum/objective_item/steal/nuke_core
	name = "the heavily radioactive plutonium core from the onboard self-destruct. Take care to wear the proper safety equipment when extracting the core"
	targetitem = /obj/item/nuke_core
	difficulty = 15

/datum/objective_item/steal/nuke_core/New()
	special_equipment += new /obj/item/weapon/storage/box/syndie_kit/nuke()

//Items with special checks!
/* // SHINE fuck plasma seriously
datum/objective_item/steal/plasma
	name = "28 moles of plasma (full tank)"
	targetitem = /obj/item/weapon/tank
	difficulty = 3
	excludefromjob = list("Chief Engineer","Research Director","Station Engineer","Scientist","Atmospheric Technician")

/datum/objective_item/plasma/check_special_completion(obj/item/weapon/tank/T)
	var/target_amount = text2num(name)
	var/found_amount = 0
	found_amount += T.air_contents.toxins
	return found_amount>=target_amount
*/
/*
/datum/objective_item/steal/functionalai
	name = "an AI card"
	targetitem = /obj/item/device/aicard
	difficulty = 5 //beyond the impossible // SHINE changed to 5 since no actual ai
 //SHINE we dont have AI on ministation so dead ones will do
/datum/objective_item/functionalai/check_special_completion(obj/item/device/aicard/C)
	for(var/mob/living/silicon/ai/A in C)
		if(istype(A, /mob/living/silicon/ai) && A.stat != 2) //See if any AI's are alive inside that card.
			return 1
	return 0
*/
/datum/objective_item/steal/blueprints
	name = "the station blueprints"
	targetitem = /obj/item/areaeditor/blueprints
	difficulty = 5
	excludefromjob = list("Chief Engineer")
	altitems = list(/obj/item/weapon/photo)

/datum/objective_item/blueprints/check_special_completion(obj/item/I)
	if(istype(I, /obj/item/areaeditor/blueprints))
		return 1
	if(istype(I, /obj/item/weapon/photo))
		var/obj/item/weapon/photo/P = I
		if(P.blueprints)	//if the blueprints are in frame
			return 1
	return 0
/*
/datum/objective_item/steal/slime
	name = "an unused sample of slime extract"
	targetitem = /obj/item/slime_extract
	difficulty = 3
	excludefromjob = list("Research Director","Scientist")

/datum/objective_item/slime/check_special_completion(obj/item/slime_extract/E)
	if(E.Uses > 0)
		return 1
	return 0
*/
/////////////////////////////////////////////////
//////////SHINE ADDED THIS SECTION////////////////////////
//////////////////////////////////////////////////////
/*
datum/objective_item/steal/monitorkey
	name = "the key for the station's message monitors"
	targetitem = /obj/item/weapon/paper/monitorkey
	difficulty = 5
*/
/*
datum/objective_item/steal/recipe
	name = "Lord Frenrir Cageth's recipe book"
	targetitem = /obj/item/weapon/book/manual/chef_recipes
	difficulty = 3
*/
/*
datum/objective_item/steal/shotgun
	name = "the bartender's shotgun. Intel suggests it can be found in the Bar"
	targetitem = /obj/item/weapon/gun/projectile/revolver/doublebarrel
	difficulty = 3

datum/objective_item/steal/detectivegun
	name = "the detective's revolver. Intel suggests it can be found in the Detective Office"
	targetitem = /obj/item/weapon/gun/projectile/revolver/detective
	difficulty = 5

datum/objective_item/steal/loyaltybox
	name = "the box of loyalty implants"
	targetitem = /obj/item/weapon/storage/lockbox/loyalty
	difficulty = 5
*/

datum/objective_item/steal/powercrystal
	name = "the Cargo Bay's priceless aurichalcum shard."
	targetitem = /obj/item/weapon/uniquesteal/powercrystal
	difficulty = 3

datum/objective_item/steal/can
	name = "the Bar's can of priceless spacecarp caviar."
	targetitem = /obj/item/weapon/uniquesteal/can
	difficulty = 3

datum/objective_item/steal/owl
	name = "the Head of Personnel's collectable owl action figure."
	targetitem = /obj/item/toy/owl
	difficulty = 5

datum/objective_item/steal/baton
	name = "the Brig's antique police baton."
	targetitem = /obj/item/weapon/melee/classic_baton
	difficulty = 5

/datum/objective_item/steal/phone
	name = "the Telecomm's special red phone."
	targetitem = /obj/item/weapon/phone
	difficulty = 3

datum/objective_item/steal/sandwich
	name = "the Bar's Perfect Sandwich."
	targetitem = /obj/item/weapon/reagent_containers/food/snacks/sandwich/perfect
	difficulty = 3
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

//Unique Objectives
/datum/objective_item/unique/docs_red
	name = "the \"Red\" secret documents"
	targetitem = /obj/item/documents/syndicate/red
	difficulty = 10

/datum/objective_item/unique/docs_blue
	name = "the \"Blue\" secret documents"
	targetitem = /obj/item/documents/syndicate/blue
	difficulty = 10

//Old ninja objectives.
/datum/objective_item/special/pinpointer
	name = "the captain's pinpointer"
	targetitem = /obj/item/weapon/pinpointer
	difficulty = 10

/datum/objective_item/special/aegun
	name = "an advanced energy gun"
	targetitem = /obj/item/weapon/gun/energy/gun/nuclear
	difficulty = 10

/datum/objective_item/special/ddrill
	name = "a diamond drill"
	targetitem = /obj/item/weapon/pickaxe/drill/diamonddrill
	difficulty = 10

/datum/objective_item/special/boh
	name = "a bag of holding"
	targetitem = /obj/item/weapon/storage/backpack/holding
	difficulty = 10

/datum/objective_item/special/hypercell
	name = "a hyper-capacity cell"
	targetitem = /obj/item/weapon/stock_parts/cell/hyper
	difficulty = 5

/datum/objective_item/special/laserpointer
	name = "a laser pointer"
	targetitem = /obj/item/device/laser_pointer
	difficulty = 5

/datum/objective_item/special/corgimeat
	name = "a piece of corgi meat"
	targetitem = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/corgi
	difficulty = 5

//Stack objectives get their own subtype
/datum/objective_item/stack
	name = "5 cardboards"
	targetitem = /obj/item/stack/sheet/cardboard
	difficulty = 9001

/datum/objective_item/stack/check_special_completion(obj/item/stack/S)
	var/target_amount = text2num(name)
	var/found_amount = 0

	if(istype(S, targetitem))
		found_amount = S.amount
	return found_amount>=target_amount

/datum/objective_item/stack/diamond
	name = "10 diamonds"
	targetitem = /obj/item/stack/sheet/mineral/diamond
	difficulty = 10

/datum/objective_item/stack/gold
	name = "50 gold bars"
	targetitem = /obj/item/stack/sheet/mineral/gold
	difficulty = 15

/datum/objective_item/stack/uranium
	name = "25 refined uranium bars"
	targetitem = /obj/item/stack/sheet/mineral/uranium
	difficulty = 10
