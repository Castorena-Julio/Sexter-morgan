extends CharacterBody2D

var bullet = preload("res://escenas/personajes/bullet.tscn")
const salto : float = -50.0
var _velocidad : float = 200.0

func  _physics_process(delta):
	
	if Input.is_action_pressed("arriba")  || Input.is_action_pressed("ui_up"):
		velocity.y = salto
	elif Input.is_action_pressed("abajo") || Input.is_action_pressed("ui_down"):
		velocity.y = -salto
	else : 
		velocity.y = 0
	
	
	if Input.is_action_pressed("derecha") || Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
	elif Input.is_action_pressed("izquierda") || Input.is_action_pressed("ui_left"): 
		velocity.x = -_velocidad
	else : 
		velocity.x =0
	move_and_slide()
	
	
	
	
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
		
func shoot():
	var newBullet = bullet.instantiate()
	newBullet.direction=rotation
	newBullet.global_position =$spawnpoint.global_position
	get_parent().add_child(newBullet)
