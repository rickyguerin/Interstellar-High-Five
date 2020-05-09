extends Node

var leftArm
var leftHand

var rightArm
var rightHand

# Called when the node enters the scene tree for the first time.
func _ready():
	leftArm = get_parent().get_node("LeftArm")
	rightArm = get_parent().get_node("RightArm")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	leftArm.rotate_object_local(Vector3(0.0, 0.0, 1.0), deg2rad(-2) * delta)
	leftArm.global_translate(Vector3(0.05, 0.0, 0.0) * delta)
	
	rightArm.rotate_object_local(Vector3(0.0, 0.0, 1.0), deg2rad(-2) * delta)
	rightArm.global_translate(Vector3(-0.05, 0.0, 0.0) * delta)
