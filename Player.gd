extends Area2D

var speed = 50
onready var lightning = preload("res://Lightning.tscn")

func _process(delta):
	#movement
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	
	if Input.is_action_pressed("ui_select"):
		get_parent().add_child(lightning.instance())
