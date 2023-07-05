extends CanvasLayer

@onready var smoke_textures: Array = [
	$Sprite2D,
	$Sprite2D2
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for texture in smoke_textures:
		texture.position.x -= 100.0 * delta
		if texture.position.x <= -256.0 * 3.0:
			texture.position.x += 256.0 * 12.0
