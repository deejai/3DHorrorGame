extends Node3D

@onready var forward_ray: RayCast3D = $ForwardRay

signal entered
signal exited

func _ready():
	pass

func _process(delta):
	pass

func _on_area_3d_body_entered(body):
	if body is Player:
		var to_player = body.position - position
		if to_player.dot(basis.z) > 0:
			emit_signal("entered")

func _on_area_3d_body_exited(body):
	if body is Player:
		var to_player = body.position - position
		if to_player.dot(basis.z) > 0:
			emit_signal("exited")
