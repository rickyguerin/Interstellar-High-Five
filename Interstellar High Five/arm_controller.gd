extends Node

signal game_ended

const ROT_VEC = Vector3(0.0, 0.0, 1.0)
const TRANS_VEC = Vector3(0.052, 0.0, 0.0)

var game_over_flag

var _arm_nodes: Array
var _arm_rotations: Array

var _left_rot
var _right_rot

# Mode Controller Node
var _mode_controller

# Current mode for each arm
var _modes: Array

func _ready():
	var left_arm = get_parent().get_node("LeftArm")
	var right_arm = get_parent().get_node("RightArm")
	_arm_nodes = [left_arm, right_arm]
	_arm_rotations = [0.0, 0.0]
	
	game_over_flag = false
	
	_mode_controller = get_parent().get_node("Mode Controller")
	_mode_controller.connect("mode_changed", self, "_set_arm_mode")

	_modes = [_mode_controller.Modes.HOLD, _mode_controller.Modes.HOLD]

func _process(delta):
	if game_over_flag:
		return

	_arm_rotations[0] = rad2deg(_arm_nodes[0].rotation.z)
	_arm_rotations[1] = rad2deg(_arm_nodes[1].rotation.z)

	if _arm_rotations[0] <= 120.05 and _arm_rotations[1] <= 120.05:
		game_over_flag = true
		emit_signal("game_ended")
		return
		
	_hold_mode(delta)


# mode_changed signal handler
func _set_arm_mode(updated_arm: int, mode: int):
	_modes[updated_arm] = mode

func _hold_mode(arm_id: int, delta: float):
	# left/right arms translate in opposite directions
	var d = 1 if arm_id == 0 else -1;
	
	if Input.is_action_pressed("move_arm_" + str(arm_id)) \
			and _arm_rotations[arm_id] > 120:
		_arm_nodes[arm_id].rotate_object_local(ROT_VEC, deg2rad(-2) * delta)
		_arm_nodes[arm_id].global_translate(TRANS_VEC * delta * d)

	elif _arm_rotations[arm_id] < 145:
		_arm_nodes[arm_id].rotate_object_local(ROT_VEC, deg2rad(2) * delta)
		_arm_nodes[arm_id].global_translate(TRANS_VEC * -delta * d)
