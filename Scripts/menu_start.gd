extends Control

#region Exports
@export var _new_game: PackedScene
@export var _modes_menu: Control
@export var _options_menu: Control
@export var _trials_menu: Control
#endregion Exports


#region Values
var previous_menu: Control
#endregion Values


func _on_option_up_pressed() -> void:
	get_tree().change_scene_to_packed(_new_game)


func _on_option_right_pressed() -> void:
	visible = false
	_modes_menu.visible = true
	_modes_menu.previous_menu = self


func _on_option_down_pressed() -> void:
	visible = false
	_options_menu.visible = true
	_options_menu.previous_menu = self


func _on_option_left_pressed() -> void:
	visible = false
	_trials_menu.visible = true
	_trials_menu.previous_menu = self


func _on_menu_middle_pressed() -> void:
	get_tree().quit()
