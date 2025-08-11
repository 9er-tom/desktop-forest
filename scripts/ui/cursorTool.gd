class_name CursorTool
extends AnimatedSprite2D

@export var mouseOffset := Vector2(20, 20)
@export var toolbox: Toolbox

var lastButton: Control
# icons should be 256x256

enum GardenTools {WATERING_CAN, SEED, SHOVEL, NONE}
var currentTool := GardenTools.NONE
signal tool_changed(currentTool: GardenTools)


func _process(_delta: float) -> void:
	position = get_global_mouse_position() + mouseOffset
	if Input.is_action_just_pressed("Interact"):
		play()
	if Input.is_action_just_released("Interact"):
		stop()
		frame = 0
	if Input.is_action_just_released("Cancel"):
		set_current_tool(GardenTools.NONE)
		lastButton.visible = true


func set_current_tool(tool: GardenTools):
	currentTool = tool
	if lastButton:
		lastButton.visible = true

	match currentTool:
		GardenTools.WATERING_CAN:
			toolbox.waterButton.visible = false
			lastButton = toolbox.waterButton
			animation = "wateringCan"
			frame = 0
			scale = Vector2(0.6, 0.6)
			visible = true
			
		GardenTools.SEED:
			toolbox.seedButton.visible = false
			lastButton = toolbox.seedButton
			animation = "seed"
			frame = 0
			scale = Vector2(0.3, 0.3)
			visible = true

		GardenTools.NONE:
			visible = false

	tool_changed.emit(currentTool)
