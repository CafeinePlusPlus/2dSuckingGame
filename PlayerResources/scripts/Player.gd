extends KinematicBody2D


var dpad
var downcast
var playerAnim
var bullet
var eBar
var eBarLength
var b_instance = []
var movement = 0b0000
signal rightImpulse
signal leftImpulse
signal playerJump
signal playerCrounch
var insCursor = 0
var velocity = Vector2(0.0,0.0)
const accel = 10
const maxSpeed = 170
const maxJump = 170
const maxFall = 120
const gravity = 120
const maxEnergy = 5
var energy = 5
var cooldown = 0

func _ready():
	dpad = get_node("./DPAD/Sprite")
	downcast = get_node("RayCast2D")
	playerAnim = get_node("AnimatedSprite")
	get_node("Camera2D").make_current()
	eBar = get_node("EnergyBar/Line2D")
	eBarLength = (abs(eBar.points[0].y - eBar.points[1].y) - 10) / maxEnergy
	bullet = preload("res://MagicBullet.tscn")

func _physics_process(delta):
	cooldown += delta
	if(cooldown > 3 && energy != maxEnergy):
		cooldown = 0
		energy += 1
		eBar.points[0].y -= eBarLength
	if(movement & 2):
		velocity.x += accel
	elif(movement & 8):
		velocity.x -= accel
	else:
		velocity.x = lerp(velocity.x,0,0.2)
	if(movement & 1):
		velocity.y = float(is_on_floor())*(-maxJump - velocity.y) + velocity.y
		movement &= ~1
	elif(movement & 4):
		pass
	else:
		pass
		#velocity.y += gravity*delta
	velocity.y += gravity*delta
	velocity.x = clamp(velocity.x,-maxSpeed,maxSpeed)
	velocity.y = clamp(velocity.y,-maxJump,maxFall)
	move_and_slide(velocity,Vector2(0,-1))


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		if shape_idx == 0:
			dpad.animation = "up"
			movement = (movement | 1 << shape_idx) & ~4
			
			#velocity.y = (float(downcast.is_colliding()))*(velocity.y + maxSpeed) - maxSpeed
		elif shape_idx == 1:
			movement = (movement | 1 << shape_idx) & ~8
			dpad.animation = "right"
			playerAnim.animation = "RightWalk"
			playerAnim.flip_h = false
			#velocity.x += accel
		elif shape_idx == 2:
			movement = (movement | 1 << shape_idx) & ~1
			dpad.animation = "down"
		elif shape_idx == 3:
			movement = (movement | 1 << shape_idx) & ~2
			dpad.animation = "left"
			playerAnim.animation = "LeftWalk"
			playerAnim.flip_h = true
			#velocity.x -= accel
		else:
			dpad.frame = 0
			movement = 0
			return
		
		#velocity = velocity.normalized()
		dpad.frame = 1
	if event is InputEventScreenTouch and !event.is_pressed():
		dpad.frame = 0
		playerAnim.animation = "idle"
		movement = 0

func _on_Xbutton_pressed():
	if energy == 0:
		return
	if b_instance.size() < maxEnergy:
		b_instance.push_back(bullet.instance())
		
		b_instance[b_instance.size() - 1].positionBullet(self.position)
		get_parent().add_child(b_instance[b_instance.size() - 1])
	else:
		b_instance[insCursor%maxEnergy].reset(self.position)
		insCursor+=1
	energy -= 1
	eBar.points[0].y += eBarLength
	# Replace with function body.
