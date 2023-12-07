extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var collect = $Collect

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func _on_Coin_body_entered(_body):
  print( "Player grabbed a coin." )
  collect.play()
#  if("Player") in body.name:
#    PlayerVariables.Coins += 1;
#    print(PlayerVariables.Coins )
  queue_free()
