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
func _on_Powerup_body_entered(body):
  print( "Player grabbed a powerup." )
  if("Player") in body.name && PlayerVariables.Coins >= 3:
    body.power_up_signal = 1;
    body.Powerup_jump()
    queue_free()
