extends Label

export var arm_name: String

var _mode_controller

func _ready():
	_mode_controller = get_parent().get_node("Mode Controller")
	_mode_controller.connect("mode_changed", self, "_update_label")

func _update_label(updated_arm: int, mode: int):
	
	var updated_arm_name = _mode_controller.arm_name(updated_arm)
	var mode_name = _mode_controller.mode_name(mode)
	
	if updated_arm_name == arm_name:
		text = arm_name + " Arm Mode:\n" + mode_name
