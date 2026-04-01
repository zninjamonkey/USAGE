extends Node2D

@onready var center_animation_player: AnimationPlayer = $"center tile/AnimationPlayer"
@onready var right_animation_player: AnimationPlayer = $"right tile/AnimationPlayer"
@onready var left_animation_player: AnimationPlayer = $"left tile/AnimationPlayer"

@onready var center_tile: Node2D = $"center tile"
@onready var right_tile: Node2D = $"right tile"
@onready var left_tile: Node2D = $"left tile"

#enum games {MINECRAFT, BOPL, HOGWARTS, PORTAL, WII_SPORTS}
var minecraft = game_tile.new("Minecraft", "minecraft.png", [0])
var bopl = game_tile.new("Bopl Battle", "bopl.png", [0])
var hogwarts = game_tile.new("Hogwarts Legacy", "hogwarts.jpg", [0])
var portal = game_tile.new("Portal", "portal.png", [0])
var sports = game_tile.new("Wii Sports", "wiisports.png", [0])
	
var title_reel = [minecraft, bopl, portal, sports, hogwarts]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$"center tile/cover".texture = load("res://title_images/" + portal.image_file_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("right"):
		center_animation_player.play("move_right")
		right_animation_player.play("move_right")
		left_animation_player.play("move_right")
	if Input.is_action_just_pressed("left"):
		center_animation_player.play("move_left")
		right_animation_player.play("move_left")
		left_animation_player.play("move_left")
		
