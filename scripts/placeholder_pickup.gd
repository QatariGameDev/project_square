extends Area2D

signal collected

func _ready():
	#hint Autoload (GroupNames)
	add_to_group(GroupNames.PickupGroup)
	var scene = get_tree().current_scene
	if scene.has_method("check_if_win"):
		connect("collected", Callable(scene, "check_if_win"))
		
		
func _on_body_entered(body):
	if body.is_in_group(GroupNames.PlayerGroup):
		emit_signal("collected")
		call_deferred("queue_free")

