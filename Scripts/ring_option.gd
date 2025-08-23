#region Header
class_name RingOption
extends RingSelect
#endregion


#region Signals
#endregion


#region Enums
#endregion


#region Exports
#endregion


#region Values
var _previous_selection: int = -1
#endregion


#region Built-Ins
#endregion


#region Public Functions
#endregion


#region Private Functions
func _on_option_picked(option: int, state: bool):
	#if Globals.get_option("speech"):
		#if _previous_selection != option:
			#_previous_selection = option
			#return
	
	match(option):
		Globals.Colors.PURPLE:
			#_switch_menu(self, previous_menu)
			_switch_menu(self, Globals.previous_menus.pop_back())
		_:
			var key: String = self.name + " " + _labels.get_key(option)
			Globals.settings[key] = state
			_labels.set_switch(option, state)
	#_previous_selection = -1
#endregion
