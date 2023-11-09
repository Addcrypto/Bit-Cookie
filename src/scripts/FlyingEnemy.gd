extends KinematicBody2D

export var speed = 100
export var shoot_cooldown: float = .02
export var bullet_speed: float = 1400

onready var bullet_emitter = $BulletEmitter
const Bullet = preload("res://src/prefabs/Bullet.tscn")

var last_shot: float = 0
var motion = Vector2.ZERO
var path: Array = []
var NavigationNode = null
var Player = null
var DArea = null
var InRange = null

func _ready():
    if get_tree().has_group("Nav"):
        NavigationNode = get_tree().get_nodes_in_group("Nav")[0]
    if get_tree().has_group("Player"):
        Player = get_tree().get_nodes_in_group("Player")[0]
    DArea = get_node("Vision")
    InRange = get_node("Range")
        
func CreatePath():
    if NavigationNode != null and Player != null:
        path = NavigationNode.get_simple_path(global_position, Player.global_position, false)
        
func goto():
    if path.size() > 0:
        motion = global_position.direction_to(path[1]) * speed
        look_at(Player.position)
        
func _make_bullet():
    var main = get_tree().current_scene
    var new_bullet = Bullet.instance()
    var bullet_vel = Vector2.RIGHT.rotated(rotation) * bullet_speed
    
    new_bullet.global_position = bullet_emitter.global_position
    new_bullet.set_owner(get_parent())
    new_bullet.apply_impulse(bullet_vel)
    
    main.add_child(new_bullet)        
    
func _shoot():
    if OS.get_ticks_msec() - last_shot < shoot_cooldown*1000:
        return
    last_shot = OS.get_ticks_msec()
    _make_bullet()
        
func _physics_process(_delta):    
    #print(DArea.get_overlapping_bodies())
    #
    
    if Player in DArea.get_overlapping_bodies():
        CreatePath()
        goto()
            
        if !(Player in InRange.get_overlapping_bodies()):
            motion = move_and_slide(motion)
        else:
            _shoot()


func _on_Hurtbox_area_entered(_area):
    queue_free()

