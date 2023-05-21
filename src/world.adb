with Common; use Common;

package body World is
	-----------------------------------------------------------------------------------------------
	---- Coord
	function "+"(a, b: Coord) return Coord is
		c: Coord;
	begin
		c.x := a.x + b.x;
		c.y := a.y + b.y;
		return c;
	end "+";

	function "-"(a, b: Coord) return Coord is
		c: Coord;
	begin
		c.x := a.x - b.x;
		c.y := a.y - b.y;
		return c;
	end "-";

	function above_coord(a: Coord) return Coord is
		c: Coord;
	begin
		c.x := a.x;
		c.y := a.y - 1;
		return c;
	end above_coord;

	function below_coord(a: Coord) return Coord is
		c: Coord;
	begin
		c.x := a.x;
		c.y := a.y + 1;
		return c;
	end below_coord;

	function left_coord(a: Coord) return Coord is
		c: Coord;
	begin
		c.x := a.x - 1;
		c.y := a.y;
		return c;
	end left_coord;

	function right_coord(a: Coord) return Coord is
		c: Coord;
	begin
		c.x := a.x + 1;
		c.y := a.y;
		return c;
	end right_coord;

	function relative_coord(a: Coord; d: Direction) return Coord is
		c: Coord;
	begin
		case d is
			when Left        => c.x := a.x - 1; c.y := a.y + 0;
			when TopLeft     => c.x := a.x - 1; c.y := a.y - 1;
			when Top         => c.x := a.x + 0; c.y := a.y - 1;
			when TopRight    => c.x := a.x + 1; c.y := a.y - 1;
			when Right       => c.x := a.x + 1; c.y := a.y + 0;
			when BottomRight => c.x := a.x + 1; c.y := a.y + 1;
			when Bottom      => c.x := a.x + 0; c.y := a.y + 1;
			when BottomLeft  => c.x := a.x - 1; c.y := a.y + 1;
		end case;
		return c;
	end relative_coord;

	procedure println(a: Coord) is begin
		Common.println("(" & Integer'Image(Integer(a.x)) & "," & Integer'Image(Integer(a.y)) & ")");
	end println;


	-----------------------------------------------------------------------------------------------
	---- Cell
	function get_cell(x, y: Length) return Cell is begin
		return world(x)(y);
	end get_cell;

	function get_cell(r: Coord) return Cell is begin
		return world(r.x)(r.y);
	end get_cell;

	function get_cell(a: Area) return Cell is begin
		return world(Length(Integer(a) / Size))(Length(Integer(a) mod Size));
	end get_cell;

	procedure set_cell(x, y: Length; c: Cell) is begin
		world(x)(y) := c;
	end set_cell;

	procedure set_cell(r: Coord; c: Cell) is begin
		world(r.x)(r.y) := c;
	end set_cell;

	procedure set_cell(a: Area; c: Cell) is begin
		world(Length(Integer(a) / Size))(Length(Integer(a) mod Size)) := c;
	end set_cell;

	function above_cell(a: Coord) return Cell is begin
		return get_cell(above_coord(a));
	end above_cell;

	function below_cell(a: Coord) return Cell is begin
		return get_cell(below_coord(a));
	end below_cell;

	function left_cell(a: Coord) return Cell is begin
		return get_cell(left_coord(a));
	end left_cell;

	function right_cell(a: Coord) return Cell is begin
		return get_cell(right_coord(a));
	end right_cell;

	procedure print(a: Cell) is begin
		if(a = Alive) then
			Common.print("@");
		else
			Common.print(" ");
		end if;
	end print;


	-----------------------------------------------------------------------------------------------
	---- World
	procedure print_world is begin
		for i in Length loop print("="); end loop; println("==");
		for i in Area loop
			if(Integer(i) mod Size = 0) then print("|"); end if;
			print(get_cell(i));
			if(Integer(i) mod Size = Size-1) then println("|"); end if;
		end loop;
		for i in Length loop print("="); end loop; println("==");
	end print_world;

	procedure sim is
		scan: Coord;
	begin
		for i in Area loop
			scan.x := Length(i  /  Area(Size));
			scan.y := Length(i mod Area(Size));
			--  if get_coord(right)
			--  set_cell(i, Alive);
		end loop;
	end sim;
end World;