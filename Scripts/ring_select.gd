#region Header
class_name RingSelect
extends Control
#endregion


#region Signals
#endregion


#region Enums
#endregion


#region Exports
@export var _options: Array[RingSelect]
@export var _sounds: Array[AudioStreamOggVorbis]
#endregion


#region Values
@onready var _buttons: Control = $Buttons
@onready var _labels: LabelGroup = $Labels
var previous_menu: RingSelect
var _option_buttons: Array[OmnisButton]
#endregion


#region Built-Ins
func _ready() -> void:
	_connect_signals()
	_set_sounds()
#endregion


#region Public Functions
#endregion


#region Private Functions
func _on_option_picked(option: int, _state: bool):
	match(option):
		Globals.Colors.PURPLE:
			_switch_menu(self, previous_menu)
		_:
			Globals.switch_menu(self, _options[option])


func _switch_menu(current: Control, next: Control):
	current.visible = false
	next.visible = true
	next.previous_menu = current


## Connects a selected board's child buttons to it's current parent object
func _connect_signals() -> void:
	for btn: OmnisButton in _buttons.get_children():
		btn.option_picked.connect(_on_option_picked)


func _set_sounds() -> void:
	for btn: OmnisButton in _buttons.get_children():
		btn.set_sound(_sounds[btn.get_index()])
#endregion
