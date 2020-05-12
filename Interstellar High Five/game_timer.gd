extends Label

var timer

func _ready():
	timer = 0
	

func _process(delta):
	timer += delta

	var hours = str(int(timer / 3600)).pad_zeros(2)
	var minutes = str(int(timer / 60)).pad_zeros(2)
	var seconds = ("%.2f" % fmod(timer, 60.0)).pad_zeros(2)

	set_text(hours + ":" + minutes + ":" + seconds)
