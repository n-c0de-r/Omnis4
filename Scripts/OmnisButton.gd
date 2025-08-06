extends TextureButton
class_name OmnisButton

signal omnis_pressed

var original_color: Color

func _ready():
	original_color = self_modulate

func _input(event: InputEvent) -> void:
	if(event is InputEventMouseButton and button_pressed):
		disabled = true
		emit_signal(omnis_pressed.get_name(), self)

func _simulatePress(speed: float, strength: float) -> void:
	disabled = true
	self_modulate = original_color.darkened(strength)
	await get_tree().create_timer(speed).timeout
	self_modulate = original_color
	await get_tree().create_timer(speed).timeout
	self_modulate = original_color.darkened(strength)
	disabled = false
