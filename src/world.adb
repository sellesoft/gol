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

	function relative_coord(a: Coord; d: Direction) return Coord is begin
		case d is
			when Left        => return a + (-1, 0);
			when TopLeft     => return a + (-1,-1);
			when Top         => return a + ( 0,-1);
			when TopRight    => return a + ( 1,-1);
			when Right       => return a + ( 1, 0);
			when BottomRight => return a + ( 1, 1);
			when Bottom      => return a + ( 0, 1);
			when BottomLeft  => return a + (-1, 1);
		end case;
	end relative_coord;

	procedure print(a: Coord) is begin
		Common.print("(" & Integer'Image(Integer(a.x)) & "," & Integer'Image(Integer(a.y)) & ")");
	end print;

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
		world_buffer(Size+5 + Integer(y)*3 + Integer(y)*Size + Integer(x)) := (if (c = Alive) then '@' else ' ');
	end set_cell;

	procedure set_cell(r: Coord; c: Cell) is begin
		world(r.x)(r.y) := c;
		world_buffer(Size+5 + Integer(r.y)*3 + Integer(r.y)*Size + Integer(r.x)) := (if (c = Alive) then '@' else ' ');
	end set_cell;

	procedure set_cell(a: Area; c: Cell) is begin
		world(Length(Integer(a) / Size))(Length(Integer(a) mod Size)) := c;
		world_buffer(Size+5 + (Integer(a) / Size)*3 + Integer(a)) := (if (c = Alive) then '@' else ' ');
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


	-----------------------------------------------------------------------------------------------
	---- World
	procedure init_world is
		cursor: Integer := 1;
		LF: constant Character := Character'Val(10);
		
		procedure put_buffer(c: Character) is begin
			world_buffer(cursor) := c;
			cursor := cursor + 1;
		end put_buffer;
	begin
		--init the world buffer
		for i in 1..(Size+2) loop put_buffer('='); end loop; put_buffer(LF);
		for i in Area loop
			if(Integer(i) mod Size = 0) then put_buffer('|'); end if;
			put_buffer(if (get_cell(i) = Alive) then '@' else ' ');
			if(Integer(i) mod Size = Size-1) then put_buffer('|'); put_buffer(LF); end if;
		end loop;
		for i in 1..(Size+2) loop put_buffer('='); end loop;
	end init_world;
	
	procedure print_world is begin
		println(world_buffer);
	end print_world;

	procedure simulate is
		--scan: Coord;
	begin
		for i in Area loop
			--scan.x := Length(i mod Area(Size));
			--scan.y := Length(i  /  Area(Size));
			
			--just flip flop for now
			if get_cell(scan) = Alive then
				set_cell(scan, Dead);
			else
				set_cell(scan, Alive);
			end if;
		end loop;
	end simulate;
end World;