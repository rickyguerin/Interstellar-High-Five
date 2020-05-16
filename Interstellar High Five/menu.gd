extends MarginContainer

func _input(event):
	# If F or Z is pressed, start the game
	if event.is_action_pressed("move_arm_0") \
			or event.is_action_pressed("move_arm_1"):
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://game.tscn")
