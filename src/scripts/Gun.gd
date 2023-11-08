extends Node2D

export var shoot_cooldown: float = .02
export var bullet_speed: float = 1400

onready var sprite = $Sprite
onready var bullet_emitter = $BulletEmitter

const Bullet = preload("res://src/prefabs/Bullet.tscn")

func _ready():
    pass # Replace with function body.

var last_shot: float = 0

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

func _physics_process(dt):
    var mouse_pos = get_global_mouse_position()
    var gun_pos = global_position

    if Input.is_action_just_pressed("shoot"):
        _shoot()

    look_at(mouse_pos)
    sprite.flip_v = true if mouse_pos.x < gun_pos.x else false
