/mob/dead/observer/say(var/message)
	message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))

	if (!message)
		return

	log_say("Ghost/[src.key] : [message]")

	if (src.client)
		if(src.client.prefs.muted & MUTE_DEADCHAT)
			src << "<span class='danger'>You cannot talk in deadchat (muted).</span>"
			return

		if (src.client.handle_spam_prevention(message,MUTE_DEADCHAT))
			return

	. = src.say_dead(message)

/mob/dead/observer/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, list/spans)
	if(radio_freq)
		var/atom/movable/virtualspeaker/V = speaker
		speaker = V.source
	src << "<a href=?src=\ref[src];follow=\ref[speaker]>(F)</a> [message]"



	/*
	for (var/mob/M in hearers(null, null))
		if (!M.stat)
			if(M.job == "Chaplain")
				if (prob (49))
					M.show_message("<span class='game'><i>You hear muffled susurration... the departed are trying to communicate...</i></span>", 2)
				else
					M.show_message("<span class='game'><i>The departed are trying to communicate with you... you can almost make out some words...</i></span>", 2)
					M.show_message("<span class='game'><span class='whisper'><i>[stutter(message)]</i></span></span>", 2)
					playsound(src.loc, pick('sound/effects/ghost.ogg','sound/effects/ghost2.ogg'), 10, 1)
			else
				if (prob(80))
					return
				else if (prob (80))
					M.show_message("<span class='game'><i>You hear muffled susurration... but nothing is there...</i></span>", 2)
				else
					M.show_message("<span class='game'><i>You hear muffled speech... you can almost make out some words...</i></span>", 2)
					M.show_message("<span class='game'><span class='whisper'><i>[stutter(message)]</i></span></span>", 2)
					playsound(src.loc, pick('sound/effects/ghost.ogg','sound/effects/ghost2.ogg'), 10, 1)
*/
