
var/datum/controller/transfer_controller/transfer_controller

datum/controller/transfer_controller
	var/timerbuffer = 0 //buffer for time check
	var/currenttick = 0
	var/notified = 0
	var/toldantag = 0

datum/controller/transfer_controller/New()
	timerbuffer = 144000
//	timerbuffer = 1800
	processing_objects += src

datum/controller/transfer_controller/Del()
	processing_objects -= src

datum/controller/transfer_controller/proc/process()
	currenttick = currenttick + 1
//	if (currenttick >= 10800)
/*
	if (currenttick >= 30)
		if(!toldantag)
			message_admins("Checking for antags to notify")
			for(var/mob/P in world)
				var/list/people
				people += P
				for(var/datum/mind/M in people)
					message_admins("[M] found to notify of time")
					if(M.special_role == "Changeling")
						M.current << "<span class='userdanger'>We feel like we are running out of time... We must make haste with our plans.</span>"
					if(M.special_role == "traitor")
						M.current << "<span class='userdanger'>You're running out of time to complete your objectives. The boss isn't going to be happy, better hurry up.</span>"
			toldantag = 1
*/
	if (world.time >= timerbuffer)
		if(!notified)
			message_admins("<h1>Out of time!</h1>")
			notified = 1
//		vote.autotransfer()
// call shuttle here
			emergency_shuttle.incall(1)
			priority_announce("The work shift has ended, and the emergency shuttle will arrive shortly to retrieve the crew. It will arrive in [round(emergency_shuttle.timeleft()/60)] minutes.", null, 'sound/AI/shuttlecalled.ogg', "Priority")
			emergency_shuttle.hometime = 1



/*
datum/controller/transfer_controller/proc/check_time_left()
	usr << "Checking time..."
	usr << "Currenttick: [transfer_controller.currenttick], Timerbuffer: [transfer_controller.timerbuffer]"
*/

/* baystation thing for reference
var/datum/controller/transfer_controller/transfer_controller

datum/controller/transfer_controller
	var/timerbuffer = 0 //buffer for time check
	var/currenttick = 0

datum/controller/transfer_controller/New()
	timerbuffer = config.vote_autotransfer_initial
	processing_objects += src

datum/controller/transfer_controller/Del()
	processing_objects -= src

datum/controller/transfer_controller/proc/process()
	currenttick = currenttick + 1
	if (world.time >= timerbuffer - 600)
		vote.autotransfer()
		timerbuffer = timerbuffer + config.vote_autotransfer_interval
*/