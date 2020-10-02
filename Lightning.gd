extends Node2D

#TODO - add collision object so that we can zap things

var is_casting = false
var count = 0 
var point_count = 0
var random_number_x
var random_number_y
var lightning_direction

func _ready():
	$Line2D.add_point(Vector2(0,0))
	$Line2D.points[0] = Vector2(300,0)
	
	is_casting = true
	lightning_direction = get_parent().get_node("Player").get_node("Pointer").pointerDirection
	$Line2D.points[0] = get_parent().get_node("Player").global_position
	

func _physics_process(_delta):
	if is_casting:
		if point_count > 15:
			is_casting = false
		
		elif count < 2:
			count +=1
		
		elif count == 2:
			randomize()
			random_number_x = rand_range(-5,50)
			random_number_y = rand_range(-5,50)
			var spread = rand_range(-0.5,0.5)
			
			var last_position = $Line2D.points[point_count]
			var next_x = lightning_direction.x * random_number_x + spread * random_number_x 
			var next_y = lightning_direction.y * random_number_y + spread * random_number_y
			$Line2D.add_point(last_position + Vector2(next_x, next_y))
			point_count += 1
		
		elif count < 2:
			count += 1
		
	elif !is_casting:
		for n in range(point_count,0,-1):
			$Line2D.remove_point(n)
		point_count = 0
		queue_free()
