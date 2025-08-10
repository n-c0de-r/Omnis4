#region Header
class_name SelectStart
extends RingSelect
#endregion


#region Signals
#endregion


#region Enums
#endregion


#region Exports
@export var _game_screen: PackedScene
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
			get_tree().change_scene_to_packed(_game_screen)
		Globals.Colors.RED:
			_switch_menu(self, _options[option])
		Globals.Colors.YELLOW:
			_switch_menu(self, _options[option])
		Globals.Colors.GREEN:
			_switch_menu(self, _options[option])
		Globals.Colors.PURPLE:
			get_tree().quit()
#endregion
