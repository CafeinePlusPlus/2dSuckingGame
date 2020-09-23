extends Node2D


func _ready():
	pass
func positionBullet(pos):
	position = pos
	return self

func _process(delta):
	position.x += 100.0*delta

func reset(pos):
	position = pos
	self.show()


func _on_Area_body_entered(body):
	print("HIT!")
	body.hurt(0.5)
	self.hide()
