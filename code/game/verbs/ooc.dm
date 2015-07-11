/client/verb/ooc(msg as text)
	set name = "OOC" //Gave this shit a shorter name so you only have to time out "ooc" rather than "ooc message" to use it --NeoFite
	set category = "OOC"

	if(say_disabled)	//This is here to try to identify lag problems
		usr << "<span class='danger'>Speech is currently admin-disabled.</span>"
		return

	if(!mob)	return
	if(IsGuestKey(key))
		src << "Guests may not use OOC."
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)	return

	if(!(prefs.chat_toggles & CHAT_OOC))
		src << "<span class='danger'>You have OOC muted.</span>"
		return

	if(!holder)
		if(!ooc_allowed)
			src << "<span class='danger'>OOC is globally muted.</span>"
			return
		if(!dooc_allowed && (mob.stat == DEAD))
			usr << "<span class='danger'>OOC for dead mobs has been turned off.</span>"
			return
		if(prefs.muted & MUTE_OOC)
			src << "<span class='danger'>You cannot use OOC (muted).</span>"
			return
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			src << "<B>Advertising other servers is not allowed.</B>"
			log_admin("[key_name(src)] has attempted to advertise in OOC: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in OOC: [msg]")
			return

	log_ooc("[mob.name]/[key] : [msg]")

	var/keyname = key
	if(prefs.unlock_content)
		if(prefs.toggles & MEMBER_PUBLIC)
			keyname = "<font color='[prefs.ooccolor ? prefs.ooccolor : normal_ooc_colour]'><img style='width:9px;height:9px;' class=icon src=\ref['icons/member_content.dmi'] iconstate=blag>[keyname]</font>"

	msg = emoji_parse(msg)

	for(var/client/C in clients)
		if(C.prefs.chat_toggles & CHAT_OOC)
			if(holder)
				if(!holder.fakekey || C.holder)
					if(check_rights_for(src, R_ADMIN))
						C << "<span class='adminooc'>[config.allow_admin_ooccolor && prefs.ooccolor ? "<font color=[prefs.ooccolor]>" :"" ]<span class='prefix'>OOC:</span> <EM>[keyname][holder.fakekey ? "/([holder.fakekey])" : ""]:</EM> <span class='message'>[msg]</span></span></font>"
					else
						C << "<span class='adminobserverooc'><span class='prefix'>OOC:</span> <EM>[keyname][holder.fakekey ? "/([holder.fakekey])" : ""]:</EM> <span class='message'>[msg]</span></span>"
				else
					C << "<font color='[normal_ooc_colour]'><span class='ooc'><span class='prefix'>OOC:</span> <EM>[holder.fakekey ? holder.fakekey : key]:</EM> <span class='message'>[msg]</span></span></font>"
			else
				C << "<font color='[normal_ooc_colour]'><span class='ooc'><span class='prefix'>OOC:</span> <EM>[keyname]:</EM> <span class='message'>[msg]</span></span></font>"


///LOCAL OOC///
/client/verb/looc(msg as text)
	set name = "LOOC" //Gave this shit a shorter name so you only have to time out "ooc" rather than "ooc message" to use it --NeoFite
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	if(say_disabled)	//This is here to try to identify lag problems
		usr << "\red Speech is currently admin-disabled."
		return

	if(!mob)
//		message_admins("LOOC DEBUG !mob")
		return
	if(IsGuestKey(key))
		src << "Guests may not use OOC."
		return

	msg = trim(copytext(sanitize(msg), 1, MAX_MESSAGE_LEN))
	if(!msg)
//		message_admins("LOOC DEBUG !msg")
		return

	if(!(prefs.toggles & CHAT_OOC))
		src << "<span class='danger'>You have OOC muted.</span>"
		return

	if(!holder)
		if(!ooc_allowed)
			src << "\red OOC is globally muted"
			return
		if(!dooc_allowed && (mob.stat == DEAD))
			usr << "\red OOC for dead mobs has been turned off."
			return
		if(prefs.muted & MUTE_OOC)
			src << "\red You cannot use OOC (muted)."
			return
		if(handle_spam_prevention(msg,MUTE_OOC))
//			message_admins("LOOC DEBUG spame prevention")
			return

		if(findtext(msg, "byond://"))
			src << "<B>Advertising other servers is not allowed.</B>"
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in LOOC: [msg]")
			return

	log_ooc("(LOCAL) [mob.name]/[key] : [msg]")
	message_admins("Distant LOOC: [mob.name]([key]): [msg]")

	var/list/heard = list()//= get_mobs_in_view(7, src.mob)
	var/mob/S = src.mob

	for(var/mob/M in view(7, S))
		heard += M
//		message_admins("[M] found for looc. Heard: [heard]")

	var/display_name = S.key
	if(S.stat != DEAD)
		display_name = S.name
	if(S.stat == DEAD)
		S << "<span class='userdanger'>You cannot use Local OOC when dead!</span>"
		return

	// Handle non-admins
	for(var/mob/M in heard)
//		message_admins("LOOC handling")
		if(!M.client)
//			message_admins("[M] DEBUG LOOC !M.Client")
			continue
		var/client/C = M.client
//		if (C in admins)
//			continue //they are handled after that
//		message_admins("[M] found, [C] found.")
		if(C.prefs.toggles & CHAT_OOC)
//			message_admins("Running last part of looc)")
		/*
			if(holder)
				if(holder.fakekey)
					if(C.holder)
						display_name = "[holder.fakekey]/([src.key])"
					else
						display_name = holder.fakekey
		*/
			C << "<font color='#5ECCA6'><span class='ooc'><span class='prefix'>LOOC:</span> <EM>[display_name]:</EM> <span class='message'>[msg]</span></span></font>"

/*
	// Now handle admins
	display_name = S.key
	if(S.stat != DEAD)
		display_name = "[S.name]/([S.key])"

	for(var/client/C in admins)
		if(C.prefs.toggles & CHAT_OOC)
			var/prefix = "(R)LOOC"
			if (C.mob in heard)
				prefix = "LOOC"
			C << "<font color='#5ECCA6'><span class='ooc'><span class='prefix'>[prefix]:</span> <EM>[display_name]:</EM> <span class='message'>[msg]</span></span></font>"
*/



/proc/toggle_ooc()
	ooc_allowed = !( ooc_allowed )
	if (ooc_allowed)
		world << "<B>The OOC channel has been globally enabled!</B>"
	else
		world << "<B>The OOC channel has been globally disabled!</B>"

/proc/auto_toggle_ooc(var/on)
	if(!config.ooc_during_round && ooc_allowed != on)
		toggle_ooc()

var/global/normal_ooc_colour = "#002eb8"

/client/proc/set_ooc(newColor as color)
	set name = "Set Player OOC Color"
	set desc = "Modifies player OOC Color"
	set category = "Fun"
	normal_ooc_colour = sanitize_ooccolor(newColor)

/client/proc/reset_ooc()
	set name = "Reset Player OOC Color"
	set desc = "Returns player OOC Color to default"
	set category = "Fun"
	normal_ooc_colour = initial(normal_ooc_colour)

/client/verb/colorooc()
	set name = "Set Your OOC Color"
	set category = "Preferences"

	if(!holder || check_rights_for(src, R_ADMIN))
		if(!is_content_unlocked())	return

	var/new_ooccolor = input(src, "Please select your OOC color.", "OOC color", prefs.ooccolor) as color|null
	if(new_ooccolor)
		prefs.ooccolor = sanitize_ooccolor(new_ooccolor)
		prefs.save_preferences()
	feedback_add_details("admin_verb","OC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/verb/resetcolorooc()
	set name = "Reset Your OOC Color"
	set desc = "Returns your OOC Color to default"
	set category = "Preferences"

	if(!holder || check_rights_for(src, R_ADMIN))
		if(!is_content_unlocked())	return

		prefs.ooccolor = initial(prefs.ooccolor)
		prefs.save_preferences()

//Checks admin notice
/client/verb/admin_notice()
	set name = "Adminnotice"
	set category = "Admin"
	set desc ="Check the admin notice if it has been set"

	if(admin_notice)
		src << "<span class='boldnotice'>Admin Notice:</span>\n \t [admin_notice]"
	else
		src << "<span class='notice'>There are no admin notices at the moment.</span>"

/client/verb/motd()
	set name = "MOTD"
	set category = "OOC"
	set desc ="Check the Message of the Day"

	if(join_motd)
		src << "<div class=\"motd\">[join_motd]</div>"
	else
		src << "<span class='notice'>The Message of the Day has not been set.</span>"

/client/proc/self_notes()
	set name = "View Admin Notes"
	set category = "OOC"
	set desc = "View the notes that admins have written about you"

	if(!config.see_own_notes)
		usr << "<span class='notice'>Sorry, that function is not enabled on this server.</span>"
		return

	see_own_notes()
