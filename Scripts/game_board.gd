extends Control

#region Exports
@export_group("Buttons")
@export var buttons_ring: Control
@export var color_buttons: Array[TextureButton]
@export var mid_button: TextureButton

@export_group("Icons", "icon_")
@export var icon_tex_rects: Array[TextureRect]
@export var icon_textures: Array[Texture2D]

@export_group("Texts", "text_")
@export var text_labels: Array[Label]
@export var text_strings: Array[String]
#endregion Exports

#region Values
const ROTATE_DEGREES:int = 90
var ring_tween: Tween
var has_tweened = false
#endregion Values

#region Built-Ins
func _ready() -> void:
	for i in color_buttons.size():
			#icon_textures[i].global_position = color_buttons[i].get_icon_position()
			#text_labels[i].position = text_positions[i].position - (text_labels[i].size / 2)
			
			text_labels[i].text = text_strings[i]
			color_buttons[i].name = text_strings[i]

func _process(_delta: float) -> void:
	if (not (ring_tween == null) and not ring_tween.is_running()):
		ring_tween.kill()
		ring_tween = null
		has_tweened = false
		disable_ring(false)
	
	if (has_tweened):
		for i in color_buttons.size():
			#icon_textures[i].global_position = color_buttons[i].get_icon_position()
			#text_labels[i].global_position = text_positions[i].global_position - (text_labels[i].size / 2)
			pass
#endregion

#region Public Functions
func disable_ring(state: bool):
	for btn in color_buttons:
		btn.disabled = state

## Rotates the game ring by random 90 degrees
func rotate() -> void:
	disable_ring(true)
	ring_tween = get_tree().create_tween()
	# Generates a -1 or +1 only
	var dir: int = (randi_range(0, 1) << 1) - 1
	ring_tween.tween_property(buttons_ring, "rotation_degrees", buttons_ring.rotation_degrees + (dir*ROTATE_DEGREES), Globals.speed)
	has_tweened = true
	
#endregion Public Functions
