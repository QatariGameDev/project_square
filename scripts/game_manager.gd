extends Node

# Default Setting
const DEFAULT_LIVES = 3
const LEVELS_PATH = "res://levels/"
const FINAL_LEVEL = "res://scenes/title_screen.tscn"
enum GameModes { NORMAL, HARD }  # Define enum

# Variables for current state
var player_life = DEFAULT_LIVES
var current_game_mode = GameModes.NORMAL
var level_files = []
var current_level_index : int = 0
var total_levels : int = 0

func _ready():
	discover_levels()  # Load all levels at startup

func discover_levels():
	var dir := DirAccess.open(LEVELS_PATH)
	if dir:
		dir.list_dir_begin()
		var filename := dir.get_next()
		while filename != "":
			if filename.ends_with(".tscn"):
				level_files.append(LEVELS_PATH + filename)
			filename = dir.get_next()
		level_files.sort()  # Ensure the files are in order
		total_levels = level_files.size()  # Store the total number of levels
		dir.list_dir_end()
	else:
		print("Failed to open directory at: ", LEVELS_PATH)
	print("Levels discovered: ", level_files)
	print("Total levels: ", total_levels)

func is_current_mode(mode : int) -> bool:
	return current_game_mode == mode


func get_current_level_path() -> String:
	if current_level_index < level_files.size():
		return level_files[current_level_index]
	else:
		return FINAL_LEVEL

func get_next_level_path() -> String:
	if current_level_index + 1 < level_files.size():
		return level_files[current_level_index + 1]
	else:
		return FINAL_LEVEL

func advance_level():
	if current_level_index + 1 < level_files.size():
		current_level_index += 1
	else:
		print("Final level reached or repeated.")

func set_game_mode(mode: int) -> void:
	if mode in GameModes.values():
		current_game_mode = mode
		print("Game mode set to: " + GameModes.keys()[mode])
	else:
		print("Invalid game mode selected.")

func player_loss_life(amount: int = 1) -> void:
	AudioManager.play_global_damage_sound()
	player_life -= abs(amount)
	print("Player life is " + str(player_life))
	get_tree().reload_current_scene()
	if player_life <= 0:
		player_life = 0
		print("Call game over")
		game_over()

func game_over() -> void:
	print("Game Over! Resetting game...")
	reset_game()
	AudioManager.stop_all_bgm()
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func reset_game() -> void:
	player_life = DEFAULT_LIVES
	set_game_mode(GameModes.NORMAL)
	current_level_index = 0  # Reset to first level
