extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Health = 100
var Coins = 0
var speed = 500
var jump = 13
var Can = 0
var Spring = 0
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func Reset():
    Health = 100
    Coins = 0
    speed = 500
    jump = 13
