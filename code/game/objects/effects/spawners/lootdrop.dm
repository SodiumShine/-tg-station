/obj/effect/spawner/lootdrop
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x2"
	color = "#00FF00"
	var/lootcount = 1		//how many items will be spawned
	var/lootdoubles = 1		//if the same item can be spawned twice
	var/list/loot			//a list of possible items to spawn e.g. list(/obj/item, /obj/structure, /obj/effect)

/obj/effect/spawner/lootdrop/New()
	if(loot && loot.len)
		for(var/i = lootcount, i > 0, i--)
			if(!loot.len) break
			var/lootspawn = pickweight(loot)
			if(!lootdoubles)
				loot.Remove(lootspawn)

			if(lootspawn)
				new lootspawn(get_turf(src))
	qdel(src)

/obj/effect/spawner/lootdrop/armory_contraband
	name = "armory contraband gun spawner"
	lootdoubles = 0

	loot = list(
				/obj/item/weapon/gun/projectile/automatic/pistol = 8,
				/obj/item/weapon/gun/projectile/shotgun/combat = 5,
				/obj/item/weapon/gun/projectile/revolver/mateba,
				/obj/item/weapon/gun/projectile/automatic/deagle
				)

/obj/effect/spawner/lootdrop/maintenance
	name = "maintenance loot spawner"

	//How to balance this table
	//-------------------------
	//The total added weight of all the entries should be (roughly) equal to the total number of lootdrops
	//(take in account those that spawn more than one object!)
	//
	//While this is random, probabilities tells us that item distribution will have a tendency to look like
	//the content of the weighted table that created them.
	//The less lootdrops, the less even the distribution.
	//
	//If you want to give items a weight <1 you can multiply all the weights by 10
	//
	//the "" entry will spawn nothing, if you increase this value,
	//ensure that you balance it with more spawn points

	//table data:
	//-----------
	//aft maintenance: 		23 items, 17 spots 2 extra (08/08/2014)
	//asmaint: 				16 items, 11 spots 0 extra (08/08/2014)
	//asmaint2:			 	36 items, 25 spots 2 extra (08/08/2014)
	//fpmaint:				5  items,  4 spots 0 extra (08/08/2014)
	//fpmaint2:				11 items, 10 spots 2 extra (08/08/2014)
	//fsmaint:				0  items,  0 spots 0 extra (08/08/2014)
	//fsmaint2:				40 items, 30 spots 5 extra (11/08/2014)
	//maintcentral:			2  items,  2 spots 0 extra (08/08/2014)
	//port:					5  items,  5 spots 0 extra (08/08/2014)
	loot = list(
				/obj/item/bodybag = 1,
				/obj/item/clothing/glasses/meson = 2,
				/obj/item/clothing/glasses/sunglasses = 1,
				/obj/item/clothing/gloves/fyellow = 1,
				/obj/item/clothing/gloves/yellow = 1,
				/obj/item/clothing/gloves/black = 1,
				/obj/item/clothing/head/hardhat = 1,
				/obj/item/clothing/head/hardhat/red = 1,
				/obj/item/clothing/head/welding = 1,
				/obj/item/clothing/ears/earmuffs = 1,
				/obj/item/clothing/mask/gas = 7,
				/obj/item/clothing/mask/breath = 5,
				/obj/item/clothing/mask/balaclava = 1,
				/obj/item/clothing/suit/hazardvest = 1,
				/obj/item/device/analyzer = 4,
				/obj/item/device/assembly/prox_sensor = 3,
				/obj/item/device/assembly/timer = 3,
				/obj/item/device/assembly/signaler = 3,
				/obj/item/device/assembly/igniter = 3,
				/obj/item/device/camera = 2,
				/obj/item/device/flashlight = 4,
				/obj/item/device/flashlight/pen = 1,
				/obj/item/device/laser_pointer =1,
				/obj/item/device/multitool = 2,
				/obj/item/device/radio/off = 2,
				/obj/item/device/t_scanner = 6,
				/obj/item/device/taperecorder = 2,
				/obj/item/stack/cable_coil = 4,
				/obj/item/stack/cable_coil{amount = 5} = 6,
				/obj/item/stack/medical/bruise_pack = 1,
				/obj/item/stack/rods{amount = 10} = 9,
				/obj/item/stack/sheet/cardboard{amount = 10} = 2,
				/obj/item/stack/sheet/metal{amount = 20} = 1,
				/obj/item/stack/sheet/mineral/plasma{layer = 2.9} = 1,
				/obj/item/stack/sheet/glass{amount = 20} = 1,
				/obj/item/stack/sheet/rglass{amount = 2} = 1,
				/obj/item/stack/sheet/mineral/wood{amount = 10} = 1,
				/obj/item/toy/gun = 1,
				/obj/item/weapon/beach_ball = 1,
				/obj/item/weapon/book/manual/wiki/engineering_hacking = 1,
				/obj/item/weapon/caution/cone = 1,
				/obj/item/weapon/coin/silver = 1,
				/obj/item/weapon/coin/iron = 1,
				/obj/item/weapon/coin/gold = 1,
				/obj/item/weapon/coin/twoheaded = 1,
				/obj/item/weapon/contraband/poster = 1,
				/obj/item/weapon/crowbar = 1,
				/obj/item/weapon/crowbar/red = 1,
				/obj/item/weapon/extinguisher = 10,
				/obj/item/weapon/gun/projectile/revolver/russian = 1,
				/obj/item/weapon/hand_labeler = 1,
				/obj/item/weapon/legcuffs/beartrap = 1,
				/obj/item/weapon/mop = 1,
				/obj/item/weapon/paper/crumpled = 1,
				/obj/item/weapon/pen = 1,
				/obj/item/weapon/reagent_containers/glass/beaker = 1,
				/obj/item/weapon/reagent_containers/spray/pestspray = 1,
				/obj/item/weapon/reagent_containers/spray/cleaner = 1,
				/obj/item/weapon/stock_parts/cell = 3,
				/obj/item/weapon/stock_parts/cell/crap = 1,
				/obj/item/weapon/storage/belt/utility = 2,
				/obj/item/weapon/storage/box = 2,
				/obj/item/weapon/storage/box/cups = 1,
				/obj/item/weapon/storage/box/donkpockets = 1,
				/obj/item/weapon/storage/box/lights/mixed = 3,
				/obj/item/weapon/storage/fancy/cigarettes/dromedaryco = 1,
				/obj/item/weapon/storage/toolbox/mechanical = 1,
				/obj/item/weapon/screwdriver = 3,
				/obj/item/weapon/tank/emergency_oxygen = 3,
				/obj/item/weapon/umbrella = 1,
				/obj/item/weapon/vending_refill/cola = 1,
				/obj/item/weapon/vending_refill/snack = 1,
				/obj/item/weapon/weldingtool = 3,
				/obj/item/weapon/wirecutters = 2,
				/obj/item/weapon/wrench = 4,
				"" = 11
				)
