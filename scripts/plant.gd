extends Control
class_name Plant

@export var outlineMaterial: ShaderMaterial
@export var growthStageTime: float # seconds per stage
@export var wateringDuration: float

@onready var debugButton: CheckButton = $"/root/Main/ToolboxUi/toolbox/DebugBtn"
@onready var cursorTool: CursorTool = $"/root/Main/CursorTool"
@onready var thirstIcon: TextureRect = $ThirstIcon
@onready var sprite := $AnimatedSprite2D
@onready var growthProgressBar: ProgressBar = $"DebugInfo/ProgressContainer/ProgressBar"
@onready var growthStateLabel: Label = $"DebugInfo/StateLabel"
@onready var growthProgressLabel: Label = $"DebugInfo/ProgressContainer/ProgressLabel"
@onready var growthStages: int = sprite.sprite_frames.get_frame_count(sprite.animation)
@onready var growTimer: Timer = $GrowTimer

var currentGrowthStage := 1
var waterTimer         := 0.0
enum PLANT_STATES {
	IDLE,
	WATERING,
	GROWING,
	FULLY_GROWN
}
var state := PLANT_STATES.IDLE


func _process(delta: float) -> void:
	growthStateLabel.text = PLANT_STATES.keys()[state]

	match state:
		PLANT_STATES.WATERING:
			if waterTimer < wateringDuration:
				waterTimer += delta
				thirstIcon.material.set_shader_parameter("progress", waterTimer / wateringDuration)
			elif growTimer.time_left == 0:
				waterPlant()
		PLANT_STATES.GROWING:
			growthProgressBar.value = growthStageTime - growTimer.time_left
		PLANT_STATES.IDLE:
			pass
		PLANT_STATES.FULLY_GROWN:
			return


func _ready() -> void:
	GlobalDebugInfo.debug_info_toggled.connect(_on_debug_info_toggled)
	_on_debug_info_toggled(GlobalDebugInfo.debugInfoEnabled)

	var spriteSize = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame).get_size() * sprite.scale
	sprite.position = Vector2(spriteSize.x / 2, spriteSize.y / 2)

	size = Vector2(spriteSize.x, spriteSize.y)
	$ReferenceRect.size = size

	_setup_progress_bar()

	growTimer.wait_time = growthStageTime

	growTimer.timeout.connect(_on_grow_timer_timeout)
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)


func _setup_progress_bar() -> void:
	$DebugInfo.position.y -= 100
	growthProgressLabel.text = "{curr}/{max}".format({"curr": currentGrowthStage, "max": growthStages})
	growthProgressBar.max_value = growthStageTime


func _on_grow_timer_timeout() -> void:
	sprite.frame += 1
	currentGrowthStage += 1
	if currentGrowthStage == growthStages:
		state = PLANT_STATES.FULLY_GROWN
	else:
		state = PLANT_STATES.IDLE
		thirstIcon.visible = true
		growthProgressBar.value = 0.0
	growthProgressLabel.text = "{curr}/{max}".format({"curr": currentGrowthStage, "max": growthStages})
	growTimer.stop()


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("Interact"):
		if state == PLANT_STATES.WATERING:
			state = PLANT_STATES.IDLE
	if event.is_action_pressed("Interact"):
		match cursorTool.currentTool:
			CursorTool.GardenTools.WATERING_CAN:
				if state == PLANT_STATES.IDLE:
					state = PLANT_STATES.WATERING


func _on_mouse_enter() -> void:
	sprite.material = outlineMaterial


func _on_mouse_exit() -> void:
	sprite.material = null


func _on_debug_info_toggled(toggled_on: bool):
	$DebugInfo.visible = toggled_on
	$ReferenceRect.visible = toggled_on


func waterPlant() -> void:
	state = PLANT_STATES.GROWING
	thirstIcon.visible = false
	waterTimer = 0.0
	growTimer.start()
