/mob/living/silicon/robot/default_toggle_sprint(shutdown = FALSE)
	if(!CONFIG_GET(flag/sprint_enabled))
		disable_intentional_sprint_mode()
		return
	var/current = (combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
	if(current || shutdown || !cell || (cell.charge < 15) || !cansprint) //BLUEMOON EDIT Снижение порога проверки заряда батареи со стандартных 25 до 15
		disable_intentional_sprint_mode()
		if(CHECK_MULTIPLE_BITFIELDS(mobility_flags, MOBILITY_STAND|MOBILITY_MOVE))
			if(shutdown)
				playsound_local(src, 'sound/effects/light_flicker.ogg', 50, FALSE, pressure_affected = FALSE)
			playsound_local(src, 'sound/misc/sprintdeactivate.ogg', 50, FALSE, pressure_affected = FALSE)
	else
		enable_intentional_sprint_mode()
		if(CHECK_MULTIPLE_BITFIELDS(mobility_flags, MOBILITY_STAND|MOBILITY_MOVE))
			playsound_local(src, 'sound/misc/sprintactivate.ogg', 50, FALSE, pressure_affected = FALSE)
