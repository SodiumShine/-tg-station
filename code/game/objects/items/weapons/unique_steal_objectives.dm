//////////////
/*
Items here are useless and unique for traitors to steal
*/
//////////////

/obj/item/weapon/uniquesteal/
	name = "unique steal objective"
	desc = "nick it quick"
	icon = 'icons/obj/stealobjectives.dmi'
	force = 3
	w_class = 2.0
	throwforce = 3


/obj/structure/uniquesteal_container/
	name = "display stand"
	icon = 'icons/obj/stealobjectives.dmi'
	icon_state = ""
	desc = "A display stand for fancy things"
	density = 0
	anchored = 1
	unacidable = 1//Dissolving the case would also delete the contents
//	var/health = 30
	var/occupied = 1
//	var/destroyed = 0
	var/stand_content // this is what is in the stand
	var/icon_id = "item"
	var/list/current_contents
/*
/obj/structure/uniquesteal_container/New()
	..()
	sleep(2)
	current_contents += new stand_content(src)
*/
/obj/structure/uniquesteal_container/attack_hand(mob/user as mob)
	user.changeNext_move(CLICK_CD_MELEE)
	if (src.occupied)
		new stand_content(src.loc)
		user << "<span class='notice'>You deactivate the hover field built into the stand.</span>"
		user.visible_message("<span class='warning'>[user] removes the [src.name] from the stand.</span>")
		src.occupied = 0
		src.add_fingerprint(user)
		update_icon()
		src.name = "empty display stand"
		src.desc = "Someone stole it!"
		//Activate Anti-theft
//		var/area/alarmed = get_area(src)
//		alarmed.burglaralert(src)
//		playsound(src, "sound/effects/alert.ogg", 50, 1)
		return
	else
		return

/obj/structure/uniquesteal_container/attackby(obj/item/weapon/W as obj, mob/user as mob)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(W, stand_content))
		user << "<span class='notice'>You put the [W.name] back on the stand.</span>"
		user.drop_item()
		qdel(W)
		src.occupied = 1
		src.add_fingerprint(user)
		update_icon()
		src.name = "[W.name]"
		src.desc = "[W.desc]"
	else
		user << "<span class='warning'>The stand refuses that item.</span>"
	return

/obj/structure/uniquesteal_container/update_icon()
	src.icon_state = "[src.icon_id][src.occupied]"
	return
/*
/obj/item/weapon/uniquesteal/New()
	..()
	processing_objects.Add(src)

/obj/item/weapon/uniquesteal/process()
	var/turf/item_loc = get_turf(src)
	if(item_loc.z > 2)
		get(src, /mob) << "<span class='danger'>You can't help but feel that you just lost something back there...</span>"
		Destroy()

/obj/item/weapon/uniquesteal/Destroy()
	if(blobstart.len > 0)
		var/obj/item/weapon/uniquesteal/NEWSTEAL = new(pick(blobstart))
		transfer_fingerprints_to(NEWSTEAL)
		message_admins("[src] has been destroyed.  Moving it to ([NEWSTEAL.x], [NEWSTEAL.y], [NEWSTEAL.z]).")
		log_game("[src] has been destroyed.  Moving it to ([NEWSTEAL.x], [NEWSTEAL.y], [NEWSTEAL.z]).")
		del(src) //Needed to clear all references to it
	else
		ERROR("[src] was supposed to be destroyed, but we were unable to locate a blobstart landmark to spawn a new one.")
	return 1 // Cancel destruction.
*/
////////////////////////////////////////////


/obj/item/weapon/uniquesteal/powercrystal
	name = "aurichalcum shard"
	desc = "A very rare and very valuable piece of refined aurichalcum. It is completely useless."
	icon_state = "powercrystal_item"

/obj/structure/uniquesteal_container/powercrystal
	name = "aurichalcum shard"
	desc = "A very rare and very valuable piece of refined aurichalcum. It is completely useless."
	icon_state = "powercrystal1"
	stand_content = /obj/item/weapon/uniquesteal/powercrystal
	icon_id = "powercrystal"

/obj/structure/uniquesteal_container/powercrystal/attack_hand(mob/user as mob)
	..()
	return

/obj/structure/uniquesteal_container/powercrystal/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	return

/obj/structure/uniquesteal_container/powercrystal/update_icon()
	..()
	return

///////////////////////////////////////////////////

/obj/item/weapon/uniquesteal/can
	name = "can of spacecarp caviar"
	desc = "A small tin of spacecarp eggs. Needless to say these are extremely difficult to collect, and therefor highly valuable. They also taste terrible."
	icon_state = "can_item"

/obj/structure/uniquesteal_container/can
	name = "can of spacecarp caviar"
	desc = "A small tin of spacecarp eggs. Needless to say these are extremely difficult to collect, and therefor highly valuable. They also taste terrible."
	icon_state = "can1"
	stand_content = /obj/item/weapon/uniquesteal/can
	icon_id = "can"

/obj/structure/uniquesteal_container/can/attack_hand(mob/user as mob)
	..()
	return

/obj/structure/uniquesteal_container/can/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	return

/obj/structure/uniquesteal_container/can/update_icon()
	..()
	return