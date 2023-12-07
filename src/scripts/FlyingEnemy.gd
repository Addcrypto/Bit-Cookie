extends KinematicBody2D

export var speed = 100
export var shoot_cooldown: float = .02
export var bullet_speed: float = 1400
export var bullet_damage: float = 20

onready var bullet_emitter = $GunSprite/BulletEmitter
const Bullet = preload("res://src/prefabs/Bullet.tscn")
const Coin = preload("res://src/prefabs/Coin.tscn")

var last_shot: float = 0
var motion = Vector2.ZERO
var path: Array = []
var NavigationNode = null
var Player = null
var DArea = null
var InRange = null

onready var sprite = $GunSprite

func _ready():
    if get_tree().has_group("Nav"):
        NavigationNode = get_tree().get_nodes_in_group("Nav")[0]
    if get_tree().has_group("Player"):
        Player = get_tree().get_nodes_in_group("Player")[0]
    DArea = get_node("Vision")
    InRange = $GunSprite/Range
        
func CreatePath():
    if NavigationNode != null and Player != null:
        path = NavigationNode.get_simple_path(global_position, Player.global_position, false)
        
func goto():
    if path.size() > 0:
        motion = global_position.direction_to(path[1]) * speed
        sprite.look_at(Player.position)
        
func _make_bullet():
    print("TRYING TO SHOOT YOU")
    var main = get_tree().current_scene
    var new_bullet = Bullet.instance()
    var bullet_vel = Vector2.RIGHT.rotated(sprite.rotation) * bullet_speed
    
    new_bullet.global_position = bullet_emitter.global_position
    new_bullet.Damage = bullet_damage
    new_bullet.set_owner(self)
    new_bullet.apply_impulse(bullet_vel)
    
    main.add_child(new_bullet)        
    
func _make_coin():
    var main = get_tree().current_scene
    var new_coin = Coin.instance()
    new_coin.global_position = self.global_position
    
#    main.add_child(new_coin)
    main.call_deferred("add_child", new_coin)
     
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

func _on_Hurtbox_area_entered(area):
    print(area)
    if("Bullet" in area.name):
        if(area.bullet_owner.is_in_group("Enemies")):
            return
    queue_free()



func _on_FlyingEnemy_tree_exiting():
    print("dead")
    _make_coin()
    pass # Replace with function body.
