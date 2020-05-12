extends Node

signal game_ended

const ROT_VEC = Vector3(0.0, 0.0, 1.0)
const TRANS_VEC = Vector3(0.052, 0.0, 0.0)

var left_arm
var right_arm
var game_over_flag

func _ready():
	left_arm = get_parent().get_node("LeftArm")
	right_arm = get_parent().get_node("RightArm")
	game_over_flag = false

func _process(delta):
	if game_over_flag:
		return

	var left_rot = rad2deg(left_arm.rotation.z)
	var right_rot = rad2deg(right_arm.rotation.z)

	if left_rot <= 120.05 and right_rot <= 120.05:
		game_over_flag = true
		emit_signal("game_ended")
		return

	# Move left arm
	if Input.is_action_pressed("left_arm_move") and left_rot > 120:
		left_arm.rotate_object_local(ROT_VEC, deg2rad(-2) * delta)
		left_arm.global_translate(TRANS_VEC * delta)

	elif left_rot < 145:
		left_arm.rotate_object_local(ROT_VEC, deg2rad(2) * delta)
		left_arm.global_translate(TRANS_VEC * -delta)

	# Move right arm
	if Input.is_action_pressed("right_arm_move") and right_rot > 120:
		right_arm.rotate_object_local(ROT_VEC, deg2rad(-2) * delta)
		right_arm.global_translate(TRANS_VEC * -delta)

	elif right_rot < 145:
		right_arm.rotate_object_local(ROT_VEC, deg2rad(2) * delta)
		right_arm.global_translate(TRANS_VEC * delta)
