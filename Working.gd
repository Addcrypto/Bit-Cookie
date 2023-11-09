extends KinematicBody2D

#export (PackedScene) var Projectile

var Projectile = preload("res://Projectile.tscn")
var power_up_signal=0
var death_signal=0
var timer_duration = 3

# gravity to keep the player down
var gravity  : = 30.0
# chances to prevent the player from dying
var health = 100;

var velocity : = Vector2(0,-1)
# controls movement speed
var speed : = 180.0
var speed_add : = 0.0
# jumping is negative and therefore
var jumpforce : = -900.0

func _physics_process(_delta: float) -> void:
  
#movement is a and d
  if Input.is_action_pressed("right_movement"):
    velocity.x = speed + speed_add
  elif Input.is_action_pressed("left_movement"):
    velocity.x = -speed - speed_add
    
  if Input.is_action_pressed("Sprint_action"):
    speed_add = speed
  else:
    speed_add = 0
    
  velocity.y = velocity.y + gravity
  if Input.is_action_just_pressed("jump_movement") and is_on_floor():
    velocity.y = jumpforce

  velocity = move_and_slide(velocity,Vector2.UP)
  
  velocity.x = lerp(velocity.x,0,0.3)
  
func gotoStart() -> void :
    position = Vector2(0, 0)

func kill_block_touch():
  if death_signal == 1:
    health = 0
    reset_on_kill()


func reset_on_kill():
  if(health <= 0):
    print(health)
    get_tree().reload_current_scene()



#func shoot():
#  var Projectile_instance = Projectile.instance()
#  add_child(Projectile_instance)
#  Projectile_instance.global_position = end_of_gun.global_position
#  var target = get_global_mouse_position()
#  var direction_to_mouse = Projectile_instance.global_position.direction_to(target).normalized()
#  Projectile_instance.set_direction(direction_to_mouse)



func Powerup_jump():
  if power_up_signal == 1:
    var prevjump = jumpforce
    jumpforce *= 1.5
    yield(get_tree().create_timer(timer_duration), "timeout")
    jumpforce = prevjump
  
  
func Powerup_gun():
  var prev_time = $gun.timing
  print(prev_time)
  if power_up_signal == 2:
    get_child(2).timing = .1
    print(get_child(2).timing)
    yield(get_tree().create_timer(timer_duration), "timeout")
    $gun.timing = prev_time
