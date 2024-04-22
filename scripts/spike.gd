extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(GroupNames.EnemyGroup)
	check_if_hard()

func check_if_hard():
	#if not hard, then remove the enemy
	if !GameManager.is_current_mode(GameManager.GameModes.HARD):
		queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group(GroupNames.PlayerGroup):
		GameManager.player_loss_life()
