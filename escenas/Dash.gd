extends Node2D
@onready var duration_timer = $DurationTimer

func  start_dash(duration):
	
	duration_timer.wait_time = duration
	duration_timer.start()
	
	
func is_dashing():
	return !duration_timer.is_stopped()


#con esto creamos un retardo para no hacer saltos por siepre 
const retardo = 0.4 
var can_dash = true 
func end_dash ():
	can_dash = false 
	await get_tree().create_timer(retardo).timeout
	can_dash = true
	

func _on_duration_timer_timeout() -> void:
	end_dash()
