extends Node

# Signal when an arm's mode changes
signal mode_changed(updated_arm, mode)

enum Arms {
	LEFT,
	RIGHT
}

# Interaction modes
enum Modes {
	HOLD,
	MASH,
	RELEASE,
}

var _rng

# Current mode for each arm
var _modes: Array

# Countdown until mode change for each arm
var _timers: Array

func _ready():
	_rng = RandomNumberGenerator.new()
	_rng.randomize()
	
	_modes = [Modes.HOLD, Modes.HOLD]
	_timers = [0.0, 0.0]
	
func _process(delta):
	for i in range(2):
		# Reset timer if 0.0
		if _timers[i] <= 0.0:
			_modes[i] += _rng.randi_range(1, Modes.size() - 1)
			_modes[i] %= Modes.size()
			_timers[i] = _rng.randf_range(2.0, 4.0)
			emit_signal("mode_changed", i, _modes[i])
 
		# Update timer
		_timers[i] -= delta

# Get the String name for each arm
func arm_name(id: int) -> String:
	match id:
		0:
			return "Left"
		1:
			return "Right"
		_:
			return "Invalid"

# Get the String name for each mode
func mode_name(id: int) -> String:
	match id:
		Modes.HOLD:
			return "HOLD"
		Modes.MASH:
			return "MASH"
		Modes.RELEASE:
			return "RELEASE"
		_:
			return "INVALID"
