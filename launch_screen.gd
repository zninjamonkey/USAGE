extends Node2D

var pc = preload("res://platform_logos/pc.svg")
var steam = preload("res://platform_logos/steam.svg")
var epic = preload("res://platform_logos/epic.svg")
var gc = preload("res://platform_logos/gc.svg")
var wii = preload("res://platform_logos/wii.svg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$fader.visible = true
	$bg.texture = Global.active_game.hero
	#$fader/AnimationPlayer.play("fade_in")
	$logo.texture = Global.active_game.logo
	$logo/shadow.texture = Global.active_game.logo
	$sub_logo/Label.text = Global.active_game.description

	if Global.active_game.platform == Global.platform.PC:
		$sub_logo/platform.texture = pc
	elif Global.active_game.platform == Global.platform.STEAM:
		$sub_logo/platform.texture = steam
	elif Global.active_game.platform == Global.platform.EGS:
		$sub_logo/platform.texture = epic
	elif Global.active_game.platform == Global.platform.GC:
		$sub_logo/platform.texture = gc
	elif Global.active_game.platform == Global.platform.WII:
		$sub_logo/platform.texture = wii
	#$bg.scale.x = 
	$splash.hide()
	
	var width = $logo.get_rect().size.x
	var height = $logo.get_rect().size.y
	
	$logo.position = Vector2i(960, 150 + height/2)
	#$sub_logo.position.y += height
	#$sub_logo/Label.text = Global.active_game.description
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("back"):
		#get_tree().change_scene_to_file("res://main.tscn")
	if Input.is_action_just_pressed("forward"):
		print("launching...")
		OS.create_process(Global.active_game.launch_path, [])
		#$fader/AnimationPlayer.play("fade_out")
		Global.fader_animation.play("fade_out")
		await Global.fader_animation.animation_finished
		Global.fader_animation.play("fade_in")
		$splash.show()
		$splash/anim.play("normal")
