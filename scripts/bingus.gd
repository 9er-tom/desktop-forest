extends Sprite2D

@export var speed := 3

@onready var spriteWidth := (texture.get_width() * scale.x) / 2
@onready var _MainWindow: Window = get_window()

var direction := Vector2.RIGHT


func _physics_process(delta: float) -> void:
	#translate(direction * speed)
	if (direction == Vector2.RIGHT && position.x > DisplayServer.screen_get_size().x - spriteWidth):
		direction = Vector2.LEFT
	if (direction == Vector2.LEFT && position.x < spriteWidth):
		direction = Vector2.RIGHT
	var rect := PackedVector2Array([
	(texture.get_size() * scale / 2) * Vector2(-1, -1) + position, # Top left corner
	(texture.get_size() * scale / 2) * Vector2(1, -1) + position, # Top right corner
	(texture.get_size() * scale / 2) * Vector2(1, 1) + position, # Bottom right corner
	(texture.get_size() * scale / 2) * Vector2(-1, 1) + position # Bottom left corner
	])
	DisplayServer.window_set_mouse_passthrough(rect)
