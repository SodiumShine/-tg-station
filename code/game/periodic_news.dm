// This system defines news that will be displayed in the course of a round.
// Uses BYOND's type system to put everything into a nice format


/datum/news_announcement
	var/message // body of the message
	var/author = "NanoTrasen Editor"
	var/channel_name = "Centcom United News Network"
	var/can_be_redacted = 0
	var/message_type = "Story"
/*
/datum/news_announcement/revolution_inciting_event
	author = "Unauthorized"
	round_time = 30

/datum/news_announcement/revolution_inciting_event/paycuts_suspicion
			message = {"Reports have leaked that Nanotrasen Inc. is planning to put paycuts into
						effect on many of its Research Stations in Tau Ceti. Apparently these research
						stations haven't been able to yield the expected revenue, and thus adjustments
						have to be made."}

/datum/news_announcement/revolution_inciting_event/paycuts_confirmation
			message = {"Earlier rumours about paycuts on Research Stations in the Tau Ceti system have
						been confirmed. Shockingly, however, the cuts will only affect lower tier
						personnel. Heads of Staff will, according to our sources, not be affected."}

/datum/news_announcement/revolution_inciting_event/human_experiments
			message = {"Unbelievable reports about human experimentation have reached our ears. According
			 			to a refugee from one of the Tau Ceti Research Stations, their station, in order
			 			to increase revenue, has refactored several of their facilities to perform experiments
			 			on live humans, including virology research, genetic manipulation, and \"feeding them
			 			to the slimes to see what happens\". Allegedly, these test subjects were neither
			 			humanified monkeys nor volunteers, but rather unqualified staff that were forced into
			 			the experiments, and reported to have died in a \"work accident\" by Nanotrasen Inc."}
*/

/datum/news_announcement/cheesy_honkers
	author = "Assistant Editor Carl Ritz"
	message = {"Do cheesy honkers increase risk of having a miscarriage? Several health administrations
				say so!"}

/datum/news_announcement/net_block
	author = "Assistant Editor Carl Ritz"
	message = {"Several corporations banding together to block access to 'wetskrell.nt', site administrators
	claiming violation of net laws."}

/datum/news_announcement/found_ssd
	author = "Doctor Eric Hanfield"

	message = {"Several people have been found unconscious at their terminals. It is thought that it was due
				to a lack of sleep or of simply migraines from staring at the screen too long. Camera footage
				reveals that many of them were playing games instead of working and their pay has been docked
				accordingly."}

/datum/news_announcement/jachrid
	author = "Nienna Orntier"

	message = {"A rouge spacecraft blasted its way through the Jachrid Station surface today, making an illegal hyperspace jump moments after.
	 			Emergency forces are overwhelmed, calling this the biggest disaster in the stations recent history."}

/datum/news_announcement/whales
	author = "Samuel J. Lockheart"
	message = {"Many are left disgusted as reports come in of bands of roaming whalers on Triton, the most prominent of Neptune's moons,
				authorities are not sure how to handle the situation since there are no whales on Triton. Still, bystanders are demanding action for
				the rather loud singing and bad tall tales."}

/datum/news_announcement/reminder
	author = "Commander Ryan Brantz"
	message = {"Remember to always keep an eye out for suspicious activity aboard your station, and if you see any persons or other sentients acting strange
				and out of the ordinary it is your responsibility to report it to your station security force. Thank you and have a safe, space day"}

/datum/news_announcement/bennett
	author = "Paul Zod"
	message = {"Charges against Chairman Clinton Bennett were dropped yesterday after the claimant had reportedly fallen down some stairs and changed their mind.
				\"It's probably for the best\" said the former claimant, interviewed from their bed in the ICU. \"It was just big misunderstanding anyway.\" Bennett has refused
				to comment on the matter."}

/datum/news_announcement/meeps
	author = "Kelsey Gunn"
	message = {"Another station has fallen to the infestation, making this yet another NanoTrasen Space Station to undergo what Chairman Clinton Bennett describes as
				"Serious pest control." No crew members survived the infestation and the pest control. Crew upon other stations in the area are reminded to report all
				unregistered furry life forms to their superiors no matter how cute they might be."}

/datum/news_announcement/cake
	author = "Polly Podopolopolis"
	message = {"Authorities are still investigating the disappearance of several bluespace cakes that vanished from the Centcom Annual Cake Baking Competition several cycles ago.
				Please report any cake-related incidents to your station authorities."}

/datum/news_announcement/corgi
	message = {"Mysterious Caped Corgi still at large after recent heists on bank servers, witnesses at the scene only spotting the masked canine briefly. Like all previous
				criminal acts by the Caped Corgi, security guards were found knocked out cold but without serious injury. \"It moved like lightning! I turned around and bam,
				dog all up in my face\" reported a security guard. Authorities still puzzled as to how a corgi manages all this while thepublic is still left to speculate about the true name, owner, or even gender of the Caped Corgi."}
	author = "Felicity Cartwright"
////////////////////////////////////////////////////////////////////////////////

var/global/list/newscaster_standard_feeds = list(/datum/news_announcement/jachrid, /datum/news_announcement/cheesy_honkers, /datum/news_announcement/net_block,
												/datum/news_announcement/whales, /datum/news_announcement/found_ssd, /datum/news_announcement/reminder,
												/datum/news_announcement/bennett, /datum/news_announcement/meeps, /datum/news_announcement/cake, /datum/news_announcement/corgi)

var/global/list/announced_news_types = list()

proc/process_newscaster()
//	world << "DEBUG process_newscaster"
//	world << "DEBUG [ticker.mode.newscaster_cooldown]"
	if(!(newscaster_standard_feeds.len == announced_news_types.len))
		if(ticker.mode.newscaster_cooldown > 0)
			--ticker.mode.newscaster_cooldown
		if(prob(1) && prob(10) && (ticker.mode.newscaster_cooldown < 1))
			check_for_newscaster_updates()
			ticker.mode.newscaster_cooldown = 1000
	else return//message_admins("DEBUG out of news")

//proc/choose_news()
//	pick(

proc/check_for_newscaster_updates()
//	message_admins("check_for_newscaster_updates")
//	world << "DEBUG check_for_newscaster_updates"
//	var/list/possible_news_types = typesof(/datum/news_announcement)
	var/chosen_news = pick(newscaster_standard_feeds)
	if(chosen_news in announced_news_types)
		check_for_newscaster_updates()
		return
	else
		announced_news_types += chosen_news
//		newscaster_standard_feeds -= chosen_news
		var/datum/news_announcement/news = new chosen_news()
		announce_newscaster_news(news)

/*	for(var/subtype in typesof(type)-type)
		var/datum/news_announcement/news = new subtype()
		if(/*news.round_time <= world.time && */!(subtype in announced_news_types))
			announced_news_types += subtype
			announce_newscaster_news(news)
*/
proc/announce_newscaster_news(datum/news_announcement/news)
	message_admins("Announcing newscaster news")
	var/datum/feed_channel/sendto
	for(var/datum/feed_channel/FC in news_network.network_channels)
		if(FC.channel_name == news.channel_name)
			sendto = FC
			break

	if(!sendto)
		sendto = new /datum/feed_channel
		sendto.channel_name = news.channel_name
		sendto.author = news.author
		sendto.locked = 1
		sendto.is_admin_channel = 1
		news_network.network_channels += sendto

	var/author = news.author ? news.author : sendto.author
	news_network.SubmitArticle(news.message, author, news.channel_name, null, !news.can_be_redacted, news.message_type)

///////////////////////////


