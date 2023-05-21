with Common; use Common;

package body World is
-----------------------------------------------------------------------------------------------
	---- Coord
	function to_x(a: Area) return Length is begin
		return Length(Integer(a) mod Size);
	end to_x;
	
	function to_y(a: Area) return Length is begin
		return Length(Integer(a) / Size);
	end to_y;

	-----------------------------------------------------------------------------------------------
	---- Coord
	function "+"(left, right: Coord) return Coord is
		result: Coord;
	begin
		result.x := left.x + right.x;
		result.y := left.y + right.y;
		return result;
	end "+";

	function "-"(left, right: Coord) return Coord is
		result: Coord;
	begin
		result.x := left.x - right.x;
		result.y := left.y - right.y;
		return result;
	end "-";

	function get_coord(r: Coord; d: Direction) return Coord is begin
		case d is
			when Left        => return r + (-1, 0);
			when TopLeft     => return r + (-1,-1);
			when Top         => return r + ( 0,-1);
			when TopRight    => return r + ( 1,-1);
			when Right       => return r + ( 1, 0);
			when BottomRight => return r + ( 1, 1);
			when Bottom      => return r + ( 0, 1);
			when BottomLeft  => return r + (-1, 1);
		end case;
	end get_coord;
	
	function to_coord(a: Area) return Coord is begin
		return (to_x(a), to_y(a));
	end to_coord;

	procedure print(r: Coord) is begin
		Common.print("(" & Integer'Image(Integer(r.x)) & "," & Integer'Image(Integer(r.y)) & ")");
	end print;

	procedure println(r: Coord) is begin
		Common.println("(" & Integer'Image(Integer(r.x)) & "," & Integer'Image(Integer(r.y)) & ")");
	end println;


	-----------------------------------------------------------------------------------------------
	---- Cell
	function get_cell(r: Coord) return Cell is begin
		return world(r.x)(r.y); --reference the current world
	end get_cell;
	
	function get_cell(a: Area) return Cell is begin
		return get_cell(to_coord(a));
	end get_cell;
	
	function get_cell(r: Coord; d: Direction) return Cell is begin
		case d is
			when Left        => return get_cell((r.x-1, r.y+0));
			when TopLeft     => return get_cell((r.x-1, r.y-1));
			when Top         => return get_cell((r.x+0, r.y-1));
			when TopRight    => return get_cell((r.x+1, r.y-1));
			when Right       => return get_cell((r.x+1, r.y+0));
			when BottomRight => return get_cell((r.x+1, r.y+1));
			when Bottom      => return get_cell((r.x+0, r.y+1));
			when BottomLeft  => return get_cell((r.x-1, r.y+1));
		end case;
	end get_cell;
	
	function get_cell(a: Area; d: Direction) return Cell is begin
		return get_cell(to_coord(a), d);
	end get_cell;
	
	function alive_neighbours(r: Coord) return Integer is
		count: Integer := 0;
	begin
		for d in Direction loop
			if get_cell(r, d) = Alive then
				count := count + 1;
			end if;
		end loop;
		return count;
	end alive_neighbours;
	
	function alive_neighbours(a: Area) return Integer is begin
		return alive_neighbours(to_coord(a));
	end alive_neighbours;

	procedure set_cell(r: Coord; c: Cell) is begin
		temp_world(r.x)(r.y) := c; --edit the temp world
		world_buffer(Size+5 + Integer(r.y)*3 + Integer(r.y)*Size + Integer(r.x)) := (if (c = Alive) then '@' else ' ');
	end set_cell;
	
	procedure set_cell(a: Area; c: Cell) is begin
		temp_world(to_y(a))(to_x(a)) := c; --edit the temp world
		world_buffer(Size+5 + (Integer(a) / Size)*3 + Integer(a)) := (if (c = Alive) then '@' else ' ');
	end set_cell;


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
		--seed the current world
		--for a in Area loop
		--	world(to_y(a))(to_x(a)) := (if random(40) then Alive else Dead);
		--end loop;
		
		--test world: block
		--world(4)(4) := Alive;
		--world(4)(5) := Alive;
		--world(5)(4) := Alive;
		--world(5)(5) := Alive;
		
		--test world: blinker
		world(4)(5) := Alive;
		world(5)(5) := Alive;
		world(6)(5) := Alive;
		
		--init the world buffer
		for i in 1..(Size+2) loop put_buffer('='); end loop; put_buffer(LF);
		for a in Area loop
			if(Integer(a) mod Size = 0) then put_buffer('|'); end if;
			put_buffer(if (get_cell(a) = Alive) then '@' else ' ');
			if(Integer(a) mod Size = Size-1) then put_buffer('|'); put_buffer(LF); end if;
		end loop;
		for i in 1..(Size+2) loop put_buffer('='); end loop;
	end init_world;
	
	procedure print_world is begin
		println(world_buffer);
	end print_world;

	procedure simulate is
		state: Cell;
		neighbours: Integer;
	begin
		for a in Area loop
			state := get_cell(a);
			neighbours := alive_neighbours(a);
			
			--any alive cell with 2 or 3 alive neighbours survives
			--any dead cell with 3 alive neighbours becomes alive
			--all other cells die or stay dead
			if (neighbours = 3) or (state = Alive and neighbours = 2) then
				print(to_coord(a));
				println("; " & Cell'Image(state) & "->" & Cell'Image(Alive) & "; n=" & Integer'Image(neighbours));
				
				set_cell(a, Alive);
			else
				print(to_coord(a));
				println("; " & Cell'Image(state) & "->" & Cell'Image(Dead) & "; n=" & Integer'Image(neighbours));
				
				set_cell(a, Dead);
			end if;
		end loop;
		
		world := temp_world;
	end simulate;
end World;