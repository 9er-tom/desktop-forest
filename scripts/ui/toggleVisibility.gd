extends BaseButton

@export var showElement: Control
@export var hideElement: Control

func _ready() -> void:
	pressed.connect(_on_pressed)
	
func _on_pressed():
	if showElement:
		showElement.visible = !showElement.visible
	if hideElement:
		hideElement.visible = !hideElement.visible
