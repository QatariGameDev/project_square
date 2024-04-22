extends Node
class_name LevelManager

@export var next_level_path = "res://scenes/hello_world.tscn"
@onready var loaded_packed_scene = load(next_level_path)

var total_pickup: int
var current_total_pickup: int
signal pickup_updated(current_total_pickup, total_pickup)

func _ready():
	total_pickup = get_total_pickups()
	current_total_pickup = 0
	pickup_updated.emit(current_total_pickup, total_pickup)
	
func get_total_pickups():
	var pickup_nodes = get_tree().get_nodes_in_group(GroupNames.PickupGroup)
	var _total = pickup_nodes.size()
	return _total
	
func check_if_win():
	current_total_pickup += 1
	pickup_updated.emit(current_total_pickup, total_pickup)
	if current_total_pickup == total_pickup:
		print("player win")
		await get_tree().create_timer(1.0).timeout
		switch_to_next_level()

func switch_to_next_level():
	var next_level_path = GameManager.get_next_level_path()
	print("Switching to next level: ", next_level_path)
	AudioManager.play_global_success_sound()
	get_tree().change_scene_to_file(next_level_path)
	GameManager.advance_level()  # Update GameManager's current level index
