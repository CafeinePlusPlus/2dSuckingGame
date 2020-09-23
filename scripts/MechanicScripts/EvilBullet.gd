extends Node2D

var parent
var direction

func _ready():
	pass

func _process(delta):
	position.x += direction * rand_range(0,4)
	position.y += rand_range(-3,3)

func setDirection(dir):
	direction = dir

func positionBullet(pos):
	position = pos
	return self
func _on_Area2D_body_entered(body):
	print("PPP")
	body.flash()
	pass # Replace with function body.
