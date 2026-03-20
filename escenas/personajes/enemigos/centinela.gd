extends CharacterBody2D

const bullet_enemigo = preload("res://escenas/armas/bullet_gun.tscn")

@onready var player = get_node("/root/nivel1/dexter")

func _physics_process(delta):
	if player : 
		look_at(player.global_position)
	
	$RayCast2D.force_raycast_update()

	if $RayCast2D.is_colliding():
		var col = $RayCast2D.get_collider()
		
		if col.is_in_group("player"):
			
			shot()
		
	
func shot ():
	var bullet_instan = bullet_enemigo.instantiate () 
	get_tree().root.add_child(bullet_instan)
	bullet_instan.global_position = global_position # guarda la posicion y ejecuta  la bala ahi
	bullet_instan.rotation = rotation
