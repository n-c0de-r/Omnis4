extends Control
class_name OmnisGame

#region Exports
@export var board: SelectGame
@export var _timer: Timer
#endregion Exports

#region Values
var _button_list: Array
var _show_list: Array[int]
var _guess_list: Array[int]

const BASE_TIMEOUT: float = 3.0
var _wait_time: float
var _rounds_played: int = 1
var _check_start: int = 0
var _check_index: int = 0
var _check_direction: int = 1 # 1=normal, -1=reverse
var _spiral_counter: int	= 1 # 1=normal, increases every round
var _mirror_shift: int	= 0 # 0=normal, 2=mirrors color

var _is_flipped: bool = false
var _is_random: bool = false
var _is_timed: bool = false
var _is_double: bool = false
var _is_spiral: bool = false
#endregion Values

#region Built-Ins
func _ready() -> void:
	_init_values()
	
	await board.play_intro()
	_generate_rounds(_rounds_played)
#endregion Built-Ins


#region Public Functions
func evaluate_decision(selection: int) -> void:
	_timer.stop()
	if (_guess_list[_check_index] == selection):
		_check_index += _check_direction
	else:
		#lose life
		_restart_round()
	
	var _guess_items: int = _guess_list.size()
	if (_check_index >= _guess_items or _check_index < -_guess_items):
		_finish_round()
#endregion


#region Private Funtions
## Sets the initial values for the game,
## according to the Global settings
func _init_values():
	_button_list = Globals.Colors.values()
	_button_list.pop_back() # remove purple
	#var btn: OmnisButton = board.get_child(0).get_child(Globals.Colors.PURPLE)
	#btn.get_child(0).texture = null
	
	_mirror_shift = 2 if Globals.get_option("mirror") else 0
	
	_wait_time = BASE_TIMEOUT * Globals.get_speed()
	
	_is_flipped = Globals.get_option("flip")
	_is_random = Globals.get_option("random")
	_is_timed = Globals.get_option("timed")
	_is_double = Globals.get_option("double")
	_is_spiral = Globals.get_option("spiral")
	
	if not _is_flipped and Globals.get_option("reverse"):
		_flip_direction()


func _generate_rounds(count: int):
	var color_count: int = _button_list.size()-1
	for r in count:
		randomize()
		var next: int
		var index: int = randi_range(0, color_count)
		next = _button_list[index]
		_show_list.append(next)
		# Gets shifted button for guessing if needed
		index += _mirror_shift
		index &= color_count
		next = _button_list[index]
		_guess_list.append(next)
		
		if _is_double:
			_guess_list.append(next)
	
	print("show ", _show_list)
	print("guess ", _guess_list)
	print("dir ", _check_direction)
	
	_restart_round()


func _finish_round() -> void:
	_rounds_played += 1
	
	if (_is_flipped):
		_flip_direction()
	
	if _is_spiral:
		_spiral_counter += 1
	
	if (_is_random):
		_show_list.clear()
		_guess_list.clear()
		_generate_rounds(_rounds_played)
	else:
		_generate_rounds(_spiral_counter)
		
	_check_index = _check_start


func _flip_direction() -> void:
	_check_start -= _check_direction
	_check_direction = 0 - _check_direction
	_check_index = _check_start


func _restart_round() -> void:
	_check_index = _check_start
	await board.play_list(_show_list)
	
	if _is_timed:
		_timer.wait_time = _wait_time
		_timer.start()
		print(Time.get_time_string_from_system())


func _on_game_paused() -> void:
	if get_tree().paused:
		pass
	get_tree().paused = !get_tree().paused


func _on_timer_timeout() -> void:
	print(Time.get_time_string_from_system())
	evaluate_decision(-1)
#endregion Private Funtions
