extends Node2D

var is_casting = false
var count = 0 
var point_count = 0
var random_number_x
var random_number_y
var lightning_direction

var number_to_letter_dir = {
	1: "a",
	2: "b",
	3: "c",
	4: "d",
	5: "e",
	6: "f",
	7: "g",
	8: "h",
	9: "i",
	10: "j",
	11: "k",
	12: "l",
	13: "m",
	14: "n",
	15: "o",
	16: "p",
	17: "q",
	18: "r",
	19: "s",
	20: "t",
	21: "u",
	22: "v",
	23: "w",
	24: "x",
	25: "y",
	26: "z"	
}

func _ready():
	add_to_group("Lightning")
	
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
			
			$CollisionShape2D.shape.a = $Line2D.get_point_position(0)
			$CollisionShape2D.shape.b = $Line2D.get_point_position(point_count-1)
			#print(point_count-1)
		
		elif count < 2:
			count += 1
		
	elif !is_casting:
		for n in range(point_count,0,-1):
			$Line2D.remove_point(n)
		point_count = 0
		queue_free()


func _on_Lightning_area_entered(area):
	if area.is_in_group("Lightning") or area.name == "Player":
		pass
	else: print(area.name)
