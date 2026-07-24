extends Node2D

@onready var center_animation_player: AnimationPlayer = $"base_layer/center tile/AnimationPlayer"
@onready var right_animation_player: AnimationPlayer = $"base_layer/right tile/AnimationPlayer"
@onready var left_animation_player: AnimationPlayer = $"base_layer/left tile/AnimationPlayer"
@onready var far_right_animation_player: AnimationPlayer = $"base_layer/far right tile/AnimationPlayer"
@onready var far_left_animation_player: AnimationPlayer = $"base_layer/far left tile/AnimationPlayer"


@onready var center_tile: Node2D = $"base_layer/center tile"
@onready var right_tile: Node2D = $"base_layer/right tile"
@onready var left_tile: Node2D = $"base_layer/left tile"

var launch_screen_layer = preload("res://launch_screen.tscn")
var launch_screen : Node2D


#enum games {MINECRAFT, BOPL, HOGWARTS, PORTAL, WII_SPORTS}
#var minecraft = game_title.new("Minecraft", "minecraft.png", [0], "", "Classic 3D Sandbox Block Game", Global.platform.PC)
#var bopl = game_title.new("Bopl Battle", "bopl.png", [0], "C:\\Program Files (x86)\\Steam\\steamapps\\common\\Bopl Battle\\BoplBattle.exe", "Chaotic Party Battle Game", Global.platform.STEAM)
#var hogwarts = game_title.new("Hogwarts Legacy", "hogwarts.png", [0], "", "Stunning Open-World RPG In The Wizarding World Of Harry Potter", Global.platform.EGS)
#var portal = game_title.new("Portal", "portal.png", [0], "D:\\SteamLibrary\\steamapps\\common\\Portal 2\\portal2.exe", "Portal Game", Global.platform.STEAM)
#var sports = game_title.new("Wii Sports", "wiisports.png", [0], "", "Legendary Sports Game With Motion Controls", Global.platform.WII)
	
#var title_reel : Array[game_tile] = [minecraft, bopl, portal, sports, hogwarts]
var title_reel : Array[game_title]

var active : bool = true

enum layer {BASE, LAUNCH}
var active_layer : layer = layer.BASE

func _load_config():
	for game_config in Global.config.games:
		var name = game_config.name
		var file_name = game_config.file_name
		var categories = game_config.categories
		var launch_path = game_config.launch_path
		var description = game_config.description
		var year : int = game_config.year
		
		var platform
		match game_config.platform:
			"PC": platform = Global.platform.PC
			"EGS": platform = Global.platform.EGS
			"STEAM": platform = Global.platform.STEAM
			"WII": platform = Global.platform.WII
			"GC": platform = Global.platform.GC
		var esrb
		match game_config.esrb:
			"E" : esrb = Global.esrb.E
			"E10" : esrb = Global.esrb.E10
			"T" : esrb = Global.esrb.T
			"M" : esrb = Global.esrb.M
		var game = game_title.new(name, file_name, categories, launch_path, description, platform, esrb, year)
		title_reel.append(game)
		print(game_config)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_load_config()	
	_update_textures()
	
	Global.fader_animation = $fader/AnimationPlayer
	$fader.show()
	$fader/AnimationPlayer.play("start")
	
	var animation_speed = 4.0
	
	center_animation_player.speed_scale = animation_speed
	right_animation_player.speed_scale = animation_speed
	left_animation_player.speed_scale = animation_speed
	far_right_animation_player.speed_scale = animation_speed
	far_left_animation_player.speed_scale = animation_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$base_layer/Time.text = Time.get_time_string_from_system()
	#print(title_reel[0].name)
	if active_layer == layer.BASE:
		if Input.is_action_pressed("left") and active:
			active = false
			#reset()
			center_animation_player.play("move_right")
			right_animation_player.play("move_right")
			left_animation_player.play("move_right")
			far_left_animation_player.play("move_right")
			far_right_animation_player.play("move_right")
			
		if Input.is_action_pressed("right") and active:
			active = false
			#reset()
			center_animation_player.play("move_left")
			right_animation_player.play("move_left")
			left_animation_player.play("move_left")
			far_right_animation_player.play("move_left")
			far_left_animation_player.play("move_left")
		
		if Input.is_action_just_pressed("forward") and active:
			Global.active_game = title_reel[0]
			$fader/AnimationPlayer.play("fade_out")
			await $fader/AnimationPlayer.animation_finished
			#get_tree().change_scene_to_file("res://launch_screen.tscn")
			launch_screen = launch_screen_layer.instantiate()
			add_child(launch_screen)
			$fader/AnimationPlayer.play("fade_in")
			active_layer = layer.LAUNCH
	
	if Input.is_action_just_pressed("back"):
		if launch_screen != null:
			$fader/AnimationPlayer.play("fade_out")
			await $fader/AnimationPlayer.animation_finished
			launch_screen.queue_free()
			launch_screen = null
			active_layer = layer.BASE
			$fader/AnimationPlayer.play("fade_in")


func _update_textures() -> void:
	#$"center tile/cover".texture = load("res://title_images/" + title_reel[0].image_file_name)
	#$"right tile/cover".texture = load("res://title_images/" + title_reel[1].image_file_name)
	#$"left tile/cover".texture = load("res://title_images/" + title_reel[-1].image_file_name)
	#$"far left tile/cover".texture = load("res://title_images/" + title_reel[-2].image_file_name)
	#$"far right tile/cover".texture = load("res://title_images/" + title_reel[2].image_file_name)

	$"base_layer/center tile/cover".texture = title_reel[0].image
	$"base_layer/right tile/cover".texture = title_reel[1].image
	$"base_layer/left tile/cover".texture = title_reel[-1].image
	$"base_layer/far left tile/cover".texture = title_reel[-2].image
	$"base_layer/far right tile/cover".texture = title_reel[2].image
	


func _on_center_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move_left":
		title_reel.push_back(title_reel.pop_front())
		#$"far right tile".show()
		reset()
		active = true
	elif anim_name == "move_right":
		title_reel.push_front(title_reel.pop_back())
		#$"far left tile".show()
		reset()
		active = true

func reset():

		center_animation_player.play("RESET")
		center_animation_player.advance(0)
		right_animation_player.play("RESET")
		right_animation_player.advance(0)
		left_animation_player.play("RESET")
		left_animation_player.advance(0)
		far_right_animation_player.play("RESET")
		far_right_animation_player.advance(0)
		far_left_animation_player.play("RESET")
		far_left_animation_player.advance(0)
		
		#await get_tree().create_timer(0.1).timeout
		
		_update_textures()

		
