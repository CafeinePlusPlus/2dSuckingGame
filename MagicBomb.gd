extends Node2D

var exploison
var bomb

func _ready():
	exploison = get_node("Area2D/ExploisonBlue")
	exploison.hide()
	bomb = get_node("Sprite")
	
func positionBomb(pos):
	position = pos
	return self

func _process(delta):
	position.x += 90.0*delta

func reset(pos):
	position = pos
	self.show()

func _on_Area2D_body_entered(body):
	exploison.show()
	print("HIT!")
	body.hurt(3)
	bomb.hide()
	yield(get_tree().create_timer(0.5),"timeout")
	exploison.hide()
