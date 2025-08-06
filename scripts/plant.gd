extends Control 
class_name Plant

@export var outlineMaterial: ShaderMaterial

@onready var sprite := $AnimatedSprite2D

func _ready() -> void:
	var spriteSize = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame).get_size()
	sprite.position = Vector2(spriteSize.x / 2, spriteSize.y / 2)
	
	size = Vector2(spriteSize.x, spriteSize.y)
	$ReferenceRect.size = size
	
	$Timer.timeout.connect(_on_timer_timeout)
	
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)
	
func _on_timer_timeout() -> void:
	if sprite.frame_progress == 1:
		$Timer.stop() 
	sprite.frame += 1
	
func _on_mouse_enter() -> void:
	sprite.material = outlineMaterial
	
func _on_mouse_exit() -> void:
	sprite.material = null
