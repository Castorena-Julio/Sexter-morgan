extends CharacterBody2D

const bullet_enemigo = preload("res://escenas/armas/bullet_gun.tscn")

@onready var player = get_node("/root/nivel1/dexter")
@onready var marcador: Marker2D = $Marker2D
func _physics_process(delta):
	if player : 
		look_at(player.global_position)
	
	
func shot ():
	$AnimatedSprite2D2.play("disparo")
	var bullet_enemy = bullet_enemigo.instantiate () 
	get_tree().root.add_child(bullet_enemy)
	bullet_enemy.add_to_group("enemybala")
	
	bullet_enemy.global_position = marcador.global_position# guarda la posicion y ejecuta  la bala ahi
	bullet_enemy.rotation = rotation

# cuando lo chocan 
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerbala"):
		print ("le pegaste")
		#hla
		
		
