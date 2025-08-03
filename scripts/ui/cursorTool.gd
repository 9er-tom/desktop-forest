extends AnimatedSprite2D
class_name CursorTool

@export var mouseOffset := Vector2(20,20)

# icons should be 256x256

enum GardenTools {WATERING_CAN, SEED, SHOVEL, NONE}
var currentTool := GardenTools.NONE
	
func _process(delta: float) -> void:
	position = get_global_mouse_position() + mouseOffset
	if Input.is_action_just_pressed("Interact"):
		play()
		print_debug("press")
	if Input.is_action_just_released("Interact"):
		stop()
		frame = 0
		print_debug("release")


func setCurrentTool(tool: GardenTools):
	currentTool = tool
	print_debug(currentTool)
	match currentTool:
		GardenTools.WATERING_CAN:
			animation = "wateringCan"
			set_frame(0)
		GardenTools.SHOVEL:
			animation = "wateringCan"
			set_frame(5)
		GardenTools.NONE:
			visible = false
			return
	visible = true
		# todo change texture to correct tool
