extends Node2D

class_name Cutscene

@export var audio_track: AudioStreamPlayer
var play_delay: float = 0.5
var time_passed: float = 0.0
var started: bool = false

func _ready():
    pass

func _process(delta):
    time_passed += delta
    if not audio_track.playing and time_passed >= play_delay:
        audio_track.play()
        started = true

    if not started:
        return

    if not audio_track.playing:
        Main.transition_node.transition_to(Main.game)
