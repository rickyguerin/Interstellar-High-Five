extends Node

signal game_ended

const rotVec = Vector3(0.0, 0.0, 1.0)
const transVec = Vector3(0.052, 0.0, 0.0)

var leftArm
var rightArm
var game_over_flag

func _ready():
	leftArm = get_parent().get_node("LeftArm")
	rightArm = get_parent().get_node("RightArm")
	game_over_flag = false

func _process(delta):
	if game_over_flag:
		return

	var leftRot = rad2deg(leftArm.rotation.z)
	var rightRot = rad2deg(rightArm.rotation.z)

	if leftRot <= 120.05 and rightRot <= 120.05:
		game_over_flag = true
		emit_signal("game_ended")
		return

	# Move left arm
	if Input.is_action_pressed("left_arm_move") and leftRot > 120:
		leftArm.rotate_object_local(rotVec, deg2rad(-2) * delta)
		leftArm.global_translate(transVec * delta)

	elif leftRot < 145:
		leftArm.rotate_object_local(rotVec, deg2rad(2) * delta)
		leftArm.global_translate(transVec * -delta)

	# Move right arm
	if Input.is_action_pressed("right_arm_move") and rightRot > 120:
		rightArm.rotate_object_local(rotVec, deg2rad(-2) * delta)
		rightArm.global_translate(transVec * -delta)

	elif rightRot < 145:
		rightArm.rotate_object_local(rotVec, deg2rad(2) * delta)
		rightArm.global_translate(transVec * delta)
