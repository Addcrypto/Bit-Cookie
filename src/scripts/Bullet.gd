extends Area2D

var bullet_gravity: float = 48
var bullet_velocity: Vector2 = Vector2.ZERO
# How long until the bullet despawns, in seconds
var bullet_lifetime: float = 10

var bullet_owner: Node2D

# Give the bullet velocity
func apply_impulse(impulse):
    bullet_velocity += impulse
    rotation = bullet_velocity.angle()

# Bullets won't hit their owner
func set_owner(owner):
    bullet_owner = owner

# Destroy bullet when it's existed for too long
func _increase_age(dt):
    bullet_lifetime -= dt
    if bullet_lifetime < 0:
        queue_free()

func _physics_process(dt):
    bullet_velocity.y += bullet_gravity
    position += bullet_velocity/60
    rotation = bullet_velocity.angle()
    _increase_age(dt)
    
func _on_body_entered(body):
    if body != bullet_owner:
        queue_free()
