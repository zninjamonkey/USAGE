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
var bopl = game_tile.new("Bopl Battle", "bopl.png", [0])
var hogwarts = game_tile.new("Hogwarts Legacy", "hogwarts.jpg", [0])
var portal = game_tile.new("Portal", "portal.png", [0])
var sports = game_tile.new("Wii Sports", "wiisports.png", [0])
	
var title_reel : Array[game_tile] = [minecraft, bopl, portal, sports, hogwarts]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_textures()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(title_reel[0].name)
	if Input.is_action_pressed("left") and not center_animation_player.is_playing():
		#reset()
		center_animation_player.play("move_right")
		right_animation_player.play("move_right")
		left_animation_player.play("move_right")
		far_left_animation_player.play("move_right")
		far_right_animation_player.play("move_right")
		
		
	if Input.is_action_pressed("right") and not center_animation_player.is_playing():
		#reset()
		center_animation_player.play("move_left")
		right_animation_player.play("move_left")
		left_animation_player.play("move_left")
		far_right_animation_player.play("move_left")
		far_left_animation_player.play("move_left")
		


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
		$"far right tile".show()
		reset()
	elif anim_name == "move_right":
		title_reel.push_front(title_reel.pop_back())
		$"far left tile".show()
		reset()

func reset():
		_update_textures()

		center_animation_player.play("RESET")
		right_animation_player.play("RESET")
		left_animation_player.play("RESET")
		far_right_animation_player.play("RESET")
		far_left_animation_player.play("RESET")
		
		#await get_tree().create_timer(1).timeout
		
