extends Label

export var arm_name: String

func _ready():
	var mode_controller = get_parent().get_node("Mode Controller")
	mode_controller.connect("mode_changed", self, "_update_label")

func _update_label(updated_arm: String, mode: String):
	if updated_arm == arm_name:
		text = updated_arm + " Arm Mode:\n" + mode
