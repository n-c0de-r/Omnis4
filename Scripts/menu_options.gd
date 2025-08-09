extends Control

#region Values
var previous_menu: Control
#endregion Values


func _on_option_selected(option: int):
	visible = false
	match(option):
		Globals.Options.BLUE:
			print("up")
		Globals.Options.RED:
			print("right")
		Globals.Options.YELLOW:
			print("down")
		Globals.Options.GREEN:
			print("left")
		Globals.Options.PURPLE:
			Globals.switch_menu(self, previous_menu)


func _on_rotate_trial_toggled(_toggled_on: bool) -> void:
	print("up")


func _on_double_trial_toggled(_toggled_on: bool) -> void:
	print("right")


func _on_mirror_trial_toggled(_toggled_on: bool) -> void:
	print("down")


func _on_spiral_trial_toggled(_toggled_on: bool) -> void:
		print("left")


func _on_back_to_start_pressed() -> void:
	visible = false
	previous_menu.visible = true
