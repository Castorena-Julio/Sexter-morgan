extends Node2D
@onready var duration_timer = $DurationTimer
@onready var duration_ghost = $GhosTimer

var gosht_scene = preload("res://escenas/sombradashm.tscn")

var sprite 

func  start_dash(sprite, duration):

	duration_timer.wait_time = duration
	
	#la sombra 
	self.sprite = sprite # tuve que crear un sprite para que esta tuviera valor( una imagen)
	duration_timer.start()
	duration_ghost.start()
	instance_gosht ()
	
	
func instance_gosht():
	var ghost: Sprite2D = gosht_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	#se crea la sombra del principal al  moemnto de hacer el dash
	ghost.global_position = sprite.global_position
	ghost.texture = sprite.texture
	ghost.transform = get_parent().transform #obtenemos el transform del padre y lo usa
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes 
	ghost.frame = sprite.frame 
	ghost.flip_h = sprite.flip_h
	
	


func is_dashing():
	return !duration_timer.is_stopped()



#con esto creamos un retardo para no hacer saltos por siepre 
var contador = 0 
const retardo = 1 
var can_dash = true 


func end_dash ():
	duration_ghost.stop()
	if contador == 2  :
		
		can_dash = false 
		await get_tree().create_timer(retardo).timeout
		can_dash = true
		print (contador)
		contador = 0
	else :
		contador +=1
		
		
	



func _on_duration_timer_timeout() -> void:
	end_dash()


func _on_ghos_timer_timeout() -> void:
	instance_gosht()
