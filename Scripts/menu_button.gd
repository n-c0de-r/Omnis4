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

func _process(_delta: float) -> void:
	if button_pressed:
		_icon.texture = _icon_on
		_state.text = "on"
	else:
		_icon.texture = _icon_off
		_state.text = "off"
#endregion Built-Ins
