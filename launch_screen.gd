extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$fader.visible = true
	$bg.texture = Global.active_game.hero
	$fader/AnimationPlayer.play("fade_in")
	$logo.texture = Global.active_game.logo
	$launch.position.y += $logo.texture.get_height()/2 + 100
	#$bg.scale.x = 
	$anim.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("back"):
		get_tree().change_scene_to_file("res://main.tscn")
	if Input.is_action_just_pressed("forward"):
		print("launching...")
		OS.create_process(Global.active_game.launch_path, [])
		$fader/AnimationPlayer.play("fade_out")
		await  $fader/AnimationPlayer.animation_finished
		$anim.show()
		$anim.play("normal")
