extends Control
class_name OmnisGame

#region Exports
@export var board: Control
#endregion Exports

#region Values
var button_list: Array[TextureButton]
var show_list: Array[TextureButton]
var guess_list: Array[TextureButton]
var speed: float
var effect: float
var button_count: int

var rounds_played: int = 1
var check_start: int = 0
var check_index: int = 0
var check_direction: int = 1 # 1=normal, -1=reverse
var spiral_counter: int	= 1 # 1=normal, increases every round

var double_counter: int = 1 # 1=normal, 2=doubles each button
var mirror_shift: int	= 0 # 0=normal, 2=mirrors color
var is_spiral: bool = false
var is_flipped: bool = false
var is_random: bool = false
var is_rotating: bool = false
#endregion Values

#region Built-Ins
func _ready() -> void:
	_init_values()
	_connect_signals()
	_setButtons()
#endregion Built-Ins

#region Private Funtions
## Sets the initial values for the game,
## according to the Global settings
func _init_values():
	effect = Globals.effect
	speed = Globals.speed
	
	if (Globals.mode == Globals.Modes.REVERSE):
		_flip_direction()
	
	is_flipped = Globals.mode == Globals.Modes.FLIP
	is_random = Globals.mode == Globals.Modes.RANDOM
	
	double_counter = Globals.get_trial_bit(Globals.Trials.DOUBLE)
	mirror_shift = Globals.get_trial_bit(Globals.Trials.MIRROR)
	is_spiral = Globals.is_trial_set(Globals.Trials.SPIRAL)
	is_rotating = Globals.is_trial_set(Globals.Trials.ROTATE)


## Connects the gameboards' buttons
func _connect_signals() -> void:
	for btn: TextureButton in board.color_buttons:
		btn.omnis_pressed.connect(_evaluate)


## Sets options for the buttons
func _setButtons() -> void:
	button_list = board.color_buttons.duplicate()
	button_count = button_list.size()
	for btn: TextureButton in button_list:
		btn._simulatePress(speed / 4.0, effect)
		await get_tree().create_timer(speed  / 2.0).timeout
	
	_generate_rounds(rounds_played)


func _generate_rounds(count: int):
	var next: TextureButton
	
	for r in count:
		randomize()
		# Get next button for replay
		var index: int = randi_range(0, button_count-1)
		next = button_list[index]
		show_list.append(next)
		# Gets shifted button for guessing if needed
		index += mirror_shift
		index &= button_count-1
		next = button_list[index]
		guess_list.append(next)
		
		# Get amount of additional presses of each button
		for double in double_counter:
			guess_list.append(next)
	
	print("show ", show_list)
	print("guess ", guess_list)
	# Play the visible list
	_play_list()


func _play_list()-> void:
	for btn in show_list:
		btn._simulatePress(speed, effect)
		await get_tree().create_timer(speed * 2).timeout
		
	if (is_rotating):
		board.rotate()
	else:
		board.disable_ring(false)
	
	check_index = check_start


func _evaluate(pressed: TextureButton) -> void:
	if (guess_list[check_index] == pressed):
		check_index+=check_direction
		pressed.disabled = false
	else:
		_play_list()
	
	_finish_round()


func _finish_round() -> void:
	if (check_index >= guess_list.size() or check_index < -guess_list.size()):
		board.disable_ring(true)
		
		# round over
		rounds_played += 1
		
		# Switch directions
		if (is_flipped):
			_flip_direction()
		
		# Add progressively more to the next round
		if (is_spiral):
			spiral_counter += 1
		
		if (is_random):
			show_list.clear()
			guess_list.clear()
			_generate_rounds(rounds_played)
		else:
			_generate_rounds(spiral_counter)
			
		check_index = check_start


func _flip_direction() -> void:
	check_start -= check_direction
	check_direction = 0-check_direction
	check_index = check_start
#endregion Private Funtions
