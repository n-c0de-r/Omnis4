#region Header
class_name SelectGame
extends RingSelect
#endregion


#region Signals
signal decision_made(selection: int)
signal game_paused()
#endregion


#region Enums
#endregion


#region Exports
#endregion


#region Values
const ROTATE_DEGREES:int = 90
var _mirror_shift: int	= 0 # 0=normal, 2=mirrors color
var _is_rotating: bool
#endregion


#region Built-Ins
func _ready() -> void:
	super()
	_is_rotating = Globals.get_option("rotate")
	_mirror_shift = 2 if Globals.get_option("mirror") else 0
#endregion


#region Public Functions
func play_list(list: Array[int]) -> void:
	_switch_buttons(false)
	
	var speed: float = Globals.get_speed()
	
	for index in list:
		var btn: OmnisButton = _buttons.get_child(index)
		await btn.simulate_press(speed)
		
	if _is_rotating:
		# Generates a -1 or +1 bitwise
		var direction: int = (randi_range(0, 1) << 1) - 1
		var times: int = randi_range(1, 3)
		await _rotate_buttons(ROTATE_DEGREES, direction, times, speed)
	await get_tree().create_timer(speed).timeout

	_switch_buttons(true)


func play_intro() -> void:
	_switch_buttons(false)
	var speed: float = Globals.get_speed() / 4
	for index in 5:
		var btn: OmnisButton = _buttons.get_child(index)
		await btn.simulate_press(speed)
	await get_tree().create_timer(speed).timeout
#endregion


#region Private Functions
func _on_option_picked(option: int, _state: bool):
	match(option):
		Globals.Colors.PURPLE:
			emit_signal(game_paused.get_name())
		_:
			emit_signal(decision_made.get_name(), option)


## Rotates the game ring by random 90 degrees
func _rotate_buttons(degrees: int, direction: int, times: int, speed: float) -> void:
	for n in times:
		var tweens: Array[Tween]
		for index in Globals.Colors.PURPLE:
			var btn: OmnisButton = _buttons.get_child(index)
			tweens.append(get_tree().create_tween())
			tweens[index].tween_property(btn, "rotation_degrees",
			btn.rotation_degrees + (direction * degrees), speed / 2)
		await tweens[Globals.Colors.GREEN].finished
		await get_tree().create_timer(speed / 4).timeout


func _switch_buttons(state: bool):
	for btn: OmnisButton in _buttons.get_children():
		btn.switch_state(state)
#endregion
