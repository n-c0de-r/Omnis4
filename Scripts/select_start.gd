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
			await get_tree().create_timer(Globals.BASE_SPEED).timeout
			get_tree().change_scene_to_packed(_game_screen)
		Globals.Colors.RED:
			Globals.previous_menus.push_back(self)
			_switch_menu(self, _options[option])
		Globals.Colors.YELLOW:
			Globals.previous_menus.push_back(self)
			_switch_menu(self, _options[option])
		Globals.Colors.GREEN:
			Globals.previous_menus.push_back(self)
			_switch_menu(self, _options[option])
		Globals.Colors.PURPLE:
			get_tree().quit()
#endregion
