extends Node


@export var next_level_path = "res://scenes/hello_world.tscn"
@onready var loaded_packed_scene = load(next_level_path)

var total_pickup

func _ready():
	total_pickup = get_total_pickups()
	
func get_total_pickups():
	var pickup_nodes = get_tree().get_nodes_in_group(GroupNames.PickupGroup)
	var _total = pickup_nodes.size()
	print(_total)
	return _total
	
func check_if_win():
	await get_tree().create_timer(1.0).timeout
	total_pickup = get_total_pickups()
	print("Total Pickup " + str(total_pickup))
	if total_pickup < 1:
		print("player win")
		switch_to_next_level()



func switch_to_next_level():
	if loaded_packed_scene is PackedScene:
		print("attemp to load " + str(next_level_path))
		get_tree().change_scene_to_packed(loaded_packed_scene)
	else:
		printerr("wrong scene path")
