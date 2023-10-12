extends KinematicBody2D

#export (PackedScene) var Projectile

var Projectile = preload("res://Projectile.tscn")


onready var end_of_gun = $EndOfGun 

# gravity to keep the player down
var gravity  : = 30.0

var velocity : = Vector2(0,-1)
# controls movement speed
var speed : = 180.0
# jumping is negative and therefore
var jumpforce : = -900.0

func _physics_process( delta: float) -> void:
#movement is a and d
  if Input.is_action_pressed("right_movement"):
    velocity.x = speed
  if Input.is_action_pressed("left_movement"):
    velocity.x = -speed
    
  velocity.y = velocity.y + gravity
  if Input.is_action_just_pressed("jump_movement") and is_on_floor():
    velocity.y = jumpforce

  velocity = move_and_slide(velocity,Vector2.UP)
  
  velocity.x = lerp(velocity.x,0,0.3)
  
  look_at(get_global_mouse_position())
  
func _unhandled_input(event: InputEvent) -> void:
  if event.is_action_released("shoot_action"):
    shoot()
    
func shoot():
  var Projectile_instance = Projectile.instance()
  add_child(Projectile_instance)
  if not Projectile_instance.filename.empty():
      print(true)
  print(false)
  
  Projectile_instance.global_position = end_of_gun.global_position
  var target = get_global_mouse_position()
  var direction_to_mouse = Projectile_instance.global_position.direction_to(target).normalized()
  Projectile_instance.set_direction(direction_to_mouse)
  
  
  
