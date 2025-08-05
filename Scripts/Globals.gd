extends Node

enum colors { BLUE, RED, YELLOW, GREEN }
@export_range(1, 5, 1) var timer: int
@export_range(0.1, 0.9, 0.1) var effect: float
@export_range(0, 100, 1) var volume: int = 50

var doubleCounter:	int	= 1 # 1=normal, 2=doubles each button
var mirrorShift:	int	= 0 # 0=normal, 2=mirrors color
var spiralCounter:	int	= 1 # 1=normal, increases every round
var timerFactor:	int	= 1 # 1=normal, 2=doubles animation time
var playDirection:	int	= 1 # 1=normal (forward), -1=reverse

## Connects a selected board's child buttons to it's current parent object
func connect_signals(board: OmnisBoard, execute: Callable) -> void:
	for btn: OmnisButton in board.buttons_ring.get_children():
		btn.omnis_button.connect(execute)
	board.mid.omnis_button.connect(execute)

## Generates a -1 or +1 only
func randomOne() -> int:
	randomize()
	return (randi()%2) * 2 - 1
