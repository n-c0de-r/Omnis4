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
#endregion


#region Built-Ins
#endregion


#region Public Functions
#endregion


#region Private Functions
func _on_option_picked(option: int, state: bool):
	match(option):
		Globals.Colors.PURPLE:
			_switch_menu(self, previous_menu)
		_:
			var key: String = self.name + " " + _labels.get_key(option)
			Globals.settings[key] = state
			_labels.set_switch(option, state)
#endregion
