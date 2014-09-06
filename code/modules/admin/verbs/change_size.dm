client/proc/change_size(mob/M as mob in mob_list)
	set category = "Fun"
	set name = "Change Size"

	if(!holder)
		src << "Only administrators may use this command."
		return
	var/value = input("Enter value") as num
	if(!value)
		return
	M.transform *= value
