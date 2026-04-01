class_name game_tile

var name : String
var image_file_name : String
var categories : Array

func _init(name : String, image_file_name : String, categories : Array) -> void:
	self.name = name
	self.image_file_name = image_file_name
	self.categories = categories
	
