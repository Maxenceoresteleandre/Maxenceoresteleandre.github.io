extends KinematicBody2D
class_name DynamicObject

export var mass : float = 1.0

var ponctual_physic_force := Vector2.ZERO
var constant_physic_force := Vector2.ZERO
var physic_force := Vector2.ZERO

func add_force_ponctual(force):
	ponctual_physic_force += force

func add_force_permanent(force):
	constant_physic_force += force

func _physics_process(delta):
	compute_physics()

func compute_physics():
	physic_force = ponctual_physic_force + constant_physic_force
	ponctual_physic_force = Vector2.ZERO

func death():
	pass
