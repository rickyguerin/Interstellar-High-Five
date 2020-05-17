extends MarginContainer

export var menu_id:int

func _input(event):
	# F goes back
	if event.is_action_pressed("move_arm_0"):
		if menu_id >= 1:
			get_tree().change_scene("res://menu_" + str(menu_id - 1) + ".tscn")
	
	# J continues to next menu or game
	if event.is_action_pressed("move_arm_1"):
		if menu_id < 2:
			get_tree().change_scene("res://menu_" + str(menu_id + 1) + ".tscn")
		else:
			get_tree().change_scene("res://game.tscn")
