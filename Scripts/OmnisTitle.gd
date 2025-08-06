extends Control

@export var new_game : PackedScene
@export var start_board: OmnisBoard

func _ready() -> void:
	Globals.connect_signals(start_board, _evaluate_start)

func _evaluate_start(pressed: OmnisButton) -> void:
	pass
