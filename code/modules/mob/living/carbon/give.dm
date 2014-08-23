/mob/living/carbon/verb/give()
	set category = "IC"
	set name = "Give"
	set desc = "Give someone nearby an item."
	set src in oview(1)
	if(src.stat == 2 || usr.stat == 2 || src.client == null)
		return
	if(src == usr)
		usr << "<span class='warning'>Try giving to someone who is not already you.</span>"
		return
	var/obj/item/I
	if(!usr.hand && usr.r_hand == null)
		usr << "<span class='warning'>You don't have anything in your right hand to give to [src.name]</span>"
		return
	if(usr.hand && usr.l_hand == null)
		usr << "<span class='warning'>You don't have anything in your left hand to give to [src.name]</span>"
		return
//	if(usr.l_hand == null && usr.r_hand == null)
//		usr << "<span class='warning'>You need to actually have something to give [src] first.</span>"
//		return
	if(usr.hand)
		I = usr.l_hand
	else if(!usr.hand)
		I = usr.r_hand
	if(!I)
		return
	if(!src.r_hand == null && !src.l_hand == null)
		usr << "<span class='warning'>[src.name] already has their hands full.</span>"
		return

	if(src.r_hand == null || src.l_hand == null)
		switch(alert(src,"[usr] wants to give you \a [I]?",,"Accept","Decline"))
			if("Accept")
				if(!I)
					return
				if(!Adjacent(usr))
					usr << "<span class='warning'>You need to stay in reaching distance while giving an object.</span>"
					src << "<span class='warning'>[usr.name] moved too far away.</span>"
					return
				if((usr.hand && usr.l_hand != I) || (!usr.hand && usr.r_hand != I))
					usr << "<span class='warning'>You need to keep the item in your active hand.</span>"
					src << "<span class='warning'>[usr.name] seems to have given up on giving \the [I.name] to you.</span>"
					return
				if(src.r_hand != null && src.l_hand != null)
					src << "<span class='warning'>Your hands are full.</span>"
					usr << "<span class='warning'>Their hands are full.</span>"
					return
				else
					if(src.r_hand == null)
						src.r_hand = I
						usr.drop_item()
					if(src.l_hand == null)
						src.l_hand = I
						usr.drop_item()

				I.loc = src
				I.layer = 20
				I.add_fingerprint(src)

				src.update_inv_r_hand()
				src.update_inv_l_hand()
				usr.update_inv_r_hand()
				usr.update_inv_l_hand()
//				src.update_inv_hands()
//				usr.update_inv_hands()
				src.visible_message("<span class='notice'>[usr.name] handed \the [I.name] to [src.name].</span>")
			if("Decline")
				src.visible_message("<span class='warning'>[usr.name] tried to hand [I.name] to [src.name] but [src.name] didn't want it.</span>")
	else
		usr << "<span class='warning'>[src.name]'s hands are full.</span>"
