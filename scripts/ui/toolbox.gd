class_name Toolbox extends TextureRect

@export var waterButton: BaseButton
@export var shovelButton: BaseButton
@export var cursorTool: CursorTool

func _ready() -> void:
	waterButton.pressed.connect(_on_toolbutton_pressed.bind(CursorTool.GardenTools.WATERING_CAN))
	shovelButton.pressed.connect(_on_toolbutton_pressed.bind(CursorTool.GardenTools.SHOVEL))

func _on_toolbutton_pressed(tool: CursorTool.GardenTools):
	cursorTool.set_current_tool(tool)

func show_all_tool_buttons():
	waterButton.visible = true
	shovelButton.visible = true