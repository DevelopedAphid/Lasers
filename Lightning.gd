extends Node2D

var is_casting = false
var count = 0 
var point_count = 0
var random_number_1
var random_number_2
var lightning_direction

func _ready():
	$Line2D.add_point(Vector2(0,0))
	$Line2D.points[0] = Vector2(300,0)
	
	is_casting = true
	lightning_direction = get_parent().get_node("Player").get_node("Pointer").pointerDirection
	$Line2D.points[0] = get_parent().get_node("Player").global_position
	

func _physics_process(_delta):
	if is_casting:
		if point_count > 10:
			is_casting = false
		
		elif count < 2:
			count +=1
		
		elif count == 2:
			randomize()
			random_number_1 = rand_range(-15,50)
			random_number_2 = rand_range(-15,50)
		
			var last_position = $Line2D.points[point_count]
			$Line2D.add_point(last_position + lightning_direction * Vector2(random_number_1,random_number_2))
			point_count += 1
		
		elif count < 2:
			count += 1
		
	elif !is_casting:
		for n in range(point_count,0,-1):
			$Line2D.remove_point(n)
		point_count = 0
