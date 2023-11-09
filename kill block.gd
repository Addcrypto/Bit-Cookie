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


func _on_kill_block_body_entered(body):
  print( "Player touched kill block" )
  if("Working") in body.name:
    body.death_signal = 1;
    body.kill_block_touch()
