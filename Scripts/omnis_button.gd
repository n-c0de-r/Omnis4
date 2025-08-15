#region Header
extends TextureButton
class_name OmnisButton
#endregion


#region Signals
signal option_picked(option: int, state: bool)
#endregion


#region Enums
#endregion


#region Exports
@export var _option: Globals.Colors
@export var _icon_off: CompressedTexture2D
@export var _icon_on: CompressedTexture2D
@export_color_no_alpha var _icon_color: Color
@export var _shape_texture: CompressedTexture2D
#endregion


#region Values
@onready var _icon: TextureRect = $Icon
@onready var _shape: TextureRect = $Mask/Shape
var _icon_dark: Color
var _shape_color: Color
#endregion


#region Built-Ins
func _ready() -> void:
	_icon.texture = _icon_off
	_icon.self_modulate = _icon_color
	_icon_dark = _icon_color.darkened(0.5)
	_shape.texture = _shape_texture
	_shape_color = self_modulate
	_shape.self_modulate = self_modulate
#endregion


#region Public Functions
func switch_state(state: bool) -> void:
	disabled = not state
	_icon.self_modulate = _icon_color if state else _icon_dark
	_shape.self_modulate = _shape_color.darkened(0.5) if state else _shape_color.darkened(0.8)


func simulate_press(speed: float) -> void:
	var temp: Texture2D = texture_disabled
	await get_tree().create_timer(speed).timeout
	texture_disabled = texture_pressed
	_icon.self_modulate = _icon_color
	_shape.self_modulate = _shape_color.darkened(0.2)
	await get_tree().create_timer(speed).timeout
	texture_disabled = temp
	_icon.self_modulate = _icon_dark
	_shape.self_modulate = _shape_color.darkened(0.8)
#endregion


#region Private Functions
func _on_button_down() -> void:
	if toggle_mode:
		return
	_shape.self_modulate = _shape_color.darkened(0.2)


func _on_pressed() -> void:
	if toggle_mode:
		return
	_icon.self_modulate = _icon_color
	_shape.self_modulate = _shape_color.darkened(0.5)
	emit_signal(option_picked.get_name(), _option, true)


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_icon.self_modulate = _icon_color
		_icon.texture = _icon_on
		_shape.self_modulate = _shape_color.darkened(0.2)
	else:
		_icon.self_modulate = _icon_dark
		_icon.texture = _icon_off
		_shape.self_modulate = _shape_color.darkened(0.5)
	
	emit_signal(option_picked.get_name(),_option, toggled_on)
#endregion
