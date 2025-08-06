extends Node2D

@export var minHeight := 60
@export var maxHeight := 100
@export var minScale := 0.03
@export var maxScale := 0.05
@export var grassSpriteAmount := 3
@export var grassSpritePath := 'assets/grass/'


func _ready() -> void:
	spawnSprites.call_deferred()


func spawnSprites():
	var maxWidth := get_tree().root.size.x
	var currentX := 0

	while (currentX < maxWidth):
		var scale := randf_range(minScale, maxScale) # 0.03 .. 0.05
		var randGrassInt := randi_range(1, grassSpriteAmount) # 1 .. 3

		var spritePng = load(
							grassSpritePath +
							str(randGrassInt)
							+'.PNG')
		var spriteObj: Sprite2D = Sprite2D.new()
		spriteObj.texture = spritePng
		spriteObj.scale = Vector2(scale, scale)
		spriteObj.position.y = -(spriteObj.texture.get_size().y * scale / 3)
		spriteObj.position.x = currentX
		currentX += spriteObj.texture.get_size().x * scale / 4
		add_child(spriteObj)
