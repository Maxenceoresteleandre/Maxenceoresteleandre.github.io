tool
extends Polygon2D

onready var collision_polygon2d : CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
onready var line2d : Line2D = $Line2D

func draw_object() -> void:
	collision_polygon2d.polygon = polygon
	line2d.points = polygon
	if len(polygon) > 0:
		line2d.add_point(polygon[0])

func _ready() -> void:
	draw_object()

func _on_Wall_draw() -> void:
	draw_object()
