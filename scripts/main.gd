extends Node

@onready var _MainWindow: Window = get_window()
@onready var toolbox: Window = $toolbox
@onready var screenWidth := DisplayServer.screen_get_size().x
@onready var usableScreen := DisplayServer.screen_get_usable_rect().size
@onready var mainDisplayX_LEFT := _MainWindow.position.x - DisplayServer.screen_get_size().x/2 + _MainWindow.size.x/2
@onready var mainDisplayX_RIGHT := mainDisplayX_LEFT + DisplayServer.screen_get_size().x
@onready var mainScreenPosNull := Vector2(mainDisplayX_LEFT, 0)

@onready var bg: Node2D = $Background

enum TASKBAR_ORIENTATION {LEFT, RIGHT, UP, DOWN}

@export var windowHeight := 200
@export var taskbarOrientation := TASKBAR_ORIENTATION.DOWN

var taskbarPos : int 
var screenSize: Vector2 = DisplayServer.screen_get_size()

func _ready():
	get_viewport().transparent_bg = true
	get_tree().get_root().set_transparent_background(true)

	_MainWindow.position.x = mainScreenPosNull.x
	_MainWindow.min_size = Vector2i(screenWidth,windowHeight)
	_MainWindow.size = _MainWindow.min_size
		
	match taskbarOrientation:
		TASKBAR_ORIENTATION.UP:
			taskbarPos = screenSize.y
		TASKBAR_ORIENTATION.DOWN:
			taskbarPos = usableScreen.y
		TASKBAR_ORIENTATION.LEFT:
			pass
		TASKBAR_ORIENTATION.RIGHT:
			pass


	_MainWindow.position.y = taskbarPos - windowHeight
	# set toolbox window pos
	setToolboxPos.call_deferred()

func setToolboxPos():
	toolbox.position = Vector2i(mainDisplayX_RIGHT - toolbox.size.x, taskbarPos - toolbox.size.y - 150)
