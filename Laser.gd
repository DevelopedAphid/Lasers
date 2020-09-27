extends Line2D


var laserDirection = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	add_point(Vector2(0,0), 0)
	add_point(Vector2(0,0), 1)

func _process(_delta):
	laserDirection = get_parent().get_node("Pointer").position
	set_point_position(1, laserDirection)
