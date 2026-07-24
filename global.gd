extends Node

var active_game : game_title
var fader_animation : AnimationPlayer

enum platform {STEAM, EGS, PC, WII, WIIU, GC, SNES, NES}
enum esrb {E, E10, T, M}

var executable_dir : String = OS.get_executable_path().get_base_dir()
var config

func _ready() -> void:
	print("Test")
	
	print(executable_dir)
	
	var configuration_file = FileAccess.open(executable_dir + "/conf.json", FileAccess.READ)
	print(configuration_file.get_as_text())
	
	var json = JSON.new()
	var error = json.parse(configuration_file.get_as_text())
	if error == OK:
		config = json.data
	else:
		print("Config Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
