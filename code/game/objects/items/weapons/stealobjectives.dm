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

/obj/item/weapon/uniquesteal/powercrystal
	name = "aurichalcum shard"
	desc = "A very rare and very valuable piece of refined aurichalcum. It is completely useless."
	icon_state = "powercrystal_item"

/obj/structure/uniquesteal_container/powercrystal
	name = "aurichalcum shard"
	desc = "A very rare and very valuable piece of refined aurichalcum. It is completely useless."
	icon_state = "powercrystal1"

/obj/structure/uniquesteal_container/powercrystal/attack_hand(mob/user as mob)
	user.changeNext_move(CLICK_CD_MELEE)
	if (src.occupied)
		new /obj/item/weapon/uniquesteal/powercrystal( src.loc )
		user << "<span class='notice'>You deactivate the hover field built into the stand.</span>"
		user.visible_message("<span class='warning'>[user] removes the [src.name] from the stand.</span>")
		src.occupied = 0
		src.add_fingerprint(user)
		update_icon()
		return
	else
		return

/obj/structure/uniquesteal_container/powercrystal/attackby(obj/item/weapon/W as obj, mob/user as mob)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(W, /obj/item/weapon/uniquesteal/powercrystal))
		user << "<span class='notice'>You put the [W.name] back on the stand.</span>"
		user.drop_item()
		qdel(W)
		src.occupied = 1
		src.add_fingerprint(user)
		update_icon()
	else
		user << "<span class='warning'>The stand refuses that item.</span>"
	return

/obj/structure/uniquesteal_container/powercrystal/update_icon()
	if(src.occupied)
		src.icon_state = "powercrystal[src.occupied]"
		src.name = "aurichalcum shard"
		src.desc = "A very rare and very valuable piece of refined aurichalcum. It is completely useless."
	else
		src.icon_state = "powercrystal[src.occupied]"
		src.name = "empty display stand"
		src.desc = "Someone stole it!"
	return