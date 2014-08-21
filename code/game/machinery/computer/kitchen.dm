/obj/machinery/computer/kitchen
	name = "Bar computer"
	desc = "This computer tells you how to make stuff that people will then put in their mouth."
	icon_state = "old"
	var/temp = null
	var/screen = null

/obj/machinery/computer/kitchen/attack_hand(mob/user as mob)
	usr.set_machine(src)
	var/dat = ""
	if(..())
		return
	if(src.screen < 1)
		src.screen = 1
	if (src.temp)
		dat = text("<TT>[src.temp]</TT><BR><BR><A href='?src=\ref[src];temp=1'>Clear Screen</A>")
	if(src.screen)
		switch(src.screen)
			if(1.0)
				dat += {"
	<A href='?src=\ref[src];screen=2'>Drink recipes</A>
	<BR><A href='?src=\ref[src];screen=3'>Food Recipes</A>
	"}

			if(2.0)
				dat += "<CENTER><B>Drink recipes</B></CENTER>"
				dat += "<a href='?src=\ref[src];screen=1'><b>Back</b></a><br>"
				for(var/Dr in typesof(/datum/chemical_reaction/))
					var/datum/chemical_reaction/Dri = new Dr(0)
					dat += "<br><a href='?src=\ref[src];drinks=[Dr]'>[Dri.name]</a>"
				dat += "<br><a href='?src=\ref[src];screen=1'><b>Back</b></a>"

			if(3.0)
				dat += "<CENTER><B>Food recipes</B></CENTER>"
				dat += "<a href='?src=\ref[src];screen=1'><b>Back</b></a><br>"
				for(var/Fd in typesof(/datum/recipe/))
					var/datum/recipe/Foo = new Fd(0)
					var/obj/resultPath = Foo.result
					dat += "<br><a href='?src=\ref[src];food=[Fd]'>[initial(resultPath.name)]</a>"
				dat += "<br><a href='?src=\ref[src];screen=1'><b>Back</b></a>"

	var/datum/browser/popup = new(user, "kitchen", "Recipe Database", 600, 400)
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()
	return

/obj/machinery/computer/kitchen/Topic(href, href_list)
	if(..())
		return

	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
		usr.set_machine(src)
		if (href_list["temp"])
			src.temp = null

		if(href_list["screen"])
			src.screen = text2num(href_list["screen"])
			if(src.screen < 1)
				src.screen = 1
			if(src.screen == 1)
				src.temp = ""



		if(href_list["drinks"])
			var/type = href_list["drinks"]
			var/datum/chemical_reaction/Dri = new type(0)

			src.temp = {"<b>Drink name:</b> [Dri.name]
	<BR><b>Resulting amount:</b> [Dri.result_amount] units
	<BR><b>Ingredients:</b>"}

			for(var/A in Dri.required_reagents)
				var/Aamount = Dri.required_reagents[A]
				src.temp += "<br>[Aamount] part(s) [A]"
			for(var/C in Dri.required_catalysts)
				var/Camount = Dri.required_catalysts[C]
				src.temp += "<br> [Camount] part(s) [C] (Catalyst)"




		else if(href_list["food"])

			var/type = href_list["food"]
			var/datum/recipe/Foo = new type(0)
			var/obj/resultPath = Foo.result

			src.temp = {"<b>Name:</b> [initial(resultPath.name)]
	<BR><b>Description:</b> [initial(resultPath.desc)]
	<BR><b>Ingredients:</b>"}
			for(var/B in Foo.reagents)
				var/amount = Foo.reagents[B]
				src.temp += "<br>[amount] unit(s) of [B]"
			for(var/I in Foo.items)
				var/obj/itemsPath = I
				src.temp += "<br>[initial(itemsPath.name)]"

	src.add_fingerprint(usr)
	src.updateUsrDialog()