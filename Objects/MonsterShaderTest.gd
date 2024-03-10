extends Node3D

@onready var mesh: MeshInstance3D = $ImportedScene/Armature/Skeleton3D/Cube_001
@onready var material: ShaderMaterial = mesh.get_active_material(0)

var t: float = randf()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    t += delta
    material.set_shader_parameter("t", t)

    position.z += delta * 0.3
