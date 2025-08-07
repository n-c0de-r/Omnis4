extends Control

#region Values
var previous_menu: Control
#endregion Values


func _on_normal_mode_toggled(_toggled_on: bool) -> void:
	Globals.mode = Globals.Modes.NORMAL
	print(Globals.mode)


func _on_reverse_mode_toggled(_toggled_on: bool) -> void:
	Globals.mode = Globals.Modes.REVERSE
	print(Globals.mode)


func _on_flip_mode_toggled(_toggled_on: bool) -> void:
	Globals.mode = Globals.Modes.FLIP
	print(Globals.mode)


func _on_random_mode_toggled(_toggled_on: bool) -> void:
	Globals.mode = Globals.Modes.RANDOM
	print(Globals.mode)


func _on_back_to_start_pressed() -> void:
	visible = false
	previous_menu.visible = true
