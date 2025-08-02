extends Node2D 
class_name Plant

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout() -> void:
	if $AnimatedSprite2D.frame_progress == 1:
		$Timer.stop() 
	$AnimatedSprite2D.frame += 1
