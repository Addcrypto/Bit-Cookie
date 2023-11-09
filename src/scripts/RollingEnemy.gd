extends KinematicBody2D

var velocity = Vector2()
# Acceleration due to gravity
export var gravity: float = 3000
# Maximum horizontal walk speed
export var walk_speed: float = 500
export var Direction = 1
export var Detects_Cliffs = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    if Direction == -1:
        $Sprite.flip_h = true
    $FloorChecker.position.x = $CollisionShape2D.shape.get_radius() * Direction
    $FloorChecker.enabled = Detects_Cliffs

func _physics_process(delta):
    if ((is_on_wall() or not $FloorChecker.is_colliding()) and Detects_Cliffs and is_on_floor()):
        Direction = Direction * -1
        $Sprite.flip_h = not $Sprite.flip_h
        $FloorChecker.position.x = $CollisionShape2D.shape.get_radius() * Direction
    
    velocity.y += gravity
    velocity.x = walk_speed * Direction
    
    velocity = move_and_slide(velocity, Vector2.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
