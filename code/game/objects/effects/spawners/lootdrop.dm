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
				/obj/item/weapon/gun/projectile/automatic/pistol,
				/obj/item/weapon/gun/projectile/shotgun/combat,
				/obj/item/weapon/gun/projectile/revolver/mateba,
				/obj/item/weapon/gun/projectile/automatic/deagle,
				/obj/item/weapon/flamethrower/full/tank
				)

/obj/effect/spawner/lootdrop/armory_contraband/other
	name = "armory contraband spawner"
	lootdoubles = 0

	loot = list(
				/obj/item/weapon/reagent_containers/food/drinks/bottle/zorkrye,
				/obj/item/weapon/contraband/poster,
				/obj/item/weapon/storage/fancy/cigarettes/dromedaryco,
				/obj/item/weapon/lipstick/random
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
	//aft maintenance: 		24 items, 18 spots 2 extra (28/08/2014)
	//asmaint: 				16 items, 11 spots 0 extra (08/08/2014)
	//asmaint2:			 	36 items, 26 spots 2 extra (28/08/2014)
	//fpmaint:				5  items,  4 spots 0 extra (08/08/2014)
	//fpmaint2:				12 items, 11 spots 2 extra (28/08/2014)
	//fsmaint:				0  items,  0 spots 0 extra (08/08/2014)
	//fsmaint2:				40 items, 27 spots 5 extra (28/08/2014)
	//maintcentral:			2  items,  2 spots 0 extra (08/08/2014)
	//port:					5  items,  5 spots 0 extra (08/08/2014)
	loot = list(
				/obj/item/bodybag = 10,
				/obj/item/clothing/glasses/meson = 20,
				/obj/item/clothing/glasses/sunglasses = 10,
				/obj/item/clothing/gloves/fyellow = 10,
				/obj/item/clothing/gloves/yellow = 10,
				/obj/item/clothing/gloves/black = 10,
				/obj/item/clothing/head/hardhat = 10,
				/obj/item/clothing/head/hardhat/red = 10,
				/obj/item/clothing/head/welding = 10,
				/obj/item/clothing/ears/earmuffs = 10,
				/obj/item/clothing/mask/gas = 70,
				/obj/item/clothing/mask/breath = 50,
				/obj/item/clothing/mask/balaclava = 7,
				/obj/item/clothing/suit/hazardvest = 10,
				/obj/item/device/analyzer = 40,
				/obj/item/device/assembly/prox_sensor = 30,
				/obj/item/device/assembly/timer = 30,
				/obj/item/device/assembly/signaler = 30,
				/obj/item/device/assembly/igniter = 30,
				/obj/item/device/camera = 20,
				/obj/item/device/flashlight = 40,
//				/obj/item/device/flashlight/pen = 5,
				/obj/item/device/laser_pointer =10,
				/obj/item/device/multitool = 15,
				/obj/item/device/radio/off = 20,
				/obj/item/device/t_scanner = 60,
				/obj/item/device/taperecorder = 10,
				/obj/item/stack/cable_coil = 40,
				/obj/item/stack/cable_coil{amount = 5} = 60,
				/obj/item/stack/medical/bruise_pack = 10,
				/obj/item/stack/rods{amount = 10} = 90,
				/obj/item/stack/sheet/cardboard{amount = 10} = 20,
				/obj/item/stack/sheet/metal{amount = 20} = 10,
				/obj/item/stack/sheet/mineral/plasma{layer = 2.9} = 10,
				/obj/item/stack/sheet/glass{amount = 20} = 10,
				/obj/item/stack/sheet/rglass{amount = 2} = 10,
				/obj/item/stack/sheet/mineral/wood{amount = 10} = 10,
				/obj/item/toy/gun = 7,
				/obj/item/weapon/beach_ball = 7,
				/obj/item/weapon/book/manual/wiki/engineering_hacking = 7,
				/obj/item/weapon/caution/cone = 10,
				/obj/item/weapon/coin/silver = 10,
				/obj/item/weapon/coin/iron = 10,
				/obj/item/weapon/coin/gold = 10,
				/obj/item/weapon/coin/twoheaded = 10,
				/obj/item/weapon/contraband/poster = 7,
				/obj/item/weapon/crowbar = 8,
				/obj/item/weapon/crowbar/red = 8,
				/obj/item/weapon/crowbar/large = 8,
				/obj/item/weapon/extinguisher = 90,
//				/obj/item/weapon/gun/projectile/revolver/russian = 5,
				/obj/item/weapon/hand_labeler = 10,
				/obj/item/weapon/legcuffs/beartrap = 7,
				/obj/item/weapon/mop = 9,
				/obj/item/weapon/paper/crumpled = 10,
//				/obj/item/weapon/pen = 10,
				/obj/item/weapon/reagent_containers/glass/beaker = 10,
				/obj/item/weapon/reagent_containers/spray/pestspray = 10,
				/obj/item/weapon/reagent_containers/spray/cleaner = 10,
				/obj/item/weapon/stock_parts/cell = 30,
				/obj/item/weapon/stock_parts/cell/crap = 10,
				/obj/item/weapon/storage/belt/utility = 20,
				/obj/item/weapon/storage/box = 20,
				/obj/item/weapon/storage/box/cups = 10,
				/obj/item/weapon/storage/box/donkpockets = 7,
				/obj/item/weapon/storage/box/lights/mixed = 30,
				/obj/item/weapon/storage/fancy/cigarettes/dromedaryco = 7,
				/obj/item/weapon/storage/toolbox/mechanical = 10,
				/obj/item/weapon/screwdriver = 30,
				/obj/item/weapon/tank/emergency_oxygen = 30,
				/obj/item/weapon/umbrella = 7,
				/obj/item/weapon/vending_refill/cola = 10,
				/obj/item/weapon/vending_refill/snack = 10,
				/obj/item/weapon/weldingtool = 30,
				/obj/item/weapon/wirecutters = 20,
				/obj/item/weapon/wrench = 40,
				"" = 110
				)
