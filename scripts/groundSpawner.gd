extends Node2D

@export var plantPrefabs: Array[PackedScene]
@export var spawnButton: TextureButton

@export var gridCellSize: Vector2i
@export var gridMaxGutter := 20
@export var gridCellYMaxOffset := 30

var spawnGrid: Array[Vector2i]
func _ready() -> void:
	spawnButton.pressed.connect(_on_spawn_btn_pressed)
	_make_spawn_grid.call_deferred() # defer this to after main window resize
	#position.y = get_window().size.y

func _make_spawn_grid() -> void:
	var screenSize := get_window().size
	var currentGridX := gridCellSize.x/2
	while currentGridX < screenSize.x - gridCellSize.x/2:
		var gutter = randi_range(5, gridMaxGutter)
		var spawnSlot :=Vector2i(currentGridX, gridCellSize.y - randi_range(10,gridCellYMaxOffset)) 
		spawnGrid.append(spawnSlot)
		currentGridX += gridCellSize.x + gutter

func _on_spawn_btn_pressed()-> void:
	if spawnGrid.size() == 0:
		return
	var plantIndex := randi_range(0, plantPrefabs.size() - 1)
	var plantNode := plantPrefabs[plantIndex].instantiate()
	
	var spawnGridIndex = randi_range(0, spawnGrid.size() - 1)
	
	plantNode.position = spawnGrid[spawnGridIndex]
	spawnGrid.remove_at(spawnGridIndex)
	print_debug(spawnGrid)
	get_tree().root.add_child(plantNode)
