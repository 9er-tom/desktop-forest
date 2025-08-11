class_name SpawnSlot
extends Control

@export var refRect: ReferenceRect

@onready var spawner: GroundSpawner = get_parent()
@onready var cursorTool: CursorTool = $"/root/Main/CursorTool"


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	cursorTool.tool_changed.connect(_on_cursor_tool_changed)

	GlobalDebugInfo.debug_info_toggled.connect(_on_debug_info_toggled)


func _on_mouse_entered() -> void:
	refRect.border_width = 5


func _on_cursor_tool_changed(currentTool: CursorTool.GardenTools):
	refRect.visible = currentTool == CursorTool.GardenTools.SEED


func _on_mouse_exited() -> void:
	refRect.border_width = 1


func _on_debug_info_toggled(toggled_on: bool):
	refRect.visible = toggled_on


func _gui_input(event: InputEvent) -> void:
	if spawner.cursorTool.currentTool != CursorTool.GardenTools.SEED:
		return

	if event.is_action_pressed("Interact"):
		spawner.spawn_in_slot(self)
