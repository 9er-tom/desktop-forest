extends Node2D 
class_name Plant

@export var outlineMaterial: ShaderMaterial

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)
	$Area2D.mouse_entered.connect(_on_mouse_enter)
	$Area2D.mouse_exited.connect(_on_mouse_exit)
	
func _on_timer_timeout() -> void:
	if $AnimatedSprite2D.frame_progress == 1:
		$Timer.stop() 
	$AnimatedSprite2D.frame += 1
	
func _on_mouse_enter() -> void:
	$AnimatedSprite2D.material = outlineMaterial
	
func _on_mouse_exit() -> void:
	$AnimatedSprite2D.material = null
