extends Node

#region Enums
enum Colors { BLUE, RED, YELLOW, GREEN, PURPLE }
#enum Cues { COLOR, AUDIO, SHAKE, HINTS }
#endregion Enums


#region Values
const BASE_DARKNESS: float = 0.2
const BASE_SPEED: float = 1
var settings: Dictionary[String, bool]
#endregion Values


#region Public Functions
func get_option(value: String) -> bool:
	for key: String in settings.keys():
		if key.containsn(value):
			return settings[key]
		
		var parts = key.split(" ", false, 1)
		if parts.size() == 2 and parts[1] == value:
			return settings[value]
	return false

func get_speed() -> float:
	if get_option("slower"):
		return BASE_SPEED * 2
	return BASE_SPEED


func save_game() -> void:
	pass


func load_game() -> void:
	pass
#endregion Public Functions
