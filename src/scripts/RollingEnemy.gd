extends KinematicBody2D

var velocity = Vector2()
# Acceleration due to gravity
export var gravity: float = 3000
# Maximum horizontal walk speed
export var walk_speed: float = 500
export var Health = 100
export var Direction = 1
export var Detects_Cliffs = true

const Coin = preload("res://src/prefabs/Coin.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    if Direction == -1:
        $Sprite.flip_h = true
    $FloorChecker.position = $CollisionShape2D.shape.get_extents() * Vector2(Direction, 1)
    $FloorChecker.enabled = Detects_Cliffs

func _physics_process(_delta):
    if ((is_on_wall() or not $FloorChecker.is_colliding()) and Detects_Cliffs and is_on_floor()):
        Direction = Direction * -1
        $Sprite.flip_h = not $Sprite.flip_h
        $FloorChecker.position = $CollisionShape2D.shape.get_extents() * Vector2(Direction, 1)
    
    velocity.y += gravity
    velocity.x = walk_speed * Direction
    
    velocity = move_and_slide(velocity, Vector2.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _make_coin():
    var main = get_tree().current_scene
    var new_coin = Coin.instance()
    new_coin.global_position = self.global_position
    
#    main.add_child(new_coin)
    main.call_deferred("add_child", new_coin)

#attempt to signal to lose health and kill player.
func _on_RollingEnemy_child_entered_tree(body):
#  print(body)
#  print( "Player touched enemy" )
  if("Player") in body.name:
    body.health_gone= 1;
    body.check_on_player()
    body.die()


func _on_Hurtbox_area_entered(_area):
#    print(area)
    queue_free()
    pass # Replace with function body.


func _on_Hurtbox_body_entered(body):
#    print(body)
    if(body.name == "Player"):
        queue_free()
    pass # Replace with function body.


func _on_RollingEnemy_tree_exiting():
    print("dead")
    _make_coin()
    pass # Replace with function body.
