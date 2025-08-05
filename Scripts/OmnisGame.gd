extends Control
class_name OmnisGame

@export var board: OmnisBoard

var BUTTON_COUNT: int
var BUTTON_LIST: Array[OmnisButton]
var show_list: Array[OmnisButton]
var guess_list: Array[OmnisButton]
var current_round: int = 0
var check_index: int = 0

func _ready() -> void:
	Globals.connect_signals(board, _evaluate)
	board.toggle_ring(false)
	_setButtons()

## Sets options for the buttons
func _setButtons() -> void:
	BUTTON_COUNT = board.buttons_ring.get_child_count()
	for btn: OmnisButton in board.buttons_ring.get_children():
		btn._simulatePress(0.5,0.2)
		BUTTON_LIST.append(btn)
		await get_tree().create_timer(0.2).timeout
		
	_getNextColor()

## Generates a new color to guess
func _getNextColor():
	randomize()
	# Get next button for replay
	var next: OmnisButton
	var index: int = randi_range(0, BUTTON_COUNT-1)
	
	# Gets shifted button for guessing if needed
	if (Globals.mirrorShift == 2):
		next = BUTTON_LIST[(index + Globals.mirrorShift) % BUTTON_COUNT]
	else:
		next = BUTTON_LIST[index]
	show_list.append(next)
	guess_list.append(next)
	
	# Get amount of presses of each button
	if (Globals.doubleCounter == 2):
		guess_list.append(next)
	# Play the visible list
	#$Buttons.playList(buttonList)
	_play_list()

func _play_list()-> void:
	board.toggle_ring(false)
	for btn in show_list:
		btn._simulatePress(1, 0.2)
		await get_tree().create_timer(2).timeout
	
func _evaluate(origin: OmnisButton) -> void:
	if (guess_list[check_index] == origin):
		check_index+=1
		origin.disabled = false
	else:
		check_index=0
		_play_list()
	
	if (check_index >= guess_list.size()):
		check_index=0
		_getNextColor()
