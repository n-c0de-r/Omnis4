extends TextureButton

#region Exports
@export var _icon: TextureRect
@export var _icon_on: Texture2D
@export var _icon_off: Texture2D
@export var _state: Label
#endregion Exports


#region Built-Ins
func _ready() -> void:
	_state.visible = toggle_mode
	_on_toggled(button_pressed)
#endregion Built-Ins


#region Private Functions
func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_icon.texture = _icon_on
		_state.text = get_meta("on")
	else:
		_icon.texture = _icon_off
		_state.text = get_meta("off")
#endregion Public Functions
