extends CharacterBody2D

const bullet_enemigo = preload("res://escenas/armas/bullet_gun.tscn")
#centinela 2.0 
var vida_maxima : float = 100.0
var vida_actual : float = 100.0
@onready var player = get_node("/root/nivel1/dexter")
@onready var marcador: Marker2D = $Marker2D

var can_shoot = true
var contador = 0 
const retardo = 1 




func _physics_process(delta):
	if player : 
		look_at(player.global_position)
	
	#se gira pasando los angulos de 90 y 270
	rotation_degrees = wrap(rotation_degrees, 0 , 360)
	
	if rotation_degrees> 90  and rotation_degrees < 270 :
		$AnimatedSprite2D2.flip_v = true
	else: 
		$AnimatedSprite2D2.flip_v = false
		
		
	#checa si esta colisionando el ray cast 
	$RayCast2D.force_raycast_update()

	if $RayCast2D.is_colliding():
		var col = $RayCast2D.get_collider()
		
		if col.is_in_group("player"):
			if can_shoot:
				shot()
				can_shoot = false
				$Timer.start()
				
	else : 
		$AnimatedSprite2D2.play("idle")
		
		



func shot ():
	
	
	$AnimatedSprite2D2.play("disparo")
	var bullet_enemy = bullet_enemigo.instantiate () 
	get_tree().root.add_child(bullet_enemy)
	bullet_enemy.add_to_group("enemybala")
	
	bullet_enemy.global_position = marcador.global_position# guarda la posicion y ejecuta  la bala ahi
	bullet_enemy.rotation = rotation



func recibir_dano(cantidad: float) -> void:
	vida_actual -= cantidad
	vida_actual = max(vida_actual, 0)
	
	print (vida_actual)
	$AnimatedSprite2D2.modulate = Color.RED
	
	# Restaurar color despues de un momento
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D2, "modulate", Color.WHITE, 0.3)
	
	if vida_actual <= 0:
		morir()


func morir() -> void:
	print ("murio")
	queue_free()


# cuando lo chocan 
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerbala"):
		recibir_dano(10.0)
		print ("10")
		
		


func _on_timer_timeout() -> void:
	can_shoot = true 
