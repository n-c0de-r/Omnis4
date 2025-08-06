extends Control
class_name OmnisBoard

#region Exports
@export var buttons_ring: Control
@export_group("Buttons")
@export_subgroup("Colors")
@export var buttons: Array[OmnisButton]
@export_subgroup("")
@export var mid: OmnisButton
#endregion Exports

#region Values
const ROTATE_DEGREES:int = 90
#endregion Values

#region Public Functions
func toggle_ring(state: bool):
	mid.disabled = not state
	for btn in buttons:
		btn.disabled = not state

## Rotates the game ring by random 90 degrees
func rotate() -> void:
	var tween = get_tree().create_tween()
	# Generates a -1 or +1 only
	var dir: int = (randi_range(0, 1) << 1) - 1
	tween.tween_property(self, "rotation_degrees", self.rotation_degrees + (dir*ROTATE_DEGREES), Globals.speed)
#endregion Public Functions
