extends KinematicBody2D

var dpad


func _on_RightArr_pressed():
	dpad.animation = "right"
	dpad.frame = 1



func _on_Arr_released():
	print("YES")
	dpad.frame = 0


func _on_DownArr_pressed():
	dpad.animation = "down"
	dpad.frame = 1


func _on_LeftArr_pressed():
	dpad.animation = "left"
	dpad.frame = 1


func _on_UpArr_pressed():
	dpad.animation = "up"
	dpad.frame = 1


func _ready():
	dpad = get_node("./TouchLayer/DPAD/Sprite")
	$TouchLayer/DPAD/RightArr.connect("pressed", self, "_on_RightArr_pressed")
	$TouchLayer/DPAD/DownArr.connect("pressed", self, "_on_DownArr_pressed")
	$TouchLayer/DPAD/LeftArr.connect("pressed", self, "_on_LeftArr_pressed")
	$TouchLayer/DPAD/UpArr.connect("pressed", self, "_on_UpArr_pressed")
	$TouchLayer/DPAD/RightArr.connect("released", self, "_on_Arr_released")
	$TouchLayer/DPAD/DownArr.connect("released", self, "_on_Arr_released")
	$TouchLayer/DPAD/LeftArr.connect("released", self, "_on_Arr_released")
	$TouchLayer/DPAD/UpArr.connect("released", self, "_on_Arr_released")
	print(dpad)

func _input(event):
	if event is InputEventScreenTouch:
		print("some sorry ass signals wont work")
