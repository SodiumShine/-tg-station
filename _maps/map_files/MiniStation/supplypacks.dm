/datum/supply_packs/engineering/oxygen
	name = "Oxygen Canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/oxygen)
	cost = 15
	containertype = /obj/structure/largecrate
	containername = "oxygen canister crate"

/datum/supply_packs/engineering/toxins
	name = "Toxins Canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/toxins)
	cost = 30
	containertype = /obj/structure/largecrate
	containername = "toxins canister crate"

/datum/supply_packs/engineering/nitrogen
	name = "Nitrogen Canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/nitrogen)
	cost = 20
	containertype = /obj/structure/largecrate
	containername = "nitrogen canister crate"

/datum/supply_packs/engineering/carbon_dio
	name = "Carbon Dioxide Canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/carbon_dioxide)
	cost = 35
	containertype = /obj/structure/largecrate
	containername = "carbon dioxide canister crate"


/obj/machinery/hydroponics/unattached
	anchored = 0

/datum/supply_packs/organic/hydroponics/hydro_tray
	name = "Hydroponics Tray"
	contains = list(/obj/machinery/hydroponics/unattached)
	cost = 10
	containertype = /obj/structure/largecrate
	containername = "hydroponics tray crate"
/* SHINE FIX THIS
/datum/supply_packs/organic/pizza/margherita // SHINE added
	name = "Margherita Pizza"
	contains = list(/obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/margherita)
	cost = 35
	containername = "Pizza crate"

/datum/supply_packs/organic/pizza/meat // SHINE added
	name = "Meat Pizza"
	contains = list(/obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/meatpizza)
	cost = 35
	containername = "Pizza crate"

/datum/supply_packs/organic/pizza/mushroom // SHINE added
	name = "Mushroom Pizza"
	contains = list(/obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/mushroompizza)
	cost = 35
	containername = "Pizza crate"

/datum/supply_packs/organic/pizza/vegetable // SHINE added
	name = "Vegetable Pizza"
	contains = list(/obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/vegetablepizza)
	cost = 35
	containername = "Pizza crate"
*/
/datum/supply_packs/engineering/superair
	name = "Atmosphere replacement canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/superair)
	cost = 115
	containername = "Atmosphere replacement canister crate"
	containertype = /obj/structure/closet/crate/secure

/datum/supply_packs/engineering/pipedispenser
	name = "Atmospheric Pipe Dispensor"
	contains = list(/obj/machinery/pipedispenser)
	cost = 60
	containername = "Pipe Dispenser crate"
	containertype = /obj/structure/largecrate

/datum/supply_packs/security/charges
	name = "Breaching Charges"
	cost = 60
	contains = list(/obj/item/weapon/c4/security,/obj/item/weapon/c4/security,/obj/item/weapon/c4/security)
	containertype = /obj/structure/closet/crate/secure
	containername = "Explosives crate"