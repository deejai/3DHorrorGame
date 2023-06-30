extends Node3D

#@onready var front_door_skeleton: Skeleton3D = $front_door_handle_fixed_bone/Armature/Skeleton3D

func _ready():
	pass

func _process(delta):
#	front_door_skeleton.rotate(Vector3.UP, 5.0 * delta)
	pass


func _on_area_3d_body_entered(body):
	if body is Player:
		$AudioStreamPlayer.play()
