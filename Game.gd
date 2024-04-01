extends Node3D

#@onready var front_door_skeleton: Skeleton3D = $front_door_handle_fixed_bone/Armature/Skeleton3D
class_name Game

@onready var player: Player = $Player

func _ready():
    AudioManager.ambience_player.play()
    
    if Main.debug:
        player.speed = 8.0
    else:
        player.speed = player.DEFAULT_SPEED / 2.0


func _process(delta):
#	front_door_skeleton.rotate(Vector3.UP, 5.0 * delta)
    pass


func _on_go_upstairs_trigger_entered():
    AudioManager.ambience_player.set_mode(AmbiencePlayer.Mode.WITH_BASS)


func _on_go_upstairs_trigger_exited():
    AudioManager.ambience_player.set_mode(AmbiencePlayer.Mode.MIN)


func _on_go_into_upstairs_bathroom_trigger_entered():
    AudioManager.ambience_player.set_mode(AmbiencePlayer.Mode.MAX)


func _on_go_into_upstairs_bathroom_trigger_exited():
    AudioManager.ambience_player.set_mode(AmbiencePlayer.Mode.WITH_BASS)


func _on_callout_trigger_1_body_entered(body):
    if body is Player:
        $AudioStreamPlayer2.play()
        $CalloutTrigger1.queue_free()


func _on_callout_trigger_2_body_entered(body):
    if body is Player:
        $AudioStreamPlayer.play()
        $CalloutTrigger2.queue_free()


func _on_callout_trigger_3_body_entered(body):
    if body is Player:
        $AudioStreamPlayer4.play()
        $CalloutTrigger3.queue_free()


func _on_callout_trigger_4_body_entered(body):
    if body is Player:
        player.speed = player.DEFAULT_SPEED
        $AudioStreamPlayer3.play()
        $CalloutTrigger4.queue_free()


func _on_first_encounter_trigger_body_entered(body):
    if body is Player:
        $FirstEncounterTrigger/AudioStreamPlayer.play()
