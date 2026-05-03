class_name game_tile

var name : String
var image_file_name : String
var image : Texture2D
var categories : Array
var blurred_hero : Texture2D
var hero : Texture2D
var logo : Texture2D
var launch_path : String
var description : String
var platform : Global.platform

func _init(name : String, image_file_name : String, categories : Array, launch_path : String = "", description : String = "", platform : Global.platform = Global.platform.PC) -> void:
	self.name = name
	self.image_file_name = image_file_name
	self.categories = categories
	self.launch_path = launch_path
	self.image = load("res://title_images/" + image_file_name)
	self.description = description
	self.platform = platform
	
	var hero_temp = load("res://hero_images/" + image_file_name).get_image()
	var blur_temp = Image.new()
	blur_temp.copy_from(hero_temp)
	var ratio = float(hero_temp.get_width()) / hero_temp.get_height()
	hero_temp.resize(ratio * 1080, 1080)
	self.hero = ImageTexture.create_from_image(hero_temp)
	#self.blurred_hero = Texture2D.new()
	#var blur_temp = image.get_image()
	var blur_strength = 30
	blur_temp.resize(blur_temp.get_width()/blur_strength, blur_temp.get_height()/blur_strength, Image.INTERPOLATE_LANCZOS)
	blur_temp.resize(ratio * 1080, 1080, Image.INTERPOLATE_LANCZOS)
	self.blurred_hero = ImageTexture.create_from_image(blur_temp)
	
	var logo_temp : Image = load("res://logo_images/" + image_file_name).get_image()
	var logo_ratio = float(logo_temp.get_width()) / logo_temp.get_height()
	print(image_file_name + " " + str(logo_ratio))
	print()
	logo_temp.resize(900, 900 / logo_ratio, Image.INTERPOLATE_LANCZOS)
	self.logo = ImageTexture.create_from_image(logo_temp)
	
