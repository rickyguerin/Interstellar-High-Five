extends Label

var timer

func _ready():
	timer = 0
	

func _process(delta):
	timer += delta
	
	var format_string = "%02d:%04.2f"
	
	set_text(format_string % [(timer / 60), timer])
