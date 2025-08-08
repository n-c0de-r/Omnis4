extends Control

#region Values
var previous_menu: Control
#endregion Values


func _on_rotate_trial_toggled(_toggled_on: bool) -> void:
	Globals.flip_trial(Globals.Trials.ROTATE)


func _on_double_trial_toggled(_toggled_on: bool) -> void:
	Globals.flip_trial(Globals.Trials.DOUBLE)


func _on_mirror_trial_toggled(_toggled_on: bool) -> void:
	Globals.flip_trial(Globals.Trials.MIRROR)


func _on_spiral_trial_toggled(_toggled_on: bool) -> void:
	Globals.flip_trial(Globals.Trials.SPIRAL)


func _on_back_to_start_pressed() -> void:
	visible = false
	previous_menu.visible = true
