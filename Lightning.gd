extends Node2D

var is_casting = false
var count = 0 
var point_count = 0
var random_number_1
var random_number_2

func _ready():
	$Line2D.add_point(Vector2(0,0))
	$Line2D.points[0] = Vector2(300,0)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		is_casting = event.pressed

func _physics_process(_delta):
	if count < 2 && is_casting:
		count += 1
	
	elif count == 2 && is_casting:
		randomize()
		random_number_1 = rand_range(-50,50)
		random_number_2 = rand_range(25,50)
		
		var last_position = $Line2D.points[point_count]
		$Line2D.add_point(last_position + Vector2(random_number_1,random_number_2))
		point_count += 1
	
	elif !is_casting:
		for n in range(point_count,0,-1):
			$Line2D.remove_point(n)
		point_count = 0
