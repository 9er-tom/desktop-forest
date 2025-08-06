extends BaseButton

@export var cursorTool: CursorTool
@export var showElement: Control
@export var hideElement: Control

func _ready() -> void:
	pressed.connect(_on_pressed)
	
func _on_pressed():
	showElement.visible = !showElement.visible
	hideElement.visible = !hideElement.visible

	cursorTool.set_current_tool(CursorTool.GardenTools.NONE)	
