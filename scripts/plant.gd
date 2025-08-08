@tool
extends Control 
class_name Plant

@export var outlineMaterial: ShaderMaterial
@export var growthStageTime := 1.0 # seconds per stage

@onready var cursorTool: CursorTool = $"/root/Main/CursorTool"
@onready var sprite := $AnimatedSprite2D

@onready var growthStages: int = sprite.sprite_frames.get_frame_count(sprite.animation)
@onready var growTimer: Timer = $GrowTimer
@onready var waterTimer: Timer = $"WaterProgress/WaterTimer"
var currentGrowthStage := 1
var isWatered := false


func _process(_delta: float) -> void:
	if (isWatered):
		$"ProgressContainer/ProgressBar".value = growthStageTime - growTimer.time_left
	$WaterProgress.value = waterTimer.wait_time - waterTimer.time_left 

func _ready() -> void:
	var spriteSize = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame).get_size() * sprite.scale
	sprite.position = Vector2(spriteSize.x / 2, spriteSize.y / 2)
	
	size = Vector2(spriteSize.x, spriteSize.y)
	$ReferenceRect.size = size
	
	_setup_progress_bar()
	
	growTimer.wait_time = growthStageTime
	$WaterProgress.max_value = waterTimer.wait_time
	
	growTimer.timeout.connect(_on_timer_timeout)
	waterTimer.timeout.connect(_on_water_timer_timeout)
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
	growTimer.stop()
	
func _gui_input(event: InputEvent) -> void: 
	if event.is_action_released("Interact"):
		waterTimer.stop()
	if event.is_action_pressed("Interact"): 
		match cursorTool.currentTool:
			CursorTool.GardenTools.WATERING_CAN:
				waterTimer.start()

func _on_mouse_enter() -> void: 
	sprite.material = outlineMaterial
	
func _on_mouse_exit() -> void:
	sprite.material = null
	
func _on_water_timer_timeout():
	waterTimer.stop()
	isWatered = true
	if currentGrowthStage != growthStages:
		growTimer.start()
	
