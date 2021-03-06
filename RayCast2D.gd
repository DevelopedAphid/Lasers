extends RayCast2D

var is_casting := false setget set_is_casting

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		self.is_casting = event.pressed

func _physics_process(_delta):
	var cast_point := cast_to
	force_raycast_update()
	
	$CollisionParticle.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	
	$Line2D.points[1] = cast_point
	$BeamParticle.position = cast_point * 0.5
	$BeamParticle.process_material.emission_box_extents.x = cast_point.length() * 0.5
	$BeamParticle.process_material.emission_box_extents.y = cast_point.length() * 0.5

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	
	$BeamParticle.emitting = is_casting
	$CastingParticle.emitting = is_casting
	
	if is_casting:
		appear()
	else:
		$CollisionParticle.emitting = false
		disappear()
	
	set_physics_process(is_casting)


func appear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 10.0, 0.2)
	$Tween.start()

func disappear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10.0, 0, 0.1)
	$Tween.start()
