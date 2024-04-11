extends Node


@export var next_level_path = "res://scenes/hello_world.tscn"
@onready var loaded_packed_scene = load(next_level_path)

func _ready():
	switch_to_next_level()

func switch_to_next_level():
	if loaded_packed_scene is PackedScene:
		print("attemp to load " + str(next_level_path))
		get_tree().change_scene_to_packed(loaded_packed_scene)
	else:
		printerr("wrong scene path")
