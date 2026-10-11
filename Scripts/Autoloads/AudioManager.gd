extends Node2D

@onready var music_player = $MusicPlayer
@onready var temperature_player = $TemperaturePlayer

func play_audio(audio: AudioStreamMP3, type: String):
	var player_type = type
	var audio_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	audio_player.bus = player_type
	audio_player.stream = audio
	audio_player.play()
	
