extends Node

signal game_ended

const ROT_VEC = Vector3(0.0, 0.0, 1.0)
const TRANS_VEC = Vector3(0.052, 0.0, 0.0)

var left_arm
var right_arm
var game_over_flag

var _left_rot
var _right_rot

# Mode Controller Node
var _mode_controller

# Current mode for each arm
var _modes: Array

func _ready():
	left_arm = get_parent().get_node("LeftArm")
	right_arm = get_parent().get_node("RightArm")
	game_over_flag = false
	
	_mode_controller = get_parent().get_node("Mode Controller")
	_mode_controller.connect("mode_changed", self, "_set_arm_mode")

	_modes = [_mode_controller.Modes.HOLD, _mode_controller.Modes.HOLD]

func _process(delta):
	if game_over_flag:
		return

	_left_rot = rad2deg(left_arm.rotation.z)
	_right_rot = rad2deg(right_arm.rotation.z)

	if _left_rot <= 120.05 and _right_rot <= 120.05:
		game_over_flag = true
		emit_signal("game_ended")
		return
		
	_hold_mode(delta)

func _hold_mode(delta):
	# Move left arm
	if Input.is_action_pressed("left_arm_move") and _left_rot > 120:
		left_arm.rotate_object_local(ROT_VEC, deg2rad(-2) * delta)
		left_arm.global_translate(TRANS_VEC * delta)

	elif _left_rot < 145:
		left_arm.rotate_object_local(ROT_VEC, deg2rad(2) * delta)
		left_arm.global_translate(TRANS_VEC * -delta)

	# Move right arm
	if Input.is_action_pressed("right_arm_move") and _right_rot > 120:
		right_arm.rotate_object_local(ROT_VEC, deg2rad(-2) * delta)
		right_arm.global_translate(TRANS_VEC * -delta)

	elif _right_rot < 145:
		right_arm.rotate_object_local(ROT_VEC, deg2rad(2) * delta)
		right_arm.global_translate(TRANS_VEC * delta)

# mode_changed signal handler
func _set_arm_mode(updated_arm: int, mode: int):
	_modes[updated_arm] = mode

