extends Control

#region Exports
@export var _new_game: PackedScene
@export var _modes_menu: Control
@export var _options_menu: Control
@export var _trials_menu: Control
#endregion Exports

var previous_menu: Control


func _on_section_selected(option: Globals.Options):
	visible = false
	match(option):
		Globals.Options.BLUE:
			get_tree().change_scene_to_packed(_new_game)
		Globals.Options.RED:
			Globals.switch_menu(self, _modes_menu)
		Globals.Options.YELLOW:
			Globals.switch_menu(self, _options_menu)
		Globals.Options.GREEN:
			Globals.switch_menu(self, _trials_menu)
		Globals.Options.PURPLE:
			get_tree().quit()
