extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
    # Add this node to a group defined in Autoload (GroupNames)
    add_to_group(GroupNames.PickupGroup)
    # Connect the 'collected' signal to the 'check_if_win' method of the current scene's script
    var scene = get_tree().current_scene
    if scene.has_method("check_if_win"):
        connect("collected", Callable(scene, "check_if_win"))
    else:
        push_error("The current scene does not have a method named 'check_if_win'.")
        
