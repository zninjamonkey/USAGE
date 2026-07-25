extends Node2D

var pc = preload("res://platform_logos/pc.svg")
var steam = preload("res://platform_logos/steam.svg")
var epic = preload("res://platform_logos/epic.svg")
var gc = preload("res://platform_logos/gc.svg")
var wii = preload("res://platform_logos/wii.svg")

var e_texture = preload("res://esrb_images/250px-ESRB_Everyone.svg.png")
var e10_texture = preload("res://esrb_images/250px-ESRB_Everyone_10+.svg.png")
var t_texture = preload("res://esrb_images/250px-ESRB_Teen.svg.png")
var m_texture = preload("res://esrb_images/250px-ESRB_Mature_17+.svg.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$fader.visible = true
	$bg.texture = Global.active_game.hero
	#$fader/AnimationPlayer.play("fade_in")
	$logo.texture = Global.active_game.logo
	$logo/shadow.texture = Global.active_game.logo
	$sub_logo/Label.text = str(Global.active_game.year) + " | " + Global.active_game.description
	$sub_logo/year.text = str(Global.active_game.year)
	match Global.active_game.esrb:
		Global.esrb.E : $sub_logo/esrb.texture = e_texture
		Global.esrb.E10 : $sub_logo/esrb.texture = e10_texture
		Global.esrb.T : $sub_logo/esrb.texture = t_texture
		Global.esrb.M : $sub_logo/esrb.texture = m_texture

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
		Global.active_game_pid = OS.create_process(Global.active_game.launch_path, [])
		#$fader/AnimationPlayer.play("fade_out")
		Global.fader_animation.play("fade_out")
		await Global.fader_animation.animation_finished
		Global.fader_animation.play("fade_in")
		$splash.show()
		$splash/anim.play("normal")
