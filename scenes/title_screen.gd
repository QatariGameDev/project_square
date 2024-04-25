extends Control


func _ready():
	AudioManager.stop_all_bgm()

func _on_normal_mode_pressed():
	GameManager.reset_game()
	AudioManager.play_global_button_sound()
	GameManager.set_game_mode(GameManager.GameModes.NORMAL)
	AudioManager.play_normal_level_bgm()
	get_tree().change_scene_to_file("res://levels/level1.tscn")


func _on_hard_mode_pressed():
	GameManager.reset_game()
	AudioManager.play_global_button_sound()
	GameManager.set_game_mode(GameManager.GameModes.HARD)
	AudioManager.play_hard_level_bgm()
	get_tree().change_scene_to_file("res://levels/level1.tscn")
