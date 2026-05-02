extends Node2D

@onready var center_animation_player: AnimationPlayer = $"center tile/AnimationPlayer"
@onready var right_animation_player: AnimationPlayer = $"right tile/AnimationPlayer"
@onready var left_animation_player: AnimationPlayer = $"left tile/AnimationPlayer"
@onready var far_right_animation_player: AnimationPlayer = $"far right tile/AnimationPlayer"
@onready var far_left_animation_player: AnimationPlayer = $"far left tile/AnimationPlayer"


@onready var center_tile: Node2D = $"center tile"
@onready var right_tile: Node2D = $"right tile"
@onready var left_tile: Node2D = $"left tile"

#enum games {MINECRAFT, BOPL, HOGWARTS, PORTAL, WII_SPORTS}
var minecraft = game_tile.new("Minecraft", "minecraft.png", [0])
var bopl = game_tile.new("Bopl Battle", "bopl.png", [0], "C:\\Program Files (x86)\\Steam\\steamapps\\common\\Bopl Battle\\BoplBattle.exe")
var hogwarts = game_tile.new("Hogwarts Legacy", "hogwarts.png", [0])
var portal = game_tile.new("Portal", "portal.png", [0])
var sports = game_tile.new("Wii Sports", "wiisports.png", [0])
	
var title_reel : Array[game_tile] = [minecraft, bopl, portal, sports, hogwarts]
var active : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_textures()
	$fader/AnimationPlayer.play("start")
	
	var animation_speed = 4.0
	
	center_animation_player.speed_scale = animation_speed
	right_animation_player.speed_scale = animation_speed
	left_animation_player.speed_scale = animation_speed
	far_right_animation_player.speed_scale = animation_speed
	far_left_animation_player.speed_scale = animation_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Time.text = Time.get_time_string_from_system()
	#print(title_reel[0].name)
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
		get_tree().change_scene_to_file("res://launch_screen.tscn")



func _update_textures() -> void:
	#$"center tile/cover".texture = load("res://title_images/" + title_reel[0].image_file_name)
	#$"right tile/cover".texture = load("res://title_images/" + title_reel[1].image_file_name)
	#$"left tile/cover".texture = load("res://title_images/" + title_reel[-1].image_file_name)
	#$"far left tile/cover".texture = load("res://title_images/" + title_reel[-2].image_file_name)
	#$"far right tile/cover".texture = load("res://title_images/" + title_reel[2].image_file_name)

	$"center tile/cover".texture = title_reel[0].image
	$"right tile/cover".texture = title_reel[1].image
	$"left tile/cover".texture = title_reel[-1].image
	$"far left tile/cover".texture = title_reel[-2].image
	$"far right tile/cover".texture = title_reel[2].image
	


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

		
