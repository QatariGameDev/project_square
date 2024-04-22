extends Node


#bgm
var bgm_hard_level = preload("res://audio/bgm/Project Square Hard.mp3")
var bgm_normal_level = preload("res://audio/bgm/Project Square.mp3")


@onready var audio_stream_player = $AudioStreamPlayer

#global button sound
@onready var audio_global_button = $Audio_Global_Button


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
