/obj/item/weapon/implant
	name = "implant"
	icon = 'icons/obj/implants.dmi'
	icon_state = "generic" //Shows up as the action button icon
	action_button_is_hands_free = 1
	var/activated = 1 //1 for implant types that can be activated, 0 for ones that are "always on" like loyalty implants
	var/implanted = null
	var/mob/living/imp_in = null
	item_color = "b"
	var/allow_reagents = 0


/obj/item/weapon/implant/proc/trigger(emote, mob/source)
	return


/obj/item/weapon/implant/proc/activate()
	return

/obj/item/weapon/implant/ui_action_click()
	activate("action_button")


//What does the implant do upon injection?
//return 0 if the implant fails (ex. Revhead and loyalty implant.)
//return 1 if the implant succeeds (ex. Nonrevhead and loyalty implant.)
/obj/item/weapon/implant/proc/implanted(var/mob/source)
	if(activated)
		action_button_name = "Activate [src.name]"
	if(istype(source, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = source
		H.sec_hud_set_implants()
	return 1


/obj/item/weapon/implant/proc/get_data()
	return "No information available"

/obj/item/weapon/implant/dropped(mob/user as mob)
	. = 1
	qdel(src)
	return .

/obj/item/weapon/implant/tracking
	name = "tracking implant"
	desc = "Track with this."
	activated = 0
	var/id = 1.0

/obj/item/weapon/implant/tracking/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Tracking Beacon<BR>
				<b>Life:</b> 10 minutes after death of host<BR>
				<b>Important Notes:</b> None<BR>
				<HR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Continuously transmits low power signal. Useful for tracking.<BR>
				<b>Special Features:</b><BR>
				<i>Neuro-Safe</i>- Specialized shell absorbs excess voltages self-destructing the chip if
				a malfunction occurs thereby securing safety of subject. The implant will melt and
				disintegrate into bio-safe elements.<BR>
				<b>Integrity:</b> Gradient creates slight risk of being overcharged and frying the
				circuitry. As a result neurotoxins can cause massive damage.<HR>
				Implant Specifics:<BR>"}
	return dat

/obj/item/weapon/implant/weapons_auth
	name = "firearms authentication implant"
	desc = "Lets you shoot your guns"
	icon_state = "auth"

/obj/item/weapon/implant/tracking/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Firearms Authentication Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Allows operation of implant-locked weaponry, preventing equipment from falling into enemy hands."}
	return dat

/obj/item/weapon/implant/explosive
	name = "explosive implant"
	desc = "And boom goes the weasel."
	icon_state = "explosive"

/obj/item/weapon/implant/explosive/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Robust Corp RX-78 Employee Management Implant<BR>
				<b>Life:</b> Activates upon death.<BR>
				<b>Important Notes:</b> Explodes<BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Contains a compact, electrically detonated explosive that detonates upon receiving a specially encoded signal or upon host death.<BR>
				<b>Special Features:</b> Explodes<BR>
				<b>Integrity:</b> Implant will occasionally be degraded by the body's immune system and thus will occasionally malfunction."}
	return dat

/obj/item/weapon/implant/explosive/trigger(emote, mob/source)
	if(emote == "deathgasp")
		activate("death")

/obj/item/weapon/implant/explosive/activate(var/cause)
	if(!cause || !imp_in)	return 0
	if(cause == "action_button" && alert(imp_in, "Are you sure you want to activate your explosive implant? This will cause you to explode and gib!", "Explosive Implant Confirmation", "Yes", "No") != "Yes")
		return 0
	explosion(src,0,1,5,7,10, flame_range = 5)
	if(imp_in)
		imp_in.gib()


/obj/item/weapon/implant/chem
	name = "chem implant"
	desc = "Injects things."
	icon_state = "reagents"
	allow_reagents = 1

/obj/item/weapon/implant/chem/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Robust Corp MJ-420 Prisoner Management Implant<BR>
				<b>Life:</b> Deactivates upon death but remains within the body.<BR>
				<b>Important Notes: Due to the system functioning off of nutrients in the implanted subject's body, the subject<BR>
				will suffer from an increased appetite.</B><BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Contains a small capsule that can contain various chemicals. Upon receiving a specially encoded signal<BR>
				the implant releases the chemicals directly into the blood stream.<BR>
				<b>Special Features:</b>
				<i>Micro-Capsule</i>- Can be loaded with any sort of chemical agent via the common syringe and can hold 50 units.<BR>
				Can only be loaded while still in its original case.<BR>
				<b>Integrity:</b> Implant will last so long as the subject is alive. However, if the subject suffers from malnutrition,<BR>
				the implant may become unstable and either pre-maturely inject the subject or simply break."}
	return dat

/obj/item/weapon/implant/chem/New()
	..()
	create_reagents(50)

/obj/item/weapon/implant/chem/trigger(emote, mob/source)
	if(emote == "deathgasp")
		activate(reagents.total_volume)

/obj/item/weapon/implant/chem/activate(var/cause)
	if(!cause || !imp_in)	return 0
	var/mob/living/carbon/R = imp_in
	reagents.trans_to(R, cause)
	R << "You hear a faint *beep*."
	if(!reagents.total_volume)
		R << "You hear a faint click from your chest."
		qdel(src)


/obj/item/weapon/implant/loyalty
	name = "loyalty implant"
	desc = "Makes you loyal or such."
	activated = 0

/obj/item/weapon/implant/loyalty/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Nanotrasen Employee Management Implant<BR>
				<b>Life:</b> Ten years.<BR>
				<b>Important Notes:</b> Personnel injected with this device tend to be much more loyal to the company.<BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Contains a small pod of nanobots that manipulate the host's mental functions.<BR>
				<b>Special Features:</b> Will prevent and cure most forms of brainwashing.<BR>
				<b>Integrity:</b> Implant will last so long as the nanobots are inside the bloodstream."}
	return dat


//////////////////////
///Loyalty Implants///
//////////////////////

/obj/item/weapon/implant/loyalty/implanted(mob/target)
	..()
	if(target.mind in ticker.mode.head_revolutionaries)
		target.visible_message("<span class='warning'>[target] seems to resist the implant!</span>", "<span class='warning'>You feel the corporate tendrils of Nanotrasen try to invade your mind!</span>")
		return 0
	if(target.mind in ticker.mode.revolutionaries)
		ticker.mode.remove_revolutionary(target.mind)
		target << "<span class='notice'>You feel a surge of loyalty towards Nanotrasen.</span>"
		return 1
	if(target.mind in ticker.mode.traitors) //SHINE if traitor, make them not traitor
		target.mind.remove_traitor()
		message_admins("[key_name(usr)] has de-traitor'ed [target].")
		log_admin("[key_name(usr)] has de-traitor'ed [target].")
		target << "<span class='warning'>Your head hurts like crazy as you feel the implant's influence burrow into your mind!</span>"
		target << "\red <FONT size = 3><B>You have been brainwashed! You are no longer a traitor, and feel a surge of loyalty towards Nanotrasen!</B></FONT>"
		return 1
	if(target.mind in ticker.mode.changelings)
		message_admins("[key_name(usr)] has attempted to un-changling [target].")
		target << "<span class='notice'>We feel the implant trying to puppet our mind. We are too strong for this pathetic attempt.</span>"
		return 0
	else
		for(var/obj/item/weapon/implant/loyalty/existing_implant in target.contents)
			if(existing_implant.imp_in)
				message_admins("[key_name(usr)] has attempted to implant already loyal [target].")
				target.visible_message("<span class='danger'>[target] already had a Loyalty Implant! The nanobots overload!</span>")
				explosion(target, -1, 0, 2, 3, 0)
				return 0
		target << "<span class='warning'>Your head hurts like crazy as you feel the implant's influence burrow into your mind!</span>"
		target << "<span class='warning'>The loyalty implant nanobots suffer a critical error. You realise Nanotrasen is bullshit. <i>Fuck</i> Nanotrasen.</span>"
		if(!(src in ticker.mode.traitors))
			ticker.mode.traitors += target.mind
			target.mind.special_role = "traitor"
			target << "<FONT size = 3><B>\red You are now a traitor!</B></FONT>"
			message_admins("[key_name(usr)] has traitor'ed [target].")
			log_admin("[key_name(usr)] has traitor'ed [target].")
			ticker.mode.forge_traitor_objectives(target.mind)
			var/obj_count = 1
			target << "\blue Your current objectives:"
			for(var/datum/objective/objective in target.mind.objectives)
				target << "<B>Objective #[obj_count]</B>: [objective.explanation_text]"
				obj_count++
		return 1
/*
		target.visible_message("<span class='warning'>[target] already had a standard issue Loyalty Implant! The second one caused an overload!</span>")
		explosion(target, -1, 0, 2, 3, 0)
		return 0
*/
/obj/item/weapon/implant/adrenalin
	name = "adrenal implant"
	desc = "Removes all stuns and knockdowns."
	icon_state = "adrenal"
	var/uses = 3

/obj/item/weapon/implant/adrenalin/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Cybersun Industries Adrenaline Implant<BR>
				<b>Life:</b> Five days.<BR>
				<b>Important Notes:</b> <font color='red'>Illegal</font><BR>
				<HR>
				<b>Implant Details:</b> Subjects injected with implant can activate an injection of medical cocktails.<BR>
				<b>Function:</b> Removes stuns, increases speed, and has a mild healing effect.<BR>
				<b>Integrity:</b> Implant can only be used three times before reserves are depleted."}
	return dat

/obj/item/weapon/implant/adrenalin/activate()
	if(uses < 1)	return 0
	uses--
	imp_in << "<span class='notice'>You feel a sudden surge of energy!</span>"
	imp_in.SetStunned(0)
	imp_in.SetWeakened(0)
	imp_in.SetParalysis(0)
	imp_in.adjustStaminaLoss(-75)
	imp_in.lying = 0
	imp_in.update_canmove()

	imp_in.reagents.add_reagent("synaptizine", 10)
	imp_in.reagents.add_reagent("omnizine", 10)
	imp_in.reagents.add_reagent("morphine", 10)


/obj/item/weapon/implant/emp
	name = "emp implant"
	desc = "Triggers an EMP."
	icon_state = "emp"

	var/uses = 2

/obj/item/weapon/implant/emp/activate()
	if (src.uses < 1)	return 0
	src.uses--
	empulse(imp_in, 3, 5)
