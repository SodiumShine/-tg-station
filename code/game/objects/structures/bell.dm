/obj/structure/bell
	desc = "A bell you can ring to get someone's attention."
	name = "bell"
	icon = 'icons/obj/bell.dmi'
	icon_state = "bell"
	density = 0
	anchored = 1
	layer = 3
	var/spam_flag = 0

/obj/structure/bell/attack_hand(mob/user as mob)
	if(spam_flag == 0)
		spam_flag = 1
		playsound(src.loc, 'sound/weapons/ring.ogg', 50, 0)
		src.add_fingerprint(user)
		spawn(30)
			spam_flag = 0
	return