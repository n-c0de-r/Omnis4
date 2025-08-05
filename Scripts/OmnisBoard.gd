extends Control
class_name OmnisBoard

@export var buttons_ring: Control
@export_group("Buttons")
@export_subgroup("Colors")
@export var buttons: Array[OmnisButton]
@export_subgroup("")
@export var mid: OmnisButton

func toggle_ring(state: bool):
	mid.disabled = not state
	for btn in buttons:
		btn.disabled = not state

## Totates the game ring
## deg: degrees
func rotate(deg: int, speed: int) -> void:
	buttons_ring.rotation_degrees = buttons_ring.rotation + deg
	print_debug(buttons_ring.rotation)
