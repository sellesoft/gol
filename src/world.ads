package World is
	-----------------------------------------------------------------------------------------------
	---- Size
	Size: constant Integer := 100; -- area of world = world_size**2
	type Length is mod Size;
	type Area is mod Size**2;

	-----------------------------------------------------------------------------------------------
	---- Coord
	type Coord is record
		x: Length := 0;
		y: Length := 0;
	end record;
	type Direction is (Left,TopLeft,Top,TopRight,Right,BottomRight,Bottom,BottomLeft);

	function "+"(a, b: Coord) return Coord with Inline;
	function "-"(a, b: Coord) return Coord with Inline;
	function above_coord(a: Coord) return Coord with Inline;
	function below_coord(a: Coord) return Coord with Inline;
	function left_coord (a: Coord) return Coord with Inline;
	function right_coord(a: Coord) return Coord with Inline;
	function relative_coord(a: Coord; d: Direction) return Coord with Inline;
	procedure println(a: Coord) with Inline;

	-----------------------------------------------------------------------------------------------
	---- Cell
	type Cell is (Dead,Alive);

	function  get_cell(x, y: Length) return Cell with Inline;
	function  get_cell(r: Coord) return Cell with Inline;
	function  get_cell(a: Area) return Cell with Inline;
	procedure set_cell(x, y: Length; c: Cell) with Inline;
	procedure set_cell(r: Coord; c: Cell) with Inline;
	procedure set_cell(a: Area; c: Cell) with Inline;

	function above_cell(a: Coord) return Cell with Inline;
	function below_cell(a: Coord) return Cell with Inline;
	function left_cell (a: Coord) return Cell with Inline;
	function right_cell(a: Coord) return Cell with Inline;
	procedure print(a: Cell) with Inline;

	-----------------------------------------------------------------------------------------------
	---- World
	type WorldRow is array(Length) of Cell;
	type WorldTable is array(Length) of WorldRow;

	procedure print_world;
	procedure simulate;

	world: WorldTable;
end World;