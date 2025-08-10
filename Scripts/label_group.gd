#region Header
class_name LabelGroup
extends Control
#endregion


#region Signals
#endregion


#region Enums
#endregion


#region Exports
#endregion


#region Values
var _labels: Array[Label]
#endregion


#region Built-Ins
func _ready() -> void:
	_get_labels()
#endregion


#region Public Functions
func get_key(child: int) -> String:
	return _labels[child].text

func set_switch(child: int, state: bool) -> void:
	var switch: Label = _labels[child].get_child(0)
	if state:
		switch.text = switch.get_meta("on")
	else:
		switch.text = switch.get_meta("off")
#endregion


#region Private Functions
func _get_labels() -> void:
	for lbl: Label in get_children():
		_labels.append(lbl)
#endregion
