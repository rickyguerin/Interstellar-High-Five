extends Label

export var arm_name: String

var _mode_controller

func _ready():
	_mode_controller = get_parent().get_node("Mode Controller")
	_mode_controller.connect("mode_changed", self, "_update_label")

func _update_label(updated_arm: String, mode: String):
	if updated_arm == arm_name:
		text = updated_arm + " Arm Mode:\n" + mode
