package World is
	-----------------------------------------------------------------------------------------------
	---- Size
	Size: constant Integer := 10; -- area of world = world_size**2
	type Length is mod Size;
	type Area is mod Size**2;
	
	function to_x(a: Area) return Length with Inline;
	function to_y(a: Area) return Length with Inline;

	-----------------------------------------------------------------------------------------------
	---- Coord
	type Coord is record
		x: Length := 0;
		y: Length := 0;
	end record;
	type Direction is (Left,TopLeft,Top,TopRight,Right,BottomRight,Bottom,BottomLeft);

	function "+"(left, right: Coord) return Coord with Inline;
	function "-"(left, right: Coord) return Coord with Inline;
	function get_coord(r: Coord; d: Direction) return Coord;
	function to_coord(a: Area) return Coord with Inline;
	procedure print(r: Coord) with Inline;
	procedure println(r: Coord) with Inline;

	-----------------------------------------------------------------------------------------------
	---- Cell
	type Cell is (Dead,Alive);

	function  get_cell(r: Coord) return Cell with Inline;
	function  get_cell(a: Area) return Cell with Inline;
	function  get_cell(r: Coord; d: Direction) return Cell;
	procedure set_cell(r: Coord; c: Cell) with Inline;
	procedure set_cell(a: Area; c: Cell) with Inline;

	-----------------------------------------------------------------------------------------------
	---- World
	type WorldRow is array(Length) of Cell;
	type WorldTable is array(Length) of WorldRow;

	procedure init_world;
	procedure print_world;
	procedure simulate;

	world: WorldTable;
	temp_world: WorldTable; --work in a different world to avoid state changes mid-simulation
	world_buffer: String(1..((Size**2) + 4*Size + 4 + Size + 1)); --world + borders + corners + newlines
end World;