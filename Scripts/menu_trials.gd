extends Control

#region Values
var previous_menu: Control
#endregion Values


func _on_trial_selected(_toggled: bool, option: int):
	match(option):
		Globals.Options.PURPLE:
			Globals.switch_menu(self, previous_menu)
		_:
			Globals.flip_trial(option)
