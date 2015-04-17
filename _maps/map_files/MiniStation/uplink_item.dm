// Modified uplink items to discourage tator murderboning
/*
/datum/uplink_item/dangerous/revolver/New()
	..()
	cost = 10

/datum/uplink_item/dangerous/crossbow/New()
	..()
	cost = 8

/datum/uplink_item/dangerous/sword/New()
	..()
	cost = 5 // SHINE 7 to 5 so they can dual wield

/datum/uplink_item/dangerous/syndicate_minibomb/New()
	..()
	cost = 5
// SHINE re-add parapen
/datum/uplink_item/stealthy_weapons/para_pen/New()
	..()
//	item = null // Disabled
	cost = 6
/datum/uplink_item/stealthy_tools/syndigolashes/New()
	..()
	cost = 3 // SHINE 5 to 3

/datum/uplink_item/device_tools/c4/New()
	..()
	cost = 4 // COST 1 to 4
*/

/datum/uplink_item/device_tools/singularity_beacon/New()
	..()
//	cost = 4
	item = null // SHINE disabled

/datum/uplink_item/device_tools/syndicate_bomb/New()
	..()
	item = null // Disabled

/*
/datum/uplink_item/dangerous/viscerators/New() // SHINE transfered
	..()
	name = "Viscerator Delivery Grenade"
	desc = "A unique grenade that deploys a swarm of viscerators upon activation, which will chase down and shred any non-operatives in the area."
	item = /obj/item/weapon/grenade/spawnergrenade/manhacks
	cost = 6 // SHINE Price up 4 to 7
	gamemodes = list() // SHINE empty list for all modes

/datum/uplink_item/dangerous/bioterror // SHINE add
	..()
	item = null // SHINE remove for now, nerf later



/datum/uplink_item/device_tools/medkit/New() // SHINE add
	..()
	name = "Syndicate Medical Supply Kit"
	desc = "The syndicate medkit is a suspicious black and red. Included is a combat stimulant injector for rapid healing, a medical hud for quick identification of injured comrades, \
	and other medical supplies helpful for a medical field operative.."
	item = /obj/item/weapon/storage/firstaid/tactical
	cost = 5
	gamemodes = list() // SHINE empty list all modes


/datum/uplink_item/device_tools/shield/New() // SHINE add
	..()
	gamemodes = list() // SHINE empty list
*/