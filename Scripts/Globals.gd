extends Node

#region Enums
enum Modes { NORMAL, REVERSE, FLIP, RANDOM }
enum Trials { ROTATE, DOUBLE, MIRROR, SPIRAL }
enum Cues { COLOR, AUDIO, SYMBOL, SHAKE }
enum Sounds { ORIGINAL, INSTUMENT, VOICE, ANIMAL }
enum Symbols { CLEAR, ARROWS, SHAPES, ANIMALS }
#endregion Enums


#region Values
var speed: float = 1.0
var effect: float = 0.2
var mode: int = Modes.NORMAL
var trial: int = 0
var cue: int = Cues.COLOR
var sound: int = Sounds.ORIGINAL
var symbol: int = Symbols.CLEAR
#endregion Values


#region Public Functions
## Connects a selected board's child buttons to it's current parent object
func connect_signals(board: Control, execute: Callable) -> void:
	for btn: TextureButton in board.color_buttons:
		btn.omnis_pressed.connect(execute)


func set_trial_bit(shift: Trials) -> void:
	trial |= ~(1 << shift)


func get_trial_bit(check: Trials) -> int:
	return ((trial & (1 << check)) >> 1)


func clear_trial_bit(shift: Trials) -> void:
	trial &= ~(1 << shift)


func flip_trial(check: Trials) -> void:
	trial ^= (1 << check)


func get_trial_value(check: Trials) -> int:
	return (trial & (1 << check))


func is_trial_set(check: Trials) -> bool:
	return !!(trial & (1 << check))


func save_game() -> void:
	pass


func load_game() -> void:
	pass
#endregion Public Functions
