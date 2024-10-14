tool
extends Polygon2D


func draw_object():
	$StaticBody2D/CollisionPolygon2D.polygon = polygon
	$Line2D.points = polygon
	if len(polygon) > 0:
		$Line2D.add_point(polygon[0])

func _ready():
	draw_object()

func _on_Wall_draw():
	draw_object()
