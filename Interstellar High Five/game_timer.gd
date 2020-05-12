extends Label

var timer
var game_over_flag

func _ready():
	timer = 0
	game_over_flag = false
	# warning-ignore:return_value_discarded
	get_parent().get_node("Game Controller").connect("game_ended", self, "_game_over")

func _process(delta):
	if game_over_flag:
		return
	
	timer += delta

	var hours = str(int(timer / 3600)).pad_zeros(2)
	var minutes = str(int(timer / 60)).pad_zeros(2)
	var seconds = ("%.2f" % fmod(timer, 60.0)).pad_zeros(2)

	set_text(hours + ":" + minutes + ":" + seconds)

func _game_over():
	game_over_flag = true
	text += "\nHIGH FIVE!"
