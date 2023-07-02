extends Node3D

#@onready var front_door_skeleton: Skeleton3D = $front_door_handle_fixed_bone/Armature/Skeleton3D

func _ready():
	AudioManager.ambience_player.play()


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

