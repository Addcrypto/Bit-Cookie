extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func _on_Powerup_gun_body_entered(body):
  print( "Player grabbed a upgrade." )
  if("Working") in body.name:
    body.power_up_signal = 2;
    body.Powerup_gun()
  queue_free()
