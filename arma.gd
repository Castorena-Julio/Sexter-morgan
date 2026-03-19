extends Node2D


const  bullet = preload("res://escenas/armas/bullet_gun.tscn")
@onready var marcador: Marker2D = $Marker2D


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0 , 360)
	
	if rotation_degrees> 90  and rotation_degrees < 270 :
		$Sprite2D.flip_v = true
	else: 
		$Sprite2D.flip_v = false
	
	if Input.is_action_just_pressed("disparo ") :
		var bullet_instan = bullet.instantiate () 
		get_tree() .root.add_child(bullet_instan)
		bullet_instan.global_position = marcador.global_position # guarda la posicion y ejecuta  la bala ahi
		bullet_instan.rotation = rotation
