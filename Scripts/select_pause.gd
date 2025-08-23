#region Header
class_name SelectPause
extends RingSelect
#endregion


#region Signals
signal restart_game()
signal resume_game()
#endregion


#region Enums
#endregion


#region Exports
#@export var _start_screen: PackedScene
#endregion


#region Values
#endregion


#region Built-Ins
#endregion


#region Public Functions
#endregion


#region Private Functions
func _on_option_picked(option: int, _state: bool):
	match(option):
		Globals.Colors.BLUE:
			emit_signal(restart_game.get_name())
		Globals.Colors.RED:
			get_tree().paused = false
			# I don't like this, but apparently needed to avoid cyclic dependency
			var res: Resource = load("res://Scenes/omnis_title.tscn")
			get_tree().change_scene_to_packed(res)
		Globals.Colors.YELLOW:
			Globals.previous_menus.push_back(self)
			_switch_menu(self, _options[0])
		Globals.Colors.GREEN:
			emit_signal(resume_game.get_name())
#endregion
