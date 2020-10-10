extends KinematicBody2D


var dpad
var downcast
var playerAnim
var bullet
var bomb
var eBar
var eBarLength
var hBar
var hBarLength
var lifePoint = 5
var b_instance = []
var movement = 0b0000
var insCursor = 0
var velocity = Vector2(0.0,0.0)
const accel = 10
const maxSpeed = 170
const maxJump = 170
const maxFall = 120
const gravity = 120
const maxEnergy = 5
const maxHealth = 5
var energy = 5
var cooldown = 0
var weapon # 0 == none, 1 == bullet, 2 == bomb

func _ready():
	dpad = get_node("./DPAD/Sprite")
	downcast = get_node("RayCast2D")
	playerAnim = get_node("AnimatedSprite")
	get_node("Camera2D").make_current()
	eBar = get_node("EnergyBar/Line2D")
	eBarLength = (abs(eBar.points[0].y - eBar.points[1].y)) / maxEnergy
	hBar = get_node("HealthBar/Line2D")
	hBarLength = (abs(hBar.points[0].y - hBar.points[1].y)) / maxHealth
	weapon = 1
	if weapon == 1:
		playerAnim.animation = "idle"
		bullet = preload("res://MagicBullet.tscn")
	elif weapon == 0:
		playerAnim.animation = "idleWithoutWeapon"
	elif weapon == 2:
		bomb = preload("res://MagicBomb.tscn")
		playerAnim.animation = "idleWithMBomb"

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
	

func flash():
	player_animation(1, 0, 0, 0.3, 0.5)
	
	
func hurt(lp):
	if lifePoint > 0 :
		lifePoint -= lp
		hBar.points[1].y -= lp * hBarLength
		if lifePoint == 1 :
			hBar.change_color(Color(1, 0.023438, 0))
		if lifePoint == 2 :
			hBar.change_color(Color(1, 0.515625, 0))
		if lifePoint == 3 :
			hBar.change_color(Color(0.898039, 1, 0))
	if lifePoint <= 0:
		print("GAME OVER!")
		queue_free()
		
		
func player_animation(float1, float2, float3, float4, delay_time):
	playerAnim.modulate = Color(float1, float2, float3, float4)
	yield(get_tree().create_timer(delay_time), "timeout")
	playerAnim.modulate = Color(1,1,1,1)
	

		
func heal(lp):
	if lifePoint < 5 : 
		lifePoint += lp
		if lifePoint == 2 :
			hBar.change_color(Color(1, 0.515625, 0))
		if lifePoint == 3 :
			hBar.change_color(Color(0.898039, 1, 0))
		if lifePoint == 4 :
			hBar.change_color(Color(0, 0.858824, 1))
		hBar.points[1].y += lp * hBarLength


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		if shape_idx == 0:
			dpad.animation = "up"
			movement = (movement | 1 << shape_idx) & ~4
			
			#velocity.y = (float(downcast.is_colliding()))*(velocity.y + maxSpeed) - maxSpeed
		elif shape_idx == 1:
			movement = (movement | 1 << shape_idx) & ~8
			dpad.animation = "right"
			if weapon == 1 :
				playerAnim.animation = "RightWalk"
			elif weapon == 0 :
				playerAnim.animation = "RightWalkWithoutWeapon"
			elif weapon == 2:
				playerAnim.animation = "RightWalkWithMBomb"
			playerAnim.flip_h = false
			#velocity.x += accel
		elif shape_idx == 2:
			movement = (movement | 1 << shape_idx) & ~1
			dpad.animation = "down"
		elif shape_idx == 3:
			movement = (movement | 1 << shape_idx) & ~2
			dpad.animation = "left"
			if weapon == 1 :
				playerAnim.animation = "LeftWalk"
			elif weapon == 0 :
				playerAnim.animation = "RightWalkWithoutWeapon"
			elif weapon == 2:
				playerAnim.animation = "LeftWalkWithMBomb"
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
		if weapon == 1:
			playerAnim.animation = "idle"
		elif weapon == 0:
			playerAnim.animation = "idleWithoutWeapon"
		elif weapon == 2:
			playerAnim.animation = "idleWithMBomb"
		movement = 0

func _on_Xbutton_pressed():
	if weapon == 1:
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
	if weapon == 2:
		if energy == 0:
			return
		if b_instance.size() < maxEnergy:
				b_instance.push_back(bomb.instance())
				
				b_instance[b_instance.size() - 1].positionBomb(self.position)
				get_parent().add_child(b_instance[b_instance.size() - 1])
		else:
			b_instance[insCursor%maxEnergy].reset(self.position)
			insCursor+=1
		energy -= 1
		eBar.points[0].y += eBarLength
		
	# Replace with function body.
