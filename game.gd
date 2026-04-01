class_name game_tile

var name : String
var image_file_name : String
var image : Texture2D
var categories : Array

func _init(name : String, image_file_name : String, categories : Array) -> void:
	self.name = name
	self.image_file_name = image_file_name
	self.categories = categories
	self.image = load("res://title_images/" + image_file_name)
	
