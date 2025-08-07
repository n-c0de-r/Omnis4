extends Control
class_name OmnisGame

#region Exports
@export var board: Control
@export_range(0.1, 0.9, 0.1) var effect: float = 0.2
#endregion Exports

#region Values
const BUTTON_COUNT: int = 4
var button_list: Array[TextureButton]
var show_list: Array[TextureButton]
var guess_list: Array[TextureButton]

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
	board.disable_ring(true)
	#if (Globals.mode == Globals.Modes.REVERSE):
		#_flip_direction()
	
	is_flipped = Globals.mode == Globals.Modes.FLIP
	is_random = Globals.mode == Globals.Modes.RANDOM
	
	double_counter = Globals.get_trial_bit(Globals.Trials.DOUBLE)
	mirror_shift = Globals.get_trial_bit(Globals.Trials.MIRROR)
	is_spiral = Globals.is_trial_set(Globals.Trials.SPIRAL)
	is_rotating = Globals.is_trial_set(Globals.Trials.ROTATE)
	Globals.connect_signals(board, _evaluate)
	_setButtons()
#endregion Built-Ins

#region Private Funtions
## Sets options for the buttons
func _setButtons() -> void:
	button_list = board.color_buttons.slice(0, BUTTON_COUNT)
	for btn: TextureButton in board.color_buttons:
		btn._simulatePress(0.5, effect)
		btn.toggle_mode = false
		
		await get_tree().create_timer(0.25).timeout
	
	_generate_rounds(rounds_played)

func _generate_rounds(count: int):
	var next: TextureButton
	
	for r in count:
		randomize()
		# Get next button for replay
		var index: int = randi_range(0, BUTTON_COUNT-1)
		next = button_list[index]
		show_list.append(next)
		# Gets shifted button for guessing if needed
		next = button_list[(index + mirror_shift) & (BUTTON_COUNT-1)]
		guess_list.append(next)
		
		# Get amount of additional presses of each button
		for double in double_counter:
			guess_list.append(next)
	
	# Play the visible list
	_play_list()

func _play_list()-> void:
	for btn in show_list:
		btn._simulatePress(1, effect)
		await get_tree().create_timer(2).timeout
		
	if (is_rotating):
		board.rotate()
	else:
		board.disable_ring(false)
	
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
#endregion Private Funtions
