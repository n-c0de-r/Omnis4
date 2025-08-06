extends Node

#region Exports
@export_range(1, 5, 1) var speed: int = 3
#endregion Exports

#region Enums
enum Modes { NORMAL, REVERSE, FLIP, RANDOM }
enum Trials { ROTATE, DOUBLE, MIRROR, SPIRAL }
enum Cues { COLOR, AUDIO, SYMBOL, SHAKE }
enum Sounds { ORIGINAL, INSTUMENT, VOICE, ANIMAL }
enum Symbols { CLEAR, ARROWS, SHAPES, ANIMALS }
#endregion Enums

#region Values
var mode: int = Modes.NORMAL
var trial: int = 0
var cue: int = Cues.COLOR
var sound: int = Sounds.ORIGINAL
var symbol: int = Symbols.CLEAR
#endregion Values

#region Public Functions
## Connects a selected board's child buttons to it's current parent object
func connect_signals(board: OmnisBoard, execute: Callable) -> void:
	for btn: OmnisButton in board.buttons_ring.get_children():
		btn.omnis_button.connect(execute)
	board.mid.omnis_button.connect(execute)

func save_game() -> void:
	pass

func load_game() -> void:
	pass
#endregion Public Functions
