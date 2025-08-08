extends TextureButton

signal omnis_pressed(button: TextureButton)

var _original_color: Color

func _ready():
	_original_color = self_modulate

func _input(event: InputEvent) -> void:
	if(event is InputEventMouseButton and button_pressed):
		emit_signal(omnis_pressed.get_name(), self)

func _simulatePress(speed: float, strength: float) -> void:
	self_modulate = _original_color.darkened(strength)
	await get_tree().create_timer(speed).timeout
	self_modulate = _original_color
	await get_tree().create_timer(speed).timeout
	self_modulate = _original_color.darkened(strength)
