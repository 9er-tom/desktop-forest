@tool
extends Control 
class_name Plant

@export var outlineMaterial: ShaderMaterial
@export var growthStageTime := 1.0 # seconds per growth stage
@onready var sprite := $AnimatedSprite2D

@onready var growthStages: int = sprite.sprite_frames.get_frame_count(sprite.animation)
var currentGrowthStage := 1
var isWatered := false


func _process(_delta: float) -> void:
	if (isWatered):
		$"ProgressContainer/ProgressBar".value = growthStageTime - $Timer.time_left

func _ready() -> void:
	var spriteSize = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame).get_size() * sprite.scale
	sprite.position = Vector2(spriteSize.x / 2, spriteSize.y / 2)
	
	size = Vector2(spriteSize.x, spriteSize.y)
	$ReferenceRect.size = size
	
	_setup_progress_bar()
	
	#gui_input
	$Timer.wait_time = growthStageTime
	$Timer.timeout.connect(_on_timer_timeout)
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)
	
func _setup_progress_bar() -> void:
	$ProgressContainer.position.y -= 30
	$"ProgressContainer/Label".text = "{curr}/{max}".format({"curr": currentGrowthStage, "max": growthStages})
	$"ProgressContainer/ProgressBar".max_value = growthStageTime
	
func _on_timer_timeout() -> void:
	sprite.frame += 1
	currentGrowthStage += 1
	isWatered = false
	$"ProgressContainer/ProgressBar".value = 0.0
	$"ProgressContainer/Label".text = "{curr}/{max}".format({"curr": currentGrowthStage, "max": growthStages})
	$Timer.stop()
	
func _on_mouse_enter() -> void:
	sprite.material = outlineMaterial
	waterPlant() # todo remove this
	
func _on_mouse_exit() -> void:
	sprite.material = null
	
func waterPlant() -> void:
	isWatered = true
	if currentGrowthStage != growthStages:
		$Timer.start()
	
