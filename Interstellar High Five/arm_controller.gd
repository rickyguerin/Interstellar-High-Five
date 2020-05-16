extends Node

signal game_ended

const ROT_VEC = Vector3(0.0, 0.0, 1.0)
const TRANS_VEC = Vector3(0.052, 0.0, 0.0)



var _game_over: bool

# Mode Controller Node
var _mode_controller

# Current mode for each arm
var _arm_nodes: Array
var _arm_rotations: Array
var _arm_modes: Array

func _ready():
	var left_arm = get_parent().get_node("LeftArm")
	var right_arm = get_parent().get_node("RightArm")
	_mode_controller = get_parent().get_node("Mode Controller")
	_arm_nodes = [left_arm, right_arm]
	_arm_rotations = [0.0, 0.0]
	_arm_modes = [_mode_controller.Modes.HOLD, _mode_controller.Modes.HOLD]
	
	_game_over = false
	
	_mode_controller.connect("mode_changed", self, "_set_arm_mode")


func _process(delta):
	if _game_over:
		return

	_arm_rotations[0] = rad2deg(_arm_nodes[0].rotation.z)
	_arm_rotations[1] = rad2deg(_arm_nodes[1].rotation.z)

	if _arm_rotations[0] <= 120.05 and _arm_rotations[1] <= 120.05:
		_game_over = true
		emit_signal("game_ended")
		return
	
	for i in range(2):
		match _arm_modes[i]:
			_mode_controller.Modes.HOLD:
				_hold_mode(i, delta)
			_mode_controller.Modes.MASH:
				_mash_mode(i, delta)
			_mode_controller.Modes.RELEASE:
				_release_mode(i, delta)

# mode_changed signal handler
func _set_arm_mode(updated_arm: int, mode: int):
	_arm_modes[updated_arm] = mode

# Control an arm when it's in HOLD mode
func _hold_mode(arm_id: int, delta: float):
	if Input.is_action_pressed("move_arm_" + str(arm_id)):
		_move_arm_in(arm_id, delta)
	else:
		_move_arm_out(arm_id, delta)


# Control an arm when it's in MASH mode
func _mash_mode(arm_id: int, delta: float):
	if Input.is_action_just_pressed("move_arm_" + str(arm_id)):
		_move_arm_in(arm_id, delta)
	else:
		_move_arm_out(arm_id, delta)
	

# Control an arm when it's in RELEASE mode
func _release_mode(arm_id: int, delta: float):
	if Input.is_action_pressed("move_arm_" + str(arm_id)):
		_move_arm_out(arm_id, delta)
	else:
		_move_arm_in(arm_id, delta)


# Rotate/translate arm inwards
func _move_arm_in(arm_id: int, delta: float):
	# left/right arms translate in opposite directions
	var d = 1 if arm_id == 0 else -1;
	
	if _arm_rotations[arm_id] > 120:
		_arm_nodes[arm_id].rotate_object_local(ROT_VEC, deg2rad(-2) * delta)
		_arm_nodes[arm_id].global_translate(TRANS_VEC * delta * d)


# Rotate/translate arm outwards
func _move_arm_out(arm_id: int, delta: float):
	# left/right arms translate in opposite directions
	var d = 1 if arm_id == 0 else -1;
	
	if _arm_rotations[arm_id] < 145:
		_arm_nodes[arm_id].rotate_object_local(ROT_VEC, deg2rad(2) * delta)
		_arm_nodes[arm_id].global_translate(TRANS_VEC * -delta * d)
