extends Control

#region Values
var previous_menu: Control
#endregion Values


func _on_mode_selected(_toggled: bool, option: Globals.Options):
	match(option):
		Globals.Options.PURPLE:
			Globals.switch_menu(self, previous_menu)
		_:
			Globals.mode = option
