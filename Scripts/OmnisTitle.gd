extends Control

@export var new_game : PackedScene
@export var start_board: OmnisBoard
@export var modes_board: OmnisBoard
@export var trials_board: OmnisBoard
@export var options_board: OmnisBoard

func _ready() -> void:
	Globals.connect_signals(start_board, _evaluate_start)
	start_board.toggle_buttons(false)
	
	Globals.connect_signals(modes_board, _evaluate_modes)
	modes_board.toggle_buttons(true)
	modes_board.color_buttons[Globals.mode].set_pressed_no_signal(true)
	
	Globals.connect_signals(options_board, _evaluate_options)
	options_board.toggle_buttons(false)
	
	Globals.connect_signals(trials_board, _evaluate_trials)
	trials_board.toggle_buttons(true)
	for i in Globals.Trials.values():
		if (Globals.is_trial_set(i)):
			trials_board.color_buttons[i].set_pressed_no_signal(true)
	

# I'm really not proud of so much duplicate code...

func _evaluate_start(pressed: OmnisButton) -> void:
	match(pressed.get_index()):
		0: # new game
			get_tree().change_scene_to_packed(new_game)
		1: # modes menu
			start_board.visible = false
			modes_board.visible = true
		2: # options menu
			start_board.visible = false
			options_board.visible = true
		3: # trials menu
			start_board.visible = false
			trials_board.visible = true
		4: # quit game
			get_tree().quit()
	pressed.disabled = false

func _evaluate_modes(pressed: OmnisButton) -> void:
	modes_board.toggle_buttons(true)
	modes_board.color_buttons[Globals.mode].set_pressed_no_signal(true)
	
	match(pressed.get_index()):
		0: # Normal
			pressed.set_pressed_no_signal(true)
			Globals.mode = Globals.Modes.NORMAL
		1: # Reverse
			pressed.set_pressed_no_signal(true)
			Globals.mode = Globals.Modes.REVERSE
		2: # Flip
			pressed.set_pressed_no_signal(true)
			Globals.mode = Globals.Modes.FLIP
		3: # Random
			pressed.set_pressed_no_signal(true)
			Globals.mode = Globals.Modes.RANDOM
		4: # Back
			modes_board.visible = false
			start_board.visible = true

func _evaluate_options(pressed: OmnisButton) -> void:
	match(pressed.get_index()):
		0: # option1
			pass
		1: # option2
			pass
		2: # option3
			pass
		3: # option4
			pass
		4: # Back
			options_board.visible = false
			start_board.visible = true

func _evaluate_trials(pressed: OmnisButton) -> void:
	match(pressed.get_index()):
		0: # Rotate
			pass
		1: # Double
			pass
		2: # Mirror
			pass
		3: # Spiral
			pass
		4: # Back
			trials_board.visible = false
			start_board.visible = true
