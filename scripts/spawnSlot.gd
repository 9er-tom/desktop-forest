class_name SpawnSlot
extends Control

@export var refRect: ReferenceRect
@onready var spawner: GroundSpawner = get_parent()


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	refRect.border_width = 5


func _on_mouse_exited() -> void:
	refRect.border_width = 1


func _gui_input(event: InputEvent) -> void:
	if spawner.cursorTool.currentTool != CursorTool.GardenTools.SEED:
		return
		
	if event.is_action_pressed("Interact"):
		spawner.spawn_in_slot(self)
