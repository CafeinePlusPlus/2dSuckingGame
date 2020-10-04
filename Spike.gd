extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if !body.playerAnim :
		return
	body.hurt(1)
	body.playerAnim.hide()
	yield(get_tree().create_timer(0.05), "timeout")
	body.playerAnim.modulate = Color(10,10,10,0.3)
	body.playerAnim.show()
	yield(get_tree().create_timer(0.06), "timeout")
	body.playerAnim.hide()
	yield(get_tree().create_timer(0.07), "timeout")
	body.playerAnim.modulate = Color(10,10,10,0.3)
	body.playerAnim.show()
	yield(get_tree().create_timer(0.08), "timeout")
	body.playerAnim.hide()
	yield(get_tree().create_timer(0.09), "timeout")
	body.playerAnim.modulate = Color(1,1,1,1)
	body.playerAnim.show()
	pass # Replace with function body.
