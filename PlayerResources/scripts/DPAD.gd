extends Node2D

var dpad

func _ready():
	dpad = get_parent().get_node("Sprite")
	$DownArr.connect("pressed",self,"_on_DownArr_pressed",[],CONNECT_PERSIST)
	$LeftArr.connect("pressed",self,"_on_LeftArr_pressed",[],CONNECT_PERSIST)
	$RightArr.connect("pressed",self,"_on_RightArr_pressed",[],CONNECT_PERSIST)
	$UpArr.connect("pressed",self,"_on_UpArr_pressed",[],CONNECT_PERSIST)
	$DownArr.connect("released",self,"_on_Arr_released")
	$LeftArr.connect("released",self,"_on_Arr_released")
	$RightArr.connect("released",self,"_on_Arr_released")
	$UpArr.connect("released",self,"_on_Arr_released")

func _on_RightArr_pressed():
	print("BAd")
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
