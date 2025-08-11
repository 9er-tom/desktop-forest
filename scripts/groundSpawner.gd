class_name GroundSpawner
extends Node

@export var plantPrefabs: Array[PackedScene]
@export var spawnButton: TextureButton
@export var spawnSlotPrefab: PackedScene
@export var cursorTool: CursorTool
@export var gridCellSize: Vector2
@export var gridMaxGutter := 20
@export var gridCellYMaxOffset: int
@export var gridCellYMinOffset: int

var groundPosY: float
var usedSlots: Array[String]


func _ready() -> void:
	_make_spawn_grid.call_deferred() # defer this to after main window resize
	_calc_grid_cell_size()


## Spawn an instance of every plant prefab and get the size of the biggest plant. 
## Use this size as gridCellSize for spawning slots.
## Afterwards, remove all spawned instances	

func _calc_grid_cell_size() -> void:
	for prefab in plantPrefabs:
		var plant := prefab.instantiate()
		add_child(plant)
		if plant.size > gridCellSize:
			gridCellSize = plant.size
		remove_child(plant)


func _make_spawn_grid() -> void:
	groundPosY = get_parent().position.y
	var screenSize   := get_window().size
	var currentGridX := gridCellSize.x/2
	while currentGridX < screenSize.x - gridCellSize.x/2:
		var gutter          = randi_range(5, gridMaxGutter)
		var slot: SpawnSlot = spawnSlotPrefab.instantiate()
		slot.position = Vector2(currentGridX, groundPosY - gridCellSize.y - randi_range(gridCellYMinOffset, gridCellYMaxOffset))
		slot.size = gridCellSize
		add_child(slot)
		currentGridX += gridCellSize.x + gutter


func spawn_in_slot(slot: SpawnSlot)-> void:
	if usedSlots.find(slot.name) != -1:
		return

	var plantIndex := randi_range(0, plantPrefabs.size() - 1)
	var plantNode  := plantPrefabs[plantIndex].instantiate()

	get_tree().root.add_child(plantNode)
	usedSlots.append(slot.name)
	plantNode.position = slot.position
	plantNode.position.y += gridCellSize.y - plantNode.size.y
