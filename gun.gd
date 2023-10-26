extends Sprite
var projectile = preload("res://Projectile.tscn")
var state = "shoot"

onready var end_of_gun = $EndOfGun 


# Declare member variables here. Examples:
var can_fire = true

# Called when the node enters the scene tree for the first time.
func _ready():
  set_as_toplevel(true)
  
func _physics_process(delta):
  position.x = lerp(position.x, get_parent().position.x, 0.5)
  position.y = lerp(position.y, get_parent().position.y+10, 0.5)
  var mouse_pos = get_global_mouse_position()
  look_at(mouse_pos)
  
  if Input.is_action_pressed("shoot_action")and can_fire:
    
    call(state)

func shoot():
  var projectile_instance = projectile.instance()
  projectile_instance.rotation = rotation + rand_range(-0.1, 0.1)
  projectile_instance.global_position = end_of_gun.global_position
  get_parent().add_child(projectile_instance)
  can_fire = false
  yield(get_tree().create_timer(0.5), "timeout")
  can_fire = true
