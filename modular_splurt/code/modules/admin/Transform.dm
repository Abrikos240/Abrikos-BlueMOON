// Stuff that helps the TGUI player panel transform section to work

GLOBAL_LIST_INIT(pp_transformables, list(
	list(
	name = "Common",
	color = "",
	types = list(
		list(
			name = "Human",
			key = /mob/living/carbon/human
			),
		list(
			name = "Monkey",
			key = /mob/living/carbon/monkey
			),
		list(
			name = "Cyborg",
			key = /mob/living/silicon/robot
			)
		)
	),
	list(
	name = "Xenomorph",
	color = "purple",
	types = list(
		list(
			name = "Larva",
			key = /mob/living/carbon/alien/larva
			),
		list(
			name = "Drone",
			key = /mob/living/carbon/alien/humanoid/drone
			),
		list(
			name = "Hunter",
			key = /mob/living/carbon/alien/humanoid/hunter
			),
		list(
			name = "Sentinel",
			key = /mob/living/carbon/alien/humanoid/sentinel
			),
		list(
			name = "Praetorian",
			key = /mob/living/carbon/alien/humanoid/royal/praetorian
			),
		list(
			name = "Queen",
			key = /mob/living/carbon/alien/humanoid/royal/queen
			)
		)
	),
	list(
	name = "Lavaland",
	color = "orange",
	types = list(
		list(
			name = "Goliath",
			key = /mob/living/simple_animal/hostile/asteroid/goliath/beast
			),
		list(
			name = "Legion",
			key = /mob/living/simple_animal/hostile/asteroid/hivelord/legion
			),
		list(
			name = "Blood-Drunk Miner",
			key = /mob/living/simple_animal/hostile/megafauna/blood_drunk_miner
			),
		list(
			name = "Gladiator",
			key = /mob/living/simple_animal/hostile/megafauna/gladiator
			),
		list(
			name = "Dragon",
			key = /mob/living/simple_animal/hostile/megafauna/dragon
			),
		list(
			name = "Legion Hivelord",
			key = /mob/living/simple_animal/hostile/asteroid/elite/legionnaire
			)
		)
	),
	list(
	name = "Cultist",
	color = "violet",
	types = list(
		list(
			name = "Shade",
			key = /mob/living/simple_animal/hostile/construct/shade
			),
		list(
			name = "Artificer",
			key = /mob/living/simple_animal/hostile/construct/builder
			),
		list(
			name = "Wraith",
			key = /mob/living/simple_animal/hostile/construct/wraith
			),
		list(
			name = "Juggernaut",
			key = /mob/living/simple_animal/hostile/construct/armored
			)
		)
	)
))

// M: Mob to change
// newType: Path of new type e.g: /mob/living/carbon/alien/humanoid/drone
// newTypeName (optional): Name of the new type (used in logging): e.g: "Drone"
/datum/admins/proc/transformMob(mob/M, mob/adminMob, newType, newTypeName)
	if(!check_rights(R_SPAWN))
		return

	if(!ismob(M))
		to_chat(usr, "This can only be used on instances of type /mob.")
		return

	if (!newTypeName)
		newTypeName = newType

	log_admin("[key_name(usr)] transformed [key_name(M)] into a [newTypeName].")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] transformed [key_name_admin(M)] into a [newTypeName].</span>")

	var/mob/newMob = M.change_mob_type(newType, delete_old_mob = TRUE)

	if (M == adminMob)
		adminMob = newMob
	addtimer(CALLBACK(newMob.mob_panel, TYPE_PROC_REF(/datum, ui_interact), adminMob), 0.1 SECONDS)
