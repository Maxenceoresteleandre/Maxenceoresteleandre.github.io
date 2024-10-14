extends Path2D
tool


export var update_node : bool = false setget pls_update_my_node
export var node_to_update : NodePath = ""


func pls_update_my_node(_new_value := true):
	var p : Polygon2D = get_node(node_to_update)
	if p != null:
		set_obj_polygon(p)

func set_obj_polygon(p : Polygon2D):
	p.polygon = curve.get_baked_points()
	if p.has_method("draw_object"):
		p.draw_object()
	update_node = false
