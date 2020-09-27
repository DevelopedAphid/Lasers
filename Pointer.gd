extends Area2D

var pointerRadius = 100
var cursorPosition = Vector2(0,0)
var playerPosition = Vector2(0,0)
var playerToCursor = Vector2(0,0)
var pointerDirection = Vector2(0,0)
var pointerVector = Vector2(0,0)
var pointerPosition = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#make the pointer circle the player
	cursorPosition = get_viewport().get_mouse_position()
	playerPosition = get_parent().global_position
	
	playerToCursor = cursorPosition - playerPosition
	pointerDirection = playerToCursor.normalized()
	pointerVector = pointerDirection * pointerRadius
	pointerPosition = playerPosition + pointerVector
	
	global_position = pointerPosition
	
