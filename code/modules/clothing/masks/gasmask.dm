/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "A face-covering mask that can be connected to an air supply. While good for concealing your identity, it isn't good for blocking gas flow." //More accurate
	icon_state = "gas_alt"
	flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE
	w_class = 3.0
	item_state = "gas_alt"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH
	burn_state = -1 //Won't burn in fires

// **** Welding gas mask ****

/obj/item/clothing/mask/gas/welding
	name = "welding mask"
	desc = "A gas mask with built-in welding goggles and a face shield. Looks like a skull - clearly designed by a nerd."
	icon_state = "weldingmask"
	materials = list(MAT_METAL=4000, MAT_GLASS=2000)
	flash_protect = 2
	tint = 2
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	origin_tech = "materials=2;engineering=2"
	action_button_name = "Toggle Welding Mask"
	flags_cover = MASKCOVERSEYES
	visor_flags_inv = HIDEEYES

/obj/item/clothing/mask/gas/welding/attack_self()
	toggle()

/obj/item/clothing/mask/gas/welding/verb/toggle()
	set category = "Object"
	set name = "Adjust welding mask"
	set src in usr

	weldingvisortoggle()

// ********************************************************************

//Plague Dr suit can be found in clothing/suits/bio.dm
/obj/item/clothing/mask/gas/plaguedoctor
	name = "plague doctor mask"
	desc = "A modernised version of the classic design, this mask will not only filter out toxins but it can also be connected to an air supply."
	icon_state = "plaguedoctor"
	item_state = "gas_mask"
	armor = list(melee = 0, bullet = 0, laser = 2,energy = 2, bomb = 0, bio = 75, rad = 0)

/obj/item/clothing/mask/gas/syndicate
	name = "syndicate mask"
	desc = "A close-fitting tactical mask that can be connected to an air supply."
	icon_state = "syndicate"
	strip_delay = 60

/obj/item/clothing/mask/gas/voice
	name = "gas mask"
	//desc = "A face-covering mask that can be connected to an air supply. It seems to house some odd electronics."
	var/mode = 0// 0==Scouter | 1==Night Vision | 2==Thermal | 3==Meson
	var/voice = "Unknown"
	var/vchange = 0//This didn't do anything before. It now checks if the mask has special functions/N
	origin_tech = "syndicate=4"
	action_button_name = "Toggle mask"

/obj/item/clothing/mask/gas/voice/attack_self(mob/user)
	vchange = !vchange
	user << "<span class='notice'>The voice changer is now [vchange ? "on" : "off"]!</span>"


/obj/item/clothing/mask/gas/voice/space_ninja/speechModification(message)
	if(voice == "Unknown")
		if(copytext(message, 1, 2) != "*")
			var/list/temp_message = text2list(message, " ")
			var/list/pick_list = list()
			for(var/i = 1, i <= temp_message.len, i++)
				pick_list += i
			for(var/i=1, i <= abs(temp_message.len/3), i++)
				var/H = pick(pick_list)
				if(findtext(temp_message[H], "*") || findtext(temp_message[H], ";") || findtext(temp_message[H], ":"))
					continue
				temp_message[H] = ninjaspeak(temp_message[H])
				pick_list -= H
				message = list2text(temp_message, " ")
				message = replacetext(message, "l", "r")
				message = replacetext(message, "rr", "ru")
				message = replacetext(message, "v", "b")
				message = replacetext(message, "f", "hu")
				message = replacetext(message, "'t", "")
				message = replacetext(message, "t ", "to ")
				message = replacetext(message, "I ", " Ai ")
				message = replacetext(message, " I ", " Ai ")
				message = replacetext(message, "th", "z")
				message = replacetext(message, "ish", "isu")
				message = replacetext(message, "is", "izu")
				message = replacetext(message, "ziz", "zis")
				message = replacetext(message, "se", "su")
				message = replacetext(message, "br", "bur")
				message = replacetext(message, "ry", "ri")
				message = replacetext(message, "you", "yuu")
				message = replacetext(message, "ck", "cku")
				message = replacetext(message, "eu", "uu")
				message = replacetext(message, "ow", "au")
				message = replacetext(message, "are", "aa")
				message = replacetext(message, "ay", "ayu")
				message = replacetext(message, "ea", "ii")
				message = replacetext(message, "ch", "chi")
				message = replacetext(message, "than", "sen")
//				message = replacetext(message, ".", "")
//				message = lowertext(message)
/* //SHINE HAHAHAHA
			message = list2text(temp_message, " ")
			message = replacetext(message, "o", "?")
			message = replacetext(message, "p", "?")
			message = replacetext(message, "l", "?")
			message = replacetext(message, "s", "?")
			message = replacetext(message, "u", "?")
			message = replacetext(message, "b", "?")
*/
	return message


/obj/item/clothing/mask/gas/clown_hat
	name = "clown wig and mask"
	desc = "A true prankster's facial attire. A clown is incomplete without his wig and mask."
	flags = MASKINTERNALS
	icon_state = "clown"
	item_state = "clown_hat"
	flags_cover = MASKCOVERSEYES
	burn_state = 0 //Burnable

/obj/item/clothing/mask/gas/clown_hat/attack_self(mob/user)

	var/mob/M = usr
	var/list/options = list()
	options["True Form"] = "clown"
	options["The Feminist"] = "sexyclown"
	options["The Madman"] = "joker"
	options["The Rainbow Color"] ="rainbow"

	var/choice = input(M,"To what form do you wish to Morph this mask?","Morph Mask") in options

	if(src && choice && !M.stat && in_range(M,src))
		icon_state = options[choice]
		M << "Your Clown Mask has now morphed into [choice], all praise the Honk Mother!"
		return 1

/obj/item/clothing/mask/gas/sexyclown
	name = "sexy-clown wig and mask"
	desc = "A feminine clown mask for the dabbling crossdressers or female entertainers."
	flags = MASKINTERNALS
	icon_state = "sexyclown"
	item_state = "sexyclown"
	flags_cover = MASKCOVERSEYES
	burn_state = 0 //Burnable

/obj/item/clothing/mask/gas/mime
	name = "mime mask"
	desc = "The traditional mime's mask. It has an eerie facial posture."
	flags = MASKINTERNALS
	icon_state = "mime"
	item_state = "mime"
	flags_cover = MASKCOVERSEYES
	burn_state = 0 //Burnable

/obj/item/clothing/mask/gas/monkeymask
	name = "monkey mask"
	desc = "A mask used when acting as a monkey."
	flags = MASKINTERNALS
	icon_state = "monkeymask"
	item_state = "monkeymask"
	flags_cover = MASKCOVERSEYES
	burn_state = 0 //Burnable

/obj/item/clothing/mask/gas/sexymime
	name = "sexy mime mask"
	desc = "A traditional female mime's mask."
	flags = MASKINTERNALS
	icon_state = "sexymime"
	item_state = "sexymime"
	flags_cover = MASKCOVERSEYES
	burn_state = 0 //Burnable

/obj/item/clothing/mask/gas/death_commando
	name = "Death Commando Mask"
	icon_state = "death_commando_mask"
	item_state = "death_commando_mask"

/obj/item/clothing/mask/gas/cyborg
	name = "cyborg visor"
	desc = "Beep boop."
	icon_state = "death"
	burn_state = 0 //Burnable

/obj/item/clothing/mask/gas/owl_mask
	name = "owl mask"
	desc = "Twoooo!"
	icon_state = "owl"
	flags = MASKINTERNALS
	flags_cover = MASKCOVERSEYES
	burn_state = 0 //Burnable

/obj/item/clothing/mask/gas/carp
	name = "carp mask"
	desc = "Gnash gnash."
	icon_state = "carp_mask"