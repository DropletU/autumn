extends RigidBody2D

@onready var hitbox = $HitBox2D
@export var shoot_strength: float = 100.0
@export_range(1.0, 100.0) var damage: float = 10.0
@export var cause_splatter: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.body_entered.connect(_on_target_hit)
	apply_central_impulse(Vector2.RIGHT.rotated(rotation)*shoot_strength)
	hitbox.damage = damage
	hitbox.cause_splatter = cause_splatter
	collision_mask = 1 << 1
	collision_layer = 0
	

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if linear_velocity.length_squared() > 10.0:
		var target_angle = linear_velocity.angle()
		
		state.transform = Transform2D(target_angle, position)
	

func _on_target_hit(body: Node2D):
	if body is not HurtBox2D:
		return
	body = body as HurtBox2D
	body.take_damage(hitbox.damage, hitbox)
	
