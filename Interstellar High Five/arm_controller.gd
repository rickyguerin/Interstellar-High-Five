extends Node

var leftArm
var rightArm

# Called when the node enters the scene tree for the first time.
func _ready():
	leftArm = get_parent().get_node("LeftArm")
	rightArm = get_parent().get_node("RightArm")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	# Move left arm
	if Input.is_action_pressed("left_arm_move") \
			and rad2deg(leftArm.rotation.z) > 120:
		leftArm.rotate_object_local(Vector3(0.0, 0.0, 1.0), deg2rad(-2) * delta)
		leftArm.global_translate(Vector3(0.05, 0.0, 0.0) * delta)

	elif rad2deg(leftArm.rotation.z) < 145:
		leftArm.rotate_object_local(Vector3(0.0, 0.0, 1.0), deg2rad(2) * delta)
		leftArm.global_translate(Vector3(-0.05, 0.0, 0.0) * delta)

	# Move right arm
	if Input.is_action_pressed("right_arm_move") \
			and rad2deg(rightArm.rotation.z) > 120:
		rightArm.rotate_object_local(Vector3(0.0, 0.0, 1.0), deg2rad(-2) * delta)
		rightArm.global_translate(Vector3(-0.05, 0.0, 0.0) * delta)

	elif rad2deg(rightArm.rotation.z) < 145:
		rightArm.rotate_object_local(Vector3(0.0, 0.0, 1.0), deg2rad(2) * delta)
		rightArm.global_translate(Vector3(0.05, 0.0, 0.0) * delta)
