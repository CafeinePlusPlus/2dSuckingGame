extends KinematicBody2D

var velocity = Vector2(20.0,0.0)
var patrolPoint = 0
const patrol = 20
var lifePoint = 5
var lifeBar
var lifeBarLength

func _ready():
	lifeBar = get_node("Line2D")
	lifeBarLength = abs(lifeBar.points[0].x - lifeBar.points[1].x)/lifePoint

func hurt(lp):
	lifePoint -= lp
	lifeBar.points[1].x -= lp * lifeBarLength
	if lifePoint == 0:
		queue_free()

func _physics_process(delta):
	velocity.x = clamp(velocity.x,-20.0,20.0)
	move_and_slide(velocity,Vector2(0,1))
	patrolPoint += velocity.x * delta
	if abs(patrolPoint) > patrol:
		velocity.x = -velocity.x
