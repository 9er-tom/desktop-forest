class_name Toolbox extends TextureRect

@export var waterButton: BaseButton
@export var seedButton: BaseButton
@export var shovelButton: BaseButton
@export var cursorTool: CursorTool

@onready var debugButton: CheckButton = $DebugBtn

func _ready() -> void:
	waterButton.pressed.connect(_on_toolbutton_pressed.bind(CursorTool.GardenTools.WATERING_CAN))
	shovelButton.pressed.connect(_on_toolbutton_pressed.bind(CursorTool.GardenTools.SHOVEL))
	seedButton.pressed.connect(_on_toolbutton_pressed.bind(CursorTool.GardenTools.SEED))
	
	debugButton.toggled.connect(_on_debug_button_toggled)
	debugButton.set_pressed_no_signal(GlobalDebugInfo.debugInfoEnabled)

func _on_toolbutton_pressed(tool: CursorTool.GardenTools):
	cursorTool.set_current_tool(tool)
 
func show_all_tool_buttons():
	waterButton.visible = true
	shovelButton.visible = true
	seedButton.visible = true
	
func _on_debug_button_toggled(toggled_on: bool):
	GlobalDebugInfo.toggleDebugInfo(toggled_on)
