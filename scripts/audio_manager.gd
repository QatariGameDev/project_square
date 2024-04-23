extends Node


#bgm
var bgm_hard_level = preload("res://audio/bgm/Project Square Hard.mp3")
var bgm_normal_level = preload("res://audio/bgm/Project Square.mp3")


@onready var audio_stream_player = $AudioStreamPlayer

#global sounds
@onready var audio_global_button = $Audio_Global_Button
@onready var audio_global_jump = $Audio_Global_Jump
@onready var audio_global_circle = $Audio_Global_circle
@onready var audio_global_damage = $Audio_Global_damage
@onready var audio_global_success = $Audio_Global_success


func _ready():
	stop_all_bgm()

func play_hard_level_bgm():
	if not audio_stream_player.playing or audio_stream_player.stream != bgm_hard_level:
		audio_stream_player.stream = bgm_hard_level
		audio_stream_player.play()


func play_normal_level_bgm():
	if not audio_stream_player.playing or audio_stream_player.stream != bgm_normal_level:
		audio_stream_player.stream = bgm_normal_level
		audio_stream_player.play()

func stop_all_bgm():
	if audio_stream_player.playing:
		audio_stream_player.stop()

func play_global_button_sound():
	audio_global_button.play()

func play_global_jump_sound():
	audio_global_jump.play()
	
func play_global_damage_sound():
	audio_global_damage.play()
	
func play_global_pickup_sound():
	audio_global_circle.play()
	
func play_global_success_sound():
	audio_global_success.play()
