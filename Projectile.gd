extends Area2D

export (int ) var speed = 300

var direction := Vector2.ZERO

func _physics_process(_delta):
  if direction != Vector2.ZERO:
    var velocity = direction * speed
      
    global_position += velocity
      
      
func set_direction(direction: Vector2):
  self.direction = direction

