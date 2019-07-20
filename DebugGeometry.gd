extends ImmediateGeometry

class_name DebugGeometry

var m = SpatialMaterial.new()


func _ready():
	m.set_flag(3, true)
	material_override = m


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			draw_stuff()


func draw_stuff():
	clear()
	begin(Mesh.PRIMITIVE_LINES)
	
	draw_cube(Vector3(-1, 1, -1), 0.9 * Vector3(1, 1, 1), Color(10, 10, 0))
	
	var grid_pos = Vector3(5, 0, -5)
	var grid_normal = Vector3(-0.2, 1.0, 0.9).normalized()
	var grid_tangent = Vector3(-2.0, 0.8, 1.0).normalized()
	draw_line(grid_pos, grid_pos + grid_normal, 0, Color(0, 10, 0))
	draw_line(grid_pos, grid_pos + grid_tangent, 0, Color(0, 0, 10))
	draw_grid(grid_pos, 10, 5, 20, 10, grid_normal, grid_tangent, Color(5, 5, 5))
	
	draw_grid(Vector3(), 10, 10, 10, 10, Vector3.RIGHT, Vector3.BACK, Color(10, 0, 0))
	draw_grid(Vector3(), 10, 10, 10, 10, Vector3.UP, Vector3.RIGHT, Color(0, 10, 0))
	draw_grid(Vector3(), 10, 10, 10, 10, Vector3.BACK, Vector3.RIGHT, Color(0, 0, 10))
	
	set_color(Color(10,10,10))
	draw_cylinder(Vector3(2, -2, 1), Vector3(3, -1, 2), 1.0, 32, true, Color(5, 0, 5))
	draw_cone(Vector3(-4, 1, 0), Vector3(-4, 2, -1), 0.2, 0.5, 16, true, Color(0, 2, 0), false)
	
	draw_sphere(Vector3(-2, -2, 2), 36, 18, 1.5, Color(0, 2, 2))
	
	end()
	
	begin(Mesh.PRIMITIVE_TRIANGLES)
	draw_line(Vector3(2, 1, 0), Vector3(-2, 0, 3), 0.1, Color(0.7, 0.2, 0.1))
	draw_coordinate_system(Vector3.ZERO, Vector3(1, 0, 0), Vector3(0, 1, 0), 1, 10)
	draw_cylinder(Vector3(4, 0, -3), Vector3(2, 1, -4), 0.5, 16, true, Color(1, 1, 1), true)
	draw_cone(Vector3(-3, 1, 0), Vector3(-3, 2, -1), 0.5, 0.2, 16, true, Color(0, 2, 0), true)
	draw_arrow(Vector3(4, 2, 1), Vector3(1, -3, 2), 2, Color(3, 2, 1))
	draw_sphere(Vector3(2, 3, 1), 8, 4, 0.1, Color(0, 0, 0), true)
	draw_coordinate_system(Vector3(-4, 0, -3), Vector3(3, 2, 1), Vector3(1, 1, 1), 0.5, 10)
	
	end()


func add_line(p1 : Vector3, p2 : Vector3):
	add_vertex(p1)
	add_vertex(p2)


func add_triangle(p1 : Vector3, p2 : Vector3, p3 : Vector3):
	add_vertex(p1)
	add_vertex(p2)
	add_vertex(p3)


func draw_cube(p : Vector3, extents : Vector3, c : Color = Color(0, 0, 0), b_triangles = false):
	var x = extents.x
	var y = extents.y
	var z = extents.z
	var points = [Vector3(-x, -y, -z) + p,
			Vector3(-x, -y, z) + p,
			Vector3(-x, y, -z) + p,
			Vector3(-x, y, z) + p,
			Vector3(x, -y, -z) + p,
			Vector3(x, -y, z) + p,
			Vector3(x, y, -z) + p,
			Vector3(x, y, z) + p]
	
	set_color(c)
	if b_triangles:
		add_triangle(points[0], points[2], points[3])
		add_triangle(points[3], points[1], points[0])
		add_triangle(points[4], points[5], points[7])
		add_triangle(points[7], points[6], points[4])
		add_triangle(points[0], points[1], points[5])
		add_triangle(points[5], points[4], points[0])
		add_triangle(points[3], points[2], points[7])
		add_triangle(points[7], points[2], points[6])
		add_triangle(points[0], points[4], points[2])
		add_triangle(points[2], points[4], points[6])
		add_triangle(points[1], points[3], points[7])
		add_triangle(points[7], points[5], points[1])
	else:
		add_line(points[0], points[1])
		add_line(points[1], points[3])
		add_line(points[3], points[2])
		add_line(points[2], points[0])
		add_line(points[4], points[5])
		add_line(points[5], points[7])
		add_line(points[7], points[6])
		add_line(points[6], points[4])
		add_line(points[0], points[4])
		add_line(points[1], points[5])
		add_line(points[3], points[7])
		add_line(points[2], points[6])


func draw_sphere(p : Vector3, lon : int, lat : int, r : float, c : Color = Color(0, 0, 0), b_triangles = false):
	for i in range(1, lat + 1):
		var lat0 = PI * (-0.5 + (i - 1) as float / lat)
		var y0 = sin(lat0)
		var r0 = cos(lat0)
		var lat1 = PI * (-0.5 + i as float / lat)
		var y1 = sin(lat1)
		var r1 = cos(lat1)
		for j in range(1, lon + 1):
			var lon0 = 2 * PI * ((j - 1) as float / lon)
			var x0 = cos(lon0)
			var z0 = sin(lon0)
			var lon1 = 2 * PI * (j as float / lon)
			var x1 = cos(lon1)
			var z1 = sin(lon1)
			
			var points = [r * Vector3(x1 * r0, y0, z1 * r0) + p,
					r * Vector3(x1 * r1, y1, z1 * r1) + p,
					r * Vector3(x0 * r1, y1, z0 * r1) + p,
					r * Vector3(x0 * r0, y0, z0 * r0) + p]
			
			set_color(c)
			if b_triangles:
				add_triangle(points[0], points[1], points[2])
				add_triangle(points[2], points[3], points[0])
			else:
				add_line(points[0], points[1])
				add_line(points[1], points[2])


func draw_cylinder(p1 : Vector3, p2 : Vector3, r : float, lon : int = 8, b_caps = true,
		color : Color = Color(0, 0, 0), b_triangles = false):
	draw_cone(p1, p2, r, r, lon, b_caps, color, b_triangles)


func draw_cone(p1 : Vector3, p2 : Vector3, r1 : float, r2 : float, lon : int = 8,
		b_caps = true, color : Color = Color(0, 0, 0), b_triangles = false):
	var h = (p2 - p1).length()
	for i in range(1, lon + 1):
		var lon0 = 2 * PI * ((i - 1) as float / lon)
		var x0 = cos(lon0)
		var z0 = sin(lon0)
		var lon1 = 2 * PI * (i as float / lon)
		var x1 = cos(lon1)
		var z1 = sin(lon1)
		
		var points = [Vector3(x0 * r1, 0, z0 * r1),
				Vector3(x0 * r2, h, z0 * r2),
				Vector3(x1 * r1, 0, z1 * r1),
				Vector3(x1 * r2, h, z1 * r2),
				Vector3(0.0, 0, 0.0),
				Vector3(0.0, h, 0.0)]
		
		var dir = (p2 - p1).normalized()
		var rot
		var ang
		if dir == Vector3.UP:
			rot = Vector3.UP
			ang = 0
		else:
			rot = Vector3.UP.cross(dir).normalized()
			ang = Vector3.UP.angle_to(dir)
		for i in range(points.size()):
			points[i] = points[i].rotated(rot, ang) + p1
			
		
		set_color(color)
		if b_triangles:
			add_triangle(points[0], points[2], points[1])
			add_triangle(points[1], points[2], points[3])
			if b_caps:
				add_triangle(points[0], points[4], points[2])
				add_triangle(points[1], points[3], points[5])
		else:
			add_line(points[0], points[1])
			add_line(points[1], points[3])
			add_line(points[2], points[0])
			if b_caps:
				add_line(points[0], points[4])
				add_line(points[1], points[5])


func draw_arrow(p : Vector3, n : Vector3, s : float = 1.0, c : Color = Color(0, 0, 0)):
	n = n.normalized()
	draw_cylinder(p, p + 0.8 * n * s, 0.05 * s, 8, true, c, true)
	draw_cone(p + 0.8 * n * s, p + n * s, 0.1 * s, 0, 8, true, c, true)


func draw_coordinate_system(p : Vector3, x : Vector3 = Vector3.RIGHT, y : Vector3 = Vector3.UP, s : float = 1.0,
		c : float = 1.0):
	x = x.normalized()
	var z = x.cross(y).normalized()
	y = z.cross(x).normalized()
	
	c = clamp(c, 0, 10)
	draw_arrow(p, x, s, Color(c, 0, 0))
	draw_arrow(p, y, s, Color(0, c, 0))
	draw_arrow(p, z, s, Color(0, 0, c))


func draw_grid(p : Vector3, a : float, b : float, div_a : int, div_b : int,
		normal : Vector3 = Vector3(0, 1, 0),
		tangent : Vector3 = Vector3(1, 0, 0),
		color : Color = Color(0, 0, 0)):
	if tangent == normal:
		tangent = Vector3.RIGHT
	
	var normal_rot
	var normal_angle
	if normal == Vector3.UP:
		normal_rot = normal
		normal_angle = 0.0
	else:
		normal_rot = Vector3.UP.cross(normal).normalized()
		normal_angle = Vector3.UP.angle_to(normal)
		if normal.cross(Vector3.UP).normalized() == -normal.normalized():
			normal_angle = -normal_angle
	var rotated_right_vector = Vector3.RIGHT.rotated(normal_rot, normal_angle)
	var tangent_rot = normal.normalized()
	var proj = tangent - tangent.dot(normal) / normal.length_squared() * normal
	var tangent_angle = rotated_right_vector.angle_to(proj)
	if rotated_right_vector.cross(proj).normalized() != normal.normalized():
		tangent_angle = -tangent_angle
	
	set_color(color)
	for i in range(0, div_a + 1):
		var lx = a * (i as float / div_a - 0.5)
		add_line(Vector3(lx, 0, -b / 2.0).rotated(normal_rot, normal_angle).rotated(tangent_rot, tangent_angle) + p,
				Vector3(lx, 0, b / 2.0).rotated(normal_rot, normal_angle).rotated(tangent_rot, tangent_angle) + p)
	for j in range(0, div_b + 1):
		var lz = b * (j as float / div_b - 0.5)
		add_line(Vector3(-a / 2.0, 0, lz).rotated(normal_rot, normal_angle).rotated(tangent_rot, tangent_angle) + p,
				Vector3(a / 2.0, 0, lz).rotated(normal_rot, normal_angle).rotated(tangent_rot, tangent_angle) + p)


func draw_line(p1 : Vector3, p2 : Vector3, thickness : float, color : Color = Color(0, 0, 0)):
	if thickness <= 0.0:
		set_color(color)
		add_line(p1, p2)
	else:
		set_color(color)
		draw_cylinder(p1, p2, thickness / 2, 8, false, color, true)
